-- JriikTools V1
-- STEP 6 - AUTO SIZE (HP FRIENDLY)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

-- Notification
local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Console",
			Text = text,
			Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
			Duration = 5
		})
	end)
end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "JriikTools_V1"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- === AUTO SIZE CALCULATION ===
local screenSize = camera.ViewportSize

-- HP FIRST scaling
local scale
if screenSize.Y < 600 then
	scale = 0.75
elseif screenSize.Y < 720 then
	scale = 0.85
else
	scale = 1
end

local WIDTH = math.floor(330 * scale)
local HEIGHT = math.floor(320 * scale)

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, WIDTH, 0, HEIGHT)
main.Position = UDim2.new(0.5, -WIDTH / 2, 0.5, -HEIGHT / 2)
main.BackgroundColor3 = Color3.fromRGB(32,32,32)

-- Header (Drag)
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1, 0, 0, math.floor(40 * scale))
header.BackgroundTransparency = 1
header.Text = "JriikTools V1"
header.TextColor3 = Color3.fromRGB(255,255,255)
header.TextScaled = true

-- Drag logic
local dragging, dragStart, startPos
header.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch
	or i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = main.Position
	end
end)
header.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch
	or i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
UIS.InputChanged:Connect(function(i)
	if dragging and (
		i.UserInputType == Enum.UserInputType.Touch
		or i.UserInputType == Enum.UserInputType.MouseMovement
	) then
		local delta = i.Position - dragStart
		main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Tab Bar
local tabBarHeight = math.floor(36 * scale)
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0, 0, 0, header.Size.Y.Offset)
tabBar.Size = UDim2.new(1, 0, 0, tabBarHeight)
tabBar.BackgroundColor3 = Color3.fromRGB(25,25,25)

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, math.floor(4 * scale))

-- Pages holder
local pages = Instance.new("Frame", main)
pages.Position = UDim2.new(0, 0, 0, header.Size.Y.Offset + tabBarHeight)
pages.Size = UDim2.new(1, 0, 1, -(header.Size.Y.Offset + tabBarHeight))
pages.BackgroundTransparency = 1

-- Pages
local pageList = {}

local function createPage(name)
	local page = Instance.new("Frame", pages)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Visible = false
	page.BackgroundTransparency = 1
	pageList[name] = page
	return page
end

-- Tabs
local function createTab(name)
	local btn = Instance.new("TextButton", tabBar)
	btn.Size = UDim2.new(0, math.floor(100 * scale), 1, 0)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(220,220,220)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
	btn.TextScaled = true

	btn.MouseButton1Click:Connect(function()
		for _,p in pairs(pageList) do
			p.Visible = false
		end
		pageList[name].Visible = true
		notify("Tab : "..name)
	end)
end

-- Create pages
createPage("Info")
createPage("Fishing")
createPage("Shop")
createPage("AutoQuest")
createPage("Teleport")
createPage("Misc")

-- Create tabs
createTab("Info")
createTab("Fishing")
createTab("Shop")
createTab("AutoQuest")
createTab("Teleport")
createTab("Misc")

-- Default
pageList["Info"].Visible = true

-- Content label helper
local function label(parent, text)
	local l = Instance.new("TextLabel", parent)
	l.Size = UDim2.new(1, -20, 0, math.floor(30 * scale))
	l.Position = UDim2.new(0, 10, 0, 10)
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = Color3.fromRGB(255,255,255)
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextScaled = true
end

label(pageList.Info, "Welcome to JriikTools V1")
label(pageList.Fishing, "Fishing features here")
label(pageList.Shop, "Shop features here")
label(pageList.AutoQuest, "AutoQuest features here")
label(pageList.Teleport, "Teleport features here")
label(pageList.Misc, "Misc features here")
