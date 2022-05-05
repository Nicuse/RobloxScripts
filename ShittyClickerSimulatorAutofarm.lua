_G.RebirthAmount = 1

_G.AutoClick = false
_G.AutoRebirth = false

function AddClickThing()
    local args = {
        [1] = {
            ["manual"] = {
                ["1"] = 5
            }
        }
    }
    
    game:GetService("ReplicatedStorage").Events.Client.emitClicks:FireServer()
    game:GetService("ReplicatedStorage").Clickerr:InvokeServer(unpack(args))
end    

function requestRebirth()
    local args = {
        [1] = _G.RebirthAmount,
        [2] = false,
        [3] = false
    }
    
    game:GetService("ReplicatedStorage").Events.Client.requestRebirth:FireServer(unpack(args))   
end

spawn(function()
    while wait(1) do
        if _G.AutoClick then
            AddClickThing()
        end
    end
end)

spawn(function()
    while wait(3) do
        if _G.AutoRebirth then
            requestRebirth()
        end
    end
end)

--ui

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua", true))()
local Window = Library.CreateLib("Clicker Simulator", "GrapeTheme")

local MainTab = Window:NewTab("Main")

local MainS = MainTab:NewSection("Main")

MainS:NewToggle("Auto Click", "Auto clicks", function(state)
    _G.AutoClick = state
end)

MainS:NewToggle("Auto Rebirth", "Auto rebirths", function(state)
    _G.AutoRebirth = state
end)

local CreditsTab = Window:NewTab("Credits")
local CreditsS = CreditsTab:NewSection("Credits")

CreditsS:NewLabel("shitty autofarm i made in 5 minutes")

CreditsS:NewButton("Nicuse#6163", "Nicuse#6163", function()
    setclipboard("Nicuse#6163")
end)
