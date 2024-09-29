local mapFolder = workspace:FindFirstChild("Map")
if not mapFolder then
    print("detected")
    return
end

local contentFolder = mapFolder:FindFirstChild("Content")
if not contentFolder then
    print("detected")
    return
end

local partsFolder = contentFolder:FindFirstChild("Parts")
if not partsFolder then
    print("detected")
    return
end

local targetCFrames = {
    CFrame.new(-554.386353, 9.20025635, -1051.24243, -1, 0, 0, 0, 1, 0, 0, 0, -1),
    CFrame.new(-495.386353, 9.20022583, -1019.24243, -1, 0, 0, 0, 1, 0, 0, 0, -1)
}

for _, part in pairs(partsFolder:GetChildren()) do
    if part:IsA("Part") then
        for _, targetCFrame in pairs(targetCFrames) do
            if part.CFrame == targetCFrame then
                part.CanCollide = false
                part.Transparency = 0.7
                print("modded cframe " .. tostring(targetCFrame))
            end
        end
    end
end
