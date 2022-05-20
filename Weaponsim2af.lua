-- dont hold sword

-- game link:https://www.roblox.com/games/6191637341

game:GetService("Players").LocalPlayer.Character.Humanoid:EquipTool(game.Players.LocalPlayer.Backpack["sword"]) while wait() do game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = game:GetService("Workspace")["Current Map"].Baseplate.CFrame game:GetService("Players").LocalPlayer.Character.sword.Handle.pr.RemoteEvent:FireServer() end

