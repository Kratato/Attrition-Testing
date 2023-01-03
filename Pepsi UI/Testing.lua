local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()

local function AddDivider(Path)
	local Divider = Path:AddLabel({Name="--------------------"})
end

local Player = {
    Esp = {
        Toggle = false,
        Color = Color3.fromRGB(255,255,255),
        Transparency = 0,
        Filled = false
    },
    Tracers = {
        Toggle = false,
        Color = Color3.fromRGB(255,255,255),
        Thickness = 1,
        Transparency = 0
    },
    Chams = {
        Toggle = false,
        Color = Color3.fromRGB(255,0,0),
        Transparency = 0,
        AlwaysOnTop = false
    },
    Fly = {
        Toggle = false,
        Speed = 50,
        NoClip = false
    },
    Aimbot = {
        Toggle = false,
        Color = Color3.fromRGB(255,255,255),
        AimPartList = {"Head","UpperTorso","LowerTorso"},
        AimPart = "UpperTorso",
        Radius = 240
    }
}

local Vehicle = {
    Chams = {
        Toggle = false,
        Color = Color3.fromRGB(255,0,0),
        Transparency = 0.75,
        OutlineColor = Color3.fromRGB(255,255,255),
        OutlineTransparency = 0
    },
    Fly = {
        Toggle = false,
        Speed = 50,
        NoClip = false
    }
}

-- Gui

    local Window = Library:CreateWindow({
        Name = "Attrition",
        Themeable = {
            Info = "Script by Kratato#9175"
        }
    })

    local Tab = Window:CreateTab({
        Name = "General"
    })

    local VisualSection = Tab:CreateSection({Name="Visual",Side="Left"})
    local AimbotSection = Tab:CreateSection({Name="Aimbot",Side="Right"})
    local MovementSection = Tab:CreateSection({Name="Movement",Side="Right"})
    local MiscSection = Tab:CreateSection({Name="Miscellaneous",Side="Right"})


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

        local PlayerEspTransparency = VisualSection:AddSlider({
            Name = "Transparency",
            Value = Player.Esp.Transparency,
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
            Callback = function(Value) Player.Esp.Transparency = Value end
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

        local PlayerTracersTransparency = VisualSection:AddSlider({
            Name = "Transparency",
            Value = Player.Tracers.Transparency,
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
            Callback = function(Value) Player.Tracers.Transparency = Value end
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

        AddDivider(VisualSection)

        local VehicleChamsToggle = VisualSection:AddToggle({
            Name = "Vehicle Chams",
            Value = Vehicle.Chams.Toggle,
            Callback = function(Value) Vehicle.Chams.Toggle = Value end
        })

        local VehicleChamsColor = VisualSection:AddColorPicker({
            Name = "Color",
            Value = Vehicle.Chams.Color,
            Callback = function(Value) Vehicle.Chams.Color = Value end
        })

        local VehicleChamsTransparency = VisualSection:AddSlider({
            Name = "Transparency",
            Value = Vehicle.Chams.Transparency,
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
            Callback = function(Value) Vehicle.Chams.Transparency = Value end
        })

        local VehicleChamsOutlineColor = VisualSection:AddColorPicker({
            Name = "Outline Color",
            Value = Vehicle.Chams.OutlineColor,
            Callback = function(Value) Vehicle.Chams.OutlineColor = Value end
        })

        local VehicleChamsOutlineTransparency = VisualSection:AddSlider({
            Name = "Outline Transparency",
            Value = Vehicle.Chams.OutlineTransparency,
            Min = 0,
            Max = 1,
            InputBox = true,
            Decimals = 2,
            Format = function(Value)
                if Value == 0 then
                    return "Outline Transparency: Filled"
                elseif Value == 1 then
                    return "Outline Transparency: Invisible"
                else
                    return "Outline Transparency: "..tostring(Value)
                end
            end,
            Callback = function(Value) Vehicle.Chams.OutlineTransparency = Value end
        })

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

        local PlayerFlyNoClip = MovementSection:AddToggle({
            Name = "NoClip",
            Value = "Player.Fly.NoClip",
            Callback = function(Value) Player.Fly.NoClip = Value end
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

        local VehicleFlyNoClip = MovementSection:AddToggle({
            Name = "NoClip",
            Value = Vehicle.Fly.NoClip,
            Callback = function(Value) Vehicle.Fly.NoClip = Value end
        })

    --Misc Section

        local TpScrap = MiscSection:AddButton({
            Name = "Teleport All Scrap",
            Callback = function() end
        })

    --

--