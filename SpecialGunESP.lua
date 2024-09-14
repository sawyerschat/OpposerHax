local itemsFolder = workspace:WaitForChild("Items")
local pistolNames = {
    "Super Pistol",
    "Streamliner",
    "Nuke Pistol",
    "Health Pistol",
    "Flight Pistol",
    "Explosive Pistol",
    "Balloon Gun"
}

local function createBillboard(model)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ItemNameGui"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 70, 0, 17)
    billboard.StudsOffset = Vector3.new(0, 3, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = model.Name
    textLabel.TextScaled = true
    textLabel.TextStrokeTransparency = 0.8
    textLabel.Font = Enum.Font.SourceSansBold

    local hue = 0
    game:GetService("RunService").RenderStepped:Connect(function()
        hue = (hue + 0.01) % 1
        textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
    end)

    textLabel.Parent = billboard
    billboard.Parent = model:FindFirstChild("Head") or model.PrimaryPart
end

for _, model in pairs(itemsFolder:GetChildren()) do
    if table.find(pistolNames, model.Name) and model:IsA("Model") then
        createBillboard(model)
    end
end
