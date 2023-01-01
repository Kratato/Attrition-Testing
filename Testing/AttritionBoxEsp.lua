local RS = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local on = true

local Red = BrickColor.new("Bright red")
local Blue = BrickColor.new("Bright blue")
local White = BrickColor.new("White")
local TeamColor


repeat print("waiting for HUD...") wait(1) until LocalPlayer.PlayerGui.HudApp.MenuHud:FindFirstChild("Container") ~= nil
local TeamName = LocalPlayer.PlayerGui.HudApp.MenuHud.Container.Leaderboard.PlayerTeam.TeamBanner.TeamName.Text
print("Found! Team is:",TeamName)

if TeamName == "United Bloxxers" then
	TeamColor = Blue
elseif TeamName == "League of 1x1x1x1" then
	TeamColor = Red
else
	TeamColor = White
end


--- Player Box

local BoxColor = Color3.fromRGB(255,0,255)
local BoxMinThick = 0.1
local BoxMaxThick = 6
local Autothickness = true

--- Tracer

local TracerToggle = true
local TracerColor = BoxColor
local TracerThickness = 1
local TracerTransparency = 1

---

for _,Char in pairs(game.workspace.Characters:GetChildren()) do
	if Char.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor then
		local Part = Char.PrimaryPart
		local TracerAimAt = {Part.CFrame.Position}
		
		--PlayerBox
		local PlayerBox = Drawing.new("Quad")
		PlayerBox.Visible = false
		PlayerBox.Color = BoxColor

		--Tracer
		local Tracer = Drawing.new("Line")
		Tracer.Visible = false
		Tracer.Color = TracerColor
		Tracer.Thickness = TracerThickness
		Tracer.Transparency = TracerTransparency

		--// Updates ESP (lines) in render loop
		local function ESP()
			local connection
			connection =  RS.RenderStepped:Connect(function()
				if Char ~= nil and Char:FindFirstChild("BodyParts") ~= nil then
					if on and Char.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
						local pos, visible = camera:WorldToViewportPoint(Char.PrimaryPart.Position)
						if visible then
							-- local size_X = Part.Size.X/2
							-- local size_Y = Part.Size.Y/2
							-- local size_Z = Part.Size.Z/2
				
							PlayerBox.Visible = true
					
							PlayerBox.PointA = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, 3, 0)).p)
							PlayerBox.PointB = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, 3, 0)).p)
							PlayerBox.PointC = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, -3, 0)).p)
							PlayerBox.PointD = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, -3, 0)).p)
						else
							PlayerBox.Visible = false
						end

						--// Tracer:
						if TracerToggle then
							local pos, visible = camera:WorldToViewportPoint((Part.CFrame.Position))
							if visible then
								Tracer.Visible = true
								Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
								Tracer.To = Vector2.new(pos.X, pos.Y)
							else
								Tracer.Visible = false
							end
						end

						--// Autothickness:
						if Autothickness then
							local distance = (workspace.CurrentCamera.CFrame.Position - Part.Position).magnitude
							local value = math.clamp(1/distance*100, BoxMinThick, BoxMaxThick)
							PlayerBox.Thickness = value 
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

game.workspace.Characters.ChildAdded:Connect(function(Char)
	wait(1)
	if Char.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor then
		local Part = Char.PrimaryPart
		local TracerAimAt = {Part.CFrame.Position}
		
		--PlayerBox
		local PlayerBox = Drawing.new("Quad")
		PlayerBox.Visible = false
		PlayerBox.Color = BoxColor

		--Tracer
		local Tracer = Drawing.new("Line")
		Tracer.Color = TracerColor
		Tracer.Thickness = TracerThickness
		Tracer.Transparency = TracerTransparency

		--// Updates ESP (lines) in render loop
		local function ESP()
			local connection
			connection =  RS.RenderStepped:Connect(function()
				if Char ~= nil and Char:FindFirstChild("BodyParts") ~= nil then
					if on and Char.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
						local pos, visible = camera:WorldToViewportPoint(Char.PrimaryPart.Position)
						if visible then
							-- local size_X = Part.Size.X/2
							-- local size_Y = Part.Size.Y/2
							-- local size_Z = Part.Size.Z/2
				
							PlayerBox.Visible = true
					
							PlayerBox.PointA = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, 3, 0)).p)
							PlayerBox.PointB = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, 3, 0)).p)
							PlayerBox.PointC = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, -3, 0)).p)
							PlayerBox.PointD = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, -3, 0)).p)
						else
							PlayerBox.Visible = false
						end

						--// Tracer:
						if TracerToggle then
							local pos, visible = camera:WorldToViewportPoint((Part.CFrame.Position))
							if visible then
								Tracer.Visible = true
								Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
								Tracer.To = Vector2.new(pos.X, pos.Y)
							else
								Tracer.Visible = false
							end
						end

						--// Autothickness:
						if Autothickness then
							local distance = (workspace.CurrentCamera.CFrame.Position - Part.Position).magnitude
							local value = math.clamp(1/distance*100, BoxMinThick, BoxMaxThick)
							PlayerBox.Thickness = value 
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
end)

-- Players.PlayerDisconnecting:Connect(function()
-- 	cleardrawcache()
-- 	for _,Char in pairs(game.workspace.Characters:GetChildren()) do
-- 		if Char.BodyParts.LeftLowerLeg.BrickColor ~= TeamColor then
-- 			local Part = Char.PrimaryPart
			
-- 			--PlayerBox
-- 			local PlayerBox = Drawing.new("Quad")
-- 			PlayerBox.Visible = false
-- 			PlayerBox.Color = BoxColor
	
-- 			--Tracer
-- 			local Tracer = Drawing.new("Line")
-- 			Tracer.Visible = false
-- 			Tracer.Color = TracerColor
-- 			Tracer.Thickness = TracerThickness
-- 			Tracer.Transparency = TracerTransparency
	
-- 			--// Updates ESP (lines) in render loop
-- 			local function ESP()
-- 				local connection
-- 				connection =  RS.RenderStepped:Connect(function()
-- 					if Char ~= nil then
-- 						if on and Char.BodyParts:FindFirstChildOfClass("BallSocketConstraint") == nil then
-- 							local pos, visible = camera:WorldToViewportPoint(Char.PrimaryPart.Position)
-- 							if visible then
-- 								-- local size_X = Part.Size.X/2
-- 								-- local size_Y = Part.Size.Y/2
-- 								-- local size_Z = Part.Size.Z/2
					
-- 								PlayerBox.Visible = true
						
-- 								PlayerBox.PointA = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, 3, 0)).p)
-- 								PlayerBox.PointB = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, 3, 0)).p)
-- 								PlayerBox.PointC = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(1.5, -3, 0)).p)
-- 								PlayerBox.PointD = camera:WorldToViewportPoint((Part.CFrame * CFrame.new(-1.5, -3, 0)).p)
-- 							else
-- 								PlayerBox.Visible = false
-- 							end
		
-- 							--// Tracer:
-- 							if TracerToggle then
-- 								local pos, visible = camera:WorldToViewportPoint((Char.PrimaryPart.CFrame.Position))
-- 								if visible then
-- 									Tracer.Visible = true
-- 									Tracer.From = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y)
-- 									Tracer.To = Vector2.new(pos.X, pos.Y)
-- 								else
-- 									Tracer.Visible = false
-- 								end
-- 							end
		
-- 							--// Autothickness:
-- 							if Autothickness then
-- 								local distance = (workspace.CurrentCamera.CFrame.Position - Part.Position).magnitude
-- 								local value = math.clamp(1/distance*100, BoxMinThick, BoxMaxThick)
-- 								PlayerBox.Thickness = value 
-- 							end
-- 						else
-- 							PlayerBox:Destroy()
-- 							Tracer:Destroy()
-- 							connection:Disconnect()
-- 							coroutine.yield()
-- 						end
-- 					end
-- 				end)
-- 			end
-- 			coroutine.wrap(ESP)()
-- 		end
-- 	end
-- end)