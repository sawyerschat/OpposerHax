local cratesFolder = workspace:WaitForChild("Map"):WaitForChild("Content"):WaitForChild("Models"):WaitForChild("Crates")

local function createBillboard(crate)
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CrateNameGui"
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 100, 0, 25)
    billboard.StudsOffset = Vector3.new(0, 3, 0)

    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextScaled = true
    textLabel.TextStrokeTransparency = 0.8
    textLabel.Font = Enum.Font.SourceSansBold
    textLabel.TextColor3 = Color3.fromRGB(128, 0, 128)

    local content = crate:GetAttribute("Content")
    if content then
        textLabel.Text = "Crate | " .. content
    else
        textLabel.Text = " "
    end

    textLabel.Parent = billboard
    billboard.Parent = crate:FindFirstChild("Head") or crate.PrimaryPart
end

for _, crate in pairs(cratesFolder:GetChildren()) do
    if crate:IsA("Model") and crate.Name == "Crate" then
        createBillboard(crate)
    end
end
