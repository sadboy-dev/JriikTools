--// JriikTools V1
--// Header Split Title (Left) + Version (Right)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

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

notify("JriikTools Loaded")

-- Device detection
local function isMobileDevice()
	return UserInputService.TouchEnabled
		and not UserInputService.KeyboardEnabled
		and not UserInputService.MouseEnabled
end

local isMobile = isMobileDevice()

-- GUI size (LOCKED)
local function responsiveSize()
	if isMobile then
		return UDim2.new(0.62, 0, 0.82, 0)
	else
		return UDim2.new(0.30, 0, 0.72, 0)
	end
end

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "JriikTools"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Container
local main = Instance.new("Frame")
main.Parent = gui
main.Size = responsiveSize()
main.Position = UDim2.new(0.5, 0, 0.5, 0)
main.AnchorPoint = Vector2.new(0.5, 0.5)
main.BackgroundColor3 = Color3.fromRGB(28,28,28)
main.BorderSizePixel = 0
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)

-- Header Container (DRAG AREA)
local header = Instance.new("Frame")
header.Parent = main
header.Size = UDim2.new(1, 0, 0, 46)
header.BackgroundColor3 = Color3.fromRGB(18,18,18)
header.BorderSizePixel = 0

-- Title (LEFT)
local title = Instance.new("TextLabel")
title.Parent = header
title.Size = UDim2.new(0.7, 0, 1, 0)
title.Position = UDim2.new(0, 14, 0, 0)
title.BackgroundTransparency = 1
title.Text = "JriikTools"
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.TextYAlignment = Enum.TextYAlignment.Center
title.TextColor3 = Color3.fromRGB(245,245,245)

-- Version (RIGHT)
local version = Instance.new("TextLabel")
version.Parent = header
version.Size = UDim2.new(0.3, -14, 1, 0)
version.Position = UDim2.new(0.7, 0, 0, 0)
version.BackgroundTransparency = 1
version.Text = "V1"
version.Font = Enum.Font.GothamMedium
version.TextSize = 14
version.TextXAlignment = Enum.TextXAlignment.Right
version.TextYAlignment = Enum.TextYAlignment.Center
version.TextColor3 = Color3.fromRGB(170,170,170)

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
		TweenService:Create(main, TweenInfo.new(0.15), {
			Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		}):Play()
	end
end)

-- Tab Bar
local tabBar = Instance.new("Frame")
tabBar.Parent = main
tabBar.Position = UDim2.new(0, 8, 0, 54)
tabBar.Size = UDim2.new(1, -16, 0, 42)
tabBar.BackgroundColor3 = Color3.fromRGB(20,20,20)
tabBar.BorderSizePixel = 0
Instance.new("UICorner", tabBar).CornerRadius = UDim.new(0, 8)

local tabLayout = Instance.new("UIListLayout")
tabLayout.Parent = tabBar
tabLayout.FillDirection = Enum.FillDirection.Horizontal
tabLayout.Padding = UDim.new(0, 6)

-- Pages
local pages = Instance.new("Frame")
pages.Parent = main
pages.Position = UDim2.new(0, 0, 0, 104)
pages.Size = UDim2.new(1, 0, 1, -104)
pages.BackgroundTransparency = 1

local pageList = {}
local tabButtons = {}

local function createPage(name)
	local p = Instance.new("Frame")
	p.Parent = pages
	p.Size = UDim2.new(1, 0, 1, 0)
	p.Visible = false
	p.BackgroundTransparency = 1
	pageList[name] = p
	return p
end

local function setActive(tabName)
	for n,b in pairs(tabButtons) do
		b.BackgroundColor3 = (n == tabName)
			and Color3.fromRGB(60,60,60)
			or Color3.fromRGB(35,35,35)
	end
end

local function createTab(name)
	local b = Instance.new("TextButton")
	b.Parent = tabBar
	b.Size = UDim2.new(0, 78, 1, 0)
	b.BackgroundColor3 = Color3.fromRGB(35,35,35)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	b.TextColor3 = Color3.fromRGB(200,200,200)
	b.BorderSizePixel = 0
	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)

	tabButtons[name] = b

	b.MouseButton1Click:Connect(function()
		for _,p in pairs(pageList) do p.Visible = false end
		pageList[name].Visible = true
		setActive(name)
	end)
end

for _,n in ipairs({
	"Info","Fishing","Shop","AutoQuest","Teleport","Misc"
}) do
	createPage(n)
	createTab(n)
end

pageList.Info.Visible = true
setActive("Info")

-- Content helper
local function label(parent, text)
	local l = Instance.new("TextLabel")
	l.Parent = parent
	l.Size = UDim2.new(1, -20, 0, 34)
	l.Position = UDim2.new(0, 10, 0, 10)
	l.BackgroundTransparency = 1
	l.Text = text
	l.Font = Enum.Font.GothamMedium
	l.TextScaled = true
	l.TextXAlignment = Enum.TextXAlignment.Left
	l.TextColor3 = Color3.fromRGB(245,245,245)
end

label(pageList.Info, "Welcome to JriikTools")
label(pageList.Fishing, "Fishing features here")
label(pageList.Shop, "Shop features here")
label(pageList.AutoQuest, "AutoQuest features here")
label(pageList.Teleport, "Teleport features here")
label(pageList.Misc, "Misc features here")
