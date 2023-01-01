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
	local Attachment = Instance.new("Attachment", Pp)
	Attachment.CFrame = CFrame.new(Pp.Position)
	Attachment.Visible = true
	local Lv = Instance.new("LinearVelocity", Attachment)
	Lv.Attachment0 = Attachment
	Lv.MaxForce = 1000000000000000
	Lv.VectorVelocity = Vector3.new(10, 0, 10)
	Lv.Enabled = true
	Lv.RelativeTo = "World"
	Lv.VelocityConstraintMode = "Vector"

	print('Success?')
	end