-- JriikTools V1
-- RESET MODE - STEP 3 (Toggle + Notification)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "JriikTools_Reset"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Main Frame
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 280, 0, 180)
frame.Position = UDim2.new(0.5, -140, 0.5, -90)
frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)

-- Title (Drag Area)
local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Text = "JriikTools V1"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true

-- Drag Logic
local dragging, dragStart, startPos
title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)
title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)
UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.Touch
		or input.UserInputType == Enum.UserInputType.MouseMovement
	) then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)

-- Toggle Label
local toggleLabel = Instance.new("TextLabel")
toggleLabel.Parent = frame
toggleLabel.Position = UDim2.new(0, 12, 0, 70)
toggleLabel.Size = UDim2.new(1, -80, 0, 30)
toggleLabel.BackgroundTransparency = 1
toggleLabel.Text = "Example Toggle"
toggleLabel.TextColor3 = Color3.fromRGB(230,230,230)
toggleLabel.TextSize = 16
toggleLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Toggle Button
local toggleBtn = Instance.new("TextButton")
toggleBtn.Parent = frame
toggleBtn.Position = UDim2.new(1, -56, 0, 74)
toggleBtn.Size = UDim2.new(0, 44, 0, 22)
toggleBtn.Text = ""
toggleBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)

-- Toggle Circle
local circle = Instance.new("Frame")
circle.Parent = toggleBtn
circle.Size = UDim2.new(0, 18, 0, 18)
circle.Position = UDim2.new(0, 2, 0.5, -9)
circle.BackgroundColor3 = Color3.fromRGB(230,230,230)

-- State
local toggleState = false

-- Notification Function
local function notify(text)
	pcall(function()
		StarterGui:SetCore("SendNotification", {
			Title = "Console",
			Text = text,
			Icon = "rbxthumb://type=Asset&id=5107182114&w=150&h=150",
			Duration = 5
		})
	end)
end

-- Toggle Logic
toggleBtn.MouseButton1Click:Connect(function()
	toggleState = not toggleState

	if toggleState then
		toggleBtn.BackgroundColor3 = Color3.fromRGB(90, 150, 255)
		circle.Position = UDim2.new(1, -20, 0.5, -9)
		notify("Example Toggle : ON")
	else
		toggleBtn.BackgroundColor3 = Color3.fromRGB(70,70,70)
		circle.Position = UDim2.new(0, 2, 0.5, -9)
		notify("Example Toggle : OFF")
	end
end)
