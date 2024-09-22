local workspace = game:GetService("Workspace")
local excludedModel = "i_FillKidsWithC3m" -- Lazy so only I am excluded
local highlightFolder = Instance.new("Folder", workspace)

--> Billboard GUI (Name)
local function createBillboardGui(part, modelName)
    if not part:FindFirstChild("NameTag") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Name = "NameTag"
        billboardGui.Adornee = part
        billboardGui.Size = UDim2.new(5, 0, 1, 0)
        billboardGui.StudsOffset = Vector3.new(0, 2, 0)
        billboardGui.Parent = part

        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.Text = modelName
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextStrokeTransparency = 0
        textLabel.Font = Enum.Font.SourceSansBold
        textLabel.TextScaled = true
        textLabel.Parent = billboardGui
    end
end

--> Highlight the parts
local function highlightParts(model)
    if model.Name ~= excludedModel then
        -- Highlight Head
        local headPart = model:FindFirstChild("Head")
        if headPart and headPart:IsA("Part") then
            if not headPart:FindFirstChild("Highlight") then
                local headHighlight = Instance.new("Highlight")
                headHighlight.Adornee = headPart
                headHighlight.Parent = headPart
                headHighlight.FillColor = Color3.fromRGB(255, 255, 0)
                headHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                headHighlight.FillTransparency = 0.5
                headHighlight.OutlineTransparency = 0
                headPart.CanCollide = false
                headPart.Transparency = 0
                createBillboardGui(headPart, model.Name)
            end
        end

        -- Highlight Torso
        local torsoPart = model:FindFirstChild("Torso")
        if torsoPart and torsoPart:IsA("Part") then
            if not torsoPart:FindFirstChild("Highlight") then
                local torsoHighlight = Instance.new("Highlight")
                torsoHighlight.Adornee = torsoPart
                torsoHighlight.Parent = torsoPart
                torsoHighlight.FillColor = Color3.fromRGB(255, 255, 0)
                torsoHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                torsoHighlight.FillTransparency = 0.5
                torsoHighlight.OutlineTransparency = 0
                torsoPart.CanCollide = false
                torsoPart.Transparency = 0
            end
        end

        -- Highlight Right Arm
        local rArm = model:FindFirstChild("Right Arm")
        if rArm and rArm:IsA("Part") then
            if not rArm:FindFirstChild("Highlight") then
                local rArmHighlight = Instance.new("Highlight")
                rArmHighlight.Adornee = rArm
                rArmHighlight.Parent = rArm
                rArmHighlight.FillColor = Color3.fromRGB(255, 255, 0)
                rArmHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                rArmHighlight.FillTransparency = 0.5
                rArmHighlight.OutlineTransparency = 0
                rArm.CanCollide = false
                rArm.Transparency = 0
            end
        end

        -- Highlight Left Arm
        local lArm = model:FindFirstChild("Left Arm")
        if lArm and lArm:IsA("Part") then
            if not lArm:FindFirstChild("Highlight") then
                local lArmHighlight = Instance.new("Highlight")
                lArmHighlight.Adornee = lArm
                lArmHighlight.Parent = lArm
                lArmHighlight.FillColor = Color3.fromRGB(255, 255, 0)
                lArmHighlight.OutlineColor = Color3.fromRGB(255, 255, 255)
                lArmHighlight.FillTransparency = 0.5
                lArmHighlight.OutlineTransparency = 0
                lArm.CanCollide = false
                lArm.Transparency = 0
            end
        end
    end
end

local function checkAndHighlight()
    for _, object in ipairs(workspace:GetChildren()) do
        if object:IsA("Model") then
            highlightParts(object)
        end
    end
end

while true do
    checkAndHighlight()
    wait(1)
end
