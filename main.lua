local Library = {}
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")

-- Hapus GUI lama jika ada
if CoreGui:FindFirstChild("Aikoware") then
    CoreGui.Aikoware:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "Aikoware"
ScreenGui.Parent = CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -175)
MainFrame.Size = UDim2.new(0, 500, 0, 350)
MainFrame.ClipsDescendants = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = MainFrame

-- Dragging Function untuk Mobile
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)
MainFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Header
local Title = Instance.new("TextLabel")
Title.Parent = MainFrame
Title.Text = "Aikoware"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 26
Title.Font = Enum.Font.GothamBold
Title.Position = UDim2.new(0, 20, 0, 20)
Title.Size = UDim2.new(0, 100, 0, 30)
Title.TextXAlignment = Enum.TextXAlignment.Left

local Version = Instance.new("TextLabel")
Version.Parent = MainFrame
Version.Text = "v1"
Version.TextColor3 = Color3.fromRGB(150, 150, 150)
Version.TextSize = 14
Version.Font = Enum.Font.Gotham
Version.Position = UDim2.new(1, -40, 0, 20)
Version.Size = UDim2.new(0, 20, 0, 30)

-- Tab Bar
local TabContainer = Instance.new("ScrollingFrame")
TabContainer.Parent = MainFrame
TabContainer.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TabContainer.BorderSizePixel = 0
TabContainer.Position = UDim2.new(0, 15, 0, 65)
TabContainer.Size = UDim2.new(1, -30, 0, 40)
TabContainer.ScrollBarThickness = 0
TabContainer.CanvasSize = UDim2.new(1.5, 0, 0, 0)

local TabCorner = Instance.new("UICorner")
TabCorner.CornerRadius = UDim.new(0, 6)
TabCorner.Parent = TabContainer

local TabList = Instance.new("UIListLayout")
TabList.Parent = TabContainer
TabList.FillDirection = Enum.FillDirection.Horizontal
TabList.Padding = UDim.new(0, 15)
TabList.VerticalAlignment = Enum.VerticalAlignment.Centerlocal function CreateTab(name, active)
    local Tab = Instance.new("TextButton")
    Tab.Parent = TabContainer
    Tab.BackgroundTransparency = 1
    Tab.Size = UDim2.new(0, 80, 1, 0)
    Tab.Font = Enum.Font.GothamSemibold
    Tab.Text = name
    Tab.TextColor3 = active and Color3.fromRGB(100, 160, 255) or Color3.fromRGB(180, 180, 180)
    Tab.TextSize = 13
    return Tab
end

CreateTab("Home", false)
CreateTab("Fishing", true)
CreateTab("Shop", false)
CreateTab("Auto Favorite", false)
CreateTab("Teleport", false)

-- Content Area
local Content = Instance.new("Frame")
Content.Parent = MainFrame
Content.BackgroundTransparency = 1
Content.Position = UDim2.new(0, 15, 0, 115)
Content.Size = UDim2.new(1, -30, 1, -130)

local LeftCol = Instance.new("ScrollingFrame")
LeftCol.Parent = Content
LeftCol.Size = UDim2.new(0.48, 0, 1, 0)
LeftCol.BackgroundTransparency = 1
LeftCol.ScrollBarThickness = 0

local RightCol = Instance.new("ScrollingFrame")
RightCol.Parent = Content
RightCol.Position = UDim2.new(0.52, 0, 0, 0)
RightCol.Size = UDim2.new(0.48, 0, 1, 0)
RightCol.BackgroundTransparency = 1
RightCol.ScrollBarThickness = 0

local function AddLayout(p)
    local L = Instance.new("UIListLayout", p)
    L.SortOrder = Enum.SortOrder.LayoutOrder
    L.Padding = UDim.new(0, 8)
end
AddLayout(LeftCol)
AddLayout(RightCol)-- UI Components
local function AddSection(parent, text)
    local Label = Instance.new("TextLabel")    Label.Parent = parent
    Label.Size = UDim2.new(1, 0, 0, 25)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.Font = Enum.Font.GothamBold
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
end

local function AddToggle(parent, text, state)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.Size = UDim2.new(1, 0, 0, 30)
    Frame.BackgroundTransparency = 1
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Size = UDim2.new(1, -40, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 13
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Bg = Instance.new("Frame")
    Bg.Parent = Frame
    Bg.Position = UDim2.new(1, -35, 0.5, -8)
    Bg.Size = UDim2.new(0, 32, 0, 16)
    Bg.BackgroundColor3 = state and Color3.fromRGB(60, 120, 255) or Color3.fromRGB(45, 45, 45)
    Instance.new("UICorner", Bg).CornerRadius = UDim.new(1, 0)

    local Ball = Instance.new("Frame")
    Ball.Parent = Bg
    Ball.Position = state and UDim2.new(1, -14, 0.5, -6) or UDim2.new(0, 2, 0.5, -6)
    Ball.Size = UDim2.new(0, 12, 0, 12)
    Ball.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", Ball).CornerRadius = UDim.new(1, 0)
end

local function AddInput(parent, text, val)
    local Frame = Instance.new("Frame")
    Frame.Parent = parent
    Frame.Size = UDim2.new(1, 0, 0, 35)
    Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    Instance.new("UICorner", Frame).CornerRadius = UDim.new(0, 4)
    
    local Label = Instance.new("TextLabel")
    Label.Parent = Frame
    Label.Position = UDim2.new(0, 10, 0, 0)
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.BackgroundTransparency = 1
    Label.Text = text
    Label.TextColor3 = Color3.fromRGB(200, 200, 200)
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 12
    Label.TextXAlignment = Enum.TextXAlignment.Left

    local Box = Instance.new("TextBox")
    Box.Parent = Frame
    Box.Position = UDim2.new(1, -60, 0.5, -10)
    Box.Size = UDim2.new(0, 50, 0, 20)
    Box.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    Box.Text = val
    Box.TextColor3 = Color3.fromRGB(255, 255, 255)
    Box.Font = Enum.Font.Gotham
    Box.TextSize = 12
    Instance.new("UICorner", Box).CornerRadius = UDim.new(0, 4)
end

-- Isi Konten sesuai Gambar
AddSection(LeftCol, "Legit")
AddToggle(LeftCol, "Legit Fishing", true)

local Btn = Instance.new("TextButton", LeftCol)
Btn.Size = UDim2.new(1, 0, 0, 35)
Btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Btn.Text = "Manual Fix Stuck"
Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
Btn.Font = Enum.Font.Gotham
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 6)

AddSection(LeftCol, "Instant")
AddToggle(LeftCol, "Instant Fishing", false)
AddInput(LeftCol, "Complete Delay", "0.5")
AddInput(LeftCol, "Fishing Delay", "0.15")
AddInput(LeftCol, "Reel Delay", "0.1")

AddSection(RightCol, "Instant")
AddToggle(RightCol, "Instant Fishing", false)
AddInput(RightCol, "Complete Delay", "0.5")

AddSection(RightCol, "Auto Fish Misc")
AddToggle(RightCol, "Disable Fish Notification", false)
AddToggle(RightCol, "Disable Animations", false)
AddToggle(RightCol, "Freeze Character", false)
```### Penjelasan Perbaikan:
1.  **Nil Value Fix**: Error `nil value` sebelumnya terjadi karena ada fungsi yang terpanggil sebelum didefinisikan atau baris kode yang menempel. Di sini saya sudah memisahkan setiap baris dengan benar.
2.  **Mobile Friendly**: Menambahkan fitur **Dragging** (bisa digeser) yang mendukung layar sentuh HP.
3.  **Scrolling Frame**: Bagian Tab dan Kolom bisa di-scroll jika menu bertambah banyak, sangat penting untuk layar HP yang kecil.
4.  **CoreGui**: Menggunakan `game:GetService("CoreGui")` agar GUI tidak hilang saat karakter mati dan aman dijalankan di Delta.
