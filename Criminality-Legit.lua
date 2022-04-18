-- No Crazy Blatant Things

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
local Window = Library.CreateLib("Criminality - Legit", "DarkTheme")

local MainTab = Window:NewTab("Main")
local MainSection = MainTab:NewSection("Main")

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

MainSection:NewToggle("Chat Logs", "Shows chat.", function(state)
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

GunModsSection = MainTab:NewSection("Gun Mods")

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

CreditNUIToggleSection = MainTab:NewSection("Credits And Toggle UI")

MainSection:NewKeybind("Toggle UI", "Toggles UI.", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)
