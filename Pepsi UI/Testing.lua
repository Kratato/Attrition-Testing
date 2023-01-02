local Library = loadstring(game:GetObjects("rbxassetid://7657867786")[1].Source)()

local function AddDivider(Path)
	local Divider = Path:AddLabel({Name="------------------------------"})
end



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
local MovementSection = Tab:CreateSection({Name="Movement",Side="Right"})
local MiscSection = Tab:CreateSection({Name="Miscellaneous",Side="Right"})

local PlayerEspToggle = VisualSection:AddToggle({
    Name = "PlayerEsp",
    Flag = "PlayerEspToggle"
})
AddDivider(VisualSection)




local MovementButton = MovementSection:AddButton({
    Name = "Balls",
    Callback = function() end
})

local MiscButton = MiscSection:AddButton({
    Name = "Balls",
    Callback = function() end
})