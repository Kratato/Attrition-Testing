local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera
local CCF = Camera.CFrame
local Vehicles = game.workspace.Vehicles
local MinDistance = 100
local LV
local FLYING = false
local TOGGLED = false
_G.SPEED = 250

function FindLV()
	for i,Vehicle in pairs(Vehicles:GetChildren()) do
		local Pos = Vehicle.PrimaryPart.Position
		local Distance = math.sqrt(math.pow(CCF.Position.X-Pos.X,2)+math.pow(CCF.Position.Y-Pos.Y,2)+math.pow(CCF.Position.Y-Pos.Y,2))
		if Distance < MinDistance then
			MinDistance = Distance
			LV = Vehicle
		end
	end
end

repeat FindLV() wait(1) until LV ~= nil
FLYING = true

FlyBlock = Instance.new("Part",game.workspace)
FlyBlock.CanCollide = false
FlyBlock.Transparency = 0
FlyBlock.Size = Vector3.new(1,1,1)
FlyBlock.Position = LV.PrimaryPart.CFrame.Position

SeeFlyBlock = Instance.new("BoxHandleAdornment",game.Players.LocalPlayer.PlayerGui)
SeeFlyBlock.Adornee = FlyBlock
SeeFlyBlock.Size = FlyBlock.Size
SeeFlyBlock.AlwaysOnTop = true
SeeFlyBlock.Transparency = 0

local Attachment = Instance.new("Attachment",FlyBlock)
Attachment.Name = "LinVel Attachment"

local LinVel = Instance.new("LinearVelocity",Attachment)
LinVel.Attachment0 = Attachment
LinVel.MaxForce = (2^63) - 1

LV.PrimaryPart.Anchored = false

--Movement Keys
local CONTROL = {W = 0, S = 0, D = 0, A = 0, Q = 0, E = 0}

UIS.InputBegan:Connect(function(KEY)
	if KEY.KeyCode == Enum.KeyCode.W then
		CONTROL.W = -1
	end
	if KEY.KeyCode == Enum.KeyCode.S then
		CONTROL.S = 1
	end
	if KEY.KeyCode == Enum.KeyCode.D then
		CONTROL.D = 1
	end
	if KEY.KeyCode == Enum.KeyCode.A then
		CONTROL.A = -1
	end
	if KEY.KeyCode == Enum.KeyCode.LeftControl then
		CONTROL.Q = -1
	end
	if KEY.KeyCode == Enum.KeyCode.Space then
		CONTROL.E = 1
	end
end)
	
UIS.InputEnded:Connect(function(KEY)
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
	if KEY.KeyCode == Enum.KeyCode.LeftControl then
		CONTROL.Q = 0
	end
	if KEY.KeyCode == Enum.KeyCode.Space then
		CONTROL.E = 0
	end
end)

--Toggle
UIS.InputBegan:Connect(function(KEY) 
	if KEY.KeyCode == Enum.KeyCode.T then
		TOGGLED = not TOGGLED
		--LV.PrimaryPart.Anchored = TOGGLED
	end
end)

--If Vehicle is Destroyed
LV.Destroying:Connect(function() 
	FLYING = false
	LV = nil
	if TOGGLED then
		repeat FindLV() wait(1) until LV ~= nil
	end
	FLYING = true
end)

RS.RenderStepped:Connect(function()
	if FLYING and TOGGLED then
		LV:SetPrimaryPartCFrame(CFrame.new(LV.PrimaryPart.CFrame.Position,LV.PrimaryPart.CFrame.Position + workspace.CurrentCamera.CFrame.lookVector))
		local CurrentLook = CFrame.new(workspace.CurrentCamera.CFrame * Vector3.new(CONTROL.A + CONTROL.D, CONTROL.E + CONTROL.Q, CONTROL.W + CONTROL.S) - workspace.CurrentCamera.CFrame.Position)
		LinVel.VectorVelocity = Vector3.new(CurrentLook.X,CurrentLook.Y,CurrentLook.Z) * _G.SPEED
		LV:MoveTo(FlyBlock.Position)
	else
		FlyBlock.Position = LV.PrimaryPart.CFrame.Position
	end
end)
