--// SERVICES
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--// MAIN UI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "JriikTools"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.Size = UDim2.new(0, 520, 0, 360)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -180)
MainFrame.BackgroundColor3 = Color3.fromRGB(15,15,15)
MainFrame.BorderSizePixel = 0

local MainCorner = Instance.new("UICorner", MainFrame)
MainCorner.CornerRadius = UDim.new(0, 14)

--// TITLE
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, -20, 0, 32)
Title.Position = UDim2.new(0, 10, 0, 8)
Title.Text = "Jriik Tools"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.TextColor3 = Color3.fromRGB(230,230,230)
Title.BackgroundTransparency = 1
Title.TextXAlignment = Enum.TextXAlignment.Left

--////////////////////////////////////////////////////
--// TAB BAR (FIXED VERSION)
--////////////////////////////////////////////////////

local TabBar = Instance.new("Frame", MainFrame)
TabBar.Size = UDim2.new(1, -32, 0, 40)
TabBar.Position = UDim2.new(0, 16, 0, 48)
TabBar.BackgroundColor3 = Color3.fromRGB(18,18,18)
TabBar.BorderSizePixel = 0
TabBar.Name = "TabBar"

local TabCorner = Instance.new("UICorner", TabBar)
TabCorner.CornerRadius = UDim.new(0, 12)

--// SCROLLING CONTAINER (FIX UTAMA)
local TabsContainer = Instance.new("ScrollingFrame", TabBar)
TabsContainer.Size = UDim2.new(1, -16, 1, 0)
TabsContainer.Position = UDim2.new(0, 8, 0, 0)
TabsContainer.CanvasSize = UDim2.new(0,0,0,0)
TabsContainer.ScrollBarImageTransparency = 1
TabsContainer.ScrollingDirection = Enum.ScrollingDirection.X
TabsContainer.BackgroundTransparency = 1
TabsContainer.BorderSizePixel = 0
TabsContainer.Name = "TabsContainer"

local TabLayout = Instance.new("UIListLayout", TabsContainer)
TabLayout.FillDirection = Enum.FillDirection.Horizontal
TabLayout.VerticalAlignment = Enum.VerticalAlignment.Center
TabLayout.Padding = UDim.new(0, 6)

-- AUTO CANVAS SIZE (INI KUNCI TAB TIDAK KEPOTONG)
TabLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    TabsContainer.CanvasSize = UDim2.new(
        0,
        TabLayout.AbsoluteContentSize.X + 12,
        0,
        0
    )
end)

--////////////////////////////////////////////////////
--// CONTENT AREA
--////////////////////////////////////////////////////

local ContentFrame = Instance.new("Frame", MainFrame)
ContentFrame.Size = UDim2.new(1, -32, 1, -104)
ContentFrame.Position = UDim2.new(0, 16, 0, 96)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20,20,20)
ContentFrame.BorderSizePixel = 0

local ContentCorner = Instance.new("UICorner", ContentFrame)
ContentCorner.CornerRadius = UDim.new(0, 12)

--////////////////////////////////////////////////////
--// TAB SYSTEM (ASLI KAMU – TIDAK DIUBAH)
--////////////////////////////////////////////////////

local Tabs = {}
local CurrentTab = nil

local function CreateTab(name)
    local b = Instance.new("TextButton")
    b.Parent = TabsContainer
    b.Text = name
    b.Font = Enum.Font.GothamMedium
    b.TextSize = 13
    b.TextColor3 = Color3.fromRGB(220,220,220)
    b.BackgroundColor3 = Color3.fromRGB(28,28,28)
    b.BorderSizePixel = 0
    b.AutoButtonColor = false

    -- FIX SIZE TAB (AUTO WIDTH)
    b.Size = UDim2.new(0,0,1,-6)
    b.AutomaticSize = Enum.AutomaticSize.X

    local pad = Instance.new("UIPadding", b)
    pad.PaddingLeft = UDim.new(0, 12)
    pad.PaddingRight = UDim.new(0, 12)

    local corner = Instance.new("UICorner", b)
    corner.CornerRadius = UDim.new(0, 8)

    -- CONTENT FRAME TAB
    local page = Instance.new("Frame", ContentFrame)
    page.Size = UDim2.new(1,0,1,0)
    page.BackgroundTransparency = 1
    page.Visible = false

    b.MouseButton1Click:Connect(function()
        if CurrentTab then
            CurrentTab.Button.BackgroundColor3 = Color3.fromRGB(28,28,28)
            CurrentTab.Page.Visible = false
        end

        CurrentTab = {
            Button = b,
            Page = page
        }

        b.BackgroundColor3 = Color3.fromRGB(45,45,45)
        page.Visible = true
    end)

    table.insert(Tabs, {Button = b, Page = page})

    -- AUTO SELECT TAB PERTAMA
    if not CurrentTab then
        task.wait()
        b:Activate()
    end

    return page
end

--////////////////////////////////////////////////////
--// TABS (ASLI KAMU)
--////////////////////////////////////////////////////

local InfoTab = CreateTab("Info")
local FishingTab = CreateTab("Fishing")
local ShopTab = CreateTab("Shop")
local AutoTab = CreateTab("Auto")
local TeleportTab = CreateTab("Teleport")
local MiscTab = CreateTab("Misc")

--////////////////////////////////////////////////////
--// CONTOH ISI TAB (BIAR TIDAK KOSONG)
--////////////////////////////////////////////////////

local function MakeLabel(parent, text)
    local lbl = Instance.new("TextLabel", parent)
    lbl.Size = UDim2.new(1, -20, 0, 30)
    lbl.Position = UDim2.new(0, 10, 0, 10)
    lbl.Text = text
    lbl.Font = Enum.Font.Gotham
    lbl.TextSize = 14
    lbl.TextColor3 = Color3.fromRGB(200,200,200)
    lbl.BackgroundTransparency = 1
    lbl.TextXAlignment = Enum.TextXAlignment.Left
end

MakeLabel(InfoTab, "Info Tab")
MakeLabel(FishingTab, "Fishing Tab")
MakeLabel(ShopTab, "Shop Tab")
MakeLabel(AutoTab, "Auto Tab")
MakeLabel(TeleportTab, "Teleport Tab")
MakeLabel(MiscTab, "Misc Tab")
