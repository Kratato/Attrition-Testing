local Camera = workspace.CurrentCamera
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer
local MousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
local Holding = false

local Red = {LegColor = BrickColor.new("Bright red"), Vehicle1 = BrickColor.new("Tawny"), Vehicle2 = BrickColor.new("Terra Cotta")}
    local Blue = {LegColor = BrickColor.new("Bright blue"), Vehicle1 = BrickColor.new("Steel blue"), Vehicle2 = BrickColor.new("Bright blueish violet")}
    local White = {LegColor = BrickColor.new("White"), Vehicle1 = BrickColor.new("White"), Vehicle2 = BrickColor.new("White")}
    local Team = LocalPlayer.Team
    local TeamColor

    if Team == game.Teams["United Bloxxers"] then
        TeamColor = Blue            
    elseif Team == game.Teams["League of 1x1x1x1"] then
        TeamColor = Red
    else
        TeamColor = White
    end
    print(Team)

_G.AimbotEnabled = true
_G.TeamCheck = true
_G.AimPart = "Head"
_G.Sensitivity = 1

_G.CircleSides = 64
_G.CircleColor = Color3.fromRGB(255, 255, 255)
_G.CircleTransparency = 0.7
_G.CircleRadius = 360
_G.CircleFilled = false
_G.CircleVisible = true
_G.CircleThickness = 0

local FOVCircle = Drawing.new("Circle")
FOVCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Filled = _G.CircleFilled
FOVCircle.Color = _G.CircleColor
FOVCircle.Visible = _G.CircleVisible
FOVCircle.Radius = _G.CircleRadius
FOVCircle.Transparency = _G.CircleTransparency
FOVCircle.NumSides = _G.CircleSides
FOVCircle.Thickness = _G.CircleThickness

local function GetClosestPlayer()
	local MaximumDistance = _G.CircleRadius
	local Target = nil

     for _, v in game.workspace.Characters:GetChildren() do
        if v ~= LocalPlayer.Character then
            if v.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor.LegColor then
                if v.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
                    local ScreenPoint, Visible = Camera:WorldToScreenPoint(v.PrimaryPart.Position)
                    if Visible then
                        local VectorDistance = (MousePos - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude                           
                        if VectorDistance < MaximumDistance then
                            MaximumDistance = VectorDistance
                            Target = v
                        end
                    end
                end
            end
        end
    end

	return Target
end

local UISin = UserInputService.InputBegan:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = true
    end
end)

local USIout = UserInputService.InputEnded:Connect(function(Input)
    if Input.UserInputType == Enum.UserInputType.MouseButton2 then
        Holding = false
    end
end)

local Update = RunService.RenderStepped:Connect(function()
    FOVCircle.Position = MousePos
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Filled = _G.CircleFilled
    FOVCircle.Color = _G.CircleColor
    FOVCircle.Visible = _G.CircleVisible
    FOVCircle.Radius = _G.CircleRadius
    FOVCircle.Transparency = _G.CircleTransparency
    FOVCircle.NumSides = _G.CircleSides
    FOVCircle.Thickness = _G.CircleThickness

    if Holding == true and _G.AimbotEnabled == true then
        local Target = GetClosestPlayer()
        if Target ~= nil then
			local targetPos = Camera:WorldToScreenPoint(Target.BodyParts[_G.AimPart].Position)	
            mousemoverel((targetPos.X - MousePos.X) / 2, (targetPos.Y - MousePos.Y) / 2)
		end
    end
end)


task.spawn(function()
    repeat
        wait()
    until UserInputService:IsKeyDown(Enum.KeyCode.PageDown) == true
    FOVCircle:Destroy()
    UISin:Disconnect()
    USIout:Disconnect()
    Update:Disconnect()
end)