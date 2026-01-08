--[[ 
    JriikTools V1
    Target Game : Fishit
    Executor    : Delta
    Status      : Mobile & PC Fixed
]]

-- Remove old UI
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("JriikToolsUI") then
    CoreGui.JriikToolsUI:Destroy()
end

-- Services
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JriikToolsUI"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

-- UIScale (MOBILE SAFE)
local UIScale = Instance.new("UIScale", ScreenGui)
local viewport = Camera.ViewportSize
if viewport.X < 900 then
    UIScale.Scale = 0.9 -- Mobile
elseif viewport.X < 1300 then
    UIScale.Scale = 0.95 -- Tablet
else
    UIScale.Scale = 1 -- PC
end

-- Main Frame (OFFSET, NOT SCALE)
local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(720, 420)
Main.Position = UDim2.fromScale(0.5, 0.5)
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 22)
Main.BackgroundTransparency = 0.05
Main.Parent = ScreenGui
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

-- Shadow
local Shadow = Instance.new("ImageLabel", Main)
Shadow.Size = UDim2.new(1, 40, 1, 40)
Shadow.Position = UDim2.new(0, -20, 0, -20)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageTransparency = 0.7
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10,10,118,118)
Shadow.ZIndex = 0
Main.ZIndex = 1

-- Header
local Header = Instance.new("Frame", Main)
Header.Size = UDim2.new(1, 0, 0, 60)
Header.BackgroundTransparency = 1

local Title = Instance.new("TextLabel", Header)
Title.Text = "JriikTools"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 26
Title.TextColor3 = Color3.fromRGB(240,240,240)
Title.Position = UDim2.new(0, 24, 0, 16)
Title.Size = UDim2.new(0, 300, 0, 30)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Left

local Version = Instance.new("TextLabel", Header)
Version.Text = "V1"
Version.Font = Enum.Font.Gotham
Version.TextSize = 14
Version.TextColor3 = Color3.fromRGB(160,160,160)
Version.AnchorPoint = Vector2.new(1,0)
Version.Position = UDim2.new(1, -20, 0, 22)
Version.Size = UDim2.new(0, 50, 0, 20)
Version.BackgroundTransparency = 1

-- Drag (STABLE MOBILE)
do
    local dragging = false
    local dragStart, startPos

    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)

    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
            local delta = input.Position - dragStart
            Main.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)
end

-- Tab Bar
local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0, 20, 0, 70)
TabBar.Size = UDim2.new(1, -40, 0, 44)
TabBar.BackgroundColor3 = Color3.fromRGB(30,30,34)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 14)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Horizontal
TabLayout.Padding = UDim.new(0, 8)
TabLayout.VerticalAlignment = Center

-- Content
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 20, 0, 125)
Content.Size = UDim2.new(1, -40, 1, -145)
Content.BackgroundTransparency = 1

-- Tabs
local Tabs = {}
local CurrentTab = nil

local function OpenTab(tab)
    if CurrentTab then
        CurrentTab.Page.Visible = false
        CurrentTab.Button.TextColor3 = Color3.fromRGB(200,200,200)
    end
    tab.Page.Visible = true
    tab.Button.TextColor3 = Color3.fromRGB(80,150,255)
    CurrentTab = tab
end

local function CreateTab(name)
    local Button = Instance.new("TextButton", TabBar)
    Button.Size = UDim2.new(0, 110, 1, 0)
    Button.Text = name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.TextColor3 = Color3.fromRGB(200,200,200)
    Button.BackgroundTransparency = 1

    local Page = Instance.new("ScrollingFrame", Content)
    Page.Size = UDim2.new(1,0,1,0)
    Page.CanvasSize = UDim2.new(0,0,0,0)
    Page.ScrollBarImageTransparency = 1
    Page.Visible = false

    local Layout = Instance.new("UIListLayout", Page)
    Layout.Padding = UDim.new(0, 14)

    Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Page.CanvasSize = UDim2.new(0,0,0,Layout.AbsoluteContentSize.Y + 20)
    end)

    Button.MouseButton1Click:Connect(function()
        OpenTab(Tabs[name])
    end)

    Tabs[name] = {Button = Button, Page = Page}
    return Tabs[name]
end

-- Elements
local function Section(tab, title)
    local Frame = Instance.new("Frame", tab.Page)
    Frame.Size = UDim2.new(1,0,0,34)
    Frame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = title
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 17
    Label.TextColor3 = Color3.fromRGB(240,240,240)
    Label.Size = UDim2.new(1,0,1,0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Left
end

local function Toggle(tab, text, callback)
    local Holder = Instance.new("Frame", tab.Page)
    Holder.Size = UDim2.new(1,0,0,48)
    Holder.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", Holder)
    Label.Text = text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 15
    Label.TextColor3 = Color3.fromRGB(220,220,220)
    Label.Size = UDim2.new(1,-70,1,0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Left

    local Button = Instance.new("TextButton", Holder)
    Button.Size = UDim2.new(0,48,0,22)
    Button.Position = UDim2.new(1,-56,0.5,-11)
    Button.BackgroundColor3 = Color3.fromRGB(50,50,55)
    Button.Text = ""
    Instance.new("UICorner", Button).CornerRadius = UDim.new(1,0)

    local Circle = Instance.new("Frame", Button)
    Circle.Size = UDim2.new(0,18,0,18)
    Circle.Position = UDim2.new(0,2,0.5,-9)
    Circle.BackgroundColor3 = Color3.fromRGB(200,200,200)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Button, TweenInfo.new(0.18), {
            BackgroundColor3 = state and Color3.fromRGB(80,150,255) or Color3.fromRGB(50,50,55)
        }):Play()
        TweenService:Create(Circle, TweenInfo.new(0.18), {
            Position = state and UDim2.new(1,-20,0.5,-9) or UDim2.new(0,2,0.5,-9)
        }):Play()
        callback(state)
    end)
end

-- Tabs
local Home = CreateTab("Home")
local Fishing = CreateTab("Fishing")
local Shop = CreateTab("Shop")

-- Default Tab
OpenTab(Home)

-- Fishing Content
Section(Fishing, "Legit")
Toggle(Fishing, "Legit Fishing", function(v)
    print("JriikTools | Legit Fishing:", v)
end)

Section(Fishing, "Instant")
Toggle(Fishing, "Instant Fishing", function(v)
    print("JriikTools | Instant Fishing:", v)
end)

print("[JriikTools] Loaded successfully.")
