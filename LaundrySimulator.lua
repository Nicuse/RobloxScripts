local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Laundry Simulator", "Ocean")


local MainTab = Window:NewTab("Main")
local GamepassesTab = Window:NewTab("Gamepasses")
local LocalPlayerTab = Window:NewTab("LocalPlayer")

--Main
local MainSection = MainTab:NewSection("Main")

MainSection:NewButton("Autofarm", " ", function()
	local x = getrawmetatable(game)
	setreadonly(x, false)
	local old_namecall = x.__namecall

	x.__namecall = function(a, ...)
		local method = getnamecallmethod()
		local Args = {...}
		if method == "FireServer" then
			if tostring(Args[2]):find("LocalError") then
				return 
			end
		end
		return old_namecall(a, ...)
	end

	pcall(function()
		function GetClothes() 
			local Clothing = workspace.Debris.Clothing:GetChildren()
			for i,v in pairs(Clothing) do
				local Remote = game.ReplicatedStorage.Events['GrabClothing']
				local Arguments = {
					[1] = v
				}
				Remote:FireServer(unpack(Arguments))
			end
		end

		function GetPlot()
			local AllPlots = workspace.Plots:GetChildren()
			for i,v in pairs(AllPlots) do
				if tostring(v.Owner.Value) == game.Players.LocalPlayer.Name then
					return v
				end
			end
		end

		function LoadWash()

			local Plot = GetPlot()

			for i,v in pairs(Plot["WashingMachines"]:GetChildren()) do 
				GetClothes()

				wait(0.5)

				local CFrame = v["MAIN"].CFrame
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame

				wait(0.5)

				local Remote = game.ReplicatedStorage.Events['LoadWashingMachine']
				local Arguments = {
					[1] = v
				}
				Remote:FireServer(unpack(Arguments))
			end


		end

		function Drop()
			local CFrame = CFrame.new(-142.327789, 4.49800396, -6.91391087, 0.194494158, -9.69223208e-08, 0.980903685, -2.39351117e-08, 1, 1.03555081e-07, -0.980903685, -4.36188969e-08, 0.194494158)
			game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame
			wait(0.2)
			local Remote = game.ReplicatedStorage.Events['DropClothesInChute']
			local Arguments = {

			}
			Remote:FireServer(unpack(Arguments))
		end

		function UnLoadWash()

			local Plot = GetPlot()

			for i,v in pairs(Plot["WashingMachines"]:GetChildren()) do 
				local CFrame = v["MAIN"].CFrame
				game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame

				wait(0.5)

				local Remote = game.ReplicatedStorage.Events['UnloadWashingMachine']
				local Arguments = {
					[1] = v
				}
				Remote:FireServer(unpack(Arguments))

				wait(0.5)

				Drop()
			end
		end

		local UI_Lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/ShowerHead-FluxTeam/NICEWORD/main/FUCKV3RM"))()
		local Window = UI_Lib:Window("FluxHub")
		local Section = Window:Section("NICEWORDa Farm")

		_G.IsAutoNICEWORDaOn = false;

		Section:Toggle("Auto Farm", function(State)
			_G.IsAutoNICEWORDaOn = State
		end)

		function CollectCoins()
			LoadWash()

			wait(15)

			UnLoadWash()

			wait(0.5)
		end

		while wait() do
			if _G.IsAutoNICEWORDaOn then
				if GetPlot() then
					CollectCoins()
				end
			end
		end
	end)
end)

local GamepassesSection = GamepassesTab:NewSection("Gamepass")

GamepassesSection:NewButton("Unlock All", "Unlocks all gamepasses.", function()
	game:GetService("Players").LocalPlayer.Gamepasses.VIP.Value = true
	game:GetService("Players").LocalPlayer.Gamepasses.DoubleCoins.Value = true
	game:GetService("Players").LocalPlayer.Gamepasses.BasketCapacity.Value = true
	game:GetService("Players").LocalPlayer.Gamepasses.NitroSpeed.Value = true
	game:GetService("Players").LocalPlayer.Gamepasses.DoubleClothes.Value = true
end)

GamepassesSection:NewButton("VIP", " ", function()
	game:GetService("Players").LocalPlayer.Gamepasses.VIP.Value = true
end)

GamepassesSection:NewButton("Double Coins", " ", function()
	game:GetService("Players").LocalPlayer.Gamepasses.DoubleCoins.Value = true
end)

GamepassesSection:NewButton("Basket Capacity", " ", function()
	game:GetService("Players").LocalPlayer.Gamepasses.BasketCapacity.Value = true
end)

GamepassesSection:NewButton("Nitro Speed", " ", function()
	game:GetService("Players").LocalPlayer.Gamepasses.NitroSpeed.Value = true
end)

GamepassesSection:NewButton("Double Clothes", " ", function()
	game:GetService("Players").LocalPlayer.Gamepasses.DoubleClothes.Value = true
end)

LocalPlayerSection = LocalPlayerTab:NewSection("LocalPlayer")

LocalPlayerSection:NewSlider("Walkspeed", " ", 500, 0, function(v)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

LocalPlayerSection:NewSlider("Jumppower", " ", 500, 0, function(v)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

LocalPlayerSection:NewButton("Fly [E]", " ", function()
		repeat wait() 
		until game.Players.LocalPlayer and game.Players.LocalPlayer.Character and game.Players.LocalPlayer.Character:findFirstChild("Head") and game.Players.LocalPlayer.Character:findFirstChild("Humanoid") 
		local mouse = game.Players.LocalPlayer:GetMouse() 
		repeat wait() until mouse
		local plr = game.Players.LocalPlayer 
		local torso = plr.Character.Head 
		local flying = false
		local deb = true 
		local ctrl = {f = 0, b = 0, l = 0, r = 0} 
		local lastctrl = {f = 0, b = 0, l = 0, r = 0} 
		local maxspeed = 400 
		local speed = 5000 

		function Fly() 
			local bg = Instance.new("BodyGyro", torso) 
			bg.P = 9e4 
			bg.maxTorque = Vector3.new(9e9, 9e9, 9e9) 
			bg.cframe = torso.CFrame 
			local bv = Instance.new("BodyVelocity", torso) 
			bv.velocity = Vector3.new(0,0.1,0) 
			bv.maxForce = Vector3.new(9e9, 9e9, 9e9) 
			repeat wait() 
				plr.Character.Humanoid.PlatformStand = true 
				if ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0 then 
					speed = speed+.5+(speed/maxspeed) 
					if speed > maxspeed then 
						speed = maxspeed 
					end 
				elseif not (ctrl.l + ctrl.r ~= 0 or ctrl.f + ctrl.b ~= 0) and speed ~= 0 then 
					speed = speed-1 
					if speed < 0 then 
						speed = 0 
					end 
				end 
				if (ctrl.l + ctrl.r) ~= 0 or (ctrl.f + ctrl.b) ~= 0 then 
					bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (ctrl.f+ctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(ctrl.l+ctrl.r,(ctrl.f+ctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
					lastctrl = {f = ctrl.f, b = ctrl.b, l = ctrl.l, r = ctrl.r} 
				elseif (ctrl.l + ctrl.r) == 0 and (ctrl.f + ctrl.b) == 0 and speed ~= 0 then 
					bv.velocity = ((game.Workspace.CurrentCamera.CoordinateFrame.lookVector * (lastctrl.f+lastctrl.b)) + ((game.Workspace.CurrentCamera.CoordinateFrame * CFrame.new(lastctrl.l+lastctrl.r,(lastctrl.f+lastctrl.b)*.2,0).p) - game.Workspace.CurrentCamera.CoordinateFrame.p))*speed 
				else 
					bv.velocity = Vector3.new(0,0.1,0) 
				end 
				bg.cframe = game.Workspace.CurrentCamera.CoordinateFrame * CFrame.Angles(-math.rad((ctrl.f+ctrl.b)*50*speed/maxspeed),0,0) 
			until not flying 
			ctrl = {f = 0, b = 0, l = 0, r = 0} 
			lastctrl = {f = 0, b = 0, l = 0, r = 0} 
			speed = 0 
			bg:Destroy() 
			bv:Destroy() 
			plr.Character.Humanoid.PlatformStand = false 
		end 
		mouse.KeyDown:connect(function(key) 
			if key:lower() == "e" then 
				if flying then flying = false 
				else 
					flying = true 
					Fly() 
				end 
			elseif key:lower() == "w" then 
				ctrl.f = 1 
			elseif key:lower() == "s" then 
				ctrl.b = -1 
			elseif key:lower() == "a" then 
				ctrl.l = -1 
			elseif key:lower() == "d" then 
				ctrl.r = 1 
			end 
		end) 
		mouse.KeyUp:connect(function(key) 
			if key:lower() == "w" then 
				ctrl.f = 0 
			elseif key:lower() == "s" then 
				ctrl.b = 0 
			elseif key:lower() == "a" then 
				ctrl.l = 0 
			elseif key:lower() == "d" then 
				ctrl.r = 0 
			end 
		end)
		Fly()
end)


