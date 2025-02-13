-- made by: Zephyraris
-- << Services >> --
local Players = game:GetService("Players")
local ContentProvider = game:GetService("ContentProvider")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer

-- << Variables >> --
local c = {
    "rbxassetid://0",
    "rbxassetid://10066921516",
    "rbxassetid://13262267483",
    "rbxassetid://13253401424"
}

local p = { -- enter the ID of everyone who has access to the studio, so they don't get kicked
    660914543,
    517391900,
    4724003567,
    3669354326,
    4307154221
}

-- << Main >> --
if not RunService:IsStudio() and not table.find(p, Player.UserId) then
    for _, container in {Player.Character, game.StarterPack, Player:FindFirstChildOfClass("Backpack")} do
        for _, item in ipairs(container:GetChildren()) do
            if item:IsA("BackpackItem") and item.TextureId ~= "" then
                table.insert(c, item.TextureId)
            end
        end
    end

    while true do
        local Decal = Instance.new("Decal")
        Decal.Texture = "rbxasset://textures/face.png"

        ContentProvider:PreloadAsync({Decal, Decal, Decal, game.CoreGui, Decal}, function(url, status)
            if url == "rbxasset://textures/face.png" and status == Enum.AssetFetchStatus.Success then
                return
            elseif string.match(url, "^rbxassetid://") or string.match(url, "^http://www%.roblox%.com/asset/%?id=") then
                local icon = false
                for _, coreUrl in ipairs(c) do
                    if string.find(url, coreUrl, 1, true) then
                        icon = true
                        break
                    end
                end

                if not icon then
                    Player:Kick("Exploit Detected - 🤣")
                end
            end
        end)

        Decal:Destroy()

        local textbox = UserInputService:GetFocusedTextBox()
        if textbox and not textbox:IsDescendantOf(game:GetService("CoreGui"):FindFirstChild("TopBarApp")) then
            Player:Kick("Exploit Detected - 🤣")
        end
        wait(1)
    end
end
