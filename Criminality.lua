local Title = "Criminality Script by Nicuse"
local Body  = "By pressing OK you agree to the terms of the script (Check your clipboard for link)" wait() setclipboard("https://pastebin.com/raw/Xy2f52im")

local messagebox = messagebox(Body, Title, 0)


local RunService = game:GetService("RunService")
repeat wait() until game:IsLoaded()

function BypassAnticheat()
    local function CheckTable(tbl, ...)
        local Indexes = {...}


        for _, v in ipairs(Indexes) do
            if not (rawget(tbl, v)) then
                return false
            end
        end
    
        return true
    end
    
    local u21
    for _,v in ipairs(getgc(true)) do
        if (typeof(v) == "table" and CheckTable(v, "A", "B", "GP", "EN")) then
            u21 = v
            break
        end
    end
    
    hookfunction(u21.A, function()
    
    end)
    hookfunction(u21.B, function()
    
    end)
end

BypassAnticheat()


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
local VisualsTab = Window:NewTab("Visuals")

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

						if CharacterVar:WaitForChild("Humanoid").WalkSpeed > 16 then
							getupvalue(StaminaFunc, 6).S = 99
						end
					elseif CharacterVar then
						if CharacterVar:WaitForChild("Humanoid").WalkSpeed > 16 then
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
	
	local __newindex
	__newindex = hookmetamethod(game, "__newindex", function(t, k, v)
		if (t:IsDescendantOf(game.Players.LocalPlayer.Character) and k == "Jump" and v == false) then
			if _G.NoJumpCooldown == true then
				return
			end
		end

		return __newindex(t, k, v)
	end)
end)

MainSection:NewLabel("Hitbox Expander")

_G.HitboxExpander = false;




local hbetoexpand = 0;

local HeadSize = Vector3.new(1.2, 1, 1)


MainSection:NewToggle("Toggle", "Toggles hitbox expander.", function(state)

end)

MainSection:NewSlider("Expand", "How much hitbox to expand.", 400, 100, function(v)
	hbetoexpand = v
end)

MainSection:NewLabel("Other stuff")

local newfov = 70

MainSection:NewSlider("Field Of View", "Changes your field of view.", 265, 70, function(v)
	game.Workspace.Camera.FieldOfView = v
end)

_G.FullBrightNess = false;

MainSection:NewToggle("Full Brightness", "Makes your game full brightness!", function(state)
    _G.FullBrightNess = state;

	game:GetService("RunService").RenderStepped:Connect(function()
        if _G.FullBrightNess == true then
            game:GetService("Lighting").Brightness = 2
            game:GetService("Lighting").ClockTime = 14
            game:GetService("Lighting").FogEnd = 100000
            game:GetService("Lighting").GlobalShadows = false
            game:GetService("Lighting").OutdoorAmbient = Color3.fromRGB(128, 128, 128)
        end
    end) 
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

_G.BigLockPickBoxes = false

MainSection:NewToggle("Lockpick Hbe", "Expands lockpick hitbox.", function(state)
	_G.BigLockPickBoxes = state
	
	
	game.Players.LocalPlayer.PlayerGui.ChildAdded:Connect(function(Item)
		if _G.BigLockPickBoxes == true then
			if Item.Name == "LockpickGUI" then
				Item.MF["LP_Frame"].Frames.B1.Bar.UIScale.Scale = 10
				Item.MF["LP_Frame"].Frames.B2.Bar.UIScale.Scale = 10
				Item.MF["LP_Frame"].Frames.B3.Bar.UIScale.Scale = 10
			end
		elseif _G.BigLockPickBoxes == false then
			if Item.Name == "LockpickGUI" then
				Item.MF["LP_Frame"].Frames.B1.Bar.UIScale.Scale = 1
				Item.MF["LP_Frame"].Frames.B2.Bar.UIScale.Scale = 1
				Item.MF["LP_Frame"].Frames.B3.Bar.UIScale.Scale = 1
			end
		end
	end)
end)

_G.WalkSpeedEnabled = false
_G.JumpPowerEnabled = false

local PlayerTab = Window:NewTab("Player")
local PlayerSection = PlayerTab:NewSection("Player")

PlayerSection:NewToggle("Set WalkSpeed", "Sets walkspeed to amount", function(state)
	_G.WalkSpeedEnabled = state
end)

PlayerSection:NewSlider("WalkSpeed", "Changes your speed", 30, 16, function(v)
	while _G.WalkSpeedEnabled == true do
        wait()
		game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").WalkSpeed = v
	end
end)

PlayerSection:NewToggle("Set JumpPower", "Sets jumppower to amount", function(state)
	_G.JumpPowerEnabled = state
end)

PlayerSection:NewSlider("JumpPower", "Changes your jumppower", 75, 50, function(v)
	while _G.JumpPowerEnabled == true do
        wait()
		game.Players.LocalPlayer.Character:FindFirstChild("Humanoid").JumpPower = v
	end	
end)


local GunModsTab = Window:NewTab("Gun Mods")
local GunModsSection = GunModsTab:NewSection("Gun Mods")

_G.NoRecoil = false;

GunModsSection:NewToggle("No Recoil", "NO RECOIL!!", function(state)
	_G.NoRecoil = state;

	game.Players.LocalPlayer.Character.ChildAdded:Connect(function(Item)
		if Item:IsA("Tool") then
			for i, v in pairs(getgc(true)) do
				if type(v) == "table" and rawget(v, "EquipTime") then
					if _G.NoRecoil == true then
						v.Recoil = 0
                        v.CameraRecoilingEnabled = false
                        v.AngleX_Min = 0 
                        v.AngleX_Max = 0 
                        v.AngleY_Min = 0
                        v.AngleY_Max = 0
                        v.AngleZ_Min = 0
                        v.AngleZ_Max = 0
					end
				end
			end
		end
    end)    
end)

local MiscTab = Window:NewTab("Misc")
local MiscSection = MiscTab:NewSection("Misc")

_G.FullBrightNess = false;

MiscSection:NewToggle("Chat Logs", "Shows chat.", function(state)
	if state == true then
		local ChatFrame = game.Players.LocalPlayer.PlayerGui.Chat.Frame
		ChatFrame.ChatChannelParentFrame.Visible = true
		ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), ChatFrame.ChatChannelParentFrame.Size.Y)
	elseif state == false then
		local ChatFrame = game.Players.LocalPlayer.PlayerGui.Chat.Frame
		ChatFrame.ChatChannelParentFrame.Visible = false
		ChatFrame.ChatBarParentFrame.Position = ChatFrame.ChatChannelParentFrame.Position + UDim2.new(0, 0, 0, 0)
	end
end)

_G.SpamAdScript = false;
_G.SpamAdScriptWait = 1; --default wait

MiscSection:NewToggle("Spam Advertise Script", "Spam advertising script.", function(state)
	_G.SpamAdScript = state

	while _G.SpamAdScript == true do
		wait(1)
		local Event = game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest
	
		Event:FireServer("WANT FREE AND LEGIT AND RAGE CRIM SCRIPT? USE CRIMINALITY SCRIPT BY NICUSE (ON GITHUB)")
	end
end)

local VisualsSection = VisualsTab:NewSection("Visuals")

_G.EspToggled = false;

VisualsSection:NewToggle("Toggle ESP", "Toggles esp.", function(state)
	_G.EspToggled = state
end)

_G.MaxESPDistance = nil

VisualsSection:NewSlider("Max Distance", "Max esp distance (studs)", 2500, 0, function(v)
    _G.MaxESPDistance = v
end)

local Visuals_ESPSection = VisualsTab:NewSection("ESP")

Visuals_ESPSection:NewToggle("Player ESP", "Toggles player esp.", function()
	local Players = game:GetService("Players"):GetPlayers()
end)


_G.DealerESP = false
_G.ScrapESP = false
