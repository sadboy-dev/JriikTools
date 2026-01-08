-- JriikTools V1
-- RESET MODE - STEP 1

local Players = game:GetService("Players")
local player = Players.LocalPlayer
local gui = Instance.new("ScreenGui")

gui.Name = "JriikTools_Reset"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Parent = gui
frame.Size = UDim2.new(0, 220, 0, 120)
frame.Position = UDim2.new(0.5, -110, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local text = Instance.new("TextLabel")
text.Parent = frame
text.Size = UDim2.new(1, 0, 1, 0)
text.BackgroundTransparency = 1
text.Text = "JriikTools V1\nSTEP 1 OK"
text.TextColor3 = Color3.fromRGB(255, 255, 255)
text.TextScaled = true

print("JriikTools STEP 1 loaded")
