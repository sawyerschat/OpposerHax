local function setFenceProperties()
    local fencesFolder = workspace:FindFirstChild("Map"):FindFirstChild("Content"):FindFirstChild("Models"):FindFirstChild("Fences")

    if fencesFolder then
        for _, model in pairs(fencesFolder:GetChildren()) do
            if model:IsA("Model") and model.Name == "Fence" then
                for _, part in pairs(model:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                        part.BrickColor = BrickColor.new("Bright blue")
                        part.Transparency = 0.7
                    end
                end
            end
        end
    end
end

local function setACProperties()
    local partsFolder = workspace:FindFirstChild("Map"):FindFirstChild("Content"):FindFirstChild("Parts")

    if partsFolder then
        for _, part in pairs(partsFolder:GetChildren()) do
            if part:IsA("BasePart") and part.Name == "AC" then
                part.CanCollide = false
                part.BrickColor = BrickColor.new("Bright blue")
                part.Transparency = 0.7
            end
        end
    end
end

setFenceProperties()
setACProperties()
