local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Red = {BrickColor.new("Tawny"), BrickColor.new("Terra Cotta")}
local Blue = {BrickColor.new("Steel blue"), BrickColor.new("Bright blueish violet")}
local White = {BrickColor.new("White"), BrickColor.new("White")}
local Team = LocalPlayer.Team
local TeamColor

if Team == "United Bloxxers" then
	TeamColor = Blue            
elseif Team == "League of 1x1x1x1" then
	TeamColor = Red
else
	TeamColor = White
end

local VehicleTransparency = 0.5
local VehicleEspColor = Color3.fromRGB(255,0,0)

for i,v in pairs(game.Workspace.Vehicles:GetDescendants()) do
	if v.ClassName == "Highlight" then
		v:Destroy()
	end
end

for _,V in pairs(game.workspace.Vehicles:GetChildren()) do
	local Part = V.Body.Sections.Hull:FindFirstChildOfClass("MeshPart")
	if Part.BrickColor ~= TeamColor[1] or Part.BrickColor ~= TeamColor[2] then
		local HL = Instance.new("Highlight",V)
		HL.FillColor = VehicleEspColor
		HL.OutlineColor = VehicleEspColor
		HL.Enabled = true
	end
end

local VehicleSpawned = game.workspace.Vehicles.ChildAdded:Connect(function(V)
	wait(1)
	local Part = V.Body.Sections.Hull:FindFirstChildOfClass("MeshPart")
	if Part.BrickColor ~= TeamColor[1] or Part.BrickColor ~= TeamColor[2] then
		local HL = Instance.new("Highlight",V)
		HL.FillColor = VehicleEspColor
		HL.OutlineColor = VehicleEspColor
		HL.Enabled = true
	end
end)

local VehicleDied = game.workspace.ScrapNodes.ChildAdded:Connect(function(Vehicle)
	wait(2)
	if Vehicle:FindFirstChildOfClass("Highlight") then Vehicle:FindFirstChildOfClass("Highlight"):Destroy() end
end)

task.spawn(function()
	repeat wait() until UIS:IsKeyDown(Enum.KeyCode.T)

	VehicleSpawned:Disconnect()
	VehicleDied:Disconect()
	for _,v in pairs(game.workspace.Vehicles:GetDescendants()) do
		if v.ClassName == "Highlight" then
			v:Destroy()
		end
	end
	for _,v in pairs(game.workspace.ScrapNodes:GetDescendants()) do
		if v.ClassName == "Highlight" then
			v:Destroy()
		end
	end
	print("Disconected")
end)