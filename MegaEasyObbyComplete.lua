-- // Game: https://www.roblox.com/games/3587619225/Mega-Easy-Obby

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local num = Players.LocalPlayer.leaderstats.Stage.Value + 1

Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Workspace.Checkpoints[num].CFrame 
