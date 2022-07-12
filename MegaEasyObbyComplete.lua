-- // Game: https://www.roblox.com/games/3587619225/Mega-Easy-Obby

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace = game:GetService("Workspace")
local Checkpoints = Workspace.Checkpoints

_G.On = false -- false = turn off, true = true on
_G.Prestige = false -- Auto Prestige

spawn(function()
    while wait(0.2) do
        if _G.On == true then
            local num = Players.LocalPlayer.leaderstats.Stage.Value + 1
            if Checkpoints:FindFirstChild(num) then
                Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Checkpoints:FindFirstChild(num).CFrame + Vector3.new(0, 5, 0)
            end
        end
    end
end)

spawn(function()
    while wait(1) do
        if _G.Prestige == true then
            ReplicatedStorage.Events.prestige:FireServer()
        end
    end
end)

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name, "Ocean")

local Tab = Window:NewTab("Main")
local Section = Tab:NewSection("Main")
local Tab2 = Window:NewTab("Credits")
local Section2 = Tab2:NewSection("Credits")

Section:NewToggle("Complete Obby", "Completes the obby", function(state)
    _G.On = state;
end)

Section:NewToggle("Auto Prestige", "Automatically prestiges when you complete the obby", function(state)
    _G.Prestige = state;
end)

Section2:NewButton("Nicuse#6163", "Nicuse#6163", function()
    setclipboard("Nicuse#6163")
end)
