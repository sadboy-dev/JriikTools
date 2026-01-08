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
