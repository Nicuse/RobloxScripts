--Game: https://www.roblox.com/games/9377039667/Roblox-Innovation-Awards-Voting-Hub
([[Made by Nicuse#6163]]))({function(d)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(96, 168, -152)

playerHead = game.Players.LocalPlayer.Character.Head

while wait(0.1) do
    for i, v in pairs(game:GetService("Workspace").CubePieces:GetDescendants()) do
        if v.Name == "TouchInterest" and v.Parent then
            firetouchinterest(playerHead, v.Parent, 0)
            wait()
            firetouchinterest(playerHead, v.Parent, 1)
        end
    end
end    

wait(1)

game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(22, 23, -131)

wait(1)

game:GetService("TeleportService"):Teleport(game.PlaceId, game.Players.LocalPlayer)end)}
