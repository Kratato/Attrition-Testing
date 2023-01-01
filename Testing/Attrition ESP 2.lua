print('executed')

local RunService = game:GetService("RunService")

local Characters = game.workspace.Characters

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local Camera = game.workspace.Camera.CFrame.Position

local EspParts = Instance.new("Folder", LocalPlayer.PlayerGui)
EspParts.Name = 'ESP'

local PlayerParts = Instance.new("Folder",game.workspace)
PlayerParts.Name = 'PlayerParts'

--Format: {Part,PartsParent}
local PlayerPartsList = {}
--Format: {Part,EspPart}
local PlayerEspPartsList = {}

--Add Parts
RunService.Heartbeat:Connect(function()
	for _,PlayerModels in pairs(Characters:GetChildren()) do
		if PlayerModels.BodyParts:FindFirstChildOfClass('BallSocketConstraint') == nil then
			for _,PlayerPart in pairs(PlayerModels.BodyParts:GetChildren()) do 
				if PlayerPart.ClassName == 'MeshPart' then
					local Existing = false
					for _,ExistingParts in pairs(PlayerPartsList) do if PlayerPart == ExistingParts[1] then Existing = true end end
					if Existing == false then 
						table.insert(PlayerPartsList,{PlayerPart,PlayerPart.Parent})
                    end
                end
            end
        end
    end
end)

--Remove Parts and ESP boxes
RunService.Heartbeat:connect(function()
	for _,PlayerModels in pairs(Characters:GetChildren()) do
		if PlayerModels.BodyParts:FindFirstChildOfClass('BallSocketConstraint') ~= nil then
			for PartPos,ExistingParts in pairs(PlayerPartsList) do 
				if PlayerModels.BodyParts == Existingparts[2] then
					table.remove(PlayerPartsList,PartPos)
					for EspPos,ExisitingEsp in pairs(PlayerEspPartsList) do
						if ExistingEsp[1] == ExistingParts[1] then
							table.remove(PlayerEspPartsList,EspPos)
							ExisitingEsp[2]:Destroy()
                        end
                    end
                end
            end
        end
    end
end)

--Add ESP to Parts
RunService.Heartbeat:connect(function()
	for _,PlayerPart in pairs(PlayerPartsList) do
		local a = Instance.new("BoxHandleAdornment", EspParts)
		a.Name = PlayerPart[1].Name
		a.Adornee = PlayerPart[1]
		a.AlwaysOnTop = true
		a.ZIndex = 0
		a.Size = PlayerPart[1].Size
		a.Transparency = 0
		table.insert(PlayerEspPartsList,{PlayerPart,a})
    end
end)