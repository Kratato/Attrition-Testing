local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

repeat print("waiting for HUD...") wait(1) until LocalPlayer.PlayerGui.HudApp.MenuHud:FindFirstChild("Container") ~= nil
print("Found! Team is:",LocalPlayer.PlayerGui.HudApp.MenuHud.Container.Leaderboard.PlayerTeam.TeamBanner.TeamName.Text)