local RS = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

repeat print("waiting for HUD...") wait(1) until LocalPlayer.PlayerGui.HudApp.MenuHud:FindFirstChild("Container") ~= nil
local TeamName = LocalPlayer.PlayerGui.HudApp.MenuHud.Container.Leaderboard.PlayerTeam.TeamBanner.TeamName.Text
print("Found! Team is:",TeamName)


--variables for easy changing
local AlwaysOnTop = false
local Size = 100
local Transparency = 0.5
local EspColor = Color3.fromRGB(255,0,0)

--Team Finder
local Red = {BrickColor.new("Bright red"), BrickColor.new("Tawny"), BrickColor.new("Terra Cotta")}
local Blue = {BrickColor.new("Bright blue"), BrickColor.new("Steel blue"), BrickColor.new("Bright blueish violet")}
local White = {BrickColor.new("White"), BrickColor.new("White"), BrickColor.new("White")}
local TeamColor

if TeamName == "United Bloxxers" then
	TeamColor = Blue
elseif TeamName == "League of 1x1x1x1" then
	TeamColor = Red
else
	TeamColor = White
end


function CreateEsp(character)
	if character.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor[1] then
		for _,BodyPart in pairs(character.BodyParts:GetChildren()) do
			if BodyPart.ClassName == "MeshPart" then
				local BHA = Instance.new("BoxHandleAdornment",BodyPart)
				BHA.Color3 = EspColor
				BHA.Size = Vector3.new(BodyPart.Size.X * (Size/100),BodyPart.Size.Y,BodyPart.Size.Z * (Size/100))
				BHA.AlwaysOnTop = AlwaysOnTop
				BHA.Adornee = BodyPart
				BHA.ZIndex = 0
				BHA.Transparency = Transparency
				BHA.Name = "PlayerEsp"
				BHA.Visible = true
			end
		end
	end
end

for _,Character in pairs(game.workspace.Characters:GetChildren()) do
	if Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
		CreateEsp(Character)
	end
end

local LookForDead = RS.Stepped:Connect(function()
	for _,v in pairs(game.workspace.Characters:GetChildren()) do
		if v.BodyParts:FindFirstChildOfClass("BallSocketConstraint") ~= nil then
			for _,w in pairs(v.BodyParts:GetChildren()) do
				if w:FindFirstChild("PlayerEsp") ~= nil then
					w:FindFirstChild("PlayerEsp"):Destroy()
				end
			end
		end
	end
end)

local PlayerSpawned = game.workspace.Characters.ChildAdded:Connect(function(character)
	wait(1)
	CreateEsp(character)
end)


--Waits for Closing keys: P & L
local Connected = true
task.spawn(function()
	while Connected == true do
		wait()
		if UIS:IsKeyDown(112,108) == true then
			LookForDead:Disconnect()
			PlayerSpawned:Disconnect()
			for _,v in pairs(game.workspace.Characters:GetDescendants()) do
				if v.ClassName == "BoxHandleAdornment" then
					v:Destroy()
				end
			end
			print("Disconected")
			Connected = false
		end
	end
end)