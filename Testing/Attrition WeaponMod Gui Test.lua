local repo = 'https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/'

local Library = loadstring(game:HttpGet(repo .. 'Library.lua'))()
local ThemeManager = loadstring(game:HttpGet(repo .. 'addons/ThemeManager.lua'))()
local SaveManager = loadstring(game:HttpGet(repo .. 'addons/SaveManager.lua'))()

local Window = Library:CreateWindow({
    Title = 'Attrition WeaponMod Test',
    Center = true, 
    AutoShow = true,
})

local Tabs = {
    WeaponModTab = Window:AddTab('WeaponMods'), 
    ['UI Settings'] = Window:AddTab('UI Settings'),
}

local PrimaryMods1 = Tabs.WeaponModTab:AddRightTabbox()
local PrimaryMods2 = Tabs.WeaponModTab:AddRightTabbox()

local AKR = PrimaryMods1:AddTab('AKR')
local RPK = PrimaryMods1:AddTab('RPK')
local SMG = PrimaryMods1:AddTab('SMG')
local AWM = PrimaryMods2:AddTab('AWM')
local SVD = PrimaryMods2:AddTab('SVD')
local AKAS = PrimaryMods2:AddTab('AK-AS')

local EquipmentMods1 = Tabs.WeaponModTab:AddLeftTabbox()
local EquipmentMods2 = Tabs.WeaponModTab:AddLeftTabbox()

local MG = EquipmentMods1:AddTab('MG-42')
local PTRS = EquipmentMods1:AddTab('PTRS-41')
local Pistol = EquipmentMods1:AddTab('Pistol')
local Mortar = EquipmentMods2:AddTab('Mortar')
local RPG = EquipmentMods2:AddTab('RPG-7')
local AKE = EquipmentMods2:AddTab('AK-Type-E')



--
    --WeaponSettings
    local WeaponSettings = game:GetService("ReplicatedStorage").GameShared.SharedAssets.Loadout.Tools.Settings.Tools
    local AKR_ = require(WeaponSettings.AKR)
    local RPK_ = require(WeaponSettings.RPK)
    local SMG_ = require(WeaponSettings.SMG)
    local AWM_ = require(WeaponSettings.AWM)
    local SVD_ = require(WeaponSettings.SVD)
    local AKAS_ = require(WeaponSettings["AK-AS"])
    local MG_ = require(WeaponSettings["MG-42"])
    local PTRS_ = require(WeaponSettings["PTRS-41"])
    local Mortar_ = require(WeaponSettings.Mortar)
    local Pistol_ = require(WeaponSettings.Pistol)
    local RPG_ = require(WeaponSettings["RPG-7"])
    local AKE_ = require(WeaponSettings.AK_Type_E)

    --DefaultSettings
    local AKR_Default = table.clone(AKR_)
    local RPK_Default = table.clone(RPK_)
    local SMG_Default = table.clone(SMG_)
    local AWM_Default = table.clone(AWM_)
    local SVD_Default = table.clone(SVD_)
    local AKAS_Default = table.clone(AKAS_)
    local MG_Default = table.clone(MG_)
    local PTRS_Default = table.clone(PTRS_)
    local Pistol_Default = table.clone(Pistol_)
    local Mortar_Default = table.clone(Mortar_)
    local RPG_Default = table.clone(RPG_)
    local AKE_Default = table.clone(AKE_)
--

function UpdateRecoilMod(Weapon, Default, Multi)
    Weapon.VerticalRecoil = Default.VerticalRecoil * Multi
    Weapon.RecoilLeft = Default.RecoilLeft * Multi
    Weapon.RecoilRight = Default.RecoilRight * Multi
end

function UpdateSpreadMod(Weapon, Default, Multi)
    Weapon.MovementAimPenaltyMult = Default.MovementAimPenaltyMult * Multi
    Weapon.MaxSpreadBloom = Default.MaxSpreadBloom * Multi
    Weapon.SpreadBloom = Default.SpreadBloom * Multi
    Weapon.BloomDecayRate = Default.BloomDecayRate * Multi
    Weapon.BulletSpread = Default.BulletSpread * Multi
    Weapon.AimBulletSpread = Default.AimBulletSpread * Multi
end

AKR:AddSlider("AKR_ROF",{
    Text = "Rate Of Fire",
    Default = AKR_.RateOfFire,
    Min = 0,
    Max = 200,
    Rounding = 0,
    Compact = false,
})

AKR:AddSlider("AKR_BV",{
    Text = "Bullet Velocity",
    Default = AKR_.BulletSpeed,
    Min = 0,
    Max = 100000,
    Rounding = 0,
    Compact = false,
})

AKR:AddSlider("AKR_ADS",{
    Text = "ADS Speed",
    Default = AKR_.AimTimeMult,
    Min = 0.1,
    Max = 1,
    Rounding = 2,
    Compact = false,
})

AKR:AddSlider("AKR_Recoil",{
    Text = "Recoil Multiplier %",
    Default = 1,
    Min = 0,
    Max = 1,
    Rounding = 2,
    Compact = false,
})

AKR:AddSlider("AKR_Spread",{
    Text = "Spread Multiplier %",
    Default = 1,
    Min = 0,
    Max = 1,
    Rounding = 1,
    Compact = false,
})

AKR:AddButton("Reset", function()
    Options.AKR_ROF:SetValue(AKR_Default.RateOfFire)
    Options.AKR_BV:SetValue(AKR_Default.BulletSpeed)
    Options.AKR_ADS:SetValue(AKR_Default.AimTimeMult)
    Options.AKR_Recoil:SetValue(1)
    Options.AKR_Spread:SetValue(1)
end)









Options.AKR_ROF:OnChanged(function() AKR_.RateOfFire = Options.AKR_ROF.Value end)
Options.AKR_BV:OnChanged(function() AKR_.BulletSpeed = Options.AKR_BV.Value end)
Options.AKR_ADS:OnChanged(function() AKR_.AimTimeMult = Options.AKR_ADS.Value end)
Options.AKR_Recoil:OnChanged(function() UpdateRecoilMod(AKR_, AKR_Default, Options.AKR_Recoil.Value) end)
Options.AKR_Spread:OnChanged(function() UpdateSpreadMod(AKR_, AKR_Default, Options.AKR_Spread.Value) end)


--
    Library:SetWatermarkVisibility(false)
    Library.KeybindFrame.Visible = false; -- todo: add a function for this
    Library:OnUnload(function() print('Unloaded!') Library.Unloaded = true end)
    local MenuGroup = Tabs['UI Settings']:AddLeftGroupbox('Menu')
    MenuGroup:AddButton('Unload', function() Library:Unload() end)
    MenuGroup:AddLabel('Menu bind'):AddKeyPicker('MenuKeybind', { Default = 'End', NoUI = true, Text = 'Menu keybind' })
    Library.ToggleKeybind = Options.MenuKeybind
    ThemeManager:SetLibrary(Library)
    SaveManager:SetLibrary(Library)
    SaveManager:IgnoreThemeSettings() 
    SaveManager:SetIgnoreIndexes({ 'MenuKeybind' }) 
    ThemeManager:SetFolder('MyScriptHub')
    SaveManager:SetFolder('MyScriptHub/specific-game')
    SaveManager:BuildConfigSection(Tabs['UI Settings']) 
    ThemeManager:ApplyToTab(Tabs['UI Settings'])
