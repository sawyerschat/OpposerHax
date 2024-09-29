local mapFolder = workspace:FindFirstChild("Map")
if not mapFolder then
    warn("detected")
    return
end

local contentFolder = mapFolder:FindFirstChild("Content")
if not contentFolder then
    warn("detected")
    return
end

local partsFolder = contentFolder:FindFirstChild("Parts")
if not partsFolder then
    warn("detected")
    return
end

local targetCFrame = CFrame.new(-88.00000762939453, 7.399999618530273, 57.50001525878906, -1, 0, 0, 0, 1, 0, 0, 0, -1)

for _, part in pairs(partsFolder:GetChildren()) do
    if part:IsA("Part") and part.Name == "Smooth Block Model" then
        if part.CFrame == targetCFrame then
            part.CanCollide = false
            part.Transparency = 0.6
        end
    end
end
