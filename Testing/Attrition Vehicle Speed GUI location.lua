for i,v in pairs(game.Players['0potato01'].PlayerGui.Standard.Speed:GetChildren()) do 
    if v:IsA('TextLabel') then print(i,v,'=',v.Text)
    else print(i,v,v.ClassName) end end
print('---')