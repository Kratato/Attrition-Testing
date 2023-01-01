print('executed')

local RunService = game:GetService("RunService")

local Characters = game.workspace.Characters

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Camera = game.workspace.Camera.CFrame.Position

local IESPholder = Instance.new("Folder", LocalPlayer.PlayerGui)
IESPholder.Name = 'ESP'

local TracerHolder = Instance.new("Folder",game.workspace)
TracerHolder.Name = 'Tracers'

local PlayerParts = Instance.new("Folder",game.workspace)
PlayerParts.Name = 'PlayerParts'

--Format: {Part,PartsParent}
local PlayerPartsList = {}
--Format: {Part,EspPart}
local PlayerEspPartsList = {}

--Add Parts
RunService.Heartbeat:Connect(function()
	for _,PlayerModels in pairs(game.workspace.Characters:GetChildren()) do
		if PlayerModels.BodyParts:FindFirstChildOfClass('BallSocketConstraint') == nil then
			for _,PlayerPart in pairs(PlayerModels.BodyParts:GetChildren()) do 
				if PlayerPart.ClassName == 'MeshPart' then
					local Existing = false
					for _,ExistingParts in pairs(PlayerPartsList) do if PlayerPart == ExistingParts[1] then Existing = true end
					if Existing == false then 
						table.insert(PlayerPartsList,{PlayerPart,PlayerPart.Parent})
end)

--Remove Parts and ESP boxes
RunService.Heartbeat:connect(function()
	for _,PlayerModels in pairs(game.workspace.Characters:GetChildren()) do
		if PlayerModels.BodyParts:FindFirstChildOfClass('BallSocketConstraint') ~= nil then
			for PartPos,ExistingParts in pairs(PlayerPartsList) do 
				if PlayerModels.BodyParts == Existingparts[2] then
					table.remove(PlayerPartsList,PartPos)
					for EspPos,ExisitingEsp in pairs(PlayerEspPartsList) do
						if ExistingEsp[1] == ExistingParts[1] then
							table.remove(PlayerEspPartsList,EspPos)
							ExisitingEsp[2]:Destroy()
end)

--Add ESP to Parts
RunService.Heartbeat:connect(function()
	for _,PlayerPart in pairs(PlayerPartsList) do
		local a = Instance.new("BoxHandleAdornment", IESPholder)
		a.Name = PlayerPart[1].Name
		a.Adornee = PlayerPart[1]
		a.AlwaysOnTop = true
		a.ZIndex = 0
		a.Size = PlayerPart[1].Size
		a.Transparency = 0
		table.insert(PlayerEspPartsList,{PlayerPart,a})
end)

--temp disabled
local Heads = {}
			function FindPlayers()
				Camera = game.workspace.Camera.CFrame.Position
				for _,v in pairs(game.workspace.Characters:GetChildren()) do
					for _,w in pairs(v.BodyParts:GetChildren()) do
						if w.ClassName == 'MeshPart' then
							if math.sqrt(math.pow(w.Position.X-Camera.X,2) + math.pow(w.Position.Y-Camera.Y,2) + math.pow(w.Position.Z-Camera.Z,2)) > 15 then
								HighlightPart(w)
								if w.Name == 'Head' then table.insert(Heads,w) end
							end
						end
					end
				end
			end

			function HighlightPart(v)
				spawn(function()
					Camera = game.workspace.Camera.CFrame.Position
					local a = Instance.new("BoxHandleAdornment", IESPholder)
					a.Name = v.Name
					a.Adornee = v
					a.AlwaysOnTop = true
					a.ZIndex = 0
					a.Size = v.Size
					a.Transparency = 0
				end)
			end

			RunService.Stepped:Connect(function()
				if Heads ~= {} then
					TracerHolder:ClearAllChildren()
					Camera = game.workspace.Camera.CFrame.Position
					for _,v in pairs(Heads) do
						local b = Instance.new("Part", TracerHolder)
						b.CFrame = CFrame.new((v.Position + (Camera + Vector3.new(0,-5,0))) / 2, v.Position)
						b.Size = Vector3.new(0.1, 0.1, math.sqrt(math.pow(v.Position.X-Camera.X,2) + math.pow(v.Position.Y-Camera.Y,2) + math.pow(v.Position.Z-Camera.Z,2)))
						b.Anchored = true
						b.CanCollide = false
						b.Transparency = 0.9

						local a = Instance.new("BoxHandleAdornment", IESPholder)
						a.Name = v.Name..'-Tracer'
						a.Adornee = b
						a.AlwaysOnTop = true
						a.ZIndex = 0
						a.Transparency = 0.8
						a.Size = b.Size
					end
					wait()
				end

			end)




FindPlayers()

Characters.ChildAdded:Connect(function(instance)
	IESPholder:ClearAllChildren()
	Heads = {}
	FindPlayers()
end)