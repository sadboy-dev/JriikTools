--//JriikTools Beta
local Players = game.GetService("Players")
local UserInputService = game:GetService("UserInputService")
local StaterGui = game:GetService("StarterGui")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer

--Cegah Gui Doble Run
if CoreGui:FindFirstChild("JriikTools") then
  CoreGui.JriikTools:Destroy()
end

local function notify(text)
  pcall(function()
      StarterGui:SetCore("SendNotification", {
          Title = "Info",
          Text = text,
          icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
          Duration = 5
        })
    end)
end

-- Tes Notif
notify("JriikTools Loaded")

-- Device detection
local function isMobileDevice()
	return UserInputService.TouchEnabled
		and not UserInputService.KeyboardEnabled
		and not UserInputService.MouseEnabled
end

local isMobile = isMobileDevice()

-- GUI Size (LOCKED)
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

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.ClipsDescendants = true
MainFrame.Size = GuiSize()

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Dragging Function Mobile
local dragging, dragStart, startPos

MainFrame.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch
	or i.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = i.Position
		startPos = ScreenGui.Position
	end
end)

MainFrame.InputEnded:Connect(function(i)
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

-- Header
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "QU33N"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 18
Title.Font = Enum.Font.GothamBold
Title.Position = UDim.new(0, 14, 0, 0)
Title.Size = UDim.new(0, 100, 0, 30)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel")
Version.Parent = MainFrame
Version.Text = "v1"
Version.TextColor = Color3.fromRGB(150, 150, 150)
Version.TextSize = 14
Version.Font = Enum.Font.Gotham
Version.Position = UDim2.new(0.7, 0, 0, 0)
Version.Size = UDim2.new(0, 20, 0, 30)

-- Tab Bar
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 8, 0, 54)
TabContainer.Size = UDim2.new(1, -16, 0, 42)
TabContainer.ScrollBarThickness = 0
TabContainer.CanvasSize = UDim.new(1.5, 0, 0, 0)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabContainer

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabContainer
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0,6)

local pages = Instance.new("Frame")
pages.parent = TabContainer
pages.Position = UDim2.new(0, 0, 0, 104)
pages.Size = UDim2.new(1, 0, 1, -104)
pages.BackgroundTransparency = 1

local pageList = {}
local tabButttons = {}

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
