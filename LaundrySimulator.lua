local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Laundry Simulator", "Ocean")


local MainTab = Window:NewTab("Main")
local GamepassesTab = Window:NewTab("Gamepasses")
local LocalPlayerTab = Window:NewTab("LocalPlayer")
local CreditsTab = Window:NewTab("Credits")

--Main
local MainSection = MainTab:NewSection("Main")

_G.Autofarm = false;

while _G.Autofarm do
	wait()
	local VirtualUser = game:service("VirtualUser")
	game:service('Players').LocalPlayer.Idled:connect(function()
		VirtualUser:CaptureController()
		VirtualUser:ClickButton2(Vector2.new())
	end)

	local owned_plot = game.Players.LocalPlayer.NonSaveVars.OwnsPlot
	while owned_plot.Value == nil do
		wait(1)
	end

	while wait(0.01) do

		game.Players.LocalPlayer.Gamepasses.NitroSpeed.Value = true

		local basket_status = game.Players.LocalPlayer.NonSaveVars.BasketStatus
		local backpack_amount = game.Players.LocalPlayer.NonSaveVars.BackpackAmount
		local washing_machine_capacity = game.Players.LocalPlayer.NonSaveVars.TotalWashingMachineCapacity
		local basket_size = game.Players.LocalPlayer.NonSaveVars.BasketSize
		local remaining_basket = math.min(basket_size.Value - backpack_amount.Value, washing_machine_capacity.Value - backpack_amount.Value)

		if basket_status.Value == "Dirty" or backpack_amount.Value == 0 then
			while remaining_basket > 0 do
				remaining_basket = math.min(basket_size.Value - backpack_amount.Value, washing_machine_capacity.Value - backpack_amount.Value)

				local clothes_array = game.Workspace.Debris.Clothing:GetChildren()

				local count_clothes = #clothes_array
				for i = 1, #clothes_array do
					if clothes_array[i].Name == "Magnet" then
						count_clothes -= 1
					end
				end

				if count_clothes == 0 then
					break
				end

				local index = 1
				local closest_cloth = nil
				while closest_cloth == nil do
					if index > #clothes_array then
						index = 1
					end
					closest_cloth = clothes_array[index]
					index += 1
					wait(0.01)
				end

				local humanoid_root_part = game.Players.LocalPlayer.Character.HumanoidRootPart
				local temp = (closest_cloth.Position - humanoid_root_part.Position).Magnitude

				for i in ipairs(clothes_array) do
					local magnitude = (clothes_array[i].Position - humanoid_root_part.Position).Magnitude
					if (magnitude < temp or clothes_array[i]:FindFirstChild("SpecialTag")) and clothes_array[i].Name ~= "Magnet" then
						temp = magnitude
						closest_cloth = clothes_array[i]
					end
				end

				game.ReplicatedStorage.Events.GrabClothing:FireServer(closest_cloth)
				wait(0.01)
			end     

			local washing_machines = owned_plot.Value.WashingMachines:GetChildren()
			for i in ipairs(washing_machines) do
				if washing_machines[i].Config.CycleFinished.Value then
					game.ReplicatedStorage.Events.UnloadWashingMachine:FireServer(washing_machines[i])
					game.ReplicatedStorage.Events.DropClothesInChute:FireServer()
				else
					local temp = washing_machines[i].Config.Capacity.Value
					for j = 1, backpack_amount.Value do
						game.ReplicatedStorage.Events.LoadWashingMachine:FireServer(washing_machines[i])
						if temp >= washing_machines[i].Config.Capacity.Value then
							break
						end
					end
				end
			end
		end
	end
end

MainSection:NewButton("Autofarm", " ", function()
	_G.Autofarm = true
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

local CreditsSection = CreditsTab:NewSection("Credits")

CreditsSection:NewButton("Copy Discord", "Discord: Nicuse#6163", function()
	setclipboard("Nicuse#6163")
end)


