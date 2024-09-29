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

for _, part in pairs(partsFolder:GetChildren()) do
    if part:IsA("Part") and (part.Name == "Window" or part.Name == "WindowBezel") then
        part.CanCollide = false
        part.Transparency = 0.7
        part.BrickColor = BrickColor.new("Bright blue")
    end
end
