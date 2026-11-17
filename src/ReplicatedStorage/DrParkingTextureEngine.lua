-- DrParkingTextureEngine.lua
-- Motor de decodificacao, renderizacao (EditableImage + Greedy 2D Canvas + AssetId)
-- e construcao 3D de carros, objetos e ambiente com as texturas convertidas para Luau.

local AssetService = game:GetService("AssetService")

local DrParkingTextureEngine = {}

local _decodedCache: { [string]: any } = {}
local _editableCache: { [string]: any } = {}
local _editableSupported: boolean? = nil

local SAFE_PALETTE_CHARS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz!@#$%^&*"

local function hexToColor3(hexStr: string): Color3
	local r = tonumber(string.sub(hexStr, 1, 2), 16) or 200
	local g = tonumber(string.sub(hexStr, 3, 4), 16) or 200
	local b = tonumber(string.sub(hexStr, 5, 6), 16) or 200
	return Color3.fromRGB(r, g, b)
end

local function makePart(props: { [string]: any }): BasePart
	local p: BasePart
	if props.IsWedge then
		p = Instance.new("WedgePart")
	else
		local part = Instance.new("Part")
		part.Shape = props.Shape or Enum.PartType.Block
		p = part
	end
	p.Name = props.Name or "Part"
	p.Anchored = if props.Anchored ~= nil then props.Anchored else true
	p.CanCollide = if props.CanCollide ~= nil then props.CanCollide else false
	p.CanTouch = false
	p.CanQuery = if props.CanQuery ~= nil then props.CanQuery else true
	p.CastShadow = if props.CastShadow ~= nil then props.CastShadow else false
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Material = props.Material or Enum.Material.SmoothPlastic
	p.Reflectance = props.Reflectance or 0
	p.Color = props.Color or Color3.fromRGB(220, 220, 220)
	p.Transparency = props.Transparency or 0
	p.Size = props.Size or Vector3.new(1, 1, 1)
	p.CFrame = props.CFrame or CFrame.new()
	p.Parent = props.Parent
	return p
end

local function relCF(origin: CFrame, x: number, y: number, z: number, rx: number?, ry: number?, rz: number?): CFrame
	local cf = origin * CFrame.new(x, y, z)
	if rx or ry or rz then
		cf = cf * CFrame.Angles(math.rad(rx or 0), math.rad(ry or 0), math.rad(rz or 0))
	end
	return cf
end

function DrParkingTextureEngine.DecodePixelGrid(texEntry)
	if not texEntry or not texEntry.PixelData then
		return nil
	end
	local cacheKey = (texEntry.Id or "tex") .. "::" .. string.sub(texEntry.PixelData, 1, 24)
	if _decodedCache[cacheKey] then
		return _decodedCache[cacheKey]
	end

	local raw = texEntry.PixelData
	local pipeIdx = string.find(raw, "|", 1, true)
	if not pipeIdx then
		return nil
	end

	local header = string.sub(raw, 1, pipeIdx - 1)
	local body = string.sub(raw, pipeIdx + 1)

	local headerParts = string.split(header, ",")
	local width = tonumber(headerParts[1]) or 16
	local height = tonumber(headerParts[2]) or 16

	local paletteColors: { [number]: Color3 } = {}
	local paletteHex: { [number]: { number } } = {}
	local charToIdx: { [string]: number } = { ["_"] = 0 }

	for i = 3, #headerParts do
		local palIdx = i - 2
		local hex = headerParts[i]
		if hex and #hex >= 6 and palIdx <= #SAFE_PALETTE_CHARS then
			local ch = string.sub(SAFE_PALETTE_CHARS, palIdx, palIdx)
			charToIdx[ch] = palIdx
			paletteColors[palIdx] = hexToColor3(hex)
			paletteHex[palIdx] = {
				tonumber(string.sub(hex, 1, 2), 16) or 200,
				tonumber(string.sub(hex, 3, 4), 16) or 200,
				tonumber(string.sub(hex, 5, 6), 16) or 200,
			}
		end
	end

	local total = width * height
	local pixels = table.create(total, 0)
	local pos = 1
	local outIdx = 1
	local bodyLen = #body

	while pos <= bodyLen and outIdx <= total do
		local countStart = pos
		while pos <= bodyLen do
			local b = string.byte(body, pos)
			if b >= 48 and b <= 57 then
				pos += 1
			else
				break
			end
		end
		local runCount = 1
		if pos > countStart then
			runCount = tonumber(string.sub(body, countStart, pos - 1)) or 1
		end
		if pos <= bodyLen then
			local ch = string.sub(body, pos, pos)
			local val = charToIdx[ch] or 0
			pos += 1
			for _ = 1, runCount do
				if outIdx <= total then
					pixels[outIdx] = val
					outIdx += 1
				end
			end
		end
	end

	local decoded = {
		Width = width,
		Height = height,
		Palette = paletteColors,
		PaletteRGB = paletteHex,
		Pixels = pixels,
	}
	_decodedCache[cacheKey] = decoded
	return decoded
end

function DrParkingTextureEngine.TryCreateEditableContent(texEntry)
	if not texEntry then
		return nil
	end
	if texEntry.AssetId and texEntry.AssetId ~= "" then
		return texEntry.AssetId
	end
	if _editableSupported == false then
		return nil
	end
	local cacheKey = (texEntry.Id or "tex") .. "::editable"
	if _editableCache[cacheKey] then
		return _editableCache[cacheKey]
	end

	local grid = DrParkingTextureEngine.DecodePixelGrid(texEntry)
	if not grid then
		return nil
	end

	local ok, result = pcall(function()
		local edImg = AssetService:CreateEditableImage({
			Size = Vector2.new(grid.Width, grid.Height),
		})
		if not edImg then
			return nil
		end
		local buf = buffer.create(grid.Width * grid.Height * 4)
		local pixels = grid.Pixels
		local palRGB = grid.PaletteRGB
		for i = 1, #pixels do
			local pid = pixels[i]
			local offset = (i - 1) * 4
			if pid == 0 or not palRGB[pid] then
				buffer.writeu8(buf, offset, 0)
				buffer.writeu8(buf, offset + 1, 0)
				buffer.writeu8(buf, offset + 2, 0)
				buffer.writeu8(buf, offset + 3, 0)
			else
				local rgb = palRGB[pid]
				buffer.writeu8(buf, offset, rgb[1])
				buffer.writeu8(buf, offset + 1, rgb[2])
				buffer.writeu8(buf, offset + 2, rgb[3])
				buffer.writeu8(buf, offset + 3, 255)
			end
		end
		edImg:WritePixelsBuffer(Vector2.zero, Vector2.new(grid.Width, grid.Height), buf)
		if Content and Content.fromObject then
			return Content.fromObject(edImg)
		end
		return nil
	end)

	if ok and result then
		_editableSupported = true
		_editableCache[cacheKey] = result
		return result
	else
		-- EditableImage unavailable in this context (e.g. Server or restricted place); fallback to GreedyCanvas
		if _editableSupported == nil then
			_editableSupported = false
		end
		return nil
	end
end

-- Greedy 2D rectangle merging over decoded pixel grid:
-- Reduces 2,304+ pixels into ~250-550 crisp Frames with zero gaps.
function DrParkingTextureEngine.RenderGreedyCanvas(parentContainer: GuiObject, texEntry, zIndexBase: number?): Frame?
	local grid = DrParkingTextureEngine.DecodePixelGrid(texEntry)
	if not grid then
		return nil
	end

	local old = parentContainer:FindFirstChild("LuaGreedyCanvas")
	if old then
		old:Destroy()
	end

	local holder = Instance.new("Frame")
	holder.Name = "LuaGreedyCanvas"
	holder.Size = UDim2.fromScale(1, 1)
	holder.BackgroundTransparency = 1
	holder.BorderSizePixel = 0
	holder.ZIndex = zIndexBase or parentContainer.ZIndex
	holder.Parent = parentContainer

	local w = grid.Width
	local h = grid.Height
	local pixels = grid.Pixels
	local palette = grid.Palette
	local visited = table.create(w * h, false)
	local baseZ = zIndexBase or parentContainer.ZIndex

	for y = 0, h - 1 do
		local x = 0
		while x < w do
			local idx = y * w + x + 1
			local val = pixels[idx]
			if val ~= 0 and not visited[idx] then
				-- Expand horizontally
				local rw = 1
				while (x + rw) < w do
					local nIdx = y * w + (x + rw) + 1
					if not visited[nIdx] and pixels[nIdx] == val then
						rw += 1
					else
						break
					end
				end

				-- Expand vertically while full row matches
				local rh = 1
				while (y + rh) < h do
					local rowOk = true
					for dx = 0, rw - 1 do
						local nIdx = (y + rh) * w + (x + dx) + 1
						if visited[nIdx] or pixels[nIdx] ~= val then
							rowOk = false
							break
						end
					end
					if rowOk then
						rh += 1
					else
						break
					end
				end

				-- Mark visited
				for dy = 0, rh - 1 do
					for dx = 0, rw - 1 do
						visited[(y + dy) * w + (x + dx) + 1] = true
					end
				end

				local rect = Instance.new("Frame")
				rect.BorderSizePixel = 0
				rect.BackgroundColor3 = palette[val] or Color3.new(1, 1, 1)
				rect.BackgroundTransparency = 0
				rect.ZIndex = baseZ
				rect.Position = UDim2.fromScale(x / w, y / h)
				rect.Size = UDim2.fromScale(rw / w + 0.001, rh / h + 0.001)
				rect.Parent = holder

				x += rw
			else
				x += 1
			end
		end
	end

	return holder
end

function DrParkingTextureEngine.ApplyTextureToGui(container: GuiObject, texEntry, preferEditable: boolean?)
	for _, child in ipairs(container:GetChildren()) do
		if child.Name == "LuaEditablePreview" or child.Name == "LuaGreedyCanvas" then
			child:Destroy()
		end
	end

	if texEntry.AssetId and texEntry.AssetId ~= "" then
		local imgLabel = Instance.new("ImageLabel")
		imgLabel.Name = "LuaEditablePreview"
		imgLabel.Size = UDim2.fromScale(1, 1)
		imgLabel.BackgroundTransparency = 1
		imgLabel.Image = texEntry.AssetId
		if texEntry.RectOffset and texEntry.RectSize then
			imgLabel.ImageRectOffset = texEntry.RectOffset
			imgLabel.ImageRectSize = texEntry.RectSize
		end
		imgLabel.ScaleType = Enum.ScaleType.Fit
		imgLabel.ZIndex = container.ZIndex + 1
		imgLabel.Parent = container
		return imgLabel
	end

	if preferEditable ~= false then
		local edContent = DrParkingTextureEngine.TryCreateEditableContent(texEntry)
		if edContent then
			local imgLabel = Instance.new("ImageLabel")
			imgLabel.Name = "LuaEditablePreview"
			imgLabel.Size = UDim2.fromScale(1, 1)
			imgLabel.BackgroundTransparency = 1
			imgLabel.ImageContent = edContent
			imgLabel.ScaleType = Enum.ScaleType.Fit
			imgLabel.ResampleMode = Enum.ResamplerMode.Pixelated
			imgLabel.ZIndex = container.ZIndex + 1
			imgLabel.Parent = container
			return imgLabel
		end
	end

	return DrParkingTextureEngine.RenderGreedyCanvas(container, texEntry, container.ZIndex + 1)
end

function DrParkingTextureEngine.CreateSurfaceTextureDisplay(part: BasePart, face: Enum.NormalId, texEntry, pixelsPerStud: number?)
	if texEntry.AssetId and texEntry.AssetId ~= "" then
		local decal = Instance.new("Decal")
		decal.Face = face
		decal.Texture = texEntry.AssetId
		decal.Parent = part
		return decal
	end

	local gui = Instance.new("SurfaceGui")
	gui.Name = "LuaTextureSurface_" .. face.Name
	gui.Face = face
	gui.SizingMode = Enum.SurfaceGuiSizingMode.PixelsPerStud
	gui.PixelsPerStud = pixelsPerStud or 32
	gui.LightInfluence = 0.25
	gui.AlwaysOnTop = false
	gui.Parent = part

	local rootFrame = Instance.new("Frame")
	rootFrame.Size = UDim2.fromScale(1, 1)
	rootFrame.BackgroundTransparency = 1
	rootFrame.BorderSizePixel = 0
	rootFrame.Parent = gui

	DrParkingTextureEngine.RenderGreedyCanvas(rootFrame, texEntry, 1)
	return gui
end

function DrParkingTextureEngine.BuildTexturedCar(entry, originCF: CFrame, parent: Instance?, options: { [string]: any }?): Model
	local opts = options or {}
	local scale = opts.Scale or 2.4 -- Convert ~2m x 4.5m game meters into natural Roblox Studs
	local pal = entry.Palette
	local bbox = entry.BBoxSize or Vector3.new(2.0, 1.3, 4.4)
	local w = bbox.X * scale
	local h = bbox.Y * scale
	local l = bbox.Z * scale

	local model = Instance.new("Model")
	model.Name = opts.Name or ("Car_" .. entry.Id)
	model.Parent = parent

	local bodyColor = pal.Body
	local roofColor = pal.Roof
	local glassColor = pal.Glass
	local trimColor = pal.Trim
	local mat = entry.Material or Enum.Material.SmoothPlastic
	local refl = entry.Reflectance or 0.1

	local wheelRadius = math.max(0.75, h * 0.28)
	local wheelThick = math.max(0.42, w * 0.14)
	local bodyY = wheelRadius + (h * 0.24)

	-- Root / Hitbox
	local root = makePart({
		Name = "ChassisRoot",
		Size = Vector3.new(w * 0.94, h * 0.42, l * 0.96),
		CFrame = relCF(originCF, 0, bodyY, 0),
		Color = bodyColor,
		Material = mat,
		Reflectance = refl,
		CastShadow = true,
		Parent = model,
	})
	model.PrimaryPart = root

	-- Lower trim / bumper skirt
	makePart({
		Name = "LowerSkirt",
		Size = Vector3.new(w * 0.96, h * 0.14, l * 0.99),
		CFrame = relCF(originCF, 0, wheelRadius * 0.72, 0),
		Color = trimColor,
		Material = Enum.Material.SmoothPlastic,
		Parent = model,
	})

	-- Front Hood slope (WedgePart)
	makePart({
		Name = "FrontHood",
		IsWedge = true,
		Size = Vector3.new(w * 0.90, h * 0.22, l * 0.28),
		CFrame = relCF(originCF, 0, bodyY + h * 0.26, -l * 0.30, 0, 0, 0),
		Color = bodyColor,
		Material = mat,
		Reflectance = refl,
		Parent = model,
	})

	-- Cabin & Roof
	local cabinH = h * 0.38
	local cabinY = bodyY + h * 0.34
	makePart({
		Name = "CabinCore",
		Size = Vector3.new(w * 0.80, cabinH, l * 0.46),
		CFrame = relCF(originCF, 0, cabinY, l * 0.04),
		Color = bodyColor,
		Material = mat,
		Reflectance = refl,
		Parent = model,
	})

	-- Roof cap
	makePart({
		Name = "RoofCap",
		Size = Vector3.new(w * 0.76, h * 0.06, l * 0.40),
		CFrame = relCF(originCF, 0, cabinY + cabinH * 0.52, l * 0.04),
		Color = roofColor,
		Material = mat,
		Reflectance = refl,
		Parent = model,
	})

	-- Sunroof / Glass detail
	makePart({
		Name = "SunroofGlass",
		Size = Vector3.new(w * 0.44, h * 0.07, l * 0.16),
		CFrame = relCF(originCF, 0, cabinY + cabinH * 0.53, -l * 0.02),
		Color = glassColor,
		Material = Enum.Material.SmoothPlastic,
		Reflectance = 0.25,
		Parent = model,
	})

	-- Front Windshield (slanted WedgePart)
	makePart({
		Name = "Windshield",
		IsWedge = true,
		Size = Vector3.new(w * 0.78, cabinH * 0.92, l * 0.14),
		CFrame = relCF(originCF, 0, cabinY - h * 0.02, -l * 0.24),
		Color = glassColor,
		Material = Enum.Material.SmoothPlastic,
		Reflectance = 0.35,
		Parent = model,
	})

	-- Rear Windshield
	makePart({
		Name = "RearWindow",
		IsWedge = true,
		Size = Vector3.new(w * 0.78, cabinH * 0.88, l * 0.15),
		CFrame = relCF(originCF, 0, cabinY - h * 0.02, l * 0.33, 0, 180, 0),
		Color = glassColor,
		Material = Enum.Material.SmoothPlastic,
		Reflectance = 0.35,
		Parent = model,
	})

	-- Side Windows
	makePart({
		Name = "SideWindows",
		Size = Vector3.new(w * 0.82, cabinH * 0.68, l * 0.41),
		CFrame = relCF(originCF, 0, cabinY + h * 0.02, l * 0.04),
		Color = glassColor,
		Material = Enum.Material.SmoothPlastic,
		Reflectance = 0.30,
		Parent = model,
	})

	-- Front Grille
	makePart({
		Name = "FrontGrille",
		Size = Vector3.new(w * 0.46, h * 0.14, 0.15),
		CFrame = relCF(originCF, 0, bodyY - h * 0.03, -l * 0.49),
		Color = Color3.fromRGB(22, 24, 28),
		Material = Enum.Material.Metal,
		Parent = model,
	})

	-- Headlights (Neon)
	for _, side in ipairs({ -1, 1 }) do
		makePart({
			Name = side < 0 and "Headlight_L" or "Headlight_R",
			Size = Vector3.new(w * 0.18, h * 0.11, 0.14),
			CFrame = relCF(originCF, side * w * 0.34, bodyY + h * 0.04, -l * 0.49),
			Color = pal.Headlight,
			Material = Enum.Material.Neon,
			Parent = model,
		})

		-- Taillights + Brake + Reverse lights
		makePart({
			Name = side < 0 and "Taillight_L" or "Taillight_R",
			Size = Vector3.new(w * 0.20, h * 0.10, 0.14),
			CFrame = relCF(originCF, side * w * 0.33, bodyY + h * 0.06, l * 0.49),
			Color = pal.Taillight,
			Material = Enum.Material.Neon,
			Parent = model,
		})

		makePart({
			Name = side < 0 and "ReverseLight_L" or "ReverseLight_R",
			Size = Vector3.new(w * 0.09, h * 0.06, 0.15),
			CFrame = relCF(originCF, side * w * 0.20, bodyY + h * 0.05, l * 0.495),
			Color = Color3.fromRGB(245, 250, 255),
			Material = Enum.Material.Neon,
			Parent = model,
		})

		-- Side mirrors
		makePart({
			Name = side < 0 and "Mirror_L" or "Mirror_R",
			Size = Vector3.new(w * 0.09, h * 0.08, 0.28),
			CFrame = relCF(originCF, side * w * 0.48, cabinY - cabinH * 0.22, -l * 0.14),
			Color = bodyColor,
			Material = mat,
			Parent = model,
		})
	end

	-- 4 Wheels (Tire + Rim)
	local wheelOffsets = {
		{ "Wheel_FL", -w * 0.44, -l * 0.30 },
		{ "Wheel_FR", w * 0.44, -l * 0.30 },
		{ "Wheel_RL", -w * 0.44, l * 0.30 },
		{ "Wheel_RR", w * 0.44, l * 0.30 },
	}
	for _, wo in ipairs(wheelOffsets) do
		local wName, wx, wz = wo[1], wo[2], wo[3]
		makePart({
			Name = wName,
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(wheelThick, wheelRadius * 2, wheelRadius * 2),
			CFrame = relCF(originCF, wx, wheelRadius, wz),
			Color = pal.Wheel,
			Material = Enum.Material.Rubber,
			Parent = model,
		})
		makePart({
			Name = wName .. "_Rim",
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(wheelThick + 0.05, wheelRadius * 1.15, wheelRadius * 1.15),
			CFrame = relCF(originCF, wx, wheelRadius, wz),
			Color = pal.Rim,
			Material = Enum.Material.Metal,
			Reflectance = 0.25,
			Parent = model,
		})
	end

	-- Ground shadow decal pad (represents shadow.png)
	makePart({
		Name = "ShadowBase",
		Size = Vector3.new(w * 1.08, 0.04, l * 1.05),
		CFrame = relCF(originCF, 0, 0.02, 0),
		Color = Color3.fromRGB(14, 16, 20),
		Transparency = 0.42,
		Material = Enum.Material.SmoothPlastic,
		Parent = model,
	})

	return model
end

function DrParkingTextureEngine.BuildTexturedObject(entry, originCF: CFrame, parent: Instance?, scaleOverride: number?): Model
	local scale = scaleOverride or 2.4
	local bbox = entry.BBoxSize or Vector3.new(2.0, 1.0, 0.5)
	local sx = math.max(0.5, bbox.X * scale)
	local sy = math.max(0.4, bbox.Y * scale)
	local sz = math.max(0.5, bbox.Z * scale)
	local oid = entry.Id

	local model = Instance.new("Model")
	model.Name = "Obj_" .. oid
	model.Parent = parent

	local mainPart: BasePart

	if oid == "cone" then
		mainPart = makePart({
			Name = "ConeBase",
			Size = Vector3.new(sx, sy * 0.16, sz),
			CFrame = relCF(originCF, 0, sy * 0.08, 0),
			Color = Color3.fromRGB(235, 92, 18),
			Material = Enum.Material.Plastic,
			Parent = model,
		})
		makePart({
			Name = "ConeBodyLower",
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(sy * 0.40, sx * 0.58, sx * 0.58),
			CFrame = relCF(originCF, 0, sy * 0.36, 0, 0, 0, 90),
			Color = Color3.fromRGB(245, 96, 18),
			Material = Enum.Material.Plastic,
			Parent = model,
		})
		makePart({
			Name = "ConeStripe",
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(sy * 0.22, sx * 0.44, sx * 0.44),
			CFrame = relCF(originCF, 0, sy * 0.65, 0, 0, 0, 90),
			Color = Color3.fromRGB(248, 250, 252),
			Material = Enum.Material.Neon,
			Parent = model,
		})
		makePart({
			Name = "ConeTip",
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(sy * 0.24, sx * 0.28, sx * 0.28),
			CFrame = relCF(originCF, 0, sy * 0.86, 0, 0, 0, 90),
			Color = Color3.fromRGB(245, 96, 18),
			Material = Enum.Material.Plastic,
			Parent = model,
		})
	elseif oid == "barrier" then
		mainPart = makePart({
			Name = "BarrierBody",
			Size = Vector3.new(sx, sy, sz),
			CFrame = relCF(originCF, 0, sy * 0.5, 0),
			Color = entry.Palette.Primary,
			Material = entry.Material,
			Parent = model,
		})
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(mainPart, Enum.NormalId.Front, entry, 28)
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(mainPart, Enum.NormalId.Back, entry, 28)
	elseif oid == "box" then
		mainPart = makePart({
			Name = "BoxBody",
			Size = Vector3.new(sx, sy, sz),
			CFrame = relCF(originCF, 0, sy * 0.5, 0),
			Color = Color3.fromRGB(95, 92, 90),
			Material = entry.Material,
			Parent = model,
		})
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(mainPart, Enum.NormalId.Front, entry, 32)
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(mainPart, Enum.NormalId.Top, entry, 32)
	elseif oid == "display" or oid == "display01" or oid == "display02" then
		mainPart = makePart({
			Name = "DisplayFrame",
			Size = Vector3.new(sx, sy * 0.82, sz),
			CFrame = relCF(originCF, 0, sy * 0.58, 0),
			Color = Color3.fromRGB(36, 38, 44),
			Material = Enum.Material.Metal,
			Parent = model,
		})
		for _, lx in ipairs({ -sx * 0.36, sx * 0.36 }) do
			makePart({
				Name = "Leg",
				Size = Vector3.new(0.45, sy * 0.35, 0.45),
				CFrame = relCF(originCF, lx, sy * 0.175, 0),
				Color = Color3.fromRGB(28, 30, 34),
				Material = Enum.Material.Metal,
				Parent = model,
			})
		end
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(mainPart, Enum.NormalId.Front, entry, 24)
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(mainPart, Enum.NormalId.Back, entry, 24)
	elseif oid == "fence" then
		mainPart = makePart({
			Name = "FencePanel",
			Size = Vector3.new(sx, sy, sz),
			CFrame = relCF(originCF, 0, sy * 0.5, 0),
			Color = entry.Palette.Primary,
			Material = entry.Material,
			Transparency = 0.2,
			Parent = model,
		})
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(mainPart, Enum.NormalId.Front, entry, 28)
	elseif oid == "sign" then
		mainPart = makePart({
			Name = "SignPole",
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(sy * 0.9, 0.25, 0.25),
			CFrame = relCF(originCF, 0, sy * 0.45, 0, 0, 0, 90),
			Color = Color3.fromRGB(165, 170, 178),
			Material = Enum.Material.Metal,
			Parent = model,
		})
		local board = makePart({
			Name = "SignBoard",
			Size = Vector3.new(sx, sy * 0.55, 0.22),
			CFrame = relCF(originCF, 0, sy * 0.85, 0),
			Color = entry.Palette.Primary,
			Material = Enum.Material.SmoothPlastic,
			Parent = model,
		})
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(board, Enum.NormalId.Front, entry, 36)
	elseif oid == "grasscircle" then
		mainPart = makePart({
			Name = "CurbCircle",
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(sy, sx, sz),
			CFrame = relCF(originCF, 0, sy * 0.5, 0, 0, 0, 90),
			Color = Color3.fromRGB(168, 162, 148),
			Material = Enum.Material.Concrete,
			Parent = model,
		})
		local grassTop = makePart({
			Name = "GrassPatch",
			Shape = Enum.PartType.Cylinder,
			Size = Vector3.new(sy + 0.08, sx * 0.86, sz * 0.86),
			CFrame = relCF(originCF, 0, sy * 0.52, 0, 0, 0, 90),
			Color = entry.Palette.Primary,
			Material = Enum.Material.Grass,
			Parent = model,
		})
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(grassTop, Enum.NormalId.Right, entry, 24)
	else
		-- grass, grasssector, grasstriangle
		mainPart = makePart({
			Name = "CurbBox",
			Size = Vector3.new(sx, sy, sz),
			CFrame = relCF(originCF, 0, sy * 0.5, 0),
			Color = Color3.fromRGB(165, 160, 146),
			Material = Enum.Material.Concrete,
			Parent = model,
		})
		local grassTop = makePart({
			Name = "GrassCenter",
			Size = Vector3.new(sx * 0.86, sy + 0.08, sz * 0.86),
			CFrame = relCF(originCF, 0, sy * 0.52, 0),
			Color = entry.Palette.Primary,
			Material = Enum.Material.Grass,
			Parent = model,
		})
		DrParkingTextureEngine.CreateSurfaceTextureDisplay(grassTop, Enum.NormalId.Top, entry, 24)
	end

	model.PrimaryPart = mainPart
	makePart({
		Name = "ObjectShadow",
		Size = Vector3.new(sx * 1.12, 0.03, sz * 1.12),
		CFrame = relCF(originCF, 0, 0.015, 0),
		Color = Color3.fromRGB(12, 14, 18),
		Transparency = 0.5,
		Parent = model,
	})
	return model
end

return DrParkingTextureEngine
