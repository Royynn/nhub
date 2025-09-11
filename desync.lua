local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer
local espTransparency = 0.25

local function getRoot(char)
	return char:FindFirstChild("HumanoidRootPart")
end

local function getPing()
	local stats = game:GetService("Stats")
	local network = stats.Network
	if network and network.ServerStatsItem then
		local pingStat = network.ServerStatsItem["Data Ping"]
		if pingStat then
			return math.floor(pingStat:GetValue())
		end
	end
	return 0
end

local function createDelayedClone()
	local char = LocalPlayer.Character
	if not char then return end
	local root = getRoot(char)
	if not root then return end
	
	local oldClone = workspace:FindFirstChild("DelayedClone")
	if oldClone then
		oldClone:Destroy()
	end
	
	local clone = Instance.new("Model")
	clone.Name = "DelayedClone"
	clone.Parent = workspace
	
	local parts = {}
	for _, part in pairs(char:GetChildren()) do
		if part:IsA("BasePart") and part.Name == "HumanoidRootPart" then
			local partClone = part:Clone()
			for _, v in pairs(partClone:GetChildren()) do
				if not v:IsA("SpecialMesh") then
					v:Destroy()
				end
			end
			partClone.Anchored = true
			partClone.CanCollide = false
			partClone.Transparency = espTransparency
			partClone.Parent = clone
			parts[part.Name] = partClone
		end
	end
	
	local cframeHistory = {}
	local historyMaxSize = 60
	local smoothedPing = getPing()
	local lastUpdateTime = os.clock()
	
	local function getSmoothedPing()
		local currentPing = getPing()
		smoothedPing = smoothedPing * 0.8 + currentPing * 0.2
		return smoothedPing
	end
	
	RunService.RenderStepped:Connect(function(dt)
		local currentTime = os.clock()
		local timeSinceLastUpdate = currentTime - lastUpdateTime
		
		if timeSinceLastUpdate < 0.05 then
			return
		end
		
		lastUpdateTime = currentTime
		
		local ping = getSmoothedPing() / 1000
		local targetDelay = math.clamp(ping, 0.1, 0.5)
		
		local currentCFrames = {}
		for name, part in pairs(parts) do
			local originalPart = char:FindFirstChild(name)
			if originalPart then
				currentCFrames[name] = originalPart.CFrame
			end
		end
		
		table.insert(cframeHistory, {
			time = currentTime,
			cframes = currentCFrames
		})
		
		for i = #cframeHistory, 1, -1 do
			if currentTime - cframeHistory[i].time > 1 then
				table.remove(cframeHistory, i)
			end
		end
		
		while #cframeHistory > historyMaxSize do
			table.remove(cframeHistory, 1)
		end
		
		if #cframeHistory > 1 then
			local targetTime = currentTime - targetDelay
			local closestFrame = nil
			local closestDiff = math.huge
			
			for i = 1, #cframeHistory do
				local frame = cframeHistory[i]
				local timeDiff = math.abs(frame.time - targetTime)
				if timeDiff < closestDiff then
					closestDiff = timeDiff
					closestFrame = frame
				end
			end
			
			if closestFrame then
				for name, part in pairs(parts) do
					if closestFrame.cframes[name] then
						part.CFrame = part.CFrame:Lerp(closestFrame.cframes[name], 0.9)
					end
				end
			end
		end
	end)
end

LocalPlayer.CharacterAdded:Connect(function(character)
	local oldClone = workspace:FindFirstChild("DelayedClone")
	if oldClone then
		oldClone:Destroy()
	end
	
	task.wait(1)
	createDelayedClone()
end)

LocalPlayer.CharacterRemoving:Connect(function()
	local oldClone = workspace:FindFirstChild("DelayedClone")
	if oldClone then
		oldClone:Destroy()
	end
end)

if LocalPlayer.Character then
	createDelayedClone()
end
