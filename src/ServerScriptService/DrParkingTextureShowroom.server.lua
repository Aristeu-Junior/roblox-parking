-- DrParkingTextureShowroom.server.lua
-- Constroi automaticamente no Workspace o Showroom 3D Completo com todas as 69 texturas
-- do Dr. Parking 4 convertidas para Luau (Cars, ECars, Environment, Objects e UI/Sprites).

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local Registry = require(ReplicatedStorage:WaitForChild("DrParkingTextureRegistry"))
local TextureEngine = Registry.Engine

local SHOWROOM_NAME = "DrParkingTextureShowroom"

local function createLabelBillboard(targetPart: BasePart, title: string, subtitle: string?, accentColor: Color3?)
	local bb = Instance.new("BillboardGui")
	bb.Name = "InfoBillboard"
	bb.Size = UDim2.fromOffset(220, 58)
	bb.StudsOffset = Vector3.new(0, 4.8, 0)
	bb.AlwaysOnTop = false
	bb.MaxDistance = 95
	bb.Parent = targetPart

	local bg = Instance.new("Frame")
	bg.Size = UDim2.fromScale(1, 1)
	bg.BackgroundColor3 = Color3.fromRGB(22, 24, 30)
	bg.BackgroundTransparency = 0.16
	bg.BorderSizePixel = 0
	bg.Parent = bb

	local corner = Instance.new("UICorner")
	corner.CornerRadius = UDim.new(0, 8)
	corner.Parent = bg

	local stroke = Instance.new("UIStroke")
	stroke.Thickness = 2
	stroke.Color = accentColor or Color3.fromRGB(245, 195, 45)
	stroke.Parent = bg

	local t1 = Instance.new("TextLabel")
	t1.Size = UDim2.new(1, -10, 0.56, 0)
	t1.Position = UDim2.fromOffset(5, 3)
	t1.BackgroundTransparency = 1
	t1.Font = Enum.Font.GothamBold
	t1.TextScaled = true
	t1.TextColor3 = Color3.fromRGB(255, 255, 255)
	t1.Text = title
	t1.Parent = bg

	if subtitle then
		local t2 = Instance.new("TextLabel")
		t2.Size = UDim2.new(1, -10, 0.36, 0)
		t2.Position = UDim2.new(0, 5, 0.58, 0)
		t2.BackgroundTransparency = 1
		t2.Font = Enum.Font.GothamMedium
		t2.TextScaled = true
		t2.TextColor3 = Color3.fromRGB(205, 215, 230)
		t2.Text = subtitle
		t2.Parent = bg
	end
end

local function createTextureStand(entry, standCF: CFrame, width: number, height: number, parent: Instance): Part
	local stand = Instance.new("Part")
	stand.Name = "TextureBoard_" .. entry.Id
	stand.Anchored = true
	stand.CanCollide = false
	stand.CanTouch = false
	stand.CastShadow = false
	stand.Material = Enum.Material.SmoothPlastic
	stand.Color = Color3.fromRGB(26, 28, 34)
	stand.Size = Vector3.new(width, height, 0.35)
	stand.CFrame = standCF
	stand.Parent = parent

	TextureEngine.CreateSurfaceTextureDisplay(stand, Enum.NormalId.Front, entry, 28)
	return stand
end

local function createFloorPlatform(name: string, size: Vector3, cf: CFrame, color: Color3, material: Enum.Material, parent: Instance)
	local p = Instance.new("Part")
	p.Name = name
	p.Anchored = true
	p.CanCollide = true
	p.CanTouch = false
	p.CastShadow = false
	p.TopSurface = Enum.SurfaceType.Smooth
	p.BottomSurface = Enum.SurfaceType.Smooth
	p.Size = size
	p.CFrame = cf
	p.Color = color
	p.Material = material
	p.Parent = parent
	return p
end

local function buildShowroom()
	local existing = Workspace:FindFirstChild(SHOWROOM_NAME)
	if existing then
		existing:Destroy()
	end

	-- Remove default Baseplate if desired or elevate our arena neatly on Y=0
	local rootFolder = Instance.new("Folder")
	rootFolder.Name = SHOWROOM_NAME
	rootFolder.Parent = Workspace

	local wingsFolder = Instance.new("Folder")
	wingsFolder.Name = "ShowroomWings"
	wingsFolder.Parent = rootFolder

	-- Outer Terrain Ground (representing ground.jpg)
	createFloorPlatform(
		"OuterGround",
		Vector3.new(300, 1, 220),
		CFrame.new(0, -0.55, 0),
		Color3.fromRGB(142, 134, 118),
		Enum.Material.Ground,
		rootFolder
	)

	-- Inner Asphalt Arena (representing asphalt.jpg)
	createFloorPlatform(
		"AsphaltArena",
		Vector3.new(250, 0.5, 175),
		CFrame.new(0, -0.25, 0),
		Color3.fromRGB(58, 60, 64),
		Enum.Material.Asphalt,
		rootFolder
	)

	-- Perimeter Walls (representing wall.jpg)
	local wallH, wallT = 6, 2
	createFloorPlatform("Wall_North", Vector3.new(254, wallH, wallT), CFrame.new(0, wallH / 2, -88.5), Color3.fromRGB(165, 128, 96), Enum.Material.Brick, rootFolder)
	createFloorPlatform("Wall_South", Vector3.new(254, wallH, wallT), CFrame.new(0, wallH / 2, 88.5), Color3.fromRGB(165, 128, 96), Enum.Material.Brick, rootFolder)
	createFloorPlatform("Wall_West", Vector3.new(wallT, wallH, 179), CFrame.new(-126, wallH / 2, 0), Color3.fromRGB(165, 128, 96), Enum.Material.Brick, rootFolder)
	createFloorPlatform("Wall_East", Vector3.new(wallT, wallH, 179), CFrame.new(126, wallH / 2, 0), Color3.fromRGB(165, 128, 96), Enum.Material.Brick, rootFolder)

	-- Central SpawnLocation
	local spawn = Instance.new("SpawnLocation")
	spawn.Name = "ShowroomSpawn"
	spawn.Anchored = true
	spawn.Size = Vector3.new(10, 0.6, 10)
	spawn.Position = Vector3.new(0, 0.3, 18)
	spawn.Color = Color3.fromRGB(45, 135, 225)
	spawn.Material = Enum.Material.SmoothPlastic
	spawn.Duration = 0
	spawn.Parent = rootFolder

	local function registerWingAnchor(name: string, label: string, pos: Vector3)
		local anchor = Instance.new("Part")
		anchor.Name = name
		anchor.Anchored = true
		anchor.CanCollide = false
		anchor.Transparency = 1
		anchor.Size = Vector3.new(2, 2, 2)
		anchor.Position = pos
		anchor:SetAttribute("WingLabel", label)
		anchor.Parent = wingsFolder
	end

	-- =======================================================================
	-- ALA 1: 30 TEXTURAS DE CARROS JOGAVEIS (15 carros x 2 skins)
	-- =======================================================================
	local wingCars = Instance.new("Folder")
	wingCars.Name = "Wing1_Cars_30"
	wingCars.Parent = rootFolder
	registerWingAnchor("Cars", "Ala 1: Carros (30 Texturas)", Vector3.new(0, 3, -6))

	for i = 0, 14 do
		local x = (i - 7) * 14.5
		-- Skin 0 (Common) at Z = -20
		local e0 = Registry.GetCarSkin(i, 0)
		local lot0 = Registry.BuildParkingLot("white", CFrame.new(x, 0, -20), wingCars)
		lot0.Name = "Lot_" .. e0.Id
		local car0 = TextureEngine.BuildTexturedCar(e0, CFrame.new(x, 0, -20), wingCars, { Scale = 2.2 })
		local board0 = createTextureStand(e0, CFrame.new(x, 2.3, -12.5) * CFrame.Angles(math.rad(-22), 0, 0), 5.2, 2.6, wingCars)
		createLabelBillboard(board0, e0.Id .. " (" .. e0.CarClass .. ")", e0.SkinLabel .. " • " .. e0.OriginalPath, e0.Palette.Body)

		-- Skin 1 (Special) at Z = -40
		local e1 = Registry.GetCarSkin(i, 1)
		local lot1 = Registry.BuildParkingLot("yellow", CFrame.new(x, 0, -40), wingCars)
		lot1.Name = "Lot_" .. e1.Id
		local car1 = TextureEngine.BuildTexturedCar(e1, CFrame.new(x, 0, -40), wingCars, { Scale = 2.2 })
		local board1 = createTextureStand(e1, CFrame.new(x, 2.3, -32.5) * CFrame.Angles(math.rad(-22), 0, 0), 5.2, 2.6, wingCars)
		createLabelBillboard(board1, e1.Id .. " (" .. e1.CarClass .. ")", e1.SkinLabel .. " • " .. e1.OriginalPath, e1.Palette.Body)
	end

	-- =======================================================================
	-- ALA 2: 7 CARROS DE CENARIO (ECars)
	-- =======================================================================
	local wingECars = Instance.new("Folder")
	wingECars.Name = "Wing2_ECars_7"
	wingECars.Parent = rootFolder
	registerWingAnchor("ECars", "Ala 2: Carros Cenario (7 Texturas)", Vector3.new(-55, 3, 28))

	for i, entry in ipairs(Registry.Categories.ecars) do
		local x = -92 + (i - 1) * 14
		local z = 36
		Registry.BuildParkingLot("white", CFrame.new(x, 0, z), wingECars)
		TextureEngine.BuildTexturedCar(entry, CFrame.new(x, 0, z), wingECars, { Scale = 2.2 })
		local board = createTextureStand(entry, CFrame.new(x, 2.3, z - 7.5) * CFrame.Angles(math.rad(-22), math.rad(180), 0), 5.0, 2.5, wingECars)
		createLabelBillboard(board, entry.Id, entry.Name, entry.Palette.Body)
	end

	-- =======================================================================
	-- ALA 3: 14 TEXTURAS DE AMBIENTE (Envi)
	-- =======================================================================
	local wingEnvi = Instance.new("Folder")
	wingEnvi.Name = "Wing3_Environment_14"
	wingEnvi.Parent = rootFolder
	registerWingAnchor("Environment", "Ala 3: Ambiente (14 Texturas)", Vector3.new(55, 3, 28))

	-- Interactive Lot showcase (White / Green / Yellow + Floating Arrow)
	Registry.BuildParkingLot("white", CFrame.new(30, 0, 40), wingEnvi)
	Registry.BuildParkingLot("green", CFrame.new(40, 0, 40), wingEnvi)
	Registry.BuildParkingLot("yellow", CFrame.new(50, 0, 40), wingEnvi)

	local animatedArrow: Model? = nil
	local animatedCoin: Model? = nil

	for i, entry in ipairs(Registry.Categories.envi) do
		local col = (i - 1) % 7
		local row = math.floor((i - 1) / 7)
		local x = 28 + col * 13
		local z = 56 + row * 16
		local envModel = Registry.BuildEnvironmentPiece(entry.Id, CFrame.new(x, 0, z), wingEnvi)
		if entry.Id == "arrow" then
			animatedArrow = envModel
		elseif entry.Id == "coin" then
			animatedCoin = envModel
		end
		local board = createTextureStand(entry, CFrame.new(x, 3.0, z - 5.2) * CFrame.Angles(math.rad(-10), math.rad(180), 0), 4.2, 4.2, wingEnvi)
		createLabelBillboard(board, entry.Id, entry.OriginalPath, entry.Palette.Primary)
	end

	-- =======================================================================
	-- ALA 4: 12 OBJETOS E OBSTACULOS (Objects)
	-- =======================================================================
	local wingObjects = Instance.new("Folder")
	wingObjects.Name = "Wing4_Objects_12"
	wingObjects.Parent = rootFolder
	registerWingAnchor("Objects", "Ala 4: Objetos (12 Texturas)", Vector3.new(-55, 3, -55))

	for i, entry in ipairs(Registry.Categories.objects) do
		local x = -96 + (i - 1) * 16.5
		local z = -66
		TextureEngine.BuildTexturedObject(entry, CFrame.new(x, 0, z), wingObjects, 2.2)
		local board = createTextureStand(entry, CFrame.new(x, 2.6, z + 6.8) * CFrame.Angles(math.rad(-12), 0, 0), 4.4, 4.4, wingObjects)
		createLabelBillboard(board, entry.Id, entry.ObjPath or "", entry.Palette.Primary)
	end

	-- =======================================================================
	-- ALA 5: 6 ATLAS DE UI + SPRITES RECORTADOS (UI & Menu)
	-- =======================================================================
	local wingUI = Instance.new("Folder")
	wingUI.Name = "Wing5_UI_6"
	wingUI.Parent = rootFolder
	registerWingAnchor("UI", "Ala 5: UI & Sprites (6 Atlas)", Vector3.new(0, 3, 56))

	for i, entry in ipairs(Registry.Categories.ui) do
		local x = -32 + (i - 1) * 13
		local z = 74
		local board = createTextureStand(entry, CFrame.new(x, 6.2, z) * CFrame.Angles(0, math.rad(180), 0), 10.5, 10.5, wingUI)
		createLabelBillboard(board, entry.Id .. " (" .. entry.SourceSize.X .. "x" .. entry.SourceSize.Y .. ")", entry.OriginalPath, Color3.fromRGB(255, 175, 45))
	end

	-- Sub-sprites showcase row in front of the main UI atlases
	local keySprites = {
		"SteeringWheel", "GearShifterSlot", "GasPedal", "BrakePedal",
		"Banner_GOOD", "Banner_GREAT", "Banner_PERFECT",
		"Btn_START", "Btn_PRACTICE", "FirstPersonDashboard",
	}
	for i, spriteName in ipairs(keySprites) do
		local sp = Registry.GetSprite(spriteName)
		if sp then
			local x = -36 + (i - 1) * 8
			local z = 63
			local spEntry = {
				Id = "Sprite_" .. spriteName,
				PixelData = sp.PixelData,
				AssetId = "",
			}
			local ratio = sp.RectSize.X / math.max(1, sp.RectSize.Y)
			local w = math.clamp(3.0 * ratio, 2.2, 6.8)
			local h = math.clamp(w / math.max(0.25, ratio), 1.6, 4.2)
			local board = createTextureStand(spEntry, CFrame.new(x, 2.6, z) * CFrame.Angles(0, math.rad(180), 0), w, h, wingUI)
			createLabelBillboard(board, spriteName, "Atlas: " .. sp.AtlasId .. ".png", Color3.fromRGB(95, 205, 255))
		end
	end

	-- Gentle animation for floating parking arrow and spinning coin
	local elapsed = 0
	RunService.Heartbeat:Connect(function(dt)
		elapsed += dt
		if animatedArrow and animatedArrow.PrimaryPart then
			local p = animatedArrow.PrimaryPart
			local basePos = Vector3.new(p.Position.X, 3.6 + math.sin(elapsed * 3.0) * 0.65, p.Position.Z)
			p.CFrame = CFrame.new(basePos) * CFrame.Angles(0, elapsed * 1.4, 0)
		end
		if animatedCoin and animatedCoin.PrimaryPart then
			local p = animatedCoin.PrimaryPart
			p.CFrame = CFrame.new(p.Position) * CFrame.Angles(0, elapsed * 2.2, math.rad(90))
		end
	end)

	print(string.format("[DrParkingTextureShowroom] Showroom 3D criado com sucesso! Total de texturas registradas: %d/69", Registry.TotalCount))
end

buildShowroom()
