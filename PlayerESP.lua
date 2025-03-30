local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Function to create player display with kills and health
local function createPlayerDisplay(player)
    if not player.Character then return end
    local head = player.Character:FindFirstChild("Head")
    if not head then return end
    local humanoid = player.Character:FindFirstChild("Humanoid")
    if not humanoid then return end
    
    -- Check if display already exists
    if head:FindFirstChild("PlayerDisplayGui") then return end
    
    -- Create BillboardGui (smaller size)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerDisplayGui"
    billboard.Size = UDim2.new(0, 120, 0, 35) -- Even smaller size
    billboard.Adornee = head
    billboard.AlwaysOnTop = true
    billboard.StudsOffset = Vector3.new(0, 1.6, 0) -- Slightly lower
    billboard.Parent = head
    
    -- Create main container
    local container = Instance.new("Frame")
    container.Size = UDim2.new(1, 0, 1, 0)
    container.BackgroundTransparency = 1
    container.Parent = billboard
    
    -- Health bar background (behind everything)
    local healthBarBg = Instance.new("Frame")
    healthBarBg.Name = "HealthBarBg"
    healthBarBg.Size = UDim2.new(0.85, 0, 0.28, 0)
    healthBarBg.Position = UDim2.new(0.075, 0, 0.68, 0)
    healthBarBg.BackgroundColor3 = Color3.new(0.15, 0.15, 0.15) -- Darker background
    healthBarBg.BorderSizePixel = 0
    healthBarBg.ZIndex = 1
    healthBarBg.Parent = container
    
    -- Make health bar background rounded - fixing the roundness issue
    local bgCorner = Instance.new("UICorner")
    bgCorner.CornerRadius = UDim.new(0, 4) -- Using pixel value for consistent roundness
    bgCorner.Parent = healthBarBg
    
    -- Health bar outline
    local healthBarOutline = Instance.new("UIStroke")
    healthBarOutline.Thickness = 1.2
    healthBarOutline.Color = Color3.new(0.7, 0.7, 0.7) -- Light gray outline
    healthBarOutline.Parent = healthBarBg
    
    -- Health bar fill
    local healthBar = Instance.new("Frame")
    healthBar.Name = "HealthBar"
    healthBar.Size = UDim2.new(1, 0, 1, 0)
    healthBar.BackgroundColor3 = Color3.fromRGB(40, 180, 70) -- Nicer green color
    healthBar.BorderSizePixel = 0
    healthBar.ZIndex = 2
    healthBar.ClipsDescendants = true -- Ensure the fill stays within rounded corners
    healthBar.Parent = healthBarBg
    
    -- Make health bar fill rounded (same corners as background)
    local fillCorner = Instance.new("UICorner")
    fillCorner.CornerRadius = UDim.new(0, 4) -- Using pixel value for consistent roundness
    fillCorner.Parent = healthBar
    
    -- Add gradient to health bar
    local gradient = Instance.new("UIGradient")
    gradient.Rotation = 90
    gradient.Transparency = NumberSequence.new({
        NumberSequenceKeypoint.new(0, 0),
        NumberSequenceKeypoint.new(1, 0.3)
    })
    gradient.Parent = healthBar
    
    -- Create the red dot
    local dotContainer = Instance.new("Frame")
    dotContainer.Size = UDim2.new(0, 14, 0, 14) -- Smaller dot
    dotContainer.Position = UDim2.new(0.05, 0, 0.22, 0)
    dotContainer.BackgroundTransparency = 1
    dotContainer.ZIndex = 3
    dotContainer.Parent = container
    
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(1, 0, 1, 0)
    dot.BackgroundColor3 = Color3.fromRGB(230, 50, 50) -- Nicer red
    dot.BackgroundTransparency = 0
    dot.BorderSizePixel = 0
    dot.ZIndex = 3
    dot.Parent = dotContainer
    
    -- Add subtle gradient to dot
    local dotGradient = Instance.new("UIGradient")
    dotGradient.Rotation = 45
    dotGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 80, 80)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 30, 30))
    })
    dotGradient.Parent = dot
    
    -- Make the dot rounded
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(1, 0) -- Fully rounded (circle)
    corner.Parent = dot
    
    -- Create text label for kills and username with improved font
    local infoText = Instance.new("TextLabel")
    infoText.Name = "InfoText"
    infoText.Size = UDim2.new(0.85, 0, 0.4, 0)
    infoText.Position = UDim2.new(0.17, 0, 0.2, 0)
    infoText.BackgroundTransparency = 1
    infoText.TextColor3 = Color3.fromRGB(255, 255, 255) -- White text
    infoText.TextStrokeTransparency = 0.5
    infoText.TextStrokeColor3 = Color3.new(0, 0, 0)
    infoText.TextSize = 11 -- Smaller text
    infoText.Font = Enum.Font.GothamBold -- Nicer font
    infoText.TextXAlignment = Enum.TextXAlignment.Left
    infoText.ZIndex = 3
    infoText.Parent = container
    
    -- Function to update hitbox parts for player
    local function updateHitboxes(character)
        if not character then return end
        
        -- Update TorsoHitbox
        local torsoHitbox = character:FindFirstChild("TorsoHitbox")
        if torsoHitbox then
            torsoHitbox.Transparency = 0
            torsoHitbox.Color = Color3.fromRGB(230, 50, 50) -- Red color
            
            -- Add highlight to TorsoHitbox if it doesn't have one
            if not torsoHitbox:FindFirstChild("Highlight") then
                local highlight = Instance.new("Highlight")
                highlight.Name = "Highlight"
                highlight.FillColor = Color3.fromRGB(230, 50, 50)
                highlight.OutlineColor = Color3.fromRGB(255, 150, 150)
                highlight.FillTransparency = 0.5
                highlight.OutlineTransparency = 0
                highlight.Parent = torsoHitbox
            end
        end
        
        -- Update LocoSphere
        local locoSphere = character:FindFirstChild("LocoSphere")
        if locoSphere then
            locoSphere.Transparency = 0
        end
        
        -- Update HeadCollide
        local headCollide = character:FindFirstChild("HeadCollide")
        if headCollide then
            headCollide.Transparency = 0
        end
    end
    
    -- Initial hitbox update
    updateHitboxes(player.Character)
    
    -- Function to update display
    local function updateDisplay()
        if not player or not player.Character or not humanoid then return end
        
        -- Update hitboxes
        updateHitboxes(player.Character)
        
        -- Update health bar (with color based on health percentage)
        local healthPercent = humanoid.Health / humanoid.MaxHealth
        healthBar.Size = UDim2.new(healthPercent, 0, 1, 0)
        
        -- Change health bar color based on health percentage
        if healthPercent < 0.3 then
            -- Low health (red)
            healthBar.BackgroundColor3 = Color3.fromRGB(220, 50, 50)
        elseif healthPercent < 0.6 then
            -- Medium health (yellow)
            healthBar.BackgroundColor3 = Color3.fromRGB(220, 180, 40)
        else
            -- High health (green)
            healthBar.BackgroundColor3 = Color3.fromRGB(40, 180, 70)
        end
        
        -- Get kills from leaderstats
        local killsValue = "0"
        if player:FindFirstChild("leaderstats") then
            local kills = player.leaderstats:FindFirstChild("Kills")
            if kills and kills:IsA("IntValue") then
                killsValue = tostring(kills.Value)
            end
        end
        
        -- Update text with kills and username
        infoText.Text = killsValue .. " Kills | " .. player.Name
    end
    
    -- Set up update connection
    local updateConnection
    updateConnection = RunService.Heartbeat:Connect(function()
        if not player or not player.Character or not player.Character:FindFirstChild("Head") then
            if updateConnection then
                updateConnection:Disconnect()
            end
            return
        end
        updateDisplay()
    end)
    
    -- Character changed connection
    player.CharacterAdded:Connect(function(newCharacter)
        wait(0.5) -- Wait for character to fully load
        updateHitboxes(newCharacter)
    end)
    
    -- Initial update
    updateDisplay()
end

-- Function to update displays on all players
local function updatePlayerDisplays()
    for _, player in pairs(Players:GetPlayers()) do
        if player.Character then
            createPlayerDisplay(player)
        end
    end
end

-- Run update loop
RunService.Heartbeat:Connect(function()
    updatePlayerDisplays()
end)

-- Handle new players joining
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        wait(0.5) -- Slight delay to ensure character loads
        createPlayerDisplay(player)
    end)
end)
