-- JriikTools V1
-- STEP 5 - TAB SYSTEM MANUAL (HP SAFE)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer

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

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 330, 0, 320)
main.Position = UDim2.new(0.5, -165, 0.5, -160)
main.BackgroundColor3 = Color3.fromRGB(32,32,32)

-- Header (Drag)
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1, 0, 0, 40)
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
local tabBar = Instance.new("Frame", main)
tabBar.Position = UDim2.new(0, 0, 0, 40)
tabBar.Size = UDim2.new(1, 0, 0, 36)
tabBar.BackgroundColor3 = Color3.fromRGB(25,25,25)

local tabLayout = Instance.new("UIListLayout", tabBar)
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 4)

-- Content Holder
local pages = Instance.new("Frame", main)
pages.Position = UDim2.new(0, 0, 0, 76)
pages.Size = UDim2.new(1, 0, 1, -76)
pages.BackgroundTransparency = 1

-- Create Page
local pageList = {}

local function createPage(name)
	local page = Instance.new("Frame", pages)
	page.Size = UDim2.new(1, 0, 1, 0)
	page.Visible = false
	page.BackgroundTransparency = 1
	pageList[name] = page
	return page
end

-- Create Tab Button
local function createTab(name)
	local btn = Instance.new("TextButton", tabBar)
	btn.Size = UDim2.new(0, 100, 1, 0)
	btn.Text = name
	btn.TextColor3 = Color3.fromRGB(220,220,220)
	btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
	btn.TextSize = 14

	btn.MouseButton1Click:Connect(function()
		for _,p in pairs(pageList) do
			p.Visible = false
		end
		pageList[name].Visible = true
		notify("Tab : "..name)
	end)
end

-- Pages
local Info = createPage("Info")
local Fishing = createPage("Fishing")
local Shop = createPage("Shop")
local AutoQuest = createPage("AutoQuest")
local Teleport = createPage("Teleport")
local Misc = createPage("Misc")

-- Tabs
createTab("Info")
createTab("Fishing")
createTab("Shop")
createTab("AutoQuest")
createTab("Teleport")
createTab("Misc")

-- Default Page
pageList["Info"].Visible = true

-- Example content
local function label(parent, text)
	local l = Instance.new("TextLabel", parent)
	l.Size = UDim2.new(1, -20, 0, 30)
	l.Position = UDim2.new(0, 10, 0, 10)
	l.BackgroundTransparency = 1
	l.Text = text
	l.TextColor3 = Color3.fromRGB(255,255,255)
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextSize = 16
end

label(Info, "Welcome to JriikTools V1")
label(Fishing, "Fishing features here")
label(Shop, "Shop features here")
label(AutoQuest, "AutoQuest features here")
label(Teleport, "Teleport features here")
label(Misc, "Misc features here")
