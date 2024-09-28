local workspace = game:GetService("Workspace")
local Players = game:GetService("Players")

local playersFolder = workspace:FindFirstChild("Players")
if not playersFolder then
    playersFolder = Instance.new("Folder")
    playersFolder.Name = "Players"
    playersFolder.Parent = workspace
end

local function createRainbowBillboardGui(part, playerName)
    if not part:FindFirstChild("PlayerTag") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "PlayerTag"
        billboardGui.Adornee = part
        billboardGui.Size = UDim2.new(0, 200, 0, 50)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.AlwaysOnTop = true
        billboardGui.Parent = part

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Text = playerName .. " | Player"
        textLabel.BackgroundTransparency = 1
        textLabel.TextStrokeTransparency = 0
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextScaled = true
        textLabel.Parent = billboardGui
        spawn(function()
            local hue = 0
            while true do
                textLabel.TextColor3 = Color3.fromHSV(hue, 1, 1)
                hue = (hue + 0.01) % 1
                wait(0.03)
            end
        end)
    end
end

local function processPlayerModel(model)
    if model:IsA("Model") and model:FindFirstChild("Humanoid") then
        local player = Players:GetPlayerFromCharacter(model)
        if player then
            model.Parent = playersFolder
            local head = model:FindFirstChild("Head")
            if head then
                createRainbowBillboardGui(head, player.Name)
            end
        end
    end
end

local function checkAndProcessModels()
    for _, object in ipairs(workspace:GetChildren()) do
        if object:IsA("Model") and object.Parent == workspace then
            processPlayerModel(object)
        end
    end
end

checkAndProcessModels()

workspace.ChildAdded:Connect(processPlayerModel)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        wait(1)
        processPlayerModel(character)
    end)
end)
