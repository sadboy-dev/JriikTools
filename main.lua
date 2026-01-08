--// JriikTools V1
--// Final Stable UI + Safe Auto Size (Mobile Friendly)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera
local viewport = camera.ViewportSize

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

-- === DEVICE DETECTION ===
local function isMobileDevice()
	return UserInputService.TouchEnabled
		and not UserInputService.KeyboardEnabled
		and not UserInputService.MouseEnabled
end

local isMobile = isMobileDevice()

-- === SAFE AUTO SIZE (REQUESTED) ===
local function safeSize(pxWidth, pxHeight)
	local scaleX = pxWidth / viewport.X
	local scaleY = pxHeight / viewport.Y

	if isMobile then
		scaleX = math.clamp(scaleX, 0, 0.5)
		scaleY = math.clamp(scaleY, 0, 0.35)
	end

	return UDim2.new(scaleX, pxWidth * 0.1, scaleY, pxHeight * 0.1)
end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "JriikTools_V1"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local main = Instance.new("Frame")
main.Parent = gui
main.Size = safeSize(360, 320)
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(32,32,32)
main.BorderSizePixel = 0

-- Header (Drag)
local header = Instance.new("TextLabel")
header.Parent = main
header.Size = UDim2.new(1, 0, 0, 40)
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

UserInputService.InputChanged:Connect(function(i)
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
local tabBar = Instance.new("Frame")
tabBar.Parent = main
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.Size = UDim2.new(1, 0, 0, 36)
tabBar.BackgroundColor3 = Color3.fromRGB(25,25,25)
tabBar.BorderSizePixel = 0

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabBar
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 4)

-- Pages Holder
local pages = Instance.new("Frame")
pages.Parent = main
pages.Position = UDim2.new(0, 0, 0, 76)
pages.Size = UDim2.new(1, 0, 1, -76)
pages.BackgroundTransparency = 1

-- Pages
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
	btn.Size = UDim2.new(0, 95, 1, 0)
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

pageList.Info.Visible = true

-- Label Helper
local function label(parent, text)
	local l = Instance.new("TextLabel")
	l.Parent = parent
	l.Size = UDim2.new(1, -20, 0, 30)
	l.Position = UDim2.new(0, 10, 0, 10)
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = Color3.fromRGB(255,255,255)
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextScaled = true
end

-- Content
label(pageList.Info, "Welcome to JriikTools V1")
label(pageList.Fishing, "Fishing features here")
label(pageList.Shop, "Shop features here")
label(pageList.AutoQuest, "AutoQuest features here")
label(pageList.Teleport, "Teleport features here")
label(pageList.Misc, "Misc features here")
