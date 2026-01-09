local ScreenGui = Instance.new("ScreenGui")
local MainFrame = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local Version = Instance.new("TextLabel")
local TabContainer = Instance.new("ScrollingFrame")
local UIListLayout = Instance.new("UIListLayout")local ContentFrame = Instance.new("Frame")
local LeftColumn = Instance.new("ScrollingFrame")
local RightColumn = Instance.new("ScrollingFrame")

-- Properties
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -150)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = MainFrame

Title.Parent = MainFrameTitle.Text = "Aikoware"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 24
Title.Font = Enum.Font.GothamBold
Title.Position = UDim2.new(0, 20, 0, 15)
Title.Size = UDim2.new(0, 100, 0, 30)
Title.TextXAlignment = Enum.TextXAlignment.Left

Version.Parent = MainFrame
Version.Text = "v1"
Version.TextColor3 = Color3.fromRGB(150, 150, 150)
Version.TextSize = 14
Version.Font = Enum.Font.GothamVersion.Position = UDim2.new(1, -40, 0, 15)
Version.Size = UDim2.new(0, 20, 0, 30)

-- Tab Bar
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabContainer.Position = UDim2.new(0, 10, 0, 60)
TabContainer.Size = UDim2.new(1, -20, 0, 35)
TabContainer.ScrollBarThickness = 0
TabContainer.CanvasSize = UDim2.new(1.5, 0, 0, 0)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabContainer

UIListLayout.Parent = TabContainer
UIListLayout.FillDirection = Enum.FillDirection.Horizontal
UIListLayout.Padding = UDim.new(0, 10)
UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Center

-- Function to create Tabs
local function CreateTab(name, icon)
    local Tab = Instance.new("TextButton")
    Tab.Parent = TabContainer
    Tab.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(0, 80, 1, 0)
    Tab.Font = Enum.Font.Gotham
    Tab.Text = name
    Tab.TextColor3 = (name == "Fishing") and Color3.fromRGB(100, 150, 255) or Color3.fromRGB(180, 180, 180)
    Tab.TextSize = 12
    return Tab
end

CreateTab("Home")
CreateTab("Fishing")
CreateTab("Shop")
CreateTab("Auto Favorite")
CreateTab("Teleport")
CreateTab("Trade")
CreateTab("Webhook")

-- Content Layout
ContentFrame.Parent = MainFrame
ContentFrame.Position = UDim2.new(0, 10, 0, 105)
ContentFrame.Size = UDim2.new(1, -20, 1, -115)
ContentFrame.BackgroundTransparency = 1

LeftColumn.Parent = ContentFrame
LeftColumn.Size = UDim2.new(0.48, 0, 1, 0)
LeftColumn.BackgroundTransparency = 1
LeftColumn.ScrollBarThickness = 0

RightColumn.Parent = ContentFrame
RightColumn.Position = UDim2.new(0.52, 0, 0, 0)
RightColumn.Size = UDim2.new(0.48, 0, 1, 0)
RightColumn.BackgroundTransparency = 1
RightColumn.ScrollBarThickness = 0

local function AddSection(parent, text)
    local Label = Instance.new("TextLabel")
    Label.Parent = parent
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
end

local function AddToggle(parent, text, default)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.Size = UDim2.new(1, 0, 0, 30)
    Frame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Toggle = Instance.new("TextButton")
    Toggle.Parent = Frame
    Toggle.Position = UDim2.new(1, -35, 0.5, -8)
    Toggle.Size = UDim2.new(0, 30, 0, 16)
    Toggle.BackgroundColor3 = default and Color3.fromRGB(60, 120, 255) or Color3.fromRGB(50, 50, 50)
    Toggle.Text = ""
    local TCorner = Instance.new("UICorner")
    TCorner.CornerRadius = UDim.new(1, 0)
    TCorner.Parent = Toggle
end

local function AddInput(parent, text, value)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.Size = UDim2.new(1, 0, 0, 30)
    Frame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Box = Instance.new("TextBox")
    Box.Parent = Frame
    Box.Position = UDim2.new(1, -50, 0.5, -10)    Box.Size = UDim2.new(0, 50, 0, 20)
    Box.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Text = value
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 12
    local BCorner = Instance.new("UICorner")
    BCorner.CornerRadius = UDim.new(0, 4)
    BCorner.Parent = Box
end

-- Populate Left Column
local LList = Instance.new("UIListLayout", LeftColumn)
LList.Padding = UDim.new(0, 5)

AddSection(LeftColumn, "Legit")
AddToggle(LeftColumn, "Legit Fishing", true)
local FixBtn = Instance.new("TextButton", LeftColumn)
FixBtn.Size = UDim2.new(1, 0, 0, 30)
FixBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
FixBtn.Text = "Manual Fix Stuck"
FixBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
FixBtn.Font = Enum.Font.Gotham
Instance.new("UICorner", FixBtn).CornerRadius = UDim.new(0, 5)

AddSection(LeftColumn, "Instant")
AddToggle(LeftColumn, "Instant Fishing", false)
AddInput(LeftColumn, "Complete Delay", "0.5")
AddInput(LeftColumn, "Fishing Delay", "0.15")
AddInput(LeftColumn, "Reel Delay", "0.1")

-- Populate Right Column
local RList = Instance.new("UIListLayout", RightColumn)RList.Padding = UDim.new(0, 5)

AddSection(RightColumn, "Instant")
AddToggle(RightColumn, "Instant Fishing", false)
AddInput(RightColumn, "Complete Delay", "0.5")

AddSection(RightColumn, "Auto Fish Misc")
AddToggle(RightColumn, "Disable Fish Notification", false)
AddToggle(RightColumn, "Disable Animations", false)
AddToggle(RightColumn, "Freeze Character", false)
