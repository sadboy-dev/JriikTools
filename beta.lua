--// Aikoware UI - Delta Mobile Friendly (UI ONLY)

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

-- Detect device
local function isMobileDevice()
	return UserInputService.TouchEnabled
		and not UserInputService.KeyboardEnabled
		and not UserInputService.MouseEnabled
end

local isMobile = isMobileDevice()

-- Prevent double GUI
if CoreGui:FindFirstChild("Aikoware") then
	CoreGui.Aikoware:Destroy()
end

-- Theme
local Theme = {
	BG = Color3.fromRGB(15, 17, 21),
	Panel = Color3.fromRGB(26, 30, 36),
	Text = Color3.fromRGB(235, 235, 235),
	SubText = Color3.fromRGB(155, 160, 166),
	Accent = Color3.fromRGB(79, 139, 255)
}

-- GUI size (LOCKED - YOUR REQUEST)
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

-- Main Frame
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.52, 0) -- safe for notch
Main.Size = responsiveSize()
Main.BackgroundColor3 = Theme.BG
Main.ClipsDescendants = true
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

-- ===== Drag (Mobile) =====
local dragging = false
local dragStart, startPos

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
Header.Size = UDim2.new(1, -32, 0, 64)
Header.Position = UDim2.new(0, 16, 0, 16)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Text = "Aikoware"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 32
Title.TextColor3 = Theme.Text
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 1, 0)
Title.TextXAlignment = Left

local Version = Instance.new("TextLabel", Header)
Version.Text = "v1"
Version.Font = Enum.Font.Gotham
Version.TextSize = 14
Version.TextColor3 = Theme.SubText
Version.BackgroundTransparency = 1
Version.AnchorPoint = Vector2.new(1, 0.5)
Version.Position = UDim2.new(1, 0, 0.5, 0)
Version.Size = UDim2.new(0, 30, 0, 20)

-- Tab Bar
local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0, 16, 0, 90)
TabBar.Size = UDim2.new(1, -32, 0, 46)
TabBar.BackgroundColor3 = Theme.Panel
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 14)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 14)

local function Tab(text, active)
	local t = Instance.new("TextLabel")
	t.Text = text
	t.Font = Enum.Font.GothamMedium
	t.TextSize = 15
	t.TextColor3 = active and Theme.Accent or Theme.SubText
	t.BackgroundTransparency = 1
	t.Size = UDim2.new(0, 90, 1, 0)
	t.Parent = TabBar
end

Tab("Home", false)
Tab("Fishing", true)
Tab("Shop", false)
Tab("Auto Fav", false)
Tab("Teleport", false)
Tab("Trade", false)
Tab("Webhook", false)

-- Content
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 16, 0, 150)
Content.Size = UDim2.new(1, -32, 1, -166)
Content.BackgroundTransparency = 1

-- Columns
local Left = Instance.new("Frame", Content)
Left.Size = UDim2.new(0.48, 0, 1, 0)
Left.BackgroundTransparency = 1

local Right = Instance.new("Frame", Content)
Right.Position = UDim2.new(0.52, 0, 0, 0)
Right.Size = UDim2.new(0.48, 0, 1, 0)
Right.BackgroundTransparency = 1

-- Helpers
local function Section(parent, text, y)
	local l = Instance.new("TextLabel", parent)
	l.Text = text
	l.Font = Enum.Font.GothamBold
	l.TextSize = 18
	l.TextColor3 = Theme.Text
	l.BackgroundTransparency = 1
	l.Position = UDim2.new(0, 0, 0, y)
	l.Size = UDim2.new(1, 0, 0, 30)
	l.TextXAlignment = Left
	return y + 36
end

local function Toggle(parent, text, y)
	local f = Instance.new("Frame", parent)
	f.Position = UDim2.new(0, 0, 0, y)
	f.Size = UDim2.new(1, 0, 0, 40)
	f.BackgroundTransparency = 1

	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Font = Enum.Font.Gotham
	l.TextSize = 15
	l.TextColor3 = Theme.Text
	l.BackgroundTransparency = 1
	l.Size = UDim2.new(0.7, 0, 1, 0)
	l.TextXAlignment = Left

	local t = Instance.new("Frame", f)
	t.AnchorPoint = Vector2.new(1, 0.5)
	t.Position = UDim2.new(1, 0, 0.5, 0)
	t.Size = UDim2.new(0, 42, 0, 22)
	t.BackgroundColor3 = Theme.Panel
	Instance.new("UICorner", t).CornerRadius = UDim.new(1, 0)

	local c = Instance.new("Frame", t)
	c.Position = UDim2.new(0, 2, 0.5, -9)
	c.Size = UDim2.new(0, 18, 0, 18)
	c.BackgroundColor3 = Color3.fromRGB(130, 130, 130)
	Instance.new("UICorner", c).CornerRadius = UDim.new(1, 0)

	return y + 44
end

local function Input(parent, text, value, y)
	local f = Instance.new("Frame", parent)
	f.Position = UDim2.new(0, 0, 0, y)
	f.Size = UDim2.new(1, 0, 0, 40)
	f.BackgroundTransparency = 1

	local l = Instance.new("TextLabel", f)
	l.Text = text
	l.Font = Enum.Font.Gotham
	l.TextSize = 15
	l.TextColor3 = Theme.Text
	l.BackgroundTransparency = 1
	l.Size = UDim2.new(0.7, 0, 1, 0)
	l.TextXAlignment = Left

	local box = Instance.new("TextBox", f)
	box.Text = value
	box.Font = Enum.Font.Gotham
	box.TextSize = 15
	box.TextColor3 = Theme.Text
	box.BackgroundColor3 = Theme.Panel
	box.AnchorPoint = Vector2.new(1, 0.5)
	box.Position = UDim2.new(1, 0, 0.5, 0)
	box.Size = UDim2.new(0, 64, 0, 28)
	Instance.new("UICorner", box).CornerRadius = UDim.new(0, 8)

	return y + 44
end

-- LEFT CONTENT
local y = 0
y = Section(Left, "Legit", y)
y = Toggle(Left, "Legit Fishing", y)

local fix = Instance.new("TextButton", Left)
fix.Text = "Manual Fix Stuck"
fix.Font = Enum.Font.GothamMedium
fix.TextSize = 15
fix.TextColor3 = Theme.Text
fix.BackgroundColor3 = Theme.Panel
fix.Position = UDim2.new(0, 0, 0, y)
fix.Size = UDim2.new(1, 0, 0, 40)
Instance.new("UICorner", fix).CornerRadius = UDim.new(0, 10)
y += 56

y = Section(Left, "Instant", y)
y = Toggle(Left, "Instant Fishing", y)
y = Input(Left, "Complete Delay", "0.5", y)
y = Input(Left, "Fishing Delay", "0.15", y)
y = Input(Left, "Reel Delay", "0.1", y)

-- RIGHT CONTENT
local ry = 0
ry = Section(Right, "Instant", ry)
ry = Toggle(Right, "Instant Fishing", ry)
ry = Input(Right, "Complete Delay", "0.5", ry)
ry += 12
ry = Section(Right, "Auto Fish Misc", ry)
ry = Toggle(Right, "Disable Fish Notification", ry)
ry = Toggle(Right, "Disable Animations", ry)
ry = Toggle(Right, "Freeze Character", ry)
