--// QU33N UI v2 FINAL – Tab Rapat & Font Kecil
--// Delta Mobile Compatible

repeat task.wait() until game:IsLoaded()
task.wait(1)

task.spawn(function()

----------------------------------------------------------------
-- SERVICES
----------------------------------------------------------------
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")

----------------------------------------------------------------
-- NOTIFICATION FUNCTION
----------------------------------------------------------------
local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "QU33N",
			Text = text,
			Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
			Duration = 5
		})
	end)
end

----------------------------------------------------------------
-- DEVICE DETECTION
----------------------------------------------------------------
local function isMobileDevice()
	return UserInputService.TouchEnabled
		and not UserInputService.KeyboardEnabled
		and not UserInputService.MouseEnabled
end
local isMobile = isMobileDevice()

----------------------------------------------------------------
-- CLEAN OLD GUI
----------------------------------------------------------------
pcall(function()
	if CoreGui:FindFirstChild("QU33N") then
		CoreGui.QU33N:Destroy()
	end
end)

----------------------------------------------------------------
-- THEME
----------------------------------------------------------------
local Theme = {
	BG = Color3.fromRGB(15,17,21),
	Panel = Color3.fromRGB(26,30,36),
	Text = Color3.fromRGB(235,235,235),
	SubText = Color3.fromRGB(155,160,166),
	Accent = Color3.fromRGB(79,139,255)
}

----------------------------------------------------------------
-- GUI SIZE
----------------------------------------------------------------
local function responsiveSize()
	if isMobile then
		return UDim2.new(0.62, 0, 0.82, 0)
	else
		return UDim2.new(0.30, 0, 0.72, 0)
	end
end

----------------------------------------------------------------
-- SCREEN GUI
----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "QU33N"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = CoreGui

----------------------------------------------------------------
-- MAIN FRAME
----------------------------------------------------------------
local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.AnchorPoint = Vector2.new(0.5, 0.5)
Main.Position = UDim2.new(0.5, 0, 0.52, 0)
Main.Size = responsiveSize()
Main.BackgroundColor3 = Theme.BG
Main.ClipsDescendants = true
Main.ZIndex = 1
Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 18)

----------------------------------------------------------------
-- DRAG (MOBILE)
----------------------------------------------------------------
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

----------------------------------------------------------------
-- HEADER
----------------------------------------------------------------
local Header = Instance.new("Frame", Main)
Header.Position = UDim2.new(0,16,0,6) -- geser Header lebih ke atas
Header.Size = UDim2.new(1,-32,0,50)
Header.BackgroundTransparency = 1
Header.ZIndex = 2

local Title = Instance.new("TextLabel", Header)
Title.Text = "QU33N"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Theme.Text
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1,0,1,0)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.ZIndex = 2

----------------------------------------------------------------
-- TAB BAR
----------------------------------------------------------------
local TabBar = Instance.new("Frame", Main)
TabBar.Position = UDim2.new(0,16,0,58)
TabBar.Size = UDim2.new(1,-32,0,36)
TabBar.BackgroundTransparency = 1
TabBar.ZIndex = 10

local TabsContainer = Instance.new("Frame", TabBar)
TabsContainer.Size = UDim2.new(1,0,1,0)
TabsContainer.BackgroundTransparency = 1

----------------------------------------------------------------
-- PAGES
----------------------------------------------------------------
local Pages = Instance.new("Frame", Main)
Pages.Position = UDim2.new(0,16,0,104)
Pages.Size = UDim2.new(1,-32,1,-120)
Pages.BackgroundTransparency = 1
Pages.ZIndex = 1

local pageList = {}
local tabButtons = {}

local function setActive(tabName)
	for name,btn in pairs(tabButtons) do
		btn.TextColor3 = (name == tabName) and Theme.Accent or Theme.SubText
		pageList[name].Visible = (name == tabName)
	end
	notify("Tab: "..tabName)
end

local function createTab(name, totalTabs)
	local b = Instance.new("TextButton")
	b.Parent = TabsContainer
	b.BackgroundColor3 = Theme.Panel
	b.Text = name
	b.Font = Enum.Font.Gotham
	b.TextSize = 14 -- lebih kecil
	b.TextColor3 = Theme.SubText
	b.BorderSizePixel = 0
	b.ZIndex = 11
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)

	-- otomatis menyesuaikan lebar tab
	local totalWidth = TabsContainer.AbsoluteSize.X
	local tabWidth = math.floor((totalWidth - (totalTabs-1)*3) / totalTabs)
	b.Size = UDim2.new(0, tabWidth, 1,0)
	b.Position = UDim2.new(0, (#tabButtons)*(tabWidth + 3), 0, 0)

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

----------------------------------------------------------------
-- CREATE TABS
----------------------------------------------------------------
local tabs = {"Info","Fishing","Shop","AutoQuest","Teleport","Misc"}
local totalTabs = #tabs

for _,name in ipairs(tabs) do
	createTab(name, totalTabs)
	createPage(name)
end

setActive("Info")

----------------------------------------------------------------
-- CONTENT HELPER
----------------------------------------------------------------
local function label(parent,text,y)
	local l = Instance.new("TextLabel")
	l.Parent = parent
	l.Text = text
	l.Font = Enum.Font.Gotham
	l.TextSize = 18
	l.TextColor3 = Theme.Text
	l.BackgroundTransparency = 1
	l.Position = UDim2.new(0,0,0,y)
	l.Size = UDim2.new(1,0,0,30)
	l.TextXAlignment = Enum.TextXAlignment.Left
end

----------------------------------------------------------------
-- PAGE CONTENT (PLACEHOLDER)
----------------------------------------------------------------
label(pageList.Info, "Welcome to QU33N", 10)
label(pageList.Fishing, "Fishing features here", 10)
label(pageList.Shop, "Shop features here", 10)
label(pageList.AutoQuest, "AutoQuest features here", 10)
label(pageList.Teleport, "Teleport features here", 10)
label(pageList.Misc, "Misc features here", 10)

----------------------------------------------------------------
-- SCRIPT LOADED NOTIFICATION
----------------------------------------------------------------
notify("QU33N Loaded Successfully!")

----------------------------------------------------------------
-- END
----------------------------------------------------------------
end)
