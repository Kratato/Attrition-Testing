local list = {'PorportionsNormal','AvatarPartScaleType'}
local ValueBanned = false
for i,v in pairs(game.workspace:GetDescendants()) do 
    if v:IsA('StringValue') == true then 
        for _,banned in pairs(list) do 
            if v.Name == banned then ValueBanned = true end 
        end
    if ValueBanned == false then print(i,v,'=',v.Parent,v.Parent.Parent,v.Parent.Parent.Parent) end
    ValueBanned = false
    end
end
print('=============')