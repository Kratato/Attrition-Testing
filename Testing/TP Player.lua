local Camera = workspace.CurrentCamera.CFrame.Position
local MinDistance = 30
local LocalCharacter

for i,v in pairs(game.Workspace.Characters:GetChildren()) do
	local Pos = v.PrimaryPart.Position
	local Distance = math.sqrt(math.pow(Camera.X-Pos.X,2)+math.pow(Camera.Y-Pos.Y,2)+math.pow(Camera.Y-Pos.Y,2))
	if Distance < MinDistance then
		MinDistance = Distance
		LocalCharacter = v
	end
end

if LocalCharacter ~= nil then
	local Pp = LocalCharacter.PrimaryPart
	LocalCharacter:MoveTo(Pp.Position + Vector3.new(0, 100, 0))
end