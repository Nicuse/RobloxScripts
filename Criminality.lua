
game:GetService("RunService").RenderStepped:Connect(function()
	for _, Connection in next, getconnections(game:GetService("ScriptContext").Error) do
		Connection:Disable()
	end

	for _, Connection in next, getconnections(game:GetService("LogService").MessageOut) do
		Connection:Disable()
	end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Criminality", "Ocean")

local MainTab = Window:NewTab("Main")

-- Main

local MainSection = MainTab:NewSection("Main")

_G.InfiniteStamina = false;

MainSection:NewToggle("Infinite Stamina", "Gives you inf stamina. (Only while sprinting/running)", function(state)
	_G.InfiniteStamina = state
	
	local StaminaTake = getrenv()._G.S_Take
	local StaminaFunc = getupvalue(StaminaTake, 2) 

	for i, v in pairs(getupvalues(StaminaFunc)) do
		if type(v) == "function" and getinfo(v).name == "Upt_S" then
			local OldFunction; 

			OldFunction = hookfunction(v, function(...)
				if _G.InfiniteStamina == true then
					local CharacterVar = game.Players.LocalPlayer.Character

					if not CharacterVar or not CharacterVar.Parent then
						local CharacterVar = game.Players.LocalPlayer.CharacterAdded:wait()

						if CharacterVar:WaitForChild("Humanoid").WalkSpeed > 18 then
							getupvalue(StaminaFunc, 6).S = 99
						end
					elseif CharacterVar then
						if CharacterVar:WaitForChild("Humanoid").WalkSpeed > 18 then
							getupvalue(StaminaFunc, 6).S = 99
						end
					end
				end

				return OldFunction(...)
			end)
		end
	end
end)

_G.NoJumpCooldown = false;	

MainSection:NewToggle("No Jump Cooldown", "No jump cooldown.", function(state)
	_G.NoJumpCooldown = state
end)

MainSection:NewLabel("Other stuff")

local newfov = 70

MainSection:NewSlider("Field Of View", "Changes your field of view.", math.huge, 70, function(v)
	game.Workspace.Camera.FieldOfView = v
	
	newfov = v
end)

MainSection:NewKeybind("Zoom", "Changes your FOV to 30 for 1 second.", Enum.KeyCode.C, function()
	game.Workspace.Camera.FieldOfView = 30
	
	wait(1)
	
	game.Workspace.Camera.FieldOfView = newfov
end)



MainSection:NewButton("Full Brightness", "Makes your game full brightness!", function()
	local function brightFunc()
		game:GetService("Lighting").Brightness = 2
		game:GetService("Lighting").ClockTime = 14
		game:GetService("Lighting").FogEnd = 100000
		game:GetService("Lighting").GlobalShadows = false
		game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end

	local brightLoop = game:GetService("RunService").RenderStepped:Connect(brightFunc)
end)

_G.AutoUnlockDoors = false;

MainSection:NewToggle("Auto Unlock Doors", "Auto unlocks doors when nearby.", function(state)
	_G.AutoUnlockDoors = state
	
	game:GetService("RunService").RenderStepped:Connect(function()
		if _G.AutoUnlockDoors == true then
			for i, v in pairs(game:GetService("Workspace").Map.Doors:GetChildren()) do
				if (game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart").Position - v:FindFirstChild("DoorBase").Position).Magnitude <= 5 then
					if v:FindFirstChild("Values"):FindFirstChild("Locked").Value == true then
						v:FindFirstChild("Events"):FindFirstChild("Toggle"):FireServer("Unlock", v.Lock)
					end
				end
			end
		end
	end)	
end)
