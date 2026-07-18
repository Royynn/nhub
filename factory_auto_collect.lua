local player = game.Players.LocalPlayer
local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
local name = player.Name

while wait(5) do
    for i = 1, 8 do
        local btn = workspace.Plots[name.." Plot"].PodiumFloorParts[tostring(i)].CollectButton
        btn.Transparency = 1
        btn.CanCollide = false
        for _, v in ipairs(btn:GetDescendants()) do
            if v:IsA("BasePart") then
                v.Transparency = 1
                v.CanCollide = false
            end
        end
        btn.CFrame = root.CFrame * CFrame.new(0, 0, 2)
        btn.CFrame = workspace.Plots[name.." Plot"].PodiumFloorParts[tostring(i)].CollectButton:FindFirstChild("TouchInterest").Parent.CFrame
    end
end
