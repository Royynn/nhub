local espTransparency = 0.5

COREGUI = game:GetService("CoreGui")

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
