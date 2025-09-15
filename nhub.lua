scriptname = "nigger hub v2.1.6"

if not game:IsLoaded() then game.Loaded:Wait() end
if Luna then Luna:Destroy() end

function missing(t, f, fallback)
    if type(f) == t then return f end
    return fallback
end

function loadAnimation(char, animid)
    local humanoid = char:WaitForChild("Humanoid")
    local animator = humanoid:FindFirstChildOfClass("Animator")
    if not animator then
        animator = Instance.new("Animator")
        animator.Parent = humanoid
    end
    local anim = Instance.new("Animation")
    anim.AnimationId = "rbxassetid://" .. tostring(animid)
    return animator:LoadAnimation(anim)
end

function r15(plr)
    return plr.Character:FindFirstChildOfClass('Humanoid').RigType == Enum.HumanoidRigType.R15
end

local cloneref = missing("function", cloneref, function(...) return ... end)
local queueteleport = missing("function", queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport))

-- vars
local Players = cloneref(game:GetService("Players"))
local HttpService = cloneref(game:GetService("HttpService"))
local TeleportService = cloneref(game:GetService("TeleportService"))
local PlaceId, JobId = game.PlaceId, game.JobId
local LocalPlayer = Players.LocalPlayer

local JoinJobId
local track = nil
local jtask = nil
local CURRENTTRACK
local autospinning = false
local autoinvite = false
local Keep = true
local TeleportCheck = false
--

Players.LocalPlayer.OnTeleport:Connect(function(State)
	if Keep and (not TeleportCheck) and queueteleport then
		TeleportCheck = true
		queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/nhub.lua'))()")
	end
end)

task.spawn(function()
    while task.wait(10) do
        if autospinning then
            game:GetService("ReplicatedStorage"):WaitForChild("Packages"):WaitForChild("Net"):WaitForChild("RE/GalaxyEventService/Spin"):FireServer()
        end
    end
end)

task.spawn(function()
    while task.wait(1) do
        if autoinvite then
            for _, v in pairs(Players:GetPlayers()) do
                local attr = v:GetAttribute("guildId")
                if attr == 0 then
                    game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("RequestRecruit"):FireServer(v)
                    task.wait(1)
                end
            end
        end
    end
end)

local Luna = loadstring(game:HttpGet("https://raw.nebulasoftworks.xyz/luna", true))()
local Window = Luna:CreateWindow({Name = scriptname, LoadingEnabled = false})

-- MainTab
local MainTab = Window:CreateTab({
    Name = "Home",
    Icon = "house",
    ImageSource = "Material",
    ShowTitle = false
})
local MainButton1 = MainTab:CreateButton({
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
local MainButton2 = MainTab:CreateButton({
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
            Luna:Notification({ 
                Title = "Serverhop",
                Icon = "search",
                ImageSource = "Material",
                Content = "Couldn't find a server."
            })
        end
    end
})
MainTab:CreateDivider()
local MainButton3 = MainTab:CreateButton({
    Name = "copy jobid",
    Description = nil,
    Callback = function()
        setclipboard(JobId)
        Luna:Notification({ 
            Title = "JobId copied!",
            Icon = "done",
            ImageSource = "Material",
            Content = JobId
        })
    end
})
local MainButton4 = MainTab:CreateInput({
    Name = "jobid",
    Description = nil,
    PlaceholderText = "",
    CurrentValue = "",
    Numeric = false,
    MaxCharacters = nil,
    Enter = false,
    Callback = function(Text)
        JoinJobId = Text
    end
}, "Input")
local MainButton5 = MainTab:CreateButton({
    Name = "join",
    Description = nil,
    Callback = function()
        TeleportService:TeleportToPlaceInstance(PlaceId, JoinJobId, Players.LocalPlayer)
    end
})
MainTab:CreateDivider()
local MainButton6 = MainTab:CreateButton({
    Name = "unload",
    Description = nil,
    Callback = function()
        Keep = false
        Luna:Destroy()
        script:Destroy()
    end
})
--
-- UniversalTab
local UniversalTab = Window:CreateTab({
    Name = "Universal",
    Icon = "menu",
    ImageSource = "Material",
    ShowTitle = true
})
local UniversalButton1 = UniversalTab:CreateSlider({
    Name = "walkspeed",
    Range = {16, 100},
    Increment = 1,
    CurrentValue = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass('Humanoid').WalkSpeed or 16,
    Callback = function(Value)
        if LocalPlayer.Character then LocalPlayer.Character:FindFirstChildOfClass('Humanoid').WalkSpeed = Value end
    end
}, "Slider")
UniversalTab:CreateDivider()
local UniversalButton2 = UniversalTab:CreateButton({
    Name = "infinite yield",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    end
})
local UniversalButton3 = UniversalTab:CreateButton({
    Name = "show server pos",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/desync.lua"))()
    end
})
local UniversalButton4 = UniversalTab:CreateButton({
    Name = "faggot esp",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/friend3sp.lua"))()
    end
})
UniversalTab:CreateDivider()
local UniversalButton5 = UniversalTab:CreateButton({
    Name = "xvc hub",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://pastebin.com/raw/Piw5bqGq"))()
    end
})
--
-- ChatTab
local ChatTab = Window:CreateTab({
    Name = "Chat",
    Icon = "chat",
    ImageSource = "Material",
    ShowTitle = true
})
local ChatButton1 = ChatTab:CreateButton({
    Name = "clear chat",
    Description = nil,
    Callback = function()
        for _ = 1, 4 do
            task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(string.rep("", 200))
        end
    end
})
local ChatButton2 = ChatTab:CreateButton({
    Name = "nigger spam",
    Description = nil,
    Callback = function()
        for _ = 1, 2 do
            task.wait(0.1)
            game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync(string.rep("", 200))
		end
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
local ChatButton3 = ChatTab:CreateButton({
    Name = "rape niggas",
    Description = nil,
    Callback = function()
        task.wait(0.1)
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("һสveถ'tมรedtһewჿꞅd'ꞅสpe'iถสwһiꙆe...")
        task.wait(1)
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("iꞅสpedꙆiꝁe6ჿꞅ7ถiggeꞅรtჿdสy")
    end
})
local ChatButton4 = ChatTab:CreateButton({
    Name = "hello niggers",
    Description = nil,
    Callback = function()
        task.wait(0.1)
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("helloⴖῘʛʛeꞅṡַ")
    end
})
local ChatButton5 = ChatTab:CreateButton({
    Name = "ez nigga",
    Description = nil,
    Callback = function()
        task.wait(0.1)
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("ezⴖเ่ʛʛส")
    end
})
local ChatButton6 = ChatTab:CreateButton({
    Name = "shut up nigger",
    Description = nil,
    Callback = function()
        task.wait(0.1)
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("ṡַḥַụַṭַụṗַⴖῘʛʛeꞅ")
    end
})
local ChatButton7 = ChatTab:CreateButton({
    Name = "im jerking",
    Description = nil,
    Callback = function()
        task.wait(0.1)
        game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("іṁjәַꞅꝁịַṅַg")
    end
})
--
-- EmotesTab
local EmotesTab = Window:CreateTab({
    Name = "Emotes",
    Icon = "accessibility_new",
    ImageSource = "Material",
    ShowTitle = true
})
local EmotesButton1 = EmotesTab:CreateToggle({
    Name = "Jerk",
    Description = nil,
    CurrentValue = false,
    Callback = function(Value)
        if Value then
            jtask = task.spawn(function()
                while task.wait() do
                    local isR15 = r15(LocalPlayer)
                    if not track then
                        track = loadAnimation(LocalPlayer.Character, not isR15 and 72042024 or 698251653)
                    end
                    track.Priority = Enum.AnimationPriority.Action4
                    track:Play()
                    track:AdjustSpeed(isR15 and 0.7 or 0.65)
                    track.TimePosition = 0.6
                    task.wait(0.1)
                    while track and track.TimePosition < (not isR15 and 0.65 or 0.7) do task.wait(0.1) end
                    if track then
                        track:Stop()
                        track = nil
                    end
                end
            end)
        else
            if jtask then
                task.cancel(jtask)
                jtask = nil
            end
            if track then
                track:Stop()
                track = nil
            end
        end
    end
}, "Toggle")
local EmotesButton2 = EmotesTab:CreateToggle({
    Name = "Shake Ass",
    Description = nil,
    CurrentValue = false,
    Callback = function(Value)
        local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if Value then
            CURRENTTRACK = loadAnimation(char, 136720812089001)
            CURRENTTRACK.Looped = true
            CURRENTTRACK.Priority = Enum.AnimationPriority.Action4
            CURRENTTRACK:Play(0, 99)
            CURRENTTRACK:AdjustSpeed(1)
        else
            if CURRENTTRACK then
                CURRENTTRACK:Stop(0)
                CURRENTTRACK:Destroy()
                CURRENTTRACK = nil
            end
        end
    end
}, "Toggle")
local EmotesButton3 = EmotesTab:CreateButton({
    Name = "ugc emote player",
    Description = nil,
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/XVCHub/scripts/main/ugc-emote-player"))()
    end
})
--
-- GameTab
local ink_id = {
    [99567941238278] = true,
    [125009265613167] = true,
    [122816944483266] = true,
    [121431824618615] = true,
    [113555439745862] = true,
    [76172769094087] = true
}
local sab_id = {
    [109983668079237] = true,
    [128762245270197] = true,
    [96342491571673] = true
}
local lt2_id = {
    [13822889] = true
}
local arsenal_id = {
    [286090429] = true
}
local hvh_id = {
    [301549746] = true
}
local nigga_id = {
    [78880563336454] = true,
    [78611602637625] = true,
    [110937580440810] = true,
    [116605021848414] = true,
    [124805644313664] = true,
    [127626589430786] = true,
    [132493759931413] = true
}
if ink_id[game.PlaceId] then
    local GameTab = Window:CreateTab({
        Name = "ink GAY",
        Icon = "accessible_forward",
        ImageSource = "Material",
        ShowTitle = true
    })
    local GameButton1 = GameTab:CreateButton({
        Name = "teleport to jerking position",
        Description = nil,
        Callback = function()
            game.Players.LocalPlayer.Character:PivotTo(CFrame.new(Vector3.new(197.5, 56, 25)))
        end
    })
    local GameButton2 = GameTab:CreateButton({
        Name = "voidware (ac bypass)",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VapeVoidware/VW-Add/main/inkgame.lua", true))()
        end
    })
    local GameButton3 = GameTab:CreateButton({
        Name = "owlhook",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/0785b4b8f41683be513badd57f6a71c0.lua"))()
        end
    })
    local GameButton4 = GameTab:CreateButton({
        Name = "ambrion",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/VisioneducationOfLuaCoding/Ink-Game/refs/heads/main/Ambrion"))()
        end
    })
    local GameButton5 = GameTab:CreateButton({
        Name = "guard esp",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/Royynn/nhub/refs/heads/main/guard3sp.lua"))()
        end
    })
elseif sab_id[game.PlaceId] then
    local GameTab = Window:CreateTab({
        Name = "Steal A Brainrot",
        Icon = "do_not_touch",
        ImageSource = "Material",
        ShowTitle = true
    })
    local GameButton1 = GameTab:CreateToggle({
        Name = "Auto Spin",
        Description = nil,
        CurrentValue = false,
        Callback = function(Value)
            autospinning = Value
        end
    }, "Toggle")
    local GameButton2 = GameTab:CreateButton({
        Name = "Chilli",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/EnesXVC/Anti-Logger/main/Easy-Mode"))()
            task.wait(1)
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua"))()
        end
    })
    local GameButton3 = GameTab:CreateButton({
        Name = "Koronis (Key System)",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/nf-36/Koronis/refs/heads/main/Scripts/hub.lua"))()
        end
    })
elseif lt2_id[game.PlaceId] then
    local GameTab = Window:CreateTab({
        Name = "Lumber Tycoon 2",
        Icon = "park",
        ImageSource = "Material",
        ShowTitle = true
    })
    local GameButton1 = GameTab:CreateToggle({
        Name = "View LoneCave",
        Description = nil,
        CurrentValue = false,
        Callback = function(Value)
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
            if Value then
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "TreeRegion" and v:FindFirstChild("Model") and v.Model.TreeClass.Value == "LoneCave" then
                        workspace.CurrentCamera.CameraSubject = v
                        return
                    end
                end
            end
        end
    }, "Toggle")
    local GameButton2 = GameTab:CreateToggle({
        Name = "View CaveCrawler",
        Description = nil,
        CurrentValue = false,
        Callback = function(Value)
            workspace.CurrentCamera.CameraSubject = LocalPlayer.Character.Humanoid
            if Value then
                for _, v in pairs(workspace:GetChildren()) do
                    if v.Name == "TreeRegion" and v:FindFirstChild("Model") and v.Model.TreeClass.Value == "CaveCrawler" then
                        workspace.CurrentCamera.CameraSubject = v
                        return
                    end
                end
            end
        end
    }, "Toggle")
    local GameButton3 = GameTab:CreateButton({
        Name = "Kron Hub",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet('https://raw.githubusercontent.com/DevKron/Kron_Hub/refs/heads/main/version_1.0'))("")
        end
    })
elseif arsenal_id[game.PlaceId] then
    local GameTab = Window:CreateTab({
        Name = "Arsenal",
        Icon = "shield",
        ImageSource = "Material",
        ShowTitle = true
    })
    local GameButton1 = GameTab:CreateButton({
        Name = "TbaoHubArsenal",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/tbao143/thaibao/main/TbaoHubArsenal"))()
        end
    })
elseif hvh_id[game.PlaceId] then
    local GameTab = Window:CreateTab({
        Name = "Counter Blox",
        Icon = "shield",
        ImageSource = "Material",
        ShowTitle = true
    })
    local GameButton1 = GameTab:CreateButton({
        Name = "astral hvh",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/inveris1337/dumping_nn/refs/heads/main/flohaxx/source.lua",true))()
        end
    })
    local GameButton2 = GameTab:CreateButton({
        Name = "zeroware",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/scytheXlol/ZeroWare-V2/main/Loader.luau"))()
        end
    })
    local GameButton3 = GameTab:CreateButton({
        Name = "esp",
        Description = nil,
        Callback = function()
            loadstring(game:HttpGet("https://raw.githubusercontent.com/cool83birdcarfly02six/UNIVERSALESPLTX/main/README.md"))()
        end
    })
elseif nigga_id[game.PlaceId] then
    local GameTab = Window:CreateTab({
        Name = "nigga cult",
        Icon = "favorite",
        ImageSource = "Material",
        ShowTitle = true
    })
    local GameButton1 = GameTab:CreateToggle({
        Name = "auto invite",
        Description = nil,
        CurrentValue = false,
        Callback = function(Value)
            autoinvite = Value
        end
    }, "Toggle")
    local GameButton2 = GameTab:CreateButton({
        Name = "spam",
        Description = nil,
        Callback = function()
            for _ = 1, 3 do
                task.wait(0.1)
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("" .. string.rep(" ", 100) .. "Ꙇeสvefꞅჿmyჿมꞅfมcꝁiถgรңịַttỵַcꞅewⴖჿw!")
                task.wait(0.1)
                game:GetService("TextChatService").TextChannels.RBXGeneral:SendAsync("" .. string.rep(" ", 100) .. "jჿintһeⴖῘggสธeӽcꞅewyჿมรtมpidถเ่ʛʛeꞅธ!")
            end
        end
    })
    local GameButton3 = GameTab:CreateButton({
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
                Luna:Notification({ 
                    Title = "Serverhop",
                    Icon = "search",
                    ImageSource = "Material",
                    Content = "Couldn't find a server."
                })
            end
        end
    })
end
--
--[[
local Button = Tab:CreateButton({
    Name = "Button",
    Description = nil,
    Callback = function()
        return
    end
})
--]]
