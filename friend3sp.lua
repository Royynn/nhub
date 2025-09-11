_G.killESP = false









local ctable = {}
local espTransparency = 0.25
COREGUI = game:GetService("CoreGui")
local espColor = Color3.fromHSV(1, 1, 1)
local t = 5;
local r = math.random() * t
task.spawn(function()
    while wait() do
        local hue = (tick()+r) % t / t
        espColor = Color3.fromHSV(hue, 1, 1)
    end
end)

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function CHMS(player, character)
	task.spawn(function()
		for _, v in pairs(COREGUI:GetChildren()) do
			if v.Name == player.Name..'_CHMS' then
				v:Destroy()
			end
		end

		if player.Character ~= character then return end

		repeat task.wait(0.5) until character and getRoot(character) and character:FindFirstChildOfClass("Humanoid")

		local adorns = {}
		local ESPholder = Instance.new("Folder")
		ESPholder.Name = player.Name..'_CHMS'
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
				adorn.Color3 = espColor
				table.insert(adorns, adorn)
			end
		end

		character:FindFirstChildOfClass("Humanoid").Died:Connect(function()
			if ESPholder then ESPholder:Destroy() end
		end)
		player.CharacterRemoving:Connect(function()
			if ESPholder then ESPholder:Destroy() end
		end)
		ESPholder.AncestryChanged:Connect(function(_, parent)
			if not parent and ESPholder then
				ESPholder:Destroy()
			end
		end)

		task.spawn(function()
			while ESPholder.Parent do
				for _, ad in pairs(adorns) do
					if ad.Parent then
						ad.Color3 = espColor
					end
				end
				task.wait()
			end
		end)
	end)
end

for _, player in pairs(game.Players:GetPlayers()) do
    if player:IsFriendsWith(game.Players.LocalPlayer.UserId) then
        connection = player.CharacterAdded:Connect(function(character)
            task.spawn(CHMS, player, character)
        end)
        table.insert(ctable, connection)
        if player.Character then
            task.spawn(CHMS, player, player.Character)
        end
    end
end

paconnection = game.Players.PlayerAdded:Connect(function(player)
    if not player:IsFriendsWith(game.Players.LocalPlayer.UserId) then return end
    connection = player.CharacterAdded:Connect(function(character)
		task.wait(1)
        task.spawn(CHMS, player, character)
    end)
    table.insert(ctable, connection)
end)

table.insert(ctable, paconnection)

task.spawn(function()
    while task.wait() do
        if _G.killESP then
            for _, c in pairs(ctable) do
                c:Disconnect()
                c = nil
            end
            for _, v in pairs(COREGUI:GetChildren()) do
			    if string.find(v.Name, "_CHMS") then
				    v:Destroy()
			    end
		    end
            break
        end
    end
end)
