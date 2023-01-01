camera = game.workspace.Camera.CFrame.Position

for i,v in pairs(game.workspace.ScrapNodes:GetDescendants()) do 
    if v.Name == 'Hull' and v.ClassName == 'MeshPart' then 
        v.Position = camera
        v.CanCollide = false
        scrapsfound = true
    end
end
if scrapsfound == true then
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "",
    Text = "Scraps Found!",
    })
else 
    game:GetService("StarterGui"):SetCore("SendNotification",{
    Title = "",
    Text = "No Scrap Found :(",
    })
end