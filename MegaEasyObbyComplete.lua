-- // Game: https://www.roblox.com/games/3587619225/Mega-Easy-Obby

_G.On = true -- false = turn off, true = true on

spawn(function()
    while _G.On == true do
        wait(0.2)
        local Players = game:GetService("Players")
        local Workspace = game:GetService("Workspace")
        local Checkpoints = Workspace.Checkpoints
        local num = Players.LocalPlayer.leaderstats.Stage.Value + 1

        if Checkpoints:FindFirstChild(num) then
            Players.LocalPlayer.Character.HumanoidRootPart.CFrame = Checkpoints:FindFirstChild(num).CFrame
        end 
    end
end)
