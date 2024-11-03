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

local whiteItemNames = {
    "Radio",
    "Super Shotgun",
    "Knife",
    "Desert Eagle"
}

local secretItemNames = {
    "Plush"
}

local function createBillboard(model, colorMode)
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

    if colorMode == "white" then
        textLabel.TextColor3 = Color3.new(1, 1, 1) -- White color
    elseif colorMode == "rainbow" then
        local hue = 0
        game:GetService("RunService").RenderStepped:Connect(function()
            hue = (hue + 0.01) % 1
            textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
        end)
    elseif colorMode == "secret" then
        local t = 0
        game:GetService("RunService").RenderStepped:Connect(function()
            t = t + 0.02
            local r = math.abs(math.sin(t)) -- Red
            local g = math.abs(math.sin(t + 2)) -- Green
            local b = math.abs(math.sin(t + 4)) -- Blue
            textLabel.TextColor3 = Color3.new(r, g, b)
        end)
    end

    textLabel.Parent = billboard
    billboard.Parent = model:FindFirstChild("Head") or model.PrimaryPart
end

for _, model in pairs(itemsFolder:GetChildren()) do
    if table.find(pistolNames, model.Name) and model:IsA("Model") then
        createBillboard(model, "rainbow") -- Rainbow for pistols
    elseif table.find(whiteItemNames, model.Name) and model:IsA("Model") then
        createBillboard(model, "white") -- White for Radio and Super Shotgun
    elseif table.find(secretItemNames, model.Name) and model:IsA("Model") then
        createBillboard(model, "secret") -- Red to blue to green animation for secret items
    end
end
