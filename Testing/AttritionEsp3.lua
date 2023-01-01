print('started..')

local RS = game:GetService("RunService")
local Camera = workspace.CurrentCamera.CFrame.Position
local LocalCharacter
local Team
local Loading = true
local EspPause = true
local Toggled = true
local EspFolder = Instance.new("Folder", game:GetService("Players").LocalPlayer.PlayerGui)
EspFolder.Name = "EspFolder"

repeat 
if workspace.CurrentCamera.CFrame.Position ~= 4000 then Loading = false end
print('waiting...')
wait(1)
until Loading == false
print('spawned?')

-- Functions --
function FindLocalCharacter()
    local Characters = game.Workspace.Characters
    local MinDistance = 30
    local LC
    for i,v in pairs(Characters:GetChildren()) do
	    local Pos = v.PrimaryPart.Position
	    local Distance = math.sqrt(math.pow(Camera.X-Pos.X,2)+math.pow(Camera.Y-Pos.Y,2)+math.pow(Camera.Y-Pos.Y,2))
	    if Distance < MinDistance then
	    	MinDistance = Distance
    		LC = v
    	end
    end
    return LC
end

function FindTeam(player)
    return BrickColor.new(player.BodyParts.UpperTorso.Color)
end

function ReloadEsp()
    if EspPause == false then
        EspFolder:ClearAllChildren()
        for _,Player in pairs(game.workspace.Characters:GetChildren()) do
            if Player ~= LocalCharacter and (Player:WaitForChild("BodyParts")):FindFirstChildOfClass("BallSocketConstraint") == nil and Team ~= FindTeam(Player) and Team ~= nil then
                for _,BodyPart in pairs((Player:WaitForChild("BodyParts")):GetChildren()) do
                    if BodyPart.ClassName == "MeshPart" then
                        local Box = Instance.new("BoxHandleAdornment",EspFolder)
                        Box.Name = BodyPart.Name
                        Box.Adornee = BodyPart
                        Box.AlwaysOnTop = true
                        Box.ZIndex = 0
                        Box.Size = BodyPart.Size
                        Box.Transparency = 0.5
                        Box.Color = BrickColor.new(Player.BodyParts.UpperTorso.Color)
                    end
                end
            end
        end
    end
end

function ClearDeadEsp(player)
    for i,EspPart in pairs(EspFolder:GetChildren()) do
        if EspPart.Adornee.Parent.Parent == player then
            EspPart:Destroy()
        end
    end
end

--Find LocalCharacter
repeat LocalCharacter = FindLocalCharacter() wait() until LocalCharacter ~= nil
Team = FindTeam(LocalCharacter)
EspPause = false
print('Player Found')

--
game.workspace.Characters.ChildAdded:Connect(ReloadEsp)
game.workspace.Characters.ChildRemoved:Connect(ReloadEsp)


task.spawn(function()
    while Toggled do
    for _,Player in pairs(game.workspace.Characters:GetChildren()) do
        if (Player:WaitForChild("BodyParts")):FindFirstChildOfClass("BallSocketConstraint") ~= nil then
            if Player ~= LocalCharacter then
                ClearDeadEsp(Player)
            end
        end
    end
    wait(1)
    end
end)

task.spawn(function()
    while Toggled do
        if LocalCharacter.BodyParts:FindFirstChildOfClass("BallSocketConstraint") ~= nil then
            EspPause = true
            LocalCharacter:Destroy()
            repeat LocalCharacter = FindLocalCharacter() wait() until LocalCharacter ~= nil
            Team = FindTeam(LocalCharacter)
            EspPause = false
            print('Player Found!')
        end
    end
end)
