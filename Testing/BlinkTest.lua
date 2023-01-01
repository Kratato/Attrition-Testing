print("Began")

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Character = game:GetService("Players").LocalPlayer.Character
local Camera = game.workspace.CurrentCamera

local connection = UserInputService.InputBegan:Connect(function(input)
	if input.KeyCode == Enum.KeyCode.T then
		print("Pressed")
		local Raycast = workspace:Raycast(Camera.CFrame.Position,Camera.CFrame.LookVector)
		print(Raycast,Camera.CFrame.Position,Camera.CFrame.Position)
		if Raycast ~= nil then
			Character:MoveTo(Raycast.Position)
		end
	end
end)


task.spawn(function()
	repeat
		wait()
	until
		UserInputService:IsKeyDown(Enum.KeyCode.P)
	connection:Disconnect()
	print("Ended")
end)