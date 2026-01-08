--[[ 
    JriikTools V1
    Target Game : Fishit
    Executor    : Delta
    UI Type     : Manual Tab System
]]

if game:GetService("CoreGui"):FindFirstChild("JriikToolsUI") then
    game:GetService("CoreGui").JriikToolsUI:Destroy()
end

-- Services
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Player = Players.LocalPlayer

-- Main ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JriikToolsUI"
ScreenGui.IgnoreGuiInset = true
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

-- UIScale (Responsive)
local UIScale = Instance.new("UIScale", ScreenGui)
UIScale.Scale = math.clamp(workspace.CurrentCamera.ViewportSize.X / 1920, 0.75, 1)

-- Main Frame
local Main = Instance.new("Frame")
Main.Size = UDim2.fromScale(0.7, 0.7)
Main.Position = UDim2.fromScale(0.15, 0.15)
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
Title.TextSize = 28
Title.TextColor3 = Color3.fromRGB(240,240,240)
Title.Position = UDim2.new(0, 25, 0, 15)
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

-- Drag system (stable, not sensitive)
do
    local dragging, dragStart, startPos
    Header.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = Main.Position
        end
    end)
    Header.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
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
TabBar.Size = UDim2.new(1, -40, 0, 45)
TabBar.BackgroundColor3 = Color3.fromRGB(30,30,34)
Instance.new("UICorner", TabBar).CornerRadius = UDim.new(0, 14)

local TabLayout = Instance.new("UIListLayout", TabBar)
TabLayout.FillDirection = Horizontal
TabLayout.Padding = UDim.new(0, 10)
TabLayout.VerticalAlignment = Center

-- Content Holder
local Content = Instance.new("Frame", Main)
Content.Position = UDim2.new(0, 20, 0, 130)
Content.Size = UDim2.new(1, -40, 1, -150)
Content.BackgroundTransparency = 1

-- Tables
local Tabs = {}
local CurrentTab

-- Create Tab (Manual)
local function CreateTab(name)
    local Button = Instance.new("TextButton", TabBar)
    Button.Text = name
    Button.Font = Enum.Font.Gotham
    Button.TextSize = 14
    Button.TextColor3 = Color3.fromRGB(200,200,200)
    Button.BackgroundTransparency = 1
    Button.Size = UDim2.new(0, 120, 1, 0)

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
        if CurrentTab then
            CurrentTab.Page.Visible = false
            CurrentTab.Button.TextColor3 = Color3.fromRGB(200,200,200)
        end
        Page.Visible = true
        Button.TextColor3 = Color3.fromRGB(80,150,255)
        CurrentTab = {Button = Button, Page = Page}
    end)

    Tabs[name] = {Button = Button, Page = Page}
    return Tabs[name]
end

-- UI Elements
local function Section(tab, title)
    local Frame = Instance.new("Frame", tab.Page)
    Frame.Size = UDim2.new(1,0,0,40)
    Frame.BackgroundTransparency = 1

    local Label = Instance.new("TextLabel", Frame)
    Label.Text = title
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 18
    Label.TextColor3 = Color3.fromRGB(240,240,240)
    Label.Size = UDim2.new(1,0,1,0)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Left

    return Frame
end

local function Toggle(tab, text, callback)
    local Holder = Instance.new("Frame", tab.Page)
    Holder.Size = UDim2.new(1,0,0,50)
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
    Button.Size = UDim2.new(0,50,0,24)
    Button.Position = UDim2.new(1,-60,0.5,-12)
    Button.BackgroundColor3 = Color3.fromRGB(50,50,55)
    Button.Text = ""
    Instance.new("UICorner", Button).CornerRadius = UDim.new(1,0)

    local Circle = Instance.new("Frame", Button)
    Circle.Size = UDim2.new(0,20,0,20)
    Circle.Position = UDim2.new(0,2,0.5,-10)
    Circle.BackgroundColor3 = Color3.fromRGB(200,200,200)
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1,0)

    local state = false
    Button.MouseButton1Click:Connect(function()
        state = not state
        TweenService:Create(Button, TweenInfo.new(0.2), {
            BackgroundColor3 = state and Color3.fromRGB(80,150,255) or Color3.fromRGB(50,50,55)
        }):Play()
        TweenService:Create(Circle, TweenInfo.new(0.2), {
            Position = state and UDim2.new(1,-22,0.5,-10) or UDim2.new(0,2,0.5,-10)
        }):Play()
        callback(state)
    end)
end

-- Tabs
local Home = CreateTab("Home")
local Fishing = CreateTab("Fishing")
local Shop = CreateTab("Shop")

-- Default Tab
Home.Button.MouseButton1Click:Fire()

-- Fishing Content
Section(Fishing, "Legit")
Toggle(Fishing, "Legit Fishing", function(v)
    print("Legit Fishing:", v)
end)

Section(Fishing, "Instant")
Toggle(Fishing, "Instant Fishing", function(v)
    print("Instant Fishing:", v)
end)

print("[JriikTools V1] Loaded successfully.")
