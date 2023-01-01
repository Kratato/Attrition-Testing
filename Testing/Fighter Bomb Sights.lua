--Services
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService('RunService')

--Clears any Possible Debris from previous executions
function ClearParts()
	for _,v in pairs(game.workspace:GetChildren()) do 
		if v.Name == 'CrosshairBlock' 
		or v.Name == 'CrosshairGui' 
		or v.Name == 'CrossHair'
		or v.Name == 'VelocityLine'
		then v:Destroy() print('Destroyed:',v.Name) end end
		print('---')
end
ClearParts()

--Variables
local FighterTotal = 0
local Bomb = nil
local Distance = 0
local Closest = 10000000
local TempBomb = nil

local Camera = game.Workspace.Camera.CFrame.Position

for _,v in pairs(game.Workspace.Vehicles:GetChildren()) do 
	if v.Name == 'Fighter' then
		for _,w in pairs(v:GetDescendants()) do if w.Name == 'Bomb' and w.Parent.Name == 'BombModel' then
				TempBomb = w.Position
				Distance = math.sqrt(math.pow(Camera.X-TempBomb.X,2) + math.pow(Camera.Y-TempBomb.Y,2) + math.pow(Camera.Z-TempBomb.Z,2))
				if Distance < Closest then Closest = Distance Bomb = w 
				end 
			end
		end
	end
end
if Bomb == nil then warn('No Fighters Found...') 
else
	--Crosshair
	local Crosshair = Instance.new('Part',game.Workspace)
	Crosshair.Position = Vector3.new(0,0,0)
	Crosshair.Transparency = 1
	Crosshair.Anchored = true
	Crosshair.CanCollide = false
	Crosshair.CanQuery = false
	Crosshair.Name = 'CrosshairBlock'

	local CrossHairBox = Instance.new('BillboardGui',game.Workspace)
	CrossHairBox.Adornee = Crosshair
	CrossHairBox.Size = UDim2.new(0,30,0,30)
	CrossHairBox.AlwaysOnTop = true
	CrossHairBox.Name = 'CrosshairGui'


	local BoxLabel = Instance.new("TextLabel",game.Workspace.CrosshairGui)
	BoxLabel.Text = '[   ]'
	BoxLabel.TextScaled = true
	BoxLabel.TextWrapped = true
	BoxLabel.Position = UDim2.new(0,-35,0,-35)
	BoxLabel.Size = UDim2.new(0,100,0,100)
	BoxLabel.BackgroundTransparency = 1
	BoxLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	BoxLabel.Name = 'CrossHair'

	VelocityLine = Instance.new('Part',game.Workspace)
	VelocityLine.Name = 'VelocityLine'
	VelocityLine.CanCollide = false
	VelocityLine.Anchored = true
	VelocityLine.Transparency = 0.5

	--Other Variables
	local Vel,Next,PrevNext,RcR = nil 
	local Gravity = 2


	repeat
		RunService.HeartBeat:Wait()
		Pos = Bomb.Position
		Vel = Bomb.Velocity
		local i = 2
		local Hit,Miss = false,false
		repeat
			i = i + 0.5 --time
			j = i - 0.5 --time but half a second ago
			Next = Vector3.new(Pos.X+(Vel.X*i),(-1/2*Gravity*(i*i))+(Vel.Y*i+(Pos.Y)),CPos.Z+(Vel.Z*i)) --Next pos according to "i"
			PrevNext = Vector3.new(Pos.X+(Vel.X*j),(-1/2*Gravity*(j*j))+(Vel.Y*j+(Pos.Y)),Pos.Z+(Vel.Z*j)) -- Next pos according to "j"
			RcR = workspace:Raycast(PrevNext,Next)

			--Test Raycast For Hits
			if RcR ~= nil then Hit = true 
			elseif Next.Y < -200 then Miss = true end

		until Hit == true or Miss == true
		if Hit == true then Crosshair.Position = RcR.Position end
		if UserInputService:IsKeyDown(112,108) == true then EndScript = true end
	until EndScript == true
	print('Script Ended, Have Fun :)')
	ClearParts()
end