-- JriikTools V1
-- RESET MODE - STEP 4 (Multiple Toggle + Button)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")
gui.Name = "JriikTools_Reset"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Notification
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

-- Main Frame
local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 300, 0, 260)
frame.Position = UDim2.new(0.5, -150, 0.5, -130)
frame.BackgroundColor3 = Color3.fromRGB(32, 32, 32)

-- Title (Drag)
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

-- Container
local container = Instance.new("Frame", frame)
container.Position = UDim2.new(0, 0, 0, 50)
container.Size = UDim2.new(1, 0, 1, -50)
container.BackgroundTransparency = 1

local layout = Instance.new("UIListLayout", container)
layout.Padding = UDim.new(0, 10)

-- Toggle Creator
local function createToggle(text)
	local holder = Instance.new("Frame", container)
	holder.Size = UDim2.new(1, -20, 0, 34)
	holder.BackgroundTransparency = 1

	local label = Instance.new("TextLabel", holder)
	label.Size = UDim2.new(1, -60, 1, 0)
	label.BackgroundTransparency = 1
	label.Text = text
	label.TextColor3 = Color3.fromRGB(230,230,230)
	label.TextXAlignment = Enum.TextXAlignment.Left
	label.TextScaled = false
	label.TextSize = 16

	local btn = Instance.new("TextButton", holder)
	btn.Size = UDim2.new(0, 44, 0, 22)
	btn.Position = UDim2.new(1, -44, 0.5, -11)
	btn.Text = ""
	btn.BackgroundColor3 = Color3.fromRGB(70,70,70)

	local circle = Instance.new("Frame", btn)
	circle.Size = UDim2.new(0, 18, 0, 18)
	circle.Position = UDim2.new(0, 2, 0.5, -9)
	circle.BackgroundColor3 = Color3.fromRGB(230,230,230)

	local state = false

	btn.MouseButton1Click:Connect(function()
		state = not state
		if state then
			btn.BackgroundColor3 = Color3.fromRGB(90,150,255)
			circle.Position = UDim2.new(1, -20, 0.5, -9)
			notify(text.." : ON")
		else
			btn.BackgroundColor3 = Color3.fromRGB(70,70,70)
			circle.Position = UDim2.new(0, 2, 0.5, -9)
			notify(text.." : OFF")
		end
	end)
end


-- Button Creator
local function createButton(text)
	local btn = Instance.new("TextButton", container)
	btn.Size = UDim2.new(1, -20, 0, 36)
	btn.Text = text
	btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
	btn.TextColor3 = Color3.fromRGB(255,255,255)

	btn.MouseButton1Click:Connect(function()
		notify(text.." clicked")
	end)
end

-- Create UI
createToggle("Toggle 1")
createToggle("Toggle 2")
createToggle("Toggle 3")
createButton("Example Button")


