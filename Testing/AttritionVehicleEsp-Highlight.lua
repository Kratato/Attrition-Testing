local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

--[[local VehicleInfo = {
	Jeep = ".Body.Sections.Hull.Hull",
	["Field Gun"] = ".Body.Sections.Hull.BodyRoot",
	Truck = ".Body.Sections.Hull.Body",
	APC = ".Body.Sections.Hull.Hull",
	Tank = ".Body.Root",
	Transport_Helicopter = ".Body.Sections.Hull.Body",
	Attack_Helicopter = ".Body.Sections.Hull.Hull",
	Helicopter = ".Body.Sections.Hull.Main",
	Fighter = ".Body.Sections.Hull.Cockpit",
	Attack_Jet = ".Body.Sections.Hull.Cockpit",
}]]


repeat print("waiting for HUD...") wait(1) until LocalPlayer.PlayerGui.HudApp.MenuHud:FindFirstChild("Container") ~= nil
local TeamName = LocalPlayer.PlayerGui.HudApp.MenuHud.Container.Leaderboard.PlayerTeam.TeamBanner.TeamName.Text
print("Found! Team is:",TeamName)

local Red = {BrickColor.new("Tawny"), BrickColor.new("Terra Cotta")}
local Blue = {BrickColor.new("Steel blue"), BrickColor.new("Bright blueish violet")}
local White = {BrickColor.new("White"), BrickColor.new("White")}
local TeamColor

if TeamName == "United Bloxxers" then
	TeamColor = Blue
elseif TeamName == "League of 1x1x1x1" then
	TeamColor = Red
else
	TeamColor = White
end

--Variables
local VehicleTransparency = 0.5
local VehicleEspColor = Color3.fromRGB(255,0,0)


-- Old (Keeps Crashing for some reason...)

-- local function IdentifyVehicle(Vehicle)
-- 	print("Identifying...")
-- 	print("Name:",Vehicle.Name)
-- 	wait(1)
-- 	local Enemy = false
-- 	if Vehicle.Name == "Jeep" then

-- 		if Vehicle.Body.Sections.Hull.Hull.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Field Gun" then

-- 		if Vehicle.Body.Sections.Hull.BodyRoot.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Truck" then

-- 		if Vehicle.Body.Sections.Hull.Body.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "APC" then

-- 		if Vehicle.Body.Sections.Hull.Hull.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Tank" then

-- 		if Vehicle.Body.Root.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Transport_Helicopter" then

-- 		if Vehicle.Body.Sections.Hull.Body.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Attack_Helicopter" then

-- 		if Vehicle.Body.Sections.Hull.Hull.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Helicopter" then

-- 		if Vehicle.Body.Sections.Hull.Main.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Fighter" then

-- 		if Vehicle.Body.Sections.Hull.Cockpit.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end

-- 	elseif Vehicle.Name == "Attack_Jet" then

-- 		if Vehicle.Body.Sections.Hull.Cockpit.BrickColor ~= TeamColor then
-- 			Enemy = true else Enemy = false end
-- 	else 
-- 		Enemy = false
-- 	end
-- 	if Enemy then print("Enemy\n") return true else print("Friendly\n") return false end

-- end

-- local function IdentifyVehicle(Vehicle)
-- 	local Part = Vehicle.Body.Sections.Hull:FindFirstChildOfClass("MeshPart")
-- 	if Part.BrickColor == TeamColor[1] or Part.BrickColor == TeamColor[2] then
-- 		return true
-- 	else
-- 		return false
-- 	end
-- end



for i,v in pairs(game.Workspace.Vehicles:GetDescendants()) do
	if v.ClassName == "Highlight" then
		v:Destroy()
	end
end

for _,V in pairs(game.workspace.Vehicles:GetChildren()) do
	wait(0.5)
	local Part = V.Body.Sections.Hull:FindFirstChildOfClass("MeshPart")
	if Part.BrickColor == TeamColor[1] or Part.BrickColor == TeamColor[2] then
		local HL = Instance.new("Highlight",V)
		HL.FillColor = VehicleEspColor
		HL.OutlineColor = VehicleEspColor
		HL.Enabled = true
	end
	print("Passed")
end

local VehicleSpawned = game.workspace.Vehicles.ChildAdded:Connect(function(V)
	wait(1)
	local Part = V.Body.Sections.Hull:FindFirstChildOfClass("MeshPart")
	if Part.BrickColor == TeamColor[1] or Part.BrickColor == TeamColor[2] then
		local HL = Instance.new("Highlight",V)
		HL.FillColor = VehicleEspColor
		HL.OutlineColor = VehicleEspColor
		HL.Enabled = true
	end
end)

local ClearDeadVehicles = task.spawn(function()
	while true do
		for _,v in pairs(game.workspace.ScrapNodes:GetDescendants()) do
			if v.ClassName == "Highlight" then
				v:Destroy()
			end
		end
	end
end)

-- --Waits for Closing keys: P & L
-- task.spawn(function()
-- 	while true do
-- 		wait()
-- 		if UIS:IsKeyDown(112,108) == true then
-- 			VehicleSpawned:Disconnect()
-- 			task.cancel(ClearDeadVehicles)
-- 			for _,v in pairs(game.workspace.Vehicles:GetDescendants()) do
-- 				if v.ClassName == "Highlight" then
-- 					v:Destroy()
-- 				end
-- 			end
-- 			print("Disconected")
-- 			break
-- 		end
-- 	end
-- end)