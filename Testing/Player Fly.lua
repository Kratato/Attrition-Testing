local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

_G.Speed = 250
local TOGGLED = false


local FlyBlock = Instance.new("Part",game.workspace)
FlyBlock.CanCollide = false
FlyBlock.Transparency = 0
FlyBlock.Size = Vector3.new(0,0,0)

task.spawn(function()
    repeat
        wait()
    until game.Players.LocalPlayer.Character.Parent ~= nil
    FlyBlock.Position = game.Players.LocalPlayer.Character.PrimaryPart.Position
end)

local Attachment = Instance.new("Attachment",FlyBlock)
local LinVel = Instance.new("LinearVelocity",Attachment)
LinVel.Attachment0 = Attachment
LinVel.MaxForce = (2^63) - 1

local CONTROL = {Forward = 0, Backward = 0, Right = 0, Left = 0, Down = 0, Up = 0}

UIS.InputBegan:Connect(function(KEY)
	if KEY.KeyCode == Enum.KeyCode.W then
		CONTROL.Forward = -1
	end
	if KEY.KeyCode == Enum.KeyCode.S then
		CONTROL.Backward = 1
	end
	if KEY.KeyCode == Enum.KeyCode.D then
		CONTROL.Right = 1
	end
	if KEY.KeyCode == Enum.KeyCode.A then
		CONTROL.Left = -1
	end
	if KEY.KeyCode == Enum.KeyCode.LeftControl then
		CONTROL.Down = -1
	end
	if KEY.KeyCode == Enum.KeyCode.Space then
		CONTROL.Up = 1
	end
end)
	
UIS.InputEnded:Connect(function(KEY)
	if KEY.KeyCode == Enum.KeyCode.W then
		CONTROL.Forward = 0
	end
	if KEY.KeyCode == Enum.KeyCode.S then
		CONTROL.Backward = 0
	end
	if KEY.KeyCode == Enum.KeyCode.D then
		CONTROL.Right = 0
	end
	if KEY.KeyCode == Enum.KeyCode.A then
		CONTROL.Left = 0
	end
	if KEY.KeyCode == Enum.KeyCode.LeftControl then
		CONTROL.Down = 0
	end
	if KEY.KeyCode == Enum.KeyCode.Space then
		CONTROL.Up = 0
	end
end)

UIS.InputBegan:Connect(function(KEY) 
	if KEY.KeyCode == Enum.KeyCode.T then
		TOGGLED = not TOGGLED
	end
end)

RS.RenderStepped:Connect(function()
    if game.Players.LocalPlayer.Character.Parent == nil then
        return
    end
    if game.Players.LocalPlayer.Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") ~= nil then
        game.Players.LocalPlayer.Character:Destroy()
        return
    end
    if TOGGLED then
        local CurrentLook = CFrame.new(workspace.CurrentCamera.CFrame * Vector3.new(CONTROL.Left + CONTROL.Right, CONTROL.Up + CONTROL.Down, CONTROL.Forward + CONTROL.Backward) - workspace.CurrentCamera.CFrame.Position)
        LinVel.VectorVelocity = Vector3.new(CurrentLook.X,CurrentLook.Y,CurrentLook.Z) * _G.Speed
        game.Players.LocalPlayer.Character:MoveTo(FlyBlock.Position)
    else
        FlyBlock.Position = game.Players.LocalPlayer.Character.PrimaryPart.Position
    end
end)