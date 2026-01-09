--// JriikTools Beta

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

-- Prevent double GUI
if CoreGui:FindFirstChild("JriikTools") then
	CoreGui.JriikTools:Destroy()
end

-- Notification
local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Info",
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

-- GUI Size
local function GuiSize()
	if isMobile then
		return UDim2.new(0.62, 0, 0.82, 0)
	else
		return UDim2.new(0.30, 0, 0.72, 0)
	end
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JriikTools"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.Size = GuiSize()
MainFrame.ClipsDescendants = true

Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 8)

-- Dragging (Mobile + PC)
local dragging = false
local dragStart
local startPos

MainFrame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = MainFrame.Position
	end
end)

MainFrame.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		local delta = input.Position - dragStart
		TweenService:Create(MainFrame, TweenInfo.new(0.15), {
			Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		}):Play()
	end
end)

-- Header
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "QU33N"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Position = UDim2.new(0, 14, 0, 0)
Title.Size = UDim2.new(0, 120, 0, 30)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel")
Version.Parent = MainFrame
Version.Text = "v1"
Version.TextColor3 = Color3.fromRGB(150, 150, 150)
Version.TextSize = 14
Version.Font = Enum.Font.Gotham
Version.Position = UDim2.new(1, -40, 0, 0)
Version.Size = UDim2.new(0, 30, 0, 30)
Version.BackgroundTransparency = 1

-- Tab Bar
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 8, 0, 40)
TabContainer.Size = UDim2.new(1, -16, 0, 42)
TabContainer.ScrollBarThickness = 0
TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

Instance.new("UICorner", TabContainer).CornerRadius = UDim.new(0, 6)

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabContainer
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 6)

-- Pages container
local Pages = Instance.new("Frame")
Pages.Parent = MainFrame
Pages.Position = UDim2.new(0, 0, 0, 90)
Pages.Size = UDim2.new(1, 0, 1, -90)
Pages.BackgroundTransparency = 1

local pageList = {}
local tabButtons = {}

-- Create Page
local function createPage(name)
	local p = Instance.new("Frame")
	p.Parent = Pages
	p.Size = UDim2.new(1, 0, 1, 0)
	p.BackgroundTransparency = 1
	p.Visible = false
	pageList[name] = p
	return p
end

-- Set Active Tab
local function setActive(tabName)
	for name, button in pairs(tabButtons) do
		button.BackgroundColor3 = (name == tabName)
			and Color3.fromRGB(60, 60, 60)
			or Color3.fromRGB(35, 35, 35)
	end
end

-- Create Tab
local function createTab(name)
	local b = Instance.new("TextButton")
	b.Parent = TabContainer
	b.Size = UDim2.new(0, 90, 1, 0)
	b.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
	b.Text = name
	b.Font = Enum.Font.GothamBold
	b.TextScaled = true
	b.TextColor3 = Color3.fromRGB(220, 220, 220)
	b.BorderSizePixel = 0

	Instance.new("UICorner", b).CornerRadius = UDim.new(0, 6)
	tabButtons[name] = b

	b.MouseButton1Click:Connect(function()
		for _, p in pairs(pageList) do
			p.Visible = false
		end
		pageList[name].Visible = true
		setActive(name)
	end)
end

-- Tabs
for _, name in ipairs({
	"Info", "Fishing", "Shop", "AutoQuest", "Teleport", "Misc"
}) do
	createPage(name)
	createTab(name)
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
	l.TextColor3 = Color3.fromRGB(245, 245, 245)
end

-- Page content
label(pageList.Info, "Welcome to JriikTools")
label(pageList.Fishing, "Fishing features here")
label(pageList.Shop, "Shop features here")
label(pageList.AutoQuest, "AutoQuest features here")
label(pageList.Teleport, "Teleport features here")
label(pageList.Misc, "Misc features here")
