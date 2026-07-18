local Event = game:GetService("ReplicatedStorage").Events.TotemShopPurchaseEvent

while wait(60) do
    Event:FireServer("Frostbound")
end
