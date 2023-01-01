--Linoria Library https://github.com/violin-suzutsuki/LinoriaLib
local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

--Variable Dump

    -- Services / General Variables

        local RS = game:GetService("RunService")
        local UIS = game:GetService("UserInputService")
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local camera = workspace.CurrentCamera

    -- Team

        local Red = {LegColor = BrickColor.new("Bright red"), Vehicle1 = BrickColor.new("Tawny"), Vehicle2 = BrickColor.new("Terra Cotta")}
        local Blue = {LegColor = BrickColor.new("Bright blue"), Vehicle1 = BrickColor.new("Steel blue"), Vehicle2 = BrickColor.new("Bright blueish violet")}
        local White = {LegColor = BrickColor.new("White"), Vehicle1 = BrickColor.new("White"), Vehicle2 = BrickColor.new("White")}
        local Team = LocalPlayer.Team
        local TeamColor

        if Team == game:GetService("Teams")["United Bloxxers"] then
            TeamColor = Blue            
        elseif Team == game:GetService("Teams")["League of 1x1x1x1"] then
            TeamColor = Red
        else
            TeamColor = White
        end

    -- ESP Variables

        local PlayerChams = {
            Toggle = true,
            Color = Color3.fromRGB(255,0,0),
            Transparency = 0,
            AlwaysOnTop = false,    
        }

        local PlayerBoxEsp = {
            Toggle = false,
            Min = 0.1,
            Max = 6,
            Color = Color3.fromRGB(255,255,255),
        }

        local PlayerTracers = {
            Toggle = false,
            Size = 0.5,
            Color = Color3.fromRGB(255,255,255)
        }

    -- Aimbot Variables

    -- Etc...
    
--

--Functions / Modules

    --Player Chams
        --Create Function
        function CreatePlayerChams(c)
            if c.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor.LegColor then
                for _,BodyPart in pairs(c.BodyParts:GetChildren()) do
                    if BodyPart.ClassName == "MeshPart" then
                        if BodyPart:FindFirstChildOfClass("BoxHandleAdornment") == nil then
                            local BHA = Instance.new("BoxHandleAdornment",BodyPart)
                            BHA.Color3 = PlayerChams.Color
                            BHA.Size = BodyPart.Size
                            BHA.AlwaysOnTop = PlayerChams.AlwaysOnTop
                            BHA.Adornee = BodyPart
                            BHA.ZIndex = 0
                            BHA.Transparency = PlayerChams.Transparency
                            BHA.Name = "PlayerEsp"
                            BHA.Visible = PlayerChams.Toggle
                        end
                    end
                end
            end
        end

        --Creates Initial Chams Parts
        for _,Character in pairs(game.workspace.Characters:GetChildren()) do
            if Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
                CreatePlayerChams(Character)
            end
        end

        local PlayerChamsPlayerAdded = game.workspace.Characters.ChildAdded:Connect(function(Character)
            wait(1)
            CreatePlayerChams(Character)
        end)

        --Checks for dead players and removes any Chams Parts
        local PlayerChamsLookForDead = RS.Stepped:Connect(function()
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

        --Updates Chams
        function UpdatePlayerChams()
            for _,Character in pairs(game.workspace.Characters:GetChildren()) do
                if Character.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
                    for _,Part in pairs(Character.BodyParts:GetDescendants()) do
                        if Part.ClassName == "BoxHandleAdornment" then
                            Part.Color3 = PlayerChams.Color
                            Part.AlwaysOnTop = PlayerChams.AlwaysOnTop
                            Part.Transparency = PlayerChams.Transparency
                            Part.Visible = PlayerChams.Toggle
                        end
                    end
                end
            end
        end
    --

    --Player BoxEsp & Tracers
    for _,Char in pairs(game.workspace.Characters:GetChildren()) do
        if Char.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor.LegColor then
            local Part = Char.PrimaryPart
            
            local PlayerBox = Drawing.new("Quad")
            PlayerBox.Visible = false
            PlayerBox.Color = PlayerBoxEsp.Color
    
            local Tracer = Drawing.new("Line")
            Tracer.Visible = false
            Tracer.Color = PlayerTracers.Color
            Tracer.Thickness = PlayerTracers.Thickness

            local function ESP()
                local connection
                connection = RS.RenderStepped:Connect(function()
                    --Check if body still exists or has died
                    if Char == nil or Char:FindFirstChild("BodyParts") == nil then
                        PlayerBox:Destroy()
                        Tracer:Destroy()
                        connection:Disconnect()
                        return
                    end
                    if Char.BodyParts:FindFirstChildOfClass("BallSocketConstraint") ~= nil then
                        PlayerBox:Destroy()
                        Tracer:Destroy()
                        connection:Disconnect()
                        return
                    end
                    --Updates BoxEsp
                    if PlayerBoxEsp.Toggle then
                        local pos, visible = camera:WorldToViewportPoint(Char.PrimaryPart.Position)
                        if visible then
                            PlayerBox.Visible = true
                            PlayerBox.Color = PlayerBoxEsp.Color

                            PlayerBox.PointA = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, 3, 0)).p)
                            PlayerBox.PointB = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, 3, 0)).p)
                            PlayerBox.PointC = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, -3, 0)).p)
                            PlayerBox.PointD = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, -3, 0)).p)

                            local distance = (workspace.CurrentCamera.CFrame.Position - Part.Position).magnitude
                            local value = math.clamp(1/(workspace.CurrentCamera.CFrame.Position - Part.Position).magnitude*100, PlayerBoxEsp.Min, PlayerBoxEsp.Max)
                            PlayerBox.Thickness = value
                        else
                            PlayerBox.Visible = false
                        end
                    else
                        PlayerBox.Visible = false
                    end

                    --Updates Tracer
                    if PlayerTracers.Toggle then
                        local pos, visible = camera:WorldToViewportPoint((Part.CFrame.Position))
                        if visible then
                            Tracer.Visible = true
                            Tracer.Color = PlayerTracers.Color
                            Tracer.Thickness = PlayerTracers.Thickness
                            Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                            Tracer.To = Vector2.new(pos.X, pos.Y)
                        else
                            Tracer.Visible = false
                        end
                    else
                        Tracer.Visible = false
                    end
                end)
            end
            coroutine.wrap(ESP)()
        end
    end
    
    game.workspace.Characters.ChildAdded:Connect(function(Char)
        wait(1)
        if Char.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor.LegColor then
            local Part = Char.PrimaryPart
            
            --PlayerBox
            local PlayerBox = Drawing.new("Quad")
            PlayerBox.Visible = false
            PlayerBox.Color = PlayerBoxEsp.Color
    
            --Tracer
            local Tracer = Drawing.new("Line")
            Tracer.Visible = false
            Tracer.Color = PlayerTracers.Color
            Tracer.Thickness = PlayerTracers.Thickness
    
            --// Updates ESP (lines) in render loop
            local function ESP()
                local connection
                connection = RS.RenderStepped:Connect(function()
                    --Check if body still exists or has died
                    if Char == nil or Char:FindFirstChild("BodyParts") == nil then
                        PlayerBox:Destroy()
                        Tracer:Destroy()
                        connection:Disconnect()
                        return
                    end
                    if Char.BodyParts:FindFirstChildOfClass("BallSocketConstraint") ~= nil then
                        PlayerBox:Destroy()
                        Tracer:Destroy()
                        connection:Disconnect()
                        return
                    end
                    --Updates BoxEsp
                    if PlayerBoxEsp.Toggle then
                        local pos, visible = camera:WorldToViewportPoint(Char.PrimaryPart.Position)
                        if visible then
                            PlayerBox.Visible = true
                            PlayerBox.Color = PlayerBoxEsp.Color

                            PlayerBox.PointA = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, 3, 0)).p)
                            PlayerBox.PointB = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, 3, 0)).p)
                            PlayerBox.PointC = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, -3, 0)).p)
                            PlayerBox.PointD = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, -3, 0)).p)

                            local distance = (workspace.CurrentCamera.CFrame.Position - Part.Position).magnitude
                            local value = math.clamp(1/(workspace.CurrentCamera.CFrame.Position - Part.Position).magnitude*100, PlayerBoxEsp.Min, PlayerBoxEsp.Max)
                            PlayerBox.Thickness = value
                        else
                            PlayerBox.Visible = false
                        end
                    else
                        PlayerBox.Visible = false
                    end

                    --Updates Tracer
                    if PlayerTracers.Toggle then
                        local pos, visible = camera:WorldToViewportPoint((Part.CFrame.Position))
                        if visible then
                            Tracer.Visible = true
                            Tracer.Color = PlayerTracers.Color
                            Tracer.Thickness = PlayerTracers.Thickness
                            Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
                            Tracer.To = Vector2.new(pos.X, pos.Y)
                        else
                            Tracer.Visible = false
                        end
                    else
                        Tracer.Visible = false
                    end
                end)
            end
            coroutine.wrap(ESP)()
        end
    end)

    --

--

--GUI
    --Main
        -- Window
            local Window = Library:CreateWindow({
                Title = 'Attrition GUI',
                Center = true,
                AutoShow = true,
                Size = UDim2.new(0,550,0,779)
            })

        -- Tabs
            local Tabs = {
                MainTab = Window:AddTab('Main'),
                VisualModsTab = Window:AddTab('Visual Mods'),
                ['UI Settings'] = Window:AddTab('UI Settings'),
            }

        -- GroupBoxes & TabBoxes
            local AimbotGroupBox = Tabs.MainTab:AddLeftGroupbox('Aimbot')
            local MovementGroupBox = Tabs.MainTab:AddLeftGroupbox('Movement')
            local VisualGroupBox = Tabs.MainTab:AddLeftGroupbox('Visual')
            local MiscGroupBox = Tabs.MainTab:AddLeftGroupbox('Misc')
            local EspTabBox = Tabs.MainTab:AddRightTabbox()
            local PlayerEsp = EspTabBox:AddTab('Player ESP')
            local VehicleEsp = EspTabBox:AddTab('Vehicle ESP')
            local SkyboxGroupBox = Tabs.VisualModsTab:AddLeftGroupbox('SkyBox')
            local AtmosphereGroupBox = Tabs.VisualModsTab:AddRightGroupbox('Atmosphere')
            local BloomGroupBox = Tabs.VisualModsTab:AddRightGroupbox('Bloom')
            local DepthOfFieldGroupBox = Tabs.VisualModsTab:AddRightGroupbox('DepthOfField')
            local SunRaysGroupBox = Tabs.VisualModsTab:AddRightGroupbox('SunRays')

    --

    -- Aimbot
        AimbotGroupBox:AddToggle('Aimbot', {
            Text = 'Aimbot Toggle',
            Default = false,
            Tooltip = 'Activates / Deactivates Aimbot' 
        }):AddKeyPicker('AimbotKeybind', {
            Default = '',
            SyncToggleState = true, 
            Mode = 'Toggle',
            Text = 'Aimbot',
            NoUI = false,
        })

        AimbotGroupBox:AddDropdown('AimbotAimAtDropDown',{
            Values = {'Head','Torso','left middle toe'},
            Default = 1,
            Multi = false,
            Text = 'Aim At:',
            Tooltip = 'Specify Which Part To aim At\n----------------------------\nHead or Torso is Reccomended'
        })

        AimbotGroupBox:AddSlider('AimbotMaxRange',{
            Text = 'Max Range (Studs)',
            Default = 100,
            Min = 0,
            Max = 1000,
            Rounding = 0,
            Compact = false,
        })

        AimbotGroupBox:AddSlider('AimbotSize',{
            Text = 'Aimbot Circle Size',
            Default = 80,
            Min = 0,
            Max = 400,
            Rounding = 0,
            Compact = false,
        })

        AimbotGroupBox:AddLabel('Aimbot Color'):AddColorPicker('AimbotCircleColor', {
            Default = Color3.new(1,1,1),
            Title = 'Aimbot Circle Color Picker',
        })

        AimbotGroupBox:AddButton('Update Aimbot'):AddTooltip('Updates the Aimbot Settings')
    --

    -- PlayerESP
        --Chams
            PlayerEsp:AddToggle('Chams', {
                Text = 'Chams',
                Default = false,
                Tooltip = 'Activates / Deactivates Chams' 
            }):AddKeyPicker('ChamsKeybind', {
                Default = '',
                SyncToggleState = true, 
                Mode = 'Toggle',
                Text = 'Chams',
                NoUI = false,
            })

            PlayerEsp:AddSlider('ChamsTransparency',{
                Text = 'Transparency',
                Default = 0,
                Min = 0,
                Max = 1,
                Rounding = 1,
                Compact = false,
            })

            PlayerEsp:AddToggle('ChamAlwaysOnTop', {
                Text = 'AlwaysOnTop',
                Default = false,
                Tooltip = 'Toggles between AlwaysOnTop and Occluded' 
            })

            PlayerEsp:AddLabel('Color'):AddColorPicker('ChamsColor', {
                Default = Color3.new(0,1,0),
                Title = 'Color Picker',
            })


        --BoxEsp
            PlayerEsp:AddDivider()
            PlayerEsp:AddToggle('BoxEsp', {
                Text = 'Box ESP',
                Default = false,
                Tooltip = 'Activates / Deactivates BoxEsp',
            }):AddKeyPicker('BoxEspKeybind', {
                Default = '',
                SyncToggleState = true,
                Mode = 'Toggle',
                Text = 'BoxEsp',
                NoUI = false,
            })

            PlayerEsp:AddSlider('BoxEspMinSize',{
                Text = 'Minimum Size',
                Default = 0.1,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Compact = false,
            })

            PlayerEsp:AddSlider('BoxEspMaxSize',{
                Text = 'Maximum Size',
                Default = 6,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Compact = false,
            })

            PlayerEsp:AddLabel('Color'):AddColorPicker('BoxEspColor', {
                Default = Color3.new(1,1,1),
                Title = 'Color Picker',
            })


        --Tracers
            PlayerEsp:AddDivider()
            PlayerEsp:AddToggle('Tracers', {
                Text = 'Tracers',
                Default = false,
                Tooltip = 'Activates / Deactivates Tracers',
            }):AddKeyPicker('TracersKeybind', {
                Default = '',
                SyncToggleState = true,
                Mode = 'Toggle',
                Text = 'Tracers',
                NoUI = false,
            })

            PlayerEsp:AddSlider('TracerSize',{
                Text = 'Size',
                Default = 0.5,
                Min = 0,
                Max = 5,
                Rounding = 1,
                Compact = false,
            })

            PlayerEsp:AddLabel('Color'):AddColorPicker('TracersColor',{
                Default = Color3.new(1,1,1),
                Title = 'Color Picker',
            })

    --

    -- VehicleESP
        --VehicleChams
            VehicleEsp:AddToggle('VehicleChams', {
                Text = 'Chams',
                Default = false,
                Tooltip = 'Activates / Deactivates Chams' 
            }):AddKeyPicker('VehicleChamsKeybind', {
                Default = '',
                SyncToggleState = true, 
                Mode = 'Toggle',
                Text = 'Vehicle Chams',
                NoUI = false,
            })

            VehicleEsp:AddSlider('VehicleChamsTransparency',{
                Text = 'Transparency',
                Default = 0,
                Min = 0,
                Max = 1,
                Rounding = 1,
                Compact = false,
            })

            VehicleEsp:AddToggle('ChamsAlwaysOnTop', {
                Text = 'AlwaysOnTop',
                Default = false,
                Tooltip = 'Determines if Chams is always visible, or\noccluded (only visible if you see the player)' 
            })

            VehicleEsp:AddLabel('Color'):AddColorPicker('VehicleChamsColor', {
                Default = Color3.new(0.5,0,1),
                Title = 'Color Picker',
            })

        --VehicleBoxEsp
            VehicleEsp:AddDivider()
            VehicleEsp:AddToggle('VehicleBoxEsp', {
                Text = 'Box ESP',
                Default = false,
                Tooltip = 'Activates / Deactivates BoxEsp',
            }):AddKeyPicker('VehicleBoxEspKeybind', {
                Default = '',
                SyncToggleState = true,
                Mode = 'Toggle',
                Text = 'Vehicle BoxEsp',
                NoUI = false,
            })

            VehicleEsp:AddSlider('VehicleBoxEspMinSize',{
                Text = 'Minimum Size',
                Default = 0.1,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Compact = false,
            })

            VehicleEsp:AddSlider('VehicleBoxEspMaxSize',{
                Text = 'Maximum Size',
                Default = 6,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Compact = false,
            })

            VehicleEsp:AddLabel('Color'):AddColorPicker('VehicleBoxEspColorPicker', {
                Default = Color3.new(1,1,1),
                Title = 'Color Picker',
            })

        --VehicleTracers
            VehicleEsp:AddDivider()
            VehicleEsp:AddToggle('VehicleTracers', {
                Text = 'Tracers',
                Default = false,
                Tooltip = 'Activates / Deactivates Tracers',
            }):AddKeyPicker('VehicleTracersKeybind', {
                Default = '',
                SyncToggleState = true,
                Mode = 'Toggle',
                Text = 'Vehicle Tracers',
                NoUI = false,
            })

            VehicleEsp:AddSlider('VehicleTracerSize',{
                Text = 'Size',
                Default = 0.5,
                Min = 0,
                Max = 5,
                Rounding = 1,
                Compact = false,
            })

            VehicleEsp:AddLabel('Color'):AddColorPicker('VehicleTracersColor',{
                Default = Color3.new(0.5,0,1),
                Title = 'Color Picker',
            })

    --

    -- Movement
        --Character & Vehicle Fly
            MovementGroupBox:AddToggle('CharacterFly', {
                Text = 'CharacterFly',
                Default = false,
                Tooltip = 'Activates / Deactivates CharacterFly\n----------\nNOTICE: Activating this while in a\nVehicles Passengers seat WILL break this!' 
            }):AddKeyPicker('CharacterFlyKeybind', {
                Default = '',
                SyncToggleState = true, 
                Mode = 'Toggle',
                Text = 'CharacterFly',
                NoUI = false,
            })

            MovementGroupBox:AddToggle('VehicleFly', {
                Text = 'VehicleFly',
                Default = false,
                Tooltip = 'Activates / Deactivates VehicleFly' 
            }):AddKeyPicker('VehicleFlyKeybind', {
                Default = '',
                SyncToggleState = true, 
                Mode = 'Toggle',
                Text = 'VehicleFly',
                NoUI = false,
            })

            MovementGroupBox:AddSlider('FlySpeed', {
                Text = 'Fly Speed',
                Default = 100,
                Min = 0,
                Max = 1000,
                Rounding = 0,
                Compact = false,
            })

        --Teleports
            MovementGroupBox:AddDivider()
            MovementGroupBox:AddDropdown('TeleportDropdown', {
                Values = {'Loading...'},
                Default = 1,
                Multi = false,
                Text = 'Teleport To:',
                Tooltip = 'Select a flag to teleport to and click the button below',
            })

            MovementGroupBox:AddButton('Teleport'):AddTooltip('Teleports you to whichever flag is selected')

    --

    -- Visual
        --FreeCam
            VisualGroupBox:AddToggle('FreeCam', {
                Text = 'FreeCam',
                Default = false,
                Tooltip = 'Activates/Deactivates FreeCam\n----------\nWorks Best while in the menu,\nas when you\'re spawned in you\nstill move while in FreeCam' 
            }):AddKeyPicker('FreeCamKeybind', {
                Default = '',
                SyncToggleState = true, 
                Mode = 'Toggle',
                Text = 'FreeCam',
                NoUI = false,
            })

            VisualGroupBox:AddSlider('FreeCamSpeed', {
                Text = 'FreeCam Speed',
                Default = 100,
                Min = 0,
                Max = 1000,
                Rounding = 0,
                Compact = false,
            })

        --Zoom
            VisualGroupBox:AddToggle('Zoom', {
                Text = 'Zoom',
                Default = false,
                Tooltip = 'Activates/Deactivates Zoom\n----------\nWorks best in air vehicles\nand while in FreeCam' 
            }):AddKeyPicker('AimbotKeybind', {
                Default = '',
                SyncToggleState = true, 
                Mode = 'Toggle',
                Text = 'Zoom',
                NoUI = false,
            })

            VisualGroupBox:AddSlider('ZoomMultiplier', {
                Text = 'Zoom Multiplier',
                Default = 5,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Compact = false,
            })

    --

    -- Misc
        --Panic
            MiscGroupBox:AddToggle('Panic', {
                Text = 'PANIC',
                Default = false,
                Tooltip = 'Toggling this ON allows for PANIC to be activated\n----------\nPANIC allows you to deactivate all modules\ninstantly if you are at risk of getting caught' 
            }):AddKeyPicker('PanicKeybind', {
                Default = '',
                SyncToggleState = false, 
                Mode = 'Toggle',
                Text = 'PANIC',
                NoUI = false,
            })

        --Tp all scrap
            MiscGroupBox:AddDivider()
            MiscGroupBox:AddButton('Tp All Scrap'):AddTooltip('Teleports all scrap to you')

    --

    --GUI Visual Mods
        -- Skybox --
            SkyboxGroupBox:AddLabel('Add your own Skybox\n(ASSET ID ONLY)',true)
            SkyboxGroupBox:AddDivider()

            SkyboxGroupBox:AddInput('Skybox_bk', {
                Default = '',
                Numeric = true,
                Finished = true,
                Text = 'Skybox_bk',
                Tooltip = 'The Skybox_bk part of the Skybox',
                Placeholder = 'Asset ID here...',
            })

            SkyboxGroupBox:AddInput('Skybox_dn', {
                Default = '',
                Numeric = true,
                Finished = true,
                Text = 'Skybox_dn',
                Tooltip = 'The Skybox_dn part of the Skybox',
                Placeholder = 'Asset ID here...',
            })

            SkyboxGroupBox:AddInput('Skybox_ft', {
                Default = '',
                Numeric = true,
                Finished = true,
                Text = 'Skybox_ft',
                Tooltip = 'The Skybox_ft part of the Skybox',
                Placeholder = 'Asset ID here...',
            })

            SkyboxGroupBox:AddInput('Skybox_lf', {
                Default = '',
                Numeric = true,
                Finished = true,
                Text = 'Skybox_lf',
                Tooltip = 'The Skybox_lf part of the Skybox',
                Placeholder = 'Asset ID here...',
            })

            SkyboxGroupBox:AddInput('Skybox_rt', {
                Default = '',
                Numeric = true,
                Finished = true,
                Text = 'Skybox_rt',
                Tooltip = 'The Skybox_rt part of the Skybox',
                Placeholder = 'Asset ID here...',
            })

            SkyboxGroupBox:AddInput('Skybox_up', {
                Default = '',
                Numeric = true,
                Finished = true,
                Text = 'Skybox_up',
                Tooltip = 'The Skybox_up part of the Skybox',
                Placeholder = 'Asset ID here...',
            })

            SkyboxGroupBox:AddDivider()
            SkyboxGroupBox:AddLabel('Skyboxes should save with config\nfiles!',true)

            SkyboxGroupBox:AddDivider()
            SkyboxGroupBox:AddDropdown('PresetSkyboxes', {
                Values = { 'Day Time', 'Night Time', 'Starry Sky', 'amongst us' },
                Default = 0,
                Multi = false,
                Text = 'Skybox List',
                Tooltip = 'Some of my skyboxes :)',
            })



        -- Atmosphere --
            AtmosphereGroupBox:AddSlider('AtmosphereDensity',{
                Text = 'Density',
                Default = 0.3,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

            AtmosphereGroupBox:AddSlider('AtmosphereOffset',{
                Text = 'Offset',
                Default = 0.25,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

            AtmosphereGroupBox:AddLabel('Color'):AddColorPicker('AtmosphereColor',{
                Default = Color3.new(0.78,0.78,0.78),
                Title = 'Atmosphere Color Picker',
            })

            AtmosphereGroupBox:AddLabel('Decay'):AddColorPicker('AtmosphereDecay',{
                Default = Color3.new(0.41,0.43,0.49),
                Title = 'Atmosphere Decay Color Picker',
            })

            AtmosphereGroupBox:AddSlider('AtmosphereGlare',{
                Text = 'Glare',
                Default = 0,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

            AtmosphereGroupBox:AddSlider('AtmosphereHaze',{
                Text = 'Haze',
                Default = 0,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

        -- Bloom --
            BloomGroupBox:AddToggle('Bloom', {
                Text = 'Bloom',
                Default = false,
                Tooltip = 'Toggles Bloom' 
            })

            BloomGroupBox:AddSlider('BloomIntensity',{
                Text = 'Intensity',
                Default = 1,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

            BloomGroupBox:AddSlider('BloomSize',{
                Text = 'Size',
                Default = 24,
                Min = 0,
                Max = 100,
                Rounding = 0,
                Compact = false,
            })

            BloomGroupBox:AddSlider('BloomThreshold',{
                Text = 'Threshold',
                Default = 2,
                Min = 0,
                Max = 10,
                Rounding = 1,
                Compact = false,
            })

        -- DepthOfField --
            DepthOfFieldGroupBox:AddToggle('Dof', {
                Text = 'Depth of Field',
                Default = false,
                Tooltip = 'Toggles Depth of Field' 
            })

            DepthOfFieldGroupBox:AddSlider('DofFarIntensity',{
                Text = 'FarIntensity',
                Default = 0.1,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

            DepthOfFieldGroupBox:AddSlider('DofNearIntensity',{
                Text = 'NearIntensity',
                Default = 0.75,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

            DepthOfFieldGroupBox:AddSlider('DofFocusDistance',{
                Text = 'FocusDistance',
                Default = 0.05,
                Min = 0,
                Max = 200,
                Rounding = 2,
                Compact = false,
            })

            DepthOfFieldGroupBox:AddSlider('DofInFocusRadius',{
                Text = 'InFocusRadius',
                Default = 30,
                Min = 0,
                Max = 100,
                Rounding = 0,
                Compact = false,
            })

        -- SunRays --
            SunRaysGroupBox:AddToggle('SunRays', {
                Text = 'Sunrays',
                Default = false,
                Tooltip = 'Toggles SunRays' 
            })

            SunRaysGroupBox:AddSlider('SunRaysIntensity',{
                Text = 'Intensity',
                Default = 0.01,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

            SunRaysGroupBox:AddSlider('SunRaysSpread',{
                Text = 'Spread',
                Default = 0.1,
                Min = 0,
                Max = 1,
                Rounding = 2,
                Compact = false,
            })

    --
--

--GUI & Module Communication
    
    --PlayerEsp
        
        --Chams
            Toggles.Chams:OnChanged(function()
                PlayerChams.Toggle = Toggles.Chams.Value
                UpdatePlayerChams()
            end)
            
            Options.ChamsTransparency:OnChanged(function()
                PlayerChams.Transparency = Options.ChamsTransparency.Value
                UpdatePlayerChams()
            end)

            Toggles.ChamAlwaysOnTop:OnChanged(function()
                PlayerChams.AlwaysOnTop = Toggles.ChamAlwaysOnTop.Value
                UpdatePlayerChams()
            end)

            Options.ChamsColor:OnChanged(function()
                PlayerChams.Color = Options.ChamsColor.Value
                UpdatePlayerChams()
            end)

        --BoxEsp

            Toggles.BoxEsp:OnChanged(function()
                PlayerBoxEsp.Toggle = Toggles.BoxEsp.Value
            end)

            Options.BoxEspMinSize:OnChanged(function()
                PlayerBoxEsp.Min = Options.BoxEspMinSize.Value
            end)

            Options.BoxEspMaxSize:OnChanged(function()
                PlayerBoxEsp.Max = Options.BoxEspMaxSize.Value
            end)

            Options.BoxEspColor:OnChanged(function()
                PlayerBoxEsp.Color = Options.BoxEspColor.Value
            end)

        --Tracers

            Toggles.Tracers:OnChanged(function()
                PlayerTracers.Toggle = Toggles.Tracers.Value
            end)

            Options.TracerSize:OnChanged(function()
                PlayerTracers.Size = Options.TracerSize.Value
            end)

            Options.TracersColor:OnChanged(function()
                PlayerTracers.Color = Options.TracersColor.Value
            end)


--

-- GUI UI Settings

    Library:SetWatermarkVisibility(true)
    Library:SetWatermark('Attrition GUI')

    Library.KeybindFrame.Visible = true;

    Library:OnUnload(function()
        print('Unloaded!')
        Library.Unloaded = true
    end)

    -- UI Settings
    local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')

    -- I set NoUI so it does not show up in the keybinds menu
    MenuGroup:AddButton('Unload', function() Library:Unload() end)
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' }) 

    Library.ToggleKeybind = Options.MenuKeybind -- Allows you to have a custom keybind for the menu

    -- Addons:
    -- SaveManager (Allows you to have a configuration system)
    -- ThemeManager (Allows you to have a menu theme system)

    -- Hand the library over to our managers
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)

    -- Ignore keys that are used by ThemeManager. 
    -- (we dont want configs to save themes, do we?)
    SaveManager:IgnoreThemeSettings() 

    -- Adds our MenuKeybind to the ignore list 
    -- (do you want each config to have a different menu key? probably not.)
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 

    -- use case for doing it this way: 
    -- a script hub could have themes in a global folder
    -- and game configs in a separate folder per game
    ThemeManager:SetFolder('MyScriptHub')
    SaveManager:SetFolder('MyScriptHub/Attrition')

    -- Builds our config menu on the right side of our tab
    SaveManager:BuildConfigSection(Tabs['UI Settings']) 

    -- Builds our theme menu (with plenty of built in themes) on the left side
    -- NOTE: you can also call ThemeManager:ApplyToGroupbox to add it to a specific groupbox
    ThemeManager:ApplyToTab(Tabs['UI Settings'])

    -- You can use the SaveManager:LoadAutoloadConfig() to load a config 
    -- which has been marked to be one that auto loads!
--