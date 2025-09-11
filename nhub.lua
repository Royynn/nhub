local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local HttpService = game:GetService("HttpService")
PlaceId, JobId = game.PlaceId, game.JobId

local autospinning = false

task.spawn(function()
    while task.wait(0.01) do
        if autospinning then
            game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/GalaxyEventService/Spin"):FireServer()
            task.wait(10)
        end
    end
end)

cc = game.Players.LocalPlayer.OnTeleport:Connect(function(State)
    queue_on_teleport('loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/nhub.lua"))()')
end)

local Luna = loadstring(game:HttpGet("https://raw.githubusercontent.com/Nebula-Softworks/Luna-Interface-Suite/refs/heads/master/source.lua", true))()
local Window = Luna:CreateWindow({
	Name = "nigger hub"
})
-- main
local MainTab = Window:CreateTab({
	Name = "Home",
	Icon = "house",
	ImageSource = "Material",
	ShowTitle = true
})
local m1 = MainTab:CreateButton({
	Name = "rejoin",
	Description = nil,
    	Callback = function()
    	    if #Players:GetPlayers() <= 1 then
                Players.LocalPlayer:Kick("\nRejoining...")
                wait()
                TeleportService:Teleport(PlaceId, Players.LocalPlayer)
            else
                TeleportService:TeleportToPlaceInstance(PlaceId, JobId, Players.LocalPlayer)
            end
    	end
})
local m2 = MainTab:CreateButton({
	Name = "serverhop",
	Description = nil,
    	Callback = function()
    	    local servers = {}
            local req = game:HttpGet("https://games.roblox.com/v1/games/" .. PlaceId .. "/servers/Public?sortOrder=Desc&limit=100&excludeFullGames=true")
            local body = HttpService:JSONDecode(req)

            if body and body.data then
                for i, v in next, body.data do
                    if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.id ~= JobId then
                        table.insert(servers, 1, v.id)
                    end
                end
            end

            if #servers > 0 then
                TeleportService:TeleportToPlaceInstance(PlaceId, servers[math.random(1, #servers)], Players.LocalPlayer)
            else
                print("Couldn't find a server.")
            end
    	end
})
local m3 = MainTab:CreateButton({
	Name = "destroy gui",
	Description = nil,
    	Callback = function()
    	    cc:Disconnect()
    	    cc = nil
            Luna:Destroy()
            script:Destroy()
    	end
})
-- universal
local UTab = Window:CreateTab({
	Name = "Universal",
	Icon = "menu",
	ImageSource = "Material",
	ShowTitle = true
})
local u1 = UTab:CreateButton({
	Name = "infinite yield",
	Description = nil,
    	Callback = function()
    	    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    	end
})
local u2 = UTab:CreateButton({
	Name = "show desync",
	Description = nil,
    	Callback = function()
    	    loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/desync.lua"))()
    	end
})
local u3 = UTab:CreateButton({
	Name = "friend 3sp",
	Description = nil,
    	Callback = function()
    	    loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/friend3sp.lua"))()
    	end
})
local ANIM_ID = 136720812089001
local LOOPED = true
local PLAYBACK_SPEED = 1
local ANIM_WEIGHT = 99
local player = Players.LocalPlayer
local function loadAnimation(char)
    local humanoid = char:WaitForChild("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. ANIM_ID
    return animator:LoadAnimation(anim)
end
local currentTrack
local u4 = UTab:CreateToggle({
	Name = "shake ass",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
            local char = player.Character or player.CharacterAdded:Wait()
            if Value then
                currentTrack = loadAnimation(char)
                currentTrack.Looped = LOOPED
                currentTrack.Priority = Enum.AnimationPriority.Action4
                currentTrack:Play(0, ANIM_WEIGHT)
                currentTrack:AdjustSpeed(PLAYBACK_SPEED)
            else
                currentTrack:Stop(0)
                currentTrack:Destroy()
                currentTrack = nil
            end
    	end
}, "Toggle")
local u5 = UTab:CreateButton({
	Name = "xvc hub",
	Description = nil,
    	Callback = function()
    	    loadstring(game:HttpGet("https://pastebin.com/raw/Piw5bqGq"))()
    	end
})
-- chat
local ChatTab = Window:CreateTab({
	Name = "edate chat with niggers",
	Icon = "chat",
	ImageSource = "Material",
	ShowTitle = true
})
local c1 = ChatTab:CreateButton({
	Name = "cat bypasser",
	Description = nil,
    	Callback = function()
    	    loadstring(game:HttpGet("https://raw.githubusercontent.com/shadow62x/catbypass/main/upfix"))()
    	end
})
local c2 = ChatTab:CreateButton({
	Name = "clear chat",
	Description = nil,
    	Callback = function()
    	    for _ = 1, 4 do
                task.wait(0.1)
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(string.rep("　", 66))
            end
    	end
})
ChatTab:CreateSection('-- set language to "Қазақ тілі" for this to work')
local c3 = ChatTab:CreateButton({
	Name = "nigger spam",
	Description = nil,
    	Callback = function()
    	    task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(string.rep("　", 66))
            task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("" .. string.rep(" ", 100) .. "fมϲҟถเ่ʛʛeꞅธ")
            task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("" .. string.rep(" ", 100) .. "เ่ꜧสteถเ่ʛʛeꞅธ")
            task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("" .. string.rep(" ", 100) .. "kῘllสllⴖῘʛʛeꞅṡַ")
            task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("" .. string.rep(" ", 100) .. "cมtสถiggสรხꞅสiถiถһสꙆf")
    	end
})
local c4 = ChatTab:CreateButton({
	Name = "rape niggas",
	Description = nil,
    	Callback = function()
    	    task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("һสveถ'tมรedtһewჿꞅd'ꞅสpe'iถสwһiꙆe...")
            task.wait(1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("iꞅสpedꙆiꝁe6ჿꞅ7ถiggeꞅรtჿdสy")
    	end
})
local c5 = ChatTab:CreateButton({
	Name = "shut up nigger",
	Description = nil,
    	Callback = function()
    	    task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("ṡַḥַụַṭַụṗַⴖῘʛʛeꞅ")
    	end
})
local c6 = ChatTab:CreateButton({
	Name = "ez nigga",
	Description = nil,
    	Callback = function()
    	    task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("ezⴖเ่ʛʛส")
    	end
})
local c7 = ChatTab:CreateButton({
	Name = "im jerking",
	Description = nil,
    	Callback = function()
    	    task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("іṁjәַꞅꝁịַṅַg")
    	end
})
-- lumber tycoon 2
if game.PlaceId == 13822889 then
    local GameTab = Window:CreateTab({
	Name = "Lumber Tycoon 2",
	Icon = "park",
	ImageSource = "Material",
	ShowTitle = true
    })
    local b1 = GameTab:CreateButton({
	Name = "script",
	Description = nil,
    	Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0'))("")
    	end
    })
end
-- steal a brainrot
local sabid = {
    [109983668079237] = true,
    [128762245270197] = true,
    [96342491571673] = true
}
if sabid[game.PlaceId] then
    local GameTab = Window:CreateTab({
	Name = "Steal A Brainrot",
	Icon = "do_not_touch",
	ImageSource = "Material",
	ShowTitle = true
    })
    local b1 = GameTab:CreateToggle({
	Name = "Auto Spin",
	Description = nil,
	CurrentValue = false,
    	Callback = function(Value)
            autospinning = Value
        end
    }, "Toggle")
    local b2 = GameTab:CreateButton({
	Name = "Chilli",
	Description = nil,
    	Callback = function()
            Luna:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
            script:Destroy()
    	end
    })
    local b3 = GameTab:CreateButton({
	Name = "PulsarX (key system)",
	Description = nil,
    	Callback = function()
            Luna:Destroy()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Estevansit0/KJJK/refs/heads/main/PusarX-loader.lua"))()
            script:Destroy()
    	end
    })
end
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
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/guard3sp.lua"))()
        end
    })
end
