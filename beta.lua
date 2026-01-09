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
