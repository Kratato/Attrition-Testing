list = {}
for i,v in pairs(game.workspace.Vehicles.Attack_Jet:GetDescendants()) do table.insert(list,v.Name) end
table.sort(list)
for i,v in pairs(list) do print(v) end
print('----------------------')