if not game:IsLoaded() then warn("Waiting till the game is loaded...") game.IsLoaded:Wait() end
-- Player
local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
if PlayerGui:FindFirstChild("SpecterHub") then
	return
elseif PlayerGui:FindFirstChild("HubGuiSmall") then
	warn("Click hub's small icon to open the hub. Rejoin to fix any problems.")
	return
end
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HRP = Character:WaitForChild("HumanoidRootPart")

-- Folders
local Equipment = workspace.Equipment
local NPCs = workspace.NPCs
local Dynamic = workspace.Dynamic
local Evidence = Dynamic.Evidence

-- Services
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- Script

-- Misc
local GameVersion = "V:?, GameEvent:'🦃THANKSGIVING AND MORE!', Updated:11/30/2025"
local HubVersion = "1.1.0" -- 1.10.0 -> 2.0.0; 1.0.10 -> 1.1.0
local HubUpdateLog = "Bug fixes, logic upgrade, new useful buttons, test, release"
local BigNews = "Close button fixed, better UI look, cool idea: extra light - no more flashlight needed!"
local Warning = "ShowAllItems works not good: the background color logic is very bad."
local Codes = {
	code1 = {code = "none", reward = "none"}
}

-- Functions archive
local function AddUICorner(obj, CornerRadius)
    local uiCorner = Instance.new("UICorner")
    uiCorner.Parent = obj
    uiCorner.CornerRadius = CornerRadius
end
local function AddBasicAttributes(instance, Parent, Name, Size, AnchorPoint, Position, BackgroundColor3, BackgroundTransparency, addUICorner, CornerRadius, TextScaled, TextColor3, Text, LayoutOrder)
	local newObj = instance
	newObj.Parent = Parent
	newObj.Name = Name
	newObj.Size = Size
	newObj.AnchorPoint = AnchorPoint
	newObj.BackgroundColor3 = BackgroundColor3
	newObj.BackgroundTransparency = BackgroundTransparency
	if addUICorner then
		AddUICorner(newObj, CornerRadius)
	end
	if not newObj.Parent:FindFirstChildOfClass("UIListLayout") or not newObj.Parent:FindFirstChildOfClass("UIListLayout") then
		newObj.Position = Position
	end
	if instance:IsA("TextButton") or instance:IsA("TextLabel") then
		newObj.TextScaled = TextScaled
		newObj.TextColor3 = TextColor3
		newObj.Text = Text
		newObj.LayoutOrder = LayoutOrder
		return newObj
	end
	if instance:GetAttribute("LayoutOrder") then
		newObj.LayoutOrder = LayoutOrder
	end
	return newObj
end
local function AddButton(Name, Text, Parent, LayoutOrder)-- Position,
    local newButton = Instance.new("TextButton")
    newButton.Parent = Parent
    newButton.Name = Name
    newButton.Size = UDim2.new(0.2, 0, 0.1, 0)
    --newButton.Position = Position
    newButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    newButton.BackgroundTransparency = 0.2
    newButton.TextScaled = true
	newButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    newButton.Text = Text
    newButton.LayoutOrder = LayoutOrder
    AddUICorner(newButton, UDim.new(0, 8))
    return newButton
end
local function AddTextBox(Name, Placeholder, Parent, LayoutOrder)
    local textBox = Instance.new("TextBox")
    textBox.Parent = Parent
    textBox.Name = Name
    textBox.Size = UDim2.new(0.2, 0, 0.1, 0)
    textBox.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    textBox.BackgroundTransparency = 0.2
    textBox.TextScaled = true
    textBox.LayoutOrder = LayoutOrder
    AddUICorner(textBox, UDim.new(0, 4))
    return textBox
end
local function AddUIListLayout(Parent, Name, Padding, FillDirection, HorizontalAlignment, SortOrder, VerticalAlignment)
	local newList = Instance.new("UIListLayout")
	newList.Parent = Parent
	newList.Name = Name
	newList.Padding = Padding
	newList.FillDirection = FillDirection
	newList.HorizontalAlignment = HorizontalAlignment
	newList.SortOrder = SortOrder
	newList.VerticalAlignment = VerticalAlignment
	return newList
end
local function AddScreenGui(Parent, Name, ResetOnSpawn, IgnoreGuiInset)
	local newGui = Instance.new("ScreenGui")
	newGui.Parent = Parent
	newGui.Name = Name
	newGui.ResetOnSpawn = ResetOnSpawn
	newGui.IgnoreGuiInset = IgnoreGuiInset
	return newGui
end

-- Gui
local HubGui = AddScreenGui(PlayerGui, "SpecterHub", false, true)
local Header = AddBasicAttributes(Instance.new("Frame"), HubGui, "Header", UDim2.new(0.8, 0, 0.2, 0), Vector2.new(0.5, 1), UDim2.new(0.5, 0, 0.2, 0), Color3.fromRGB(50, 50, 50), 0.2)--, addUICorner, CornerRadius, TextScaled, TextColor3, Text, LayoutOrder
local Base = AddBasicAttributes(Instance.new("Frame"), HubGui, "Base", UDim2.new(0.8, 0, 0.8, 0), Vector2.new(0.5, 0.5), UDim2.new(0.5, 0, 0.6, 0), Color3.fromRGB(50, 50, 50), 0.1)--, addUICorner, CornerRadius, TextScaled, TextColor3, Text, LayoutOrder
--local UIListLayoutHeader = AddUIListLayout(Header, "HeaderUIListLayout", UDim.new(0.05, 0), Enum.FillDirection.Horizontal, Enum.HorizontalAlignment.Left, Enum.SortOrder.LayoutOrder, Enum.VerticalAlignment.Center)
local UIListLayoutBase = AddUIListLayout(Base, "BaseUIListLayout", UDim.new(0.01, 0), Enum.FillDirection.Vertical, Enum.HorizontalAlignment.Left, Enum.SortOrder.LayoutOrder, Enum.VerticalAlignment.Center)
local HubNameLabel = AddBasicAttributes(Instance.new("TextLabel"), Header, "HubName", UDim2.new(0.2, 0, 0.8, 0), Vector2.new(0, 0.5), UDim2.new(0.02, 0, 0.5, 0), Color3.fromRGB(40, 40, 40), 0.2, true, UDim.new(0.5, 0), true, Color3.fromRGB(255, 255, 255), "SpecterHub", 1)
local PrintInfoButton = AddBasicAttributes(Instance.new("TextButton"), Header, "PrintInfo", UDim2.new(0.1, 0, 0.5, 0), Vector2.new(0, 0.5), UDim2.new(0.25, 0, 0.5, 0), Color3.fromRGB(40, 40, 40), 0.2, true, UDim.new(0.5, 0), true, Color3.fromRGB(255, 255, 255), "PrintInfo", 2)
local PrintCodesButton = AddBasicAttributes(Instance.new("TextButton"), Header, "PrintCodes", UDim2.new(0.1, 0, 0.5, 0), Vector2.new(0, 0.5), UDim2.new(0.4, 0, 0.5, 0), Color3.fromRGB(40, 40, 40), 0.2, true, UDim.new(0.5, 0), true, Color3.fromRGB(255, 255, 255), "PrintCodes", 3)
local CloseButton = AddBasicAttributes(Instance.new("TextButton"), Header, "Close", UDim2.new(0.2, 0, 0.4, 0), Vector2.new(1, 0), UDim2.new(0.95, 0, 0.05, 0), Color3.fromRGB(255, 0, 0), 0.2, true, UDim.new(0, 8), true, Color3.fromRGB(255, 255, 255), "X", 4)
local CrashButton = AddBasicAttributes(Instance.new("TextButton"), Header, "Crash", UDim2.new(0.2, 0, 0.4, 0), Vector2.new(1, 0), UDim2.new(0.95, 0, 0.55, 0), Color3.fromRGB(255, 0, 0), 0.2, true, UDim.new(0, 8), true, Color3.fromRGB(255, 255, 255), "Crash", 5)

-- Add buttons
local ShowAllItems = AddButton("ShowAllItems", "ShowAllItems", Base, 1)
ShowAllItems.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
--local HideAllItemsGui = AddButton("HideAllItemsGui", "HideAllItemsGui", Base, 2)
local PrintAllEvidents = AddButton("PrintAllEvidents", "PrintAllEvidents", Base, 3)
local GotoVan = AddButton("GotoVan", "GotoVan", Base, 4)
local EnableAdmin = AddButton("EnableAdmin", "EnableAdmin", Base, 5)
EnableAdmin.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local MarkGhost = AddButton("MarkGhost", "MarkGhost", Base, 6)
MarkGhost.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local GotoCloset = AddButton("GotoCloset", "GotoCloset", Base, 7)
local ExtraLight = AddButton("ExtraLight", "ExtraLight", Base, 8)
ExtraLight.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local DisableWalls = AddButton("DisableWalls", "DisableWalls", Base, 9)
DisableWalls.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
local FastMode = AddButton("FastMode", "FastMode", Base, 10)
FastMode.BackgroundColor3 = Color3.fromRGB(255, 0, 0)

-- Button click
PrintInfoButton.MouseButton1Click:Connect(function()
    print(GameVersion)
    print(HubVersion)
    print(HubUpdateLog)
	print(Warning)
end)
PrintCodesButton.MouseButton1Click:Connect(function()
	for _, code in pairs(Codes) do
		print(code.code)
		print("reward(s):")
		print(code.reward)
	end
end)
CloseButton.MouseButton1Click:Connect(function()
	if HubGui:IsDescendantOf(PlayerGui) then
		HubGui.Enabled = false
		if PlayerGui:FindFirstChild("HubGuiSmall") then warn("Click hub's small icon to open the hub. Rejoin to fix any problems.") return end

		local HubGuiSmall = AddScreenGui(PlayerGui, "HubGuiSmall", false, true)
		--[[local HubGuiSmall = Instance.new("ScreenGui")
		HubGuiSmall.Parent = PlayerGui
		HubGuiSmall.Name = "HubGuiSmall"
		HubGuiSmall.ResetOnSpawn = false
		HubGuiSmall.IgnoreGuiInset = true]]
		local IconOpenButton = AddBasicAttributes(Instance.new("ImageButton"), HubGuiSmall, "HubGuiSmall", UDim2.new(0, 50, 0, 50), Vector2.new(0.5, 0), UDim2.new(0.5, 0, 0.05, 0), Color3.fromRGB(50, 50, 50), 0, true, UDim.new(1, 0), false, Color3.fromRGB(0, 0, 0), "", 1)
		IconOpenButton.MouseButton1Click:Connect(function()
			HubGuiSmall:Destroy()
			if not HubGui.Enabled then HubGui.Enabled = true end
		end)
	else
		error(HubGui.Name.." not found.")
	end
end)
CrashButton.MouseButton1Click:Connect(function()
	if HubGui then
		HubGui:Destroy()
	end
end)
-- -- other
ShowAllItems.MouseButton1Click:Connect(function()
	for _, obj in pairs(Equipment:GetChildren()) do
		if obj:FindFirstChild("Mark") then
			obj.Mark:Destroy()
			ShowAllItems.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			continue
		end

		local MarkGui = Instance.new("BillboardGui")
		MarkGui.Parent = obj
		MarkGui.Name = "Mark"
		MarkGui.Size = UDim2.new(0, 50, 0, 50)
		MarkGui.AlwaysOnTop = true
		MarkGui.ResetOnSpawn = false
		MarkGui.MaxDistance = 1000
		local Mark = Instance.new("TextLabel")
		Mark.Parent = MarkGui
		Mark.Name = "Mark"
		Mark.Size = UDim2.new(1, 0, 1, 0)
		Mark.TextWrapped = true
		if obj.PrimaryPart.Color == Color3.fromRGB(159, 161, 172) then
			Mark.TextColor3 = Color3.fromRGB(106, 57, 9)
		else
			Mark.TextColor3 = obj.PrimaryPart.Color
		end
		Mark.Text = obj.Name
		ShowAllItems.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	end
end)
--[[HideAllItemsGui.MouseButton1Click:Connect(function()
	for _, obj in pairs(Equipment:GetChildren()) do
		if obj:FindFirstChild("Mark") then
			obj.Mark:Destroy()
		end
	end
end)]]
PrintAllEvidents.MouseButton1Click:Connect(function()
	local EMF = Evidence.EMF
	local Fingerprints = Evidence.Fingerprints
	local MotionGrids = Evidence.MotionGrids
	local Orbs = Evidence.Orbs

	-- Frezing temperature

	-- EMF
	if EMF:FindFirstAncestorOfClass("Model") then
		for _, emf in pairs(EMF:GetChildren()) do
			if emf.Name == "EMF5" then
				print("EMF5: true")
			else
				print("EMF5: false")
			end
		end
	else
		print("EMF5: ?working EMF required.")
	end
	--[[EMF.ChildAdded:Connect(function(child)
		if child.Name == "EMF5" then
			print("EMF5: true")
		else
			print("EMF5: false")
		end
	end)]]
	-- Fingerprints
	if Fingerprints:FindFirstChild("Fingerprint") then
		print("Fingerprints: true")
	else
		print("Fingerprints: false")
	end
	-- MotionGrids
	if MotionGrids:FindFirstChild("SensorGrid") then
		local SensorGrid = MotionGrids.SensorGrid
		local Grid = SensorGrid.Part
		if Grid.BrickColor == BrickColor.new("Red") then
			print("Paranormal motion: true")
		elseif Grid.BrickColor == BrickColor.new("Blue") then
			print("Paranormal motion: false")
		else
			print("Paranormal motion: ?must wait")
			Grid.AttributeChanged:Connect(function()
				if Grid.BrickColor == BrickColor.new("Red") then
					print("Paranormal motion: true")
				elseif Grid.BrickColor == BrickColor.new("Blue") then
					print("Paranormal motion: false")
				end
			end)
		end
	else
		print("Paranormal motion: ?place down at least one sensor grid at right place.")
	end
	-- Orbs
	--[[Orbs.ChildAdded:Connect(function()
		print("Orbs: true")
	end)]]
	if Orbs:FindFirstChild("Orb") then
		print("Orbs: true")
	else
		print("Orbs: false --if not working, you need to equip goggles and walk a little far from the van.")
	end

	-- Spirit box

	-- Ghost writing
	local Book = Equipment:WaitForChild("Book", 20)
	if Book then
		if Book.LeftPage:FindFirstChildOfClass("Decal") or Book.RightPage:FindFirstChildOfClass("Decal") then
			print("Ghost writing: true")
		else
			print("Ghost writing: false")
		end
	else
		print("Ghost writing: ?wait timeout, place a book in the right place.")
	end
	
end)
GotoVan.MouseButton1Click:Connect(function()
	local Van = workspace:WaitForChild("Van")
	local Spawn = Van:WaitForChild("Spawn")
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
	local tween = TweenService:Create(HRP, tweenInfo, {CFrame = Spawn.CFrame})
	tween:Play()
end)
EnableAdmin.MouseButton1Click:Connect(function()
	local AdminObserver = PlayerGui:WaitForChild("AdminObserver")
	if not AdminObserver.Enabled then
		AdminObserver.Enabled = true
		EnableAdmin.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
	elseif AdminObserver.Enabled then
		AdminObserver.Enabled = false
		EnableAdmin.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
	end
end)
MarkGhost.MouseButton1Click:Connect(function()
	local GLOBAL_NPCs = NPCs:WaitForChild("GLOBAL")
	
	if GLOBAL_NPCs:FindFirstChild("GhostHighlight", true) then
		GLOBAL_NPCs.GhostHighlight:Destroy()

		MarkGhost.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	else
		local GhostHighlight = Instance.new("Highlight")
		GhostHighlight.Parent = GLOBAL_NPCs
		GhostHighlight.Name = "GhostHighlight"
		GhostHighlight.FillColor = Color3.fromRGB(255, 255, 255)
		GhostHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
		GhostHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

		MarkGhost.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	end
	local GLOBAL_ServerNPCs = workspace.ServerNPCs:WaitForChild("GLOBAL")
	if GLOBAL_ServerNPCs:FindFirstChild("GhostHighlight", true) then
		GLOBAL_ServerNPCs.GhostHighlight:Destroy()

		MarkGhost.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	else
		local GhostHighlight = Instance.new("Highlight")
		GhostHighlight.Parent = GLOBAL_ServerNPCs
		GhostHighlight.Name = "GhostHighlight"
		GhostHighlight.FillColor = Color3.fromRGB(255, 255, 255)
		GhostHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
		GhostHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

		MarkGhost.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	end
end)
GotoCloset.MouseButton1Click:Connect(function()
	local Closets = workspace.Map:WaitForChild("Closets")
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In, 0, false, 0)
	local tween = TweenService:Create(HRP, tweenInfo, {CFrame = Closets.Closet.OutsideSpot.CFrame})
	tween:Play()
end)
ExtraLight.MouseButton1Click:Connect(function()
	if not Character.Head:FindFirstChild("ExtraLight") then
		local ExtraLightSpotlight = Instance.new("SpotLight")
		ExtraLightSpotlight.Parent = Character.Head
		ExtraLightSpotlight.Name = "ExtraLight"
		ExtraLightSpotlight.Angle = 75
		ExtraLightSpotlight.Brightness = 1
		ExtraLightSpotlight.Color = Color3.fromRGB(255, 255, 255)
		ExtraLightSpotlight.Enabled = false
		ExtraLightSpotlight.Face = "Front"
		ExtraLightSpotlight.Range = 30
		ExtraLightSpotlight.Shadows = true
	end
	if not Character.Head.ExtraLight.Enabled then
		Character.Head.ExtraLight.Enabled = true
		ExtraLight.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
	else
		Character.Head.ExtraLight.Enabled = false
		ExtraLight.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	end
end)
DisableWalls.MouseButton1Click:Connect(function()
	local BrickParts = workspace.Map.Building.Parts.BrickWalls:WaitForChild("BrickParts")
	
	if #BrickParts > 0 then
		for _, obj in pairs(BrickParts:GetChildren()) do
			if obj.CanCollide then
				obj.CanCollide = false
				DisableWalls.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
			elseif not obj.CanCollide then
				obj.CanCollide = true
				DisableWalls.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
			end
		end
	end
end)
FastMode.MouseButton1Click:Connect(function()
	warn("W.I.P")
end)
