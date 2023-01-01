local Players = game:GetService("Players")
local LocalPlayer = cmdp.LocalPlayer
local RS = game:GetService("RunService")

local Camera = workspace.CurrentCamera
local CameraPos = Camera.CFrame.Position

local LocalCharacter
local MinDistance = 30
for _,Characters in pairs(game.Workspace.Characters:GetChildren()) do
	local Pos = Characters.PrimaryPart.Position
	local Distance = math.sqrt(math.pow(CameraPos.X-Pos.X,2)+math.pow(CameraPos.Y-Pos.Y,2)+math.pow(CameraPos.Y-Pos.Y,2))
	if Distance < MinDistance then
		MinDistance = Distance
		LocalCharacter = Characters
	end
end

