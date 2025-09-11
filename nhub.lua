local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()
local Window = Luna:CreateWindow({
	Name = "nigger hub",
	LogoID = "82795327169782",
	LoadingEnabled = false
})
local MainTab = Window:CreateTab({
	Name = "home",
	Icon = "menu",
	ImageSource = "Material",
	ShowTitle = true
})
local DestroyButton = MainTab:CreateButton({
	Name = "destroy gui",
	Description = nil,
    	Callback = function()
            Luna:Destroy()
    	end
})

-- ink game
local inkgameid = {
    [99567941238278] = true,
    [125009265613167] = true,
    [122816944483266] = true,
    [121431824618615] = true,
    [113555439745862] = true,
    [76172769094087] = true
}
if inkgameid[game.PlaceId] then
    local GameTab = Window:CreateTab({
	Name = "ink gay",
	Icon = "accessible_forward",
	ImageSource = "Material",
	ShowTitle = true
    })
    local b1 = GameTab:CreateButton({
	Name = "join pro server",
	Description = nil,
    	Callback = function()
            game:GetService("TeleportService"):Teleport(76172769094087, game:GetService("Players").LocalPlayer)
    	end
    })
    local b2 = GameTab:CreateButton({
	Name = "voidware (ac bypass)",
	Description = nil,
    	Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/inkgame.lua", true))()
    	end
    })
    local b3 = GameTab:CreateButton({
	Name = "owlhook",
	Description = nil,
    	Callback = function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/0785b4b8f41683be513badd57f6a71c0.lua"))()
    	end
    })
    local b4 = GameTab:CreateButton({
	Name = "guard 3sp",
	Description = nil,
    	Callback = function()
            local espTransparency = 0.5
            function getRoot(char)
                local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
                return rootPart
            end
            function CHMS(character, espColor)
                task.spawn(function()
                    wait()
                    repeat task.wait(0.5) until character and getRoot(character) and character:FindFirstChildOfClass("Humanoid")
                        local ESPholder = Instance.new("Folder")
                        ESPholder.Name = character.Name..'_CHMS'
                        ESPholder.Parent = COREGUI
                        for _, part in pairs(character:GetChildren()) do
                            if part:IsA("BasePart") then
                                local adorn = Instance.new("BoxHandleAdornment")
                                adorn.Name = character.Name
                                adorn.Parent = ESPholder
                                adorn.Adornee = part
                                adorn.AlwaysOnTop = true
                                adorn.ZIndex = 10
                                adorn.Size = part.Size
                                adorn.Transparency = espTransparency
                                adorn.Color3 = espColor or Color3.new(1, 0, 0)
                            end
                        end
                        character.Humanoid.Died:Connect(function()
                            ESPholder:Destroy()
                        end)
                        ESPholder.AncestryChanged:Connect(function(_, parent)
                            if not parent then
                                ESPholder:Destroy()
                            end
                        end)
                end)
            end
            function checkifguard(child)
                if child:WaitForChild("TypeOfGuard", 3) then
                    return true
                end
                return false
            end
            workspace.Live.ChildAdded:Connect(function(ch)
                if checkifguard(ch) then
                    CHMS(ch, Color3.new(1, 0, 0))
                end
            end)
            for _, ch in pairs(workspace.Live:GetChildren()) do
                if checkifguard(ch) then
                    CHMS(ch, Color3.new(1, 0, 0))
                end
            end
    	end
    })
end
game.Players.LocalPlayer.OnTeleport:Connect(function(State)
    queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/nhub.lua"))()')
end)
