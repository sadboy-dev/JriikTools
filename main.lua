--// JriikTools V1
--// Base UI - Stable for Mobile (Delta)

-- Services
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

notify("JriikTools V1 Loaded")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "JriikTools_V1"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- === AUTO SIZE (HP FIRST) ===
local screenSize = camera.ViewportSize
local scale

if screenSize.Y < 600 then
	scale = 0.75
elseif screenSize.Y < 720 then
	scale = 0.85
else
	scale = 1
end

local WIDTH = math.floor(360 * scale)
local HEIGHT = math.floor(320 * scale)

-- Main Frame
local main = Instance.new("Frame")
main.Parent = gui
main.Size = UDim2.new(0, WIDTH, 0, HEIGHT)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(32,32,32)
main.BorderSizePixel = 0

-- Header (Drag Area)
local headerHeight = math.floor(40 * scale)
local header = Instance.new("TextLabel")
header.Parent = main
header.Size = UDim2.new(1, 0, 0, headerHeight)
header.BackgroundColor3 = Color3.fromRGB(24,24,24)
header.BorderSizePixel = 0
header.Text = "JriikTools V1"
header.TextColor3 = Color3.fromRGB(255,255,255)
header.TextScaled = true

-- Drag Logic
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
local tabBar = Instance.new("Frame")
tabBar.Parent = main
tabBar.Position = UDim2.new(0, 0, 0, headerHeight)
tabBar.Size = UDim2.new(1, 0, 0, tabBarHeight)
tabBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
tabBar.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabBar
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, math.floor(4 * scale))

-- Pages Holder
local pages = Instance.new("Frame")
pages.Parent = main
pages.Position = UDim2.new(0, 0, 0, headerHeight + tabBarHeight)
pages.Size = UDim2.new(1, 0, 1, -(headerHeight + tabBarHeight))
pages.BackgroundTransparency = 1

-- Page Storage
local pageList = {}

local function createPage(name)
	local page = Instance.new("Frame")
	page.Parent = pages
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Visible = false
	page.BackgroundTransparency = 1
	pageList[name] = page
	return page
end

local function createTab(name)
	local btn = Instance.new("TextButton")
	btn.Parent = tabBar
	btn.Size = UDim2.new(0, math.floor(95 * scale), 1, 0)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
	btn.BorderSizePixel = 0
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(220,220,220)
	btn.TextScaled = true

	btn.MouseButton1Click:Connect(function()
		for _,p in pairs(pageList) do
			p.Visible = false
		end
		pageList[name].Visible = true
		notify("Tab: "..name)
	end)
end

-- Create Pages
createPage("Info")
createPage("Fishing")
createPage("Shop")
createPage("AutoQuest")
createPage("Teleport")
createPage("Misc")

-- Create Tabs
createTab("Info")
createTab("Fishing")
createTab("Shop")
createTab("AutoQuest")
createTab("Teleport")
createTab("Misc")

-- Default Page
pageList.Info.Visible = true

-- Label Helper
local function createLabel(parent, text)
	local lbl = Instance.new("TextLabel")
	lbl.Parent = parent
	lbl.Size = UDim2.new(1, -20, 0, math.floor(30 * scale))
	lbl.Position = UDim2.new(0, 10, 0, 10)
	lbl.BackgroundTransparency = 1
	lbl.Text = text
	lbl.TextColor3 = Color3.fromRGB(255,255,255)
	lbl.TextXAlignment = Enum.TextXAlignment.Left
	lbl.TextScaled = true
end

-- Page Content
createLabel(pageList.Info, "Welcome to JriikTools V1")
createLabel(pageList.Fishing, "Fishing features here")
createLabel(pageList.Shop, "Shop features here")
createLabel(pageList.AutoQuest, "AutoQuest features here")
createLabel(pageList.Teleport, "Teleport features here")
createLabel(pageList.Misc, "Misc features here")
