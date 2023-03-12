wait(2)

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = game:GetService("Players").LocalPlayer

local TOGGLED = false
local Speed = 100
local CONTROL = {W = 0, S = 0, D = 0, A = 0}
local Root = Player.Character.PrimaryPart

local InputBegan = UserInputService.InputBegan:Connect(function(KEY)
	if KEY.KeyCode == Enum.KeyCode.W then
		CONTROL.W = 1
	end
	if KEY.KeyCode == Enum.KeyCode.S then
		CONTROL.S = 1
	end
	if KEY.KeyCode == Enum.KeyCode.D then
		CONTROL.D = 1
	end
	if KEY.KeyCode == Enum.KeyCode.A then
		CONTROL.A = 1
	end
end)

local InputEnded = UserInputService.InputEnded:Connect(function(KEY)
	if KEY.KeyCode == Enum.KeyCode.W then
		CONTROL.W = 0
	end
	if KEY.KeyCode == Enum.KeyCode.S then
		CONTROL.S = 0
	end
	if KEY.KeyCode == Enum.KeyCode.D then
		CONTROL.D = 0
	end
	if KEY.KeyCode == Enum.KeyCode.A then
		CONTROL.A = 0
	end
end)

--Toggle
local ToggleBegan = UserInputService.InputBegan:Connect(function(KEY) 
	if KEY.KeyCode == Enum.KeyCode.T then
		TOGGLED = not TOGGLED
	end
end)

local Update = RunService.RenderStepped:Connect(function()
	if TOGGLED then
		local _,Rotation,_ = workspace.CurrentCamera.CFrame:ToOrientation()
		local x = math.sin(Rotation)
		local z = math.cos(Rotation)
		
		local Velocity = Vector3.new(
			Speed*((-x*CONTROL.W)+(z*CONTROL.D)+(x*CONTROL.S)+(-z*CONTROL.A)),
			Root.Velocity.Y,
			Speed*((-z*CONTROL.W)+(-x*CONTROL.D)+(z*CONTROL.S)+(x*CONTROL.A))
		)

		Root.Velocity = Velocity
	end
end)


task.spawn(function()
	repeat wait() until UserInputService:IsKeyDown(Enum.KeyCode.U)
	InputBegan:Disconnect()
	InputEnded:Disconnect()
	ToggleBegan:Disconnect()
	Update:Disconnect()
end)