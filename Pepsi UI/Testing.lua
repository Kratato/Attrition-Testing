local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()

local Active = true
task.spawn(function() 
    repeat wait() until Library.Unload == nil
    Active = false

    for _,v in game.workspace:GetDescendants() do
        if v.ClassName == "Highlight" then
            v:Destroy()
        end
    end

    task.cancel(PlayerFlyBlockUpdate1)

    Drawing.Clear()
end)

local Alive = false
task.spawn(function()
    repeat
        if LocalPlayer.Character.Parent ~= nil then
            if LocalPlayer.Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
                Alive = true
            else
                Alive = false
            end
        else
            Alive = false
        end
        wait()
    until not Active
end)

-- Universal Variables & Services

    local RunService = game:GetService("RunService")
    local UserInputService = game:GetService("UserInputService")
    local Players = game:GetService("Players")
    local Teams = game:GetService("Teams")

    local LocalPlayer = Players.LocalPlayer
    local Camera = game.workspace.CurrentCamera
    local MousePos = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
    local Team = LocalPlayer.Team
    local TeamColor

-- Team Identification

    local Blue = {LegColor = BrickColor.new("Bright blue"), Vehicle1 = BrickColor.new("Steel blue"), Vehicle2 = BrickColor.new("Bright blueish violet")}
    local Red = {LegColor = BrickColor.new("Bright red"), Vehicle1 = BrickColor.new("Tawny"), Vehicle2 = BrickColor.new("Terra Cotta")}
    local White = {LegColor = BrickColor.new("White"), Vehicle1 = BrickColor.new("White"), Vehicle2 = BrickColor.new("White")}

    if Team == Teams["United Bloxxers"] then
        TeamColor = Blue
    elseif Team == Teams["League of 1x1x1x1"] then
        TeamColor = Red
    else
        TeamColor = White
    end


--Hax Variables

    local Player = {
        Esp = {
            Toggle = false,
            Color = Color3.fromRGB(255,255,255),
            Filled = false,
            Min = 0.1,
            Max = 6
        },
        Tracers = {
            Toggle = false,
            Color = Color3.fromRGB(255,255,255),
            Thickness = 1,
        },
        Chams = {
            Toggle = false,
            Color = Color3.fromRGB(255,0,0),
            Transparency = 0,
            AlwaysOnTop = false
        },
        Fly = {
            Toggle = false,
            Speed = 50
        },
        Aimbot = {
            Toggle = false,
            Color = Color3.fromRGB(255,255,255),
            VisibilityCheck = true,
            AimPartList = {"Head","UpperTorso","LowerTorso"},
            AimPart = "UpperTorso",
            Radius = 240
        }
    }

    local Vehicle = {
        --// Vehicle Chams not possible with Highlight Object due to weird behavior of vehicles on death

        -- Chams = {
        --     Toggle = false,
        --     FriendlyColor = Color3.fromRGB(0,255,0),
        --     EnemyColor = Color3.fromRGB(255,0,0),
        --     AlwaysOnTop = false,
        --     Transparency = 0.25,
        --     Outline = false,
        --     OutlineColor = Color3.fromRGB(255,255,255),
        --     Folder = Instance.new("Folder", game.workspace.Vehicles)
        -- },
        Fly = {
            Toggle = false,
            Speed = 50
        }
    }

--Hax

    -- Player

        -- Visual

            function CreatePlayerEspTracer(Character)
                if Character.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor.LegColor then
                    
                    --ESP Box
                    local PlayerBox = Drawing.new("Quad")
                    PlayerBox.Visible = false
                    PlayerBox.Color = Player.Esp.Color
                    PlayerBox.Filled = Player.Esp.Filled

                    --Tracer
                    local Tracer = Drawing.new("Line")
                    Tracer.Visible = false
                    Tracer.Color = Player.Tracers.Color
                    Tracer.Thickness = Player.Tracers.Color

                    local function ESP()
                        local connection
                        connection = RunService.RenderStepped:Connect(function()
                            if Character ~= nil and Character:FindFirstChild("BodyParts") ~= nil then
                                if Active and Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
                                    local pos, visible = Camera:WorldToViewportPoint(Character.PrimaryPart.Position)
                                    if visible then
                                        if Player.Esp.Toggle then
                                            PlayerBox.Visible = true

                                            PlayerBox.Color = Player.Esp.Color
                                            PlayerBox.Filled = Player.Esp.Filled

                                            PlayerBox.PointA = Camera:WorldToViewportPoint((Character.PrimaryPart.CFrame * CFrame.new(-1.5, 3, 0)).Position)
                                            PlayerBox.PointB = Camera:WorldToViewportPoint((Character.PrimaryPart.CFrame * CFrame.new(1.5, 3, 0)).Position)
                                            PlayerBox.PointC = Camera:WorldToViewportPoint((Character.PrimaryPart.CFrame * CFrame.new(1.5, -3, 0)).Position)
                                            PlayerBox.PointD = Camera:WorldToViewportPoint((Character.PrimaryPart.CFrame * CFrame.new(-1.5, -3, 0)).Position)

                                            local distance = (Camera.CFrame.Position - Character.PrimaryPart.Position).magnitude
                                            local value = math.clamp(1/distance*100, Player.Esp.Min, Player.Esp.Max)
                                            PlayerBox.Thickness = value
                                        else
                                            PlayerBox.Visible = false
                                        end

                                        if Player.Tracers.Toggle then
                                            Tracer.Visible = true

                                            Tracer.Color = Player.Tracers.Color
                                            Tracer.Thickness = Player.Tracers.Thickness

                                            Tracer.From = Vector2.new(Camera.ViewportSize.X/2, Camera.ViewportSize.Y)
                                            Tracer.To = pos
                                        else
                                            Tracer.Visible = false
                                        end
                                    else
                                        PlayerBox.Visible = false
                                        Tracer.Visible = false
                                    end
                                else
                                    PlayerBox:Destroy()
                                    Tracer:Destroy()
                                    connection:Disconnect()
                                    coroutine.yield()
                                end
                            else
                                PlayerBox:Destroy()
                                Tracer:Destroy()
                                connection:Disconnect()
                                coroutine.yield()
                            end
                        end)
                    end
                    coroutine.wrap(ESP)()
                end
            end

            function CreatePlayerChams(Character)
                if Character.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor.LegColor and Character.BodyParts:FindFirstChild("BallSocketConstraint") == nil then
                    for _,BodyPart in Character.BodyParts:GetChildren() do
                        if BodyPart.ClassName == "MeshPart" then
                            local Cham = Instance.new("BoxHandleAdornment",BodyPart)
                            Cham.Color3 = Player.Chams.Color
                            Cham.Size = BodyPart.Size
                            Cham.AlwaysOnTop = Player.Chams.AlwaysOnTop
                            Cham.Adornee = BodyPart
                            Cham.Transparency = Player.Chams.Transparency
                            Cham.Visible = false
                            
                            local function Updater()
                                local connection
                                connection = RunService.RenderStepped:Connect(function()
                                    if Character ~= nil and Character:FindFirstChild("BodyParts") ~= nil then
                                        if Active and Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
                                            if Player.Chams.Toggle then
                                                Cham.Color3 = Player.Chams.Color
                                                Cham.AlwaysOnTop = Player.Chams.AlwaysOnTop
                                                Cham.Transparency = Player.Chams.Transparency
                                                Cham.Visible = true
                                            else
                                                Cham.Visible = false
                                            end
                                        else
                                            Cham:Destroy()
                                            connection:Disconnect()
                                            coroutine.yield()
                                        end
                                    else
                                        Cham:Destroy()
                                        connection:Disconnect()
                                        coroutine.yield()
                                    end
                                end)
                            end
                            coroutine.wrap(Updater)()
                        end
                    end
                end
            end

            for _,Character in game.workspace.Characters:GetChildren() do
                CreatePlayerEspTracer(Character)
                CreatePlayerChams(Character)
            end

            Library.signals.PlayerEspNewPlayer = game.workspace.Characters.ChildAdded:Connect(function(Character)
                wait(1) -- Team Color isn't applied immediately
                CreatePlayerEspTracer(Character)
                CreatePlayerChams(Character)
            end)

        -- Aimbot
        
            local AimbotCircle = Drawing.new("Circle")
            AimbotCircle.Position = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y / 2)
            AimbotCircle.Radius = Player.Aimbot.Radius
            AimbotCircle.Filled = false
            AimbotCircle.Color = Player.Aimbot.Color
            AimbotCircle.Visible = Player.Aimbot.Toggle
            AimbotCircle.Transparency = 1
            AimbotCircle.NumSides = 64




            local AimbotRaycastParams = RaycastParams.new()
            AimbotRaycastParams.FilterDescendantsInstances = {game.workspace.Terrain}
            AimbotRaycastParams.FilterType = Enum.RaycastFilterType.Whitelist
            
            
            function GetClosestPlayer()
                local MaximumDistance = Player.Aimbot.Radius
                local Target
            
                for _, Character in game.workspace.Characters:GetChildren() do
                    if Character ~= LocalPlayer.Character and Character ~= nil then
                        if Character.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor.LegColor then
                            if Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
                                if Player.Aimbot.VisibilityCheck then
                                    local RaycastResult = workspace:Raycast(Camera.CFrame.Position,Character.BodyParts[Player.Aimbot.AimPart].Position - Camera.CFrame.Position, AimbotRaycastParams)
                                    if RaycastResult == nil then
                                        local ScreenPoint, Visible = Camera:WorldToViewportPoint(Character.PrimaryPart.Position)
                                        if Visible then
                                            local VectorDistance = (MousePos - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude                           
                                            if VectorDistance < MaximumDistance then
                                                MaximumDistance = VectorDistance
                                                Target = Character
                                            end
                                        end
                                    end
                                else
                                    local ScreenPoint, Visible = Camera:WorldToViewportPoint(Character.PrimaryPart.Position)
                                    if Visible then
                                        local VectorDistance = (MousePos - Vector2.new(ScreenPoint.X, ScreenPoint.Y)).Magnitude                           
                                        if VectorDistance < MaximumDistance then
                                            MaximumDistance = VectorDistance
                                            Target = Character
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                return Target
            end

            Library.signals.AimbotUpdate = RunService.RenderStepped:Connect(function()
                AimbotCircle.Position = MousePos
                AimbotCircle.Radius = Player.Aimbot.Radius
                AimbotCircle.Filled = false
                AimbotCircle.Color = Player.Aimbot.Color
                AimbotCircle.Visible = Player.Aimbot.Toggle
                AimbotCircle.Transparency = 1
                AimbotCircle.NumSides = 64

                if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) and Player.Aimbot.Toggle then
                    local Target = GetClosestPlayer()
                    if Target ~= nil then
                        local targetPos = Camera:WorldToViewportPoint(Target.BodyParts[Player.Aimbot.AimPart].Position)	
                        mousemoverel((targetPos.X - MousePos.X) / 2, (targetPos.Y - MousePos.Y) / 2)
                    end
                end
            end)
            
        -- Movement

            local PlayerFlyBlock = Instance.new("Part",game.workspace)
            PlayerFlyBlock.CanCollide = false
            PlayerFlyBlock.Transparency = 0
            PlayerFlyBlock.Size = Vector3.new(0,0,0)

            local Attachment = Instance.new("Attachment",PlayerFlyBlock)
            local LinVel = Instance.new("LinearVelocity",Attachment)
            LinVel.Attachment0 = Attachment
            LinVel.MaxForce = (2^63) - 1


            local PlayerFlyBlockUpdate1 = task.spawn(function()
                while Active do
                    if not Alive or not Player.Fly.Toggle then
                        PlayerFlyBlock.Position = Vector3.new(0,0,0)
                    end
                end
            end)

                            
                local CONTROL = {Forward = 0, Backward = 0, Right = 0, Left = 0, Down = 0, Up = 0}

                Library.signals.PlayerFlyControlInputBegan = UserInputService.InputBegan:Connect(function(KEY)
                    if KEY.KeyCode == Enum.KeyCode.W then
                        CONTROL.Forward = -1
                    end
                    if KEY.KeyCode == Enum.KeyCode.S then
                        CONTROL.Backward = 1
                    end
                    if KEY.KeyCode == Enum.KeyCode.D then
                        CONTROL.Right = 1
                    end
                    if KEY.KeyCode == Enum.KeyCode.A then
                        CONTROL.Left = -1
                    end
                    if KEY.KeyCode == Enum.KeyCode.LeftControl then
                        CONTROL.Down = -1
                    end
                    if KEY.KeyCode == Enum.KeyCode.Space then
                        CONTROL.Up = 1
                    end
                end)
                    
                Library.signals.PlayerFlyControlInputEnded = UserInputService.InputEnded:Connect(function(KEY)
                    if KEY.KeyCode == Enum.KeyCode.W then
                        CONTROL.Forward = 0
                    end
                    if KEY.KeyCode == Enum.KeyCode.S then
                        CONTROL.Backward = 0
                    end
                    if KEY.KeyCode == Enum.KeyCode.D then
                        CONTROL.Right = 0
                    end
                    if KEY.KeyCode == Enum.KeyCode.A then
                        CONTROL.Left = 0
                    end
                    if KEY.KeyCode == Enum.KeyCode.LeftControl then
                        CONTROL.Down = 0
                    end
                    if KEY.KeyCode == Enum.KeyCode.Space then
                        CONTROL.Up = 0
                    end
                end)

                Library.signals.PlayerFlyUpdater = RunService.RenderStepped:Connect(function()
                    if Alive then
                        if Player.Fly.Toggle then
                            local CurrentLook = CFrame.new(Camera.CFrame * Vector3.new(CONTROL.Left + CONTROL.Right, CONTROL.Up + CONTROL.Down, CONTROL.Forward + CONTROL.Backward) - Camera.CFrame.Position)
                            LinVel.VectorVelocity = Vector3.new(CurrentLook.X,CurrentLook.Y,CurrentLook.Z) * Player.Fly.Speed
                            LocalPlayer.Character:MoveTo(PlayerFlyBlock.Position)
                        else
                            PlayerFlyBlock.Position = LocalPlayer.Character.PrimaryPart.Position
                        end
                    else
                        PlayerFlyBlock.Position = Vector3.new(0,0,0)
                    end
                end)

    -- Vehicle

         --// Vehicle Chams not possible with Highlight Object due to weird behavior of vehicles on death

        -- function CheckVehicleTeam(vehicle)
        --     for _,v in vehicle:GetDescendants() do
        --         if v.ClassName == "MeshPart" then
        --             if v.BrickColor == TeamColor.Vehicle1 or v.BrickColor == TeamColor.Vehicle2 then
        --                 return "Friendly"
        --             end
        --         end
        --     end
        --     return "Enemy"
        -- end

        -- function CreateVehicleChams(vehicle)
        --     local Highlight = Instance.new("Highlight",Vehicle.Chams.Folder)
        --     Highlight.Adornee = vehicle

        --     if CheckVehicleTeam(vehicle) == "Friendly" then
        --         Highlight.FillColor = Vehicle.Chams.FriendlyColor
        --     else
        --         Highlight.FillColor = Vehicle.Chams.FriendlyColor
        --     end

        --     Highlight.FillTransparency = Vehicle.Chams.Transparency
        --     Highlight.OutlineTransparency = 1
            
        --     if Vehicle.Chams.AlwaysOnTop then
        --         Highlight.DepthMode = "AlwaysOnTop"
        --     else
        --         Highlight.DepthMode = "Occluded"
        --     end

        --     local function Updater()
        --         local connection
        --         connection = RunService.RenderStepped:Connect(function()
        --             if Active then
        --                 if vehicle ~= nil then
        --                     if Vehicle.Chams.Toggle then

        --                         Highlight.Enabled = true
        --                         Highlight.FillTransparency = Vehicle.Chams.Transparency
        --                         Highlight.OutlineColor = Vehicle.Chams.OutlineColor

        --                         if CheckVehicleTeam(vehicle) == "Friendly" then
        --                             Highlight.FillColor = Vehicle.Chams.FriendlyColor
        --                         else
        --                             Highlight.FillColor = Vehicle.Chams.FriendlyColor
        --                         end

        --                         if Vehicle.Chams.Outline then
        --                             Highlight.OutlineTransparency = 0
        --                         else
        --                             Highlight.OutlineTransparency = 1
        --                         end
                                             
        --                         if Vehicle.Chams.AlwaysOnTop then
        --                             Highlight.DepthMode = "AlwaysOnTop"
        --                         else
        --                             Highlight.DepthMode = "Occluded"
        --                         end

        --                     else
        --                         Highlight.Enabled = false
        --                     end
        --                 else
        --                     connection:Disconnect()
        --                     coroutine.yield()
        --                 end
        --             else
        --                 Highlight:Destroy()
        --                 connection:Disconnect()
        --                 coroutine.yield()
        --             end
        --         end)
        --     end
        --     coroutine.wrap(Updater)()
        -- end

        -- for _,v in game.workspace.Vehicles:GetChildren() do
        --     CreateVehicleChams(v)
        -- end

        -- Library.signals.VehicleEspNewVehicle = game.workspace.Vehicles.ChildAdded:Connect(function(v)
        --     wait(1)
        --     CreateVehicleChams(v)
        -- end)

        -- task.spawn(function()
        --     while Active do
        --         for _,v in Vehicle.Chams.Folder:GetChildren() do
        --             if v.Adornee == nil then v:Destroy() end
        --         end
        --         wait()
        --     end
        -- end)

-- Gui

    local function AddDivider(Path) Path:AddLabel({Name="--------------------"}) end

    local Window = Library:CreateWindow({Name="Attrition",Themeable={Info="Script by Kratato#9175"}})

    local Tab = Window:CreateTab({Name="General"})
    -- local GunMods = Window:CreateTab({Name="Gun Mods"})
    --// Will Be added later!

    local VisualSection = Tab:CreateSection({Name="Visual",Side="Left"})
    local AimbotSection = Tab:CreateSection({Name="Aimbot",Side="Right"})
    local MovementSection = Tab:CreateSection({Name="Movement",Side="Right"})
    local MiscSection = Tab:CreateSection({Name="Miscellaneous",Side="Left"})


    --Visual Section

        local PlayerEspToggle = VisualSection:AddToggle({
            Name = "Player ESP",
            Value = Player.Esp.Toggle,
            Callback = function(Value) Player.Esp.Toggle = Value end
        })

        local PlayerEspColor = VisualSection:AddColorPicker({
            Name = "Color",
            Value = Player.Esp.Color,
            Callback = function(Value) Player.Esp.Color = Value end
        })

        local PlayerEspFilled = VisualSection:AddToggle({
            Name = "Box Filled",
            Value = Player.Esp.Filled,
            Callback = function(Value) Player.Esp.Filled = Value end
        })

        AddDivider(VisualSection)

        local PlayerTracersToggle = VisualSection:AddToggle({
            Name = "Player Tracers",
            Value = Player.Tracers.Toggle,
            Callback = function(Value) Player.Tracers.Toggle = Value end
        })

        local PlayerTracersColor = VisualSection:AddColorPicker({
            Name = "Color",
            Value = Player.Tracers.Color,
            Callback = function(Value) Player.Tracers.Color = Value end
        })

        local PlayerTracersThickness = VisualSection:AddSlider({
            Name = "Thickness",
            Value = Player.Tracers.Thickness,
            Min = 0.01,
            Max = 2.5,
            InputBox = true,
            Decimals = 2,
            Callback = function(Value) Player.Tracers.Thickness = Value end
        })

        AddDivider(VisualSection)

        local PlayerChamsToggle = VisualSection:AddToggle({
            Name = "Player Chams",
            Value = Player.Chams.Toggle,
            Callback = function(Value) Player.Chams.Toggle = Value end
        })

        local PlayerChamsColor = VisualSection:AddColorPicker({
            Name = "Color",
            Value = Player.Chams.Color,
            Callback = function(Value) Player.Chams.Color = Value end
        })

        local PlayerChamsTransparency = VisualSection:AddSlider({
            Name = "Transparency",
            Value = Player.Chams.Transparency,
            Min = 0,
            Max = 1,
            InputBox = true,
            Decimals = 2,
            Format = function(Value)
                if Value == 0 then
                    return "Transparency: Filled"
                elseif Value == 1 then
                    return "Transparency: Invisible"
                else
                    return "Transparency: "..tostring(Value)
                end
            end,
            Callback = function(Value) Player.Chams.Transparency = Value end
        })

        local PlayerChamsAlwaysOnTop = VisualSection:AddToggle({
            Name = "AlwaysOnTop",
            Value = Player.Chams.AlwaysOnTop,
            Callback = function(Value) Player.Chams.AlwaysOnTop = Value end
        })


        --// Vehicle Chams not possible with Highlight Object due to weird behavior of vehicles on death


        -- AddDivider(VisualSection)

        -- local VehicleChamsToggle = VisualSection:AddToggle({
        --     Name = "Vehicle Chams",
        --     Value = Vehicle.Chams.Toggle,
        --     Callback = function(Value) Vehicle.Chams.Toggle = Value end
        -- })

        -- local VehicleChamsFriendlyColor = VisualSection:AddColorPicker({
        --     Name = "Friendly Color",
        --     Value = Vehicle.Chams.FriendlyColor,
        --     Callback = function(Value) Vehicle.Chams.FriendlyColor = Value end
        -- })

        -- local VehicleChamsEnemyColor = VisualSection:AddColorPicker({
        --     Name = "Enemy Color",
        --     Value = Vehicle.Chams.EnemyColor,
        --     Callback = function(Value) Vehicle.Chams.EnemyColor = Value end
        -- })

        -- local VehicleChamsAlwaysOnTop = VisualSection:AddToggle({
        --     Name = "AlwaysOnTop",
        --     Value = Vehicle.Chams.AlwaysOnTop,
        --     Callback = function(Value) Vehicle.Chams.AlwaysOnTop = Value end
        -- })

        -- local VehicleChamsTransparency = VisualSection:AddSlider({
        --     Name = "Transparency",
        --     Value = Vehicle.Chams.Transparency,
        --     Min = 0,
        --     Max = 1,
        --     InputBox = true,
        --     Decimals = 2,
        --     Format = function(Value)
        --         if Value == 0 then
        --             return "Transparency: Filled"
        --         elseif Value == 1 then
        --             return "Transparency: Invisible"
        --         else
        --             return "Transparency: "..tostring(Value)
        --         end
        --     end,
        --     Callback = function(Value) Vehicle.Chams.Transparency = Value end
        -- })

        -- local VehicleChamsOutline = VisualSection:AddToggle({
        --     Name = "Outline Vehicles",
        --     Value = Vehicle.Chams.Outline,
        --     Callback = function(Value) Vehicle.Chams.Outline = Value end
        -- })

        -- local VehicleChamsOutlineColor = VisualSection:AddColorPicker({
        --     Name = "Outline Color",
        --     Value = Vehicle.Chams.OutlineColor,
        --     Callback = function(Value) Vehicle.Chams.OutlineColor = Value end
        -- })

    -- Aimbot Section

        local AimbotToggle = AimbotSection:AddToggle({
            Name = "Aimbot",
            Value = Player.Aimbot.Toggle,
            Keybind = {Mode = "Toggle"},
            Callback = function(Value) Player.Aimbot.Toggle = Value end
        })

        local AimbotColor = AimbotSection:AddColorPicker({
            Name = "Color",
            Value = Player.Aimbot.Color
        })

        local AimbotVisibilityCheck = AimbotSection:AddToggle({
            Name = "Visibility Check",
            Value = Player.Aimbot.VisibilityCheck,
            Callback = function(Value) Player.Aimbot.VisibilityCheck = Value end
        })

        local AimbotAimPart = AimbotSection:AddDropDown({
            Name = "Aim At:",
            Value = Player.Aimbot.AimPart,
            List = Player.Aimbot.AimPartList,
            Callback = function(Value) Player.Aimbot.AimPart = Value end
        })

        local AimbotRadius = AimbotSection:AddSlider({
            Name = "Circle Radius",
            Value = Player.Aimbot.Radius,
            Min = 50,
            Max = 1000,
            InputBox = true,
            Callback = function(Value) Player.Aimbot.Radius = Value end
        })

    -- Movement Section

        local PlayerFlyToggle = MovementSection:AddToggle({
            Name = "Player Fly",
            Value = Player.Fly.Toggle,
            Keybind = {Mode = "Toggle"},
            Callback = function(Value) Player.Fly.Toggle = Value end
        })

        local PlayerFlySpeed = MovementSection:AddSlider({
            Name = "Speed",
            Value = Player.Fly.Speed,
            Min = 1,
            Max = 500,
            InputBox = true,
            Callback = function(Value) Player.Fly.Speed = Value end
        })

        AddDivider(MovementSection)

        local VehicleFlyToggle = MovementSection:AddToggle({
            Name = "Vehicle Fly",
            Value = Vehicle.Fly.Toggle,
            Keybind = {Mode = "Toggle"},
            Callback = function(Value) Vehicle.Fly.Toggle = Value end
        })

        local VehicleFlySpeed = MovementSection:AddSlider({
            Name = "Speed",
            Value = Vehicle.Fly.Speed,
            Min = 1,
            Max = 500,
            InputBox = true,
            Callback = function(Value) Vehicle.Fly.Speed = Value end
        })

    --Misc Section

        local TpScrap = MiscSection:AddButton({
            Name = "Teleport All Scrap",
            Callback = function() end
        })

    --

--
