-- DrParkingTextureRegistry.lua
-- Registro unificado das 69 texturas originais melhoradas do Dr. Parking 4 convertidas para Luau.
-- Indexa todas as texturas por Id, Caminho Original e Categoria (cars, ecars, envi, objects, ui).

local TexturesFolder = script.Parent:WaitForChild("Textures")

local CarTexturesData = require(TexturesFolder:WaitForChild("CarTexturesData"))
local EnvironmentTexturesData = require(TexturesFolder:WaitForChild("EnvironmentTexturesData"))
local ObjectTexturesData = require(TexturesFolder:WaitForChild("ObjectTexturesData"))
local UITexturesData = require(TexturesFolder:WaitForChild("UITexturesData"))
local TextureEngine = require(script.Parent:WaitForChild("DrParkingTextureEngine"))

local DrParkingTextureRegistry = {
	ById = {} :: { [string]: any },
	ByPath = {} :: { [string]: any },
	OrderedAll = {} :: { any },
	Categories = {
		cars = {} :: { any },
		ecars = {} :: { any },
		envi = {} :: { any },
		objects = {} :: { any },
		ui = {} :: { any },
	},
	Sprites = UITexturesData.Sprites,
	Engine = TextureEngine,
}

local function registerEntry(entry)
	DrParkingTextureRegistry.ById[entry.Id] = entry
	if entry.OriginalPath then
		DrParkingTextureRegistry.ByPath[entry.OriginalPath] = entry
	end
	table.insert(DrParkingTextureRegistry.OrderedAll, entry)
	local catList = DrParkingTextureRegistry.Categories[entry.Category]
	if catList then
		table.insert(catList, entry)
	end
end

-- 1. Cars (30 textures: car000..car141)
for i = 0, 14 do
	for skin = 0, 1 do
		local id = string.format("car%02d%d", i, skin)
		if CarTexturesData[id] then
			registerEntry(CarTexturesData[id])
		end
	end
end

-- 2. ECars (7 textures: ecar00..ecar06)
for i = 0, 6 do
	local id = string.format("ecar%02d", i)
	if EnvironmentTexturesData.ECars[id] then
		registerEntry(EnvironmentTexturesData.ECars[id])
	end
end

-- 3. Environment (14 textures)
local enviOrder = {
	"arrow", "asphalt", "brakelight", "building", "coin", "ground",
	"lot", "random", "reverselight", "shadow", "shadow_obj",
	"tire00", "tire01", "wall",
}
for _, id in ipairs(enviOrder) do
	if EnvironmentTexturesData.Envi[id] then
		registerEntry(EnvironmentTexturesData.Envi[id])
	end
end

-- 4. Objects (12 textures)
local objOrder = {
	"barrier", "box", "cone", "display", "display01", "display02",
	"fence", "grass", "grasscircle", "grasssector", "grasstriangle", "sign",
}
for _, id in ipairs(objOrder) do
	if ObjectTexturesData[id] then
		registerEntry(ObjectTexturesData[id])
	end
end

-- 5. UI & Atlases (6 textures)
local uiOrder = { "ui", "menu", "world", "logo", "background", "icon" }
for _, id in ipairs(uiOrder) do
	if UITexturesData.Atlases[id] then
		registerEntry(UITexturesData.Atlases[id])
	end
end

DrParkingTextureRegistry.TotalCount = #DrParkingTextureRegistry.OrderedAll

function DrParkingTextureRegistry.Get(idOrPath: string)
	return DrParkingTextureRegistry.ById[idOrPath] or DrParkingTextureRegistry.ByPath[idOrPath]
end

function DrParkingTextureRegistry.GetCarSkin(carId: number, skinIndex: number?)
	local id = string.format("car%02d%d", math.clamp(carId, 0, 14), skinIndex == 1 and 1 or 0)
	return DrParkingTextureRegistry.ById[id]
end

function DrParkingTextureRegistry.GetSprite(spriteName: string)
	return DrParkingTextureRegistry.Sprites[spriteName]
end

function DrParkingTextureRegistry.BuildParkingLot(variant: string, originCF: CFrame, parent: Instance?): Model
	local lotEntry = DrParkingTextureRegistry.ById["lot"]
	local color = Color3.fromRGB(238, 242, 246)
	if variant == "green" or variant == "lotgreen" then
		color = lotEntry.LotVariants.lotgreen
	elseif variant == "yellow" or variant == "lotyellow" then
		color = lotEntry.LotVariants.lotyellow
	end

	local model = Instance.new("Model")
	model.Name = "ParkingLot_" .. variant
	model.Parent = parent

	-- Standard Dr. Parking 4 slot: 2.0 x 5.0 units -> ~4.8 x 12.0 studs
	local w, l, thick = 5.4, 12.2, 0.08
	local border = 0.35

	local function stripe(name, size, cf)
		local p = Instance.new("Part")
		p.Name = name
		p.Anchored = true
		p.CanCollide = false
		p.CanTouch = false
		p.CastShadow = false
		p.Material = variant == "green" and Enum.Material.Neon or Enum.Material.SmoothPlastic
		p.Color = color
		p.Size = size
		p.CFrame = cf
		p.Parent = model
		return p
	end

	local left = stripe("Line_L", Vector3.new(border, thick, l), originCF * CFrame.new(-w / 2, thick / 2, 0))
	stripe("Line_R", Vector3.new(border, thick, l), originCF * CFrame.new(w / 2, thick / 2, 0))
	stripe("Line_Back", Vector3.new(w + border, thick, border), originCF * CFrame.new(0, thick / 2, l / 2))
	stripe("Line_Front", Vector3.new(w + border, thick, border), originCF * CFrame.new(0, thick / 2, -l / 2))
	model.PrimaryPart = left

	return model
end

function DrParkingTextureRegistry.BuildEnvironmentPiece(id: string, originCF: CFrame, parent: Instance?): Model
	local entry = DrParkingTextureRegistry.ById[id]
	assert(entry, "Unknown environment texture id: " .. tostring(id))

	local model = Instance.new("Model")
	model.Name = "Env_" .. id
	model.Parent = parent

	local main = Instance.new("Part")
	main.Name = "MeshBody"
	main.Anchored = true
	main.CanCollide = false
	main.CanTouch = false
	main.CastShadow = true
	main.Material = entry.Material or Enum.Material.SmoothPlastic
	main.Color = entry.Palette.Primary

	if id == "coin" then
		main.Shape = Enum.PartType.Cylinder
		main.Size = Vector3.new(0.45, 2.6, 2.6)
		main.CFrame = originCF * CFrame.new(0, 2.0, 0)
		main.Color = Color3.fromRGB(255, 204, 38)
		main.Reflectance = 0.25
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Right, entry, 28)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Left, entry, 28)
	elseif id == "tire00" or id == "tire01" then
		main.Shape = Enum.PartType.Cylinder
		main.Size = Vector3.new(1.4, 3.8, 3.8)
		main.CFrame = originCF * CFrame.new(0, 1.9, 0)
		main.Color = Color3.fromRGB(28, 30, 34)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Right, entry, 24)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Left, entry, 24)
	elseif id == "arrow" then
		main.Size = Vector3.new(2.2, 3.2, 0.5)
		main.CFrame = originCF * CFrame.new(0, 3.6, 0)
		main.Color = Color3.fromRGB(255, 212, 35)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Front, entry, 28)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Back, entry, 28)
	elseif id == "random" then
		main.Size = Vector3.new(3.2, 3.2, 3.2)
		main.CFrame = originCF * CFrame.new(0, 1.8, 0)
		main.Color = Color3.fromRGB(255, 130, 24)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Front, entry, 24)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Top, entry, 24)
	elseif id == "wall" then
		main.Size = Vector3.new(9.0, 4.2, 1.2)
		main.CFrame = originCF * CFrame.new(0, 2.1, 0)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Front, entry, 24)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Back, entry, 24)
	elseif id == "building" then
		main.Size = Vector3.new(9.0, 9.0, 3.2)
		main.CFrame = originCF * CFrame.new(0, 4.5, 0)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Front, entry, 18)
	else
		-- ground, asphalt, lot, shadow, shadow_obj, brakelight, reverselight
		main.Size = Vector3.new(5.5, 0.25, 5.5)
		main.CFrame = originCF * CFrame.new(0, 0.15, 0)
		TextureEngine.CreateSurfaceTextureDisplay(main, Enum.NormalId.Top, entry, 22)
	end

	main.Parent = model
	model.PrimaryPart = main
	return model
end

return DrParkingTextureRegistry
