local function createBillboard(model)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ModelNameGui"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 100, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 3, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.TextStrokeTransparency = 0.8
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    textLabel.Text = model.Name

    textLabel.Parent = billboard
    billboard.Parent = model:FindFirstChild("Head") or model.PrimaryPart
end

local function checkAndAttachBillboards()
    for _, player in pairs(game.Players:GetPlayers()) do
        local character = player.Character
        if character and not character:FindFirstChild("ModelNameGui") then
            createBillboard(character)
        end
    end
end

while true do
    checkAndAttachBillboards()
    wait(10)
end

game.Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)
        if not character:FindFirstChild("ModelNameGui") then
            createBillboard(character)
        end
    end)
end)
