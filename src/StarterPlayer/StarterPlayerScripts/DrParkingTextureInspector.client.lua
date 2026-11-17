-- DrParkingTextureInspector.client.lua
-- HUD interativa no Roblox Studio para inspecionar todas as 69 texturas convertidas para Luau,
-- visualizar os 52 sprites de UI recortados, testar o HUD in-game e teleportar pelas 5 alas do Showroom.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local Registry = require(ReplicatedStorage:WaitForChild("DrParkingTextureRegistry"))
local TextureEngine = Registry.Engine

local oldGui = PlayerGui:FindFirstChild("DrParkingTexturesHUD")
if oldGui then
	oldGui:Destroy()
end

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "DrParkingTexturesHUD"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = false
screenGui.Parent = PlayerGui

local function addCorner(inst: Instance, r: number)
	local c = Instance.new("UICorner")
	c.CornerRadius = UDim.new(0, r)
	c.Parent = inst
	return c
end

local function addStroke(inst: Instance, color: Color3, thick: number?)
	local s = Instance.new("UIStroke")
	s.Color = color
	s.Thickness = thick or 2
	s.Parent = inst
	return s
end

-- =========================================================================
-- TOP BAR (Estilo madeira / placa metalica do Dr. Parking 4)
-- =========================================================================
local topBar = Instance.new("Frame")
topBar.Name = "TopBar"
topBar.Size = UDim2.new(0, 740, 0, 54)
topBar.Position = UDim2.new(0.5, -370, 0, 10)
topBar.BackgroundColor3 = Color3.fromRGB(162, 104, 46)
topBar.BorderSizePixel = 0
topBar.Parent = screenGui
addCorner(topBar, 12)
addStroke(topBar, Color3.fromRGB(78, 48, 22), 3)

local titleLbl = Instance.new("TextLabel")
titleLbl.Size = UDim2.new(0, 260, 1, -8)
titleLbl.Position = UDim2.fromOffset(12, 4)
titleLbl.BackgroundTransparency = 1
titleLbl.Font = Enum.Font.FredokaOne
titleLbl.TextSize = 20
titleLbl.TextXAlignment = Enum.TextXAlignment.Left
titleLbl.TextColor3 = Color3.fromRGB(255, 232, 175)
titleLbl.Text = string.format("DR. PARKING LUA (%d/69)", Registry.TotalCount)
titleLbl.Parent = topBar

local function makeTopButton(text: string, xPos: number, w: number, bgCol: Color3): TextButton
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(0, w, 0, 38)
	btn.Position = UDim2.new(0, xPos, 0.5, -19)
	btn.BackgroundColor3 = bgCol
	btn.Font = Enum.Font.GothamBold
	btn.TextSize = 14
	btn.TextColor3 = Color3.new(1, 1, 1)
	btn.Text = text
	btn.AutoButtonColor = true
	btn.Parent = topBar
	addCorner(btn, 8)
	addStroke(btn, Color3.fromRGB(45, 28, 12), 2)
	return btn
end

local btnToggleInspector = makeTopButton("Inspetor (69)", 275, 130, Color3.fromRGB(214, 118, 28))
local btnToggleGameHud = makeTopButton("Preview HUD", 413, 122, Color3.fromRGB(48, 148, 86))
local btnNextWing = makeTopButton("Ala Showroom ->", 543, 185, Color3.fromRGB(62, 120, 198))

-- Wing Quick Teleport Bar
local wingIndex = 0
local wingOrder = {
	{ Key = "Cars", Label = "Ala 1: Carros (30)" },
	{ Key = "ECars", Label = "Ala 2: ECars (7)" },
	{ Key = "Environment", Label = "Ala 3: Ambiente (14)" },
	{ Key = "Objects", Label = "Ala 4: Objetos (12)" },
	{ Key = "UI", Label = "Ala 5: UI & Sprites (6)" },
}

local function teleportToWing(wingKey: string)
	local showroom = Workspace:FindFirstChild("DrParkingTextureShowroom")
	local wings = showroom and showroom:FindFirstChild("ShowroomWings")
	local anchor = wings and wings:FindFirstChild(wingKey)
	local char = LocalPlayer.Character
	local hrp = char and char:FindFirstChild("HumanoidRootPart") :: BasePart?
	if anchor and anchor:IsA("BasePart") and hrp then
		hrp.CFrame = anchor.CFrame + Vector3.new(0, 4, 0)
	end
end

btnNextWing.MouseButton1Click:Connect(function()
	wingIndex = (wingIndex % #wingOrder) + 1
	local info = wingOrder[wingIndex]
	btnNextWing.Text = info.Label
	teleportToWing(info.Key)
end)

-- =========================================================================
-- MODAL DO INSPETOR DE TEXTURAS (69/69 + 52 Sprites)
-- =========================================================================
local modal = Instance.new("Frame")
modal.Name = "InspectorModal"
modal.Size = UDim2.new(0, 760, 0, 470)
modal.Position = UDim2.new(0.5, -380, 0.5, -210)
modal.BackgroundColor3 = Color3.fromRGB(218, 192, 146) -- Papel pardo Dr. Parking
modal.Visible = true
modal.Parent = screenGui
addCorner(modal, 14)
addStroke(modal, Color3.fromRGB(108, 68, 32), 4)

-- Category Tabs
local tabsRow = Instance.new("Frame")
tabsRow.Size = UDim2.new(1, -24, 0, 36)
tabsRow.Position = UDim2.fromOffset(12, 12)
tabsRow.BackgroundTransparency = 1
tabsRow.Parent = modal

local tabLayout = Instance.new("UIListLayout")
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)
tabLayout.Parent = tabsRow

local listScroll = Instance.new("ScrollingFrame")
listScroll.Size = UDim2.new(0, 260, 1, -68)
listScroll.Position = UDim2.fromOffset(12, 56)
listScroll.BackgroundColor3 = Color3.fromRGB(186, 156, 110)
listScroll.BorderSizePixel = 0
listScroll.ScrollBarThickness = 6
listScroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
listScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
listScroll.Parent = modal
addCorner(listScroll, 10)
addStroke(listScroll, Color3.fromRGB(115, 76, 38), 2)

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 4)
listLayout.Parent = listScroll

local listPad = Instance.new("UIPadding")
listPad.PaddingTop = UDim.new(0, 6)
listPad.PaddingBottom = UDim.new(0, 6)
listPad.PaddingLeft = UDim.new(0, 6)
listPad.PaddingRight = UDim.new(0, 6)
listPad.Parent = listScroll

-- Preview Panel
local detailPanel = Instance.new("Frame")
detailPanel.Size = UDim2.new(1, -296, 1, -68)
detailPanel.Position = UDim2.fromOffset(284, 56)
detailPanel.BackgroundColor3 = Color3.fromRGB(32, 36, 44)
detailPanel.BorderSizePixel = 0
detailPanel.Parent = modal
addCorner(detailPanel, 10)
addStroke(detailPanel, Color3.fromRGB(115, 76, 38), 2)

local previewBox = Instance.new("Frame")
previewBox.Name = "PreviewBox"
previewBox.Size = UDim2.new(1, -24, 0, 230)
previewBox.Position = UDim2.fromOffset(12, 12)
previewBox.BackgroundColor3 = Color3.fromRGB(20, 22, 28)
previewBox.BorderSizePixel = 0
previewBox.Parent = detailPanel
addCorner(previewBox, 8)
addStroke(previewBox, Color3.fromRGB(70, 78, 92), 1)

local previewCanvas = Instance.new("Frame")
previewCanvas.Name = "CanvasContainer"
previewCanvas.Size = UDim2.new(1, -16, 1, -16)
previewCanvas.Position = UDim2.fromOffset(8, 8)
previewCanvas.BackgroundTransparency = 1
previewCanvas.ZIndex = 3
previewCanvas.Parent = previewBox

local aspectConstraint = Instance.new("UIAspectRatioConstraint")
aspectConstraint.AspectRatio = 1
aspectConstraint.Parent = previewCanvas

local metaTitle = Instance.new("TextLabel")
metaTitle.Size = UDim2.new(1, -24, 0, 28)
metaTitle.Position = UDim2.fromOffset(12, 250)
metaTitle.BackgroundTransparency = 1
metaTitle.Font = Enum.Font.GothamBold
metaTitle.TextSize = 18
metaTitle.TextXAlignment = Enum.TextXAlignment.Left
metaTitle.TextColor3 = Color3.fromRGB(255, 220, 120)
metaTitle.Text = ""
metaTitle.Parent = detailPanel

local metaBody = Instance.new("TextLabel")
metaBody.Size = UDim2.new(1, -24, 0, 96)
metaBody.Position = UDim2.fromOffset(12, 280)
metaBody.BackgroundTransparency = 1
metaBody.Font = Enum.Font.Code
metaBody.TextSize = 13
metaBody.TextWrapped = true
metaBody.TextXAlignment = Enum.TextXAlignment.Left
metaBody.TextYAlignment = Enum.TextYAlignment.Top
metaBody.TextColor3 = Color3.fromRGB(215, 222, 234)
metaBody.Text = ""
metaBody.Parent = detailPanel

local swatchRow = Instance.new("Frame")
swatchRow.Size = UDim2.new(1, -24, 0, 24)
swatchRow.Position = UDim2.fromOffset(12, 372)
swatchRow.BackgroundTransparency = 1
swatchRow.Parent = detailPanel

local swatchLayout = Instance.new("UIListLayout")
swatchLayout.FillDirection = Enum.FillDirection.Horizontal
swatchLayout.Padding = UDim.new(0, 6)
swatchLayout.Parent = swatchRow

local function selectTextureItem(item, isSprite: boolean?)
	for _, ch in ipairs(swatchRow:GetChildren()) do
		if ch:IsA("Frame") then
			ch:Destroy()
		end
	end

	local ratio = 1
	if isSprite and item.RectSize then
		ratio = math.clamp(item.RectSize.X / math.max(1, item.RectSize.Y), 0.3, 4.0)
		metaTitle.Text = "Sprite: " .. item.Id
		metaBody.Text = string.format(
			"Atlas: %s.png\nRectOffset: (%d, %d)  |  RectSize: %dx%d\nRenderizador: Lua RLE PixelGrid -> EditableImage / GreedyCanvas",
			item.AtlasId,
			item.RectOffset.X,
			item.RectOffset.Y,
			item.RectSize.X,
			item.RectSize.Y
		)
	else
		if item.SourceSize then
			ratio = math.clamp(item.SourceSize.X / math.max(1, item.SourceSize.Y), 0.4, 3.0)
		end
		metaTitle.Text = string.format("%s  [%s]", item.Name or item.Id, string.upper(item.Category or ""))
		local pbrInfo = if item.PBR then "Sim (Albedo + Normal + Roughness 1024px)" else "Textura Direta / UV"
		local sizeTxt = if item.SourceSize then string.format("%dx%d", item.SourceSize.X, item.SourceSize.Y) else "-"
		metaBody.Text = string.format(
			"Id: %s  |  Resolucao Original: %s\nOriginal: %s\nGIMP Enhanced: %s\nPBR: %s",
			item.Id,
			sizeTxt,
			item.OriginalPath or "-",
			item.EnhancedPath or "-",
			pbrInfo
		)

		if item.Palette then
			for key, col in pairs(item.Palette) do
				local sw = Instance.new("Frame")
				sw.Size = UDim2.fromOffset(56, 22)
				sw.BackgroundColor3 = col
				sw.Parent = swatchRow
				addCorner(sw, 4)
				addStroke(sw, Color3.new(1, 1, 1), 1)
				local lbl = Instance.new("TextLabel")
				lbl.Size = UDim2.fromScale(1, 1)
				lbl.BackgroundTransparency = 1
				lbl.Font = Enum.Font.GothamBold
				lbl.TextScaled = true
				lbl.TextColor3 = Color3.new(1, 1, 1)
				lbl.TextStrokeTransparency = 0.2
				lbl.Text = key
				lbl.Parent = sw
			end
		end
	end

	aspectConstraint.AspectRatio = ratio
	TextureEngine.ApplyTextureToGui(previewCanvas, item, true)
end

local currentCategory = "all"
local categoryDefs = {
	{ Id = "all", Label = "Todas (69)" },
	{ Id = "cars", Label = "Carros (30)" },
	{ Id = "ecars", Label = "ECars (7)" },
	{ Id = "envi", Label = "Ambiente (14)" },
	{ Id = "objects", Label = "Objetos (12)" },
	{ Id = "ui", Label = "UI Atlas (6)" },
	{ Id = "sprites", Label = "Sprites UI" },
}

local function populateList(catId: string)
	currentCategory = catId
	for _, ch in ipairs(listScroll:GetChildren()) do
		if ch:IsA("TextButton") then
			ch:Destroy()
		end
	end

	local items = {}
	local isSpriteMode = (catId == "sprites")
	if isSpriteMode then
		local keys = {}
		for k, _ in pairs(Registry.Sprites) do
			table.insert(keys, k)
		end
		table.sort(keys)
		for _, k in ipairs(keys) do
			table.insert(items, Registry.Sprites[k])
		end
	elseif catId == "all" then
		items = Registry.OrderedAll
	else
		items = Registry.Categories[catId] or {}
	end

	for idx, entry in ipairs(items) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1, -6, 0, 32)
		btn.BackgroundColor3 = idx % 2 == 0 and Color3.fromRGB(238, 221, 186) or Color3.fromRGB(246, 232, 204)
		btn.Font = Enum.Font.GothamSemibold
		btn.TextSize = 13
		btn.TextXAlignment = Enum.TextXAlignment.Left
		btn.TextColor3 = Color3.fromRGB(52, 34, 16)
		btn.Text = string.format("  %02d. %s", idx, entry.Id)
		btn.Parent = listScroll
		addCorner(btn, 6)

		btn.MouseButton1Click:Connect(function()
			selectTextureItem(entry, isSpriteMode)
		end)
	end

	if items[1] then
		selectTextureItem(items[1], isSpriteMode)
	end
end

for _, cdef in ipairs(categoryDefs) do
	local tab = Instance.new("TextButton")
	tab.Size = UDim2.new(0, 98, 1, 0)
	tab.BackgroundColor3 = Color3.fromRGB(134, 84, 36)
	tab.Font = Enum.Font.GothamBold
	tab.TextSize = 12
	tab.TextColor3 = Color3.fromRGB(255, 240, 205)
	tab.Text = cdef.Label
	tab.Parent = tabsRow
	addCorner(tab, 8)
	addStroke(tab, Color3.fromRGB(78, 48, 22), 2)

	tab.MouseButton1Click:Connect(function()
		populateList(cdef.Id)
	end)
end

-- =========================================================================
-- PREVIEW HUD IN-GAME (Volante, Pedais, Cambio P-R-N-D, Painel 1a Pessoa)
-- =========================================================================
local hudOverlay = Instance.new("Frame")
hudOverlay.Name = "InGameHUDPreview"
hudOverlay.Size = UDim2.fromScale(1, 1)
hudOverlay.BackgroundTransparency = 1
hudOverlay.Visible = false
hudOverlay.Parent = screenGui

local function mountSpriteOnHud(spriteName: string, pos: UDim2, size: UDim2)
	local sp = Registry.GetSprite(spriteName)
	if not sp then
		return
	end
	local holder = Instance.new("Frame")
	holder.Name = "HUD_" .. spriteName
	holder.Position = pos
	holder.Size = size
	holder.BackgroundTransparency = 1
	holder.Parent = hudOverlay
	TextureEngine.ApplyTextureToGui(holder, sp, true)
	return holder
end

mountSpriteOnHud("SteeringWheel", UDim2.new(0, 28, 1, -210), UDim2.fromOffset(180, 180))
mountSpriteOnHud("BrakePedal", UDim2.new(1, -245, 1, -120), UDim2.fromOffset(72, 95))
mountSpriteOnHud("GasPedal", UDim2.new(1, -162, 1, -152), UDim2.fromOffset(72, 130))
mountSpriteOnHud("GearShifterSlot", UDim2.new(1, -78, 1, -205), UDim2.fromOffset(64, 175))
mountSpriteOnHud("Banner_PERFECT", UDim2.new(0.5, -135, 0, 82), UDim2.fromOffset(270, 72))
mountSpriteOnHud("FirstPersonDashboard", UDim2.new(0.5, -260, 1, -92), UDim2.fromOffset(520, 82))

btnToggleInspector.MouseButton1Click:Connect(function()
	modal.Visible = not modal.Visible
end)

btnToggleGameHud.MouseButton1Click:Connect(function()
	hudOverlay.Visible = not hudOverlay.Visible
	if hudOverlay.Visible then
		modal.Visible = false
	end
end)

populateList("all")
