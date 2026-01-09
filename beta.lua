--// Aikoware UI - FIXED v2 (Delta Mobile)

-- Services
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Detect mobile
local function isMobileDevice()
	return UserInputService.TouchEnabled
		and not UserInputService.KeyboardEnabled
		and not UserInputService.MouseEnabled
end
local isMobile = isMobileDevice()

-- Remove old GUI
if CoreGui:FindFirstChild("Aikoware") then
	CoreGui.Aikoware:Destroy()
end

-- Theme
local Theme = {
	BG = Color3.fromRGB(15,17,21),
	Panel = Color3.fromRGB(26,30,36),
	Text = Color3.fromRGB(235,235,235),
	SubText = Color3.fromRGB(155,160,166),
	Accent = Color3.fromRGB(79,139,255)
}

-- GUI size (LOCKED)
local function responsiveSize()
	if isMobile then
		return UDim2.new(0.62, 0, 0.82, 0)
	else
		return UDim2.new(0.30, 0, 0.72, 0)
	end
end

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Aikoware"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- Main
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.52, 0)
Main.Size = responsiveSize()
Main.BackgroundColor3 = Theme.BG
Main.ClipsDescendants = true
Main.ZIndex = 1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

-- Drag (mobile)
local dragging, dragStart, startPos
Main.InputBegan:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = i.Position
		startPos = Main.Position
	end
end)

UserInputService.InputChanged:Connect(function(i)
	if dragging and i.UserInputType == Enum.UserInputType.Touch then
		local delta = i.Position - dragStart
		Main.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

UserInputService.InputEnded:Connect(function(i)
	if i.UserInputType == Enum.UserInputType.Touch then
		dragging = false
	end
end)

-- Header
local Header = Instance.new("Frame", Main)
Header.Position = UDim2.new(0,16,0,14)
Header.Size = UDim2.new(1,-32,0,56)
Header.BackgroundTransparency = 1
Header.ZIndex = 2

local Title = Instance.new("TextLabel", Header)
Title.Text = "Aikoware"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 30
Title.TextColor3 = Theme.Text
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,1,0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2

-- Tab Bar
local TabBar = Instance.new("ScrollingFrame", Main)
TabBar.Position = UDim2.new(0,16,0,78)
TabBar.Size = UDim2.new(1,-32,0,46)
TabBar.CanvasSize = UDim2.new(0,0,0,0)
TabBar.ScrollBarThickness = 0
TabBar.BackgroundColor3 = Theme.Panel
TabBar.ZIndex = 10
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0,14)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.Padding = UDim.new(0,14)
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Pages
local Pages = Instance.new("Frame", Main)
Pages.Position = UDim2.new(0,16,0,132)
Pages.Size = UDim2.new(1,-32,1,-148)
Pages.BackgroundTransparency = 1
Pages.ZIndex = 1

local pageList = {}
local tabButtons = {}

local function setActive(tabName)
	for name,btn in pairs(tabButtons) do
		btn.TextColor3 = (name == tabName) and Theme.Accent or Theme.SubText
		pageList[name].Visible = (name == tabName)
	end
end

local function createTab(name)
	local b = Instance.new("TextButton")
	b.Parent = TabBar
	b.Size = UDim2.new(0,90,1,0)
	b.Text = name
	b.Font = Enum.Font.GothamMedium
	b.TextSize = 15
	b.TextColor3 = Theme.SubText
	b.BackgroundTransparency = 1
	b.ZIndex = 11

	tabButtons[name] = b

	b.MouseButton1Click:Connect(function()
		setActive(name)
	end)
end

local function createPage(name)
	local p = Instance.new("Frame")
	p.Parent = Pages
	p.Size = UDim2.new(1,0,1,0)
	p.BackgroundTransparency = 1
	p.Visible = false
	pageList[name] = p
end

-- Tabs
for _,name in ipairs({
	"Home","Fishing","Shop","Auto Fav","Teleport","Trade","Webhook"
}) do
	createTab(name)
	createPage(name)
end

setActive("Fishing")

-- Simple content helper
local function label(parent,text,y)
	local l = Instance.new("TextLabel", parent)
	l.Text = text
	l.Font = Enum.Font.Gotham
	l.TextSize = 18
	l.TextColor3 = Theme.Text
	l.BackgroundTransparency = 1
	l.Position = UDim2.new(0,0,0,y)
	l.Size = UDim2.new(1,0,0,30)
	l.TextXAlignment = Enum.TextXAlignment.Left
end

label(pageList.Home,"Home Page",10)
label(pageList.Fishing,"Fishing Page",10)
label(pageList.Shop,"Shop Page",10)
label(pageList["Auto Fav"],"Auto Favorite Page",10)
label(pageList.Teleport,"Teleport Page",10)
label(pageList.Trade,"Trade Page",10)
label(pageList.Webhook,"Webhook Page",10)
