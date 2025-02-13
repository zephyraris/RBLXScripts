-- << Variables >> --
local ServerEvents = game:GetService("ReplicatedStorage").ServerEvents

-- << Main >> --
for _, player in pairs(game:GetService("Players"):GetPlayers()) do
    coroutine.wrap(function()
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            for _, part in pairs(game.Workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part:IsDescendantOf(character) then
                    ServerEvents.ProjectileExplosion:FireServer(player, part.Position, nil)
                    task.wait(0.1) 
                end
            end
        end
    end)()
end
