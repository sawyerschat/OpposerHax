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
    CFrame.new(130.983444, -38.2739983, 134.79245),
    CFrame.new(106.490067, -38.2739983, 112.792458),
    CFrame.new(101.009766, -38.2739983, 120.107483),
    CFrame.new(101.218964, -38.2818336, 140.947723),
    CFrame.new(101.218964, -40.977562, 149.925278),
    CFrame.new(120.100098, -36.4739799, 154.795334),
    CFrame.new(101.218964, -38.2737198, 154.591751),
    CFrame.new(111.103683, -38.2739983, 154.795334),
    CFrame.new(128.783493, -38.2739983, 154.795334),
    CFrame.new(126.039375, -38.2739983, 112.792458),
    CFrame.new(101.218964, -40.977562, 149.925278),
    CFrame.new(120.100113, -38.4749908, 154.800003),
    CFrame.new(106.022583, -40.9775581, 154.795334)
}

local fenceTargets = {

}

local function isCFrameClose(cframe1, cframe2, threshold)
    return (cframe1.Position - cframe2.Position).magnitude < threshold
end

for _, part in pairs(partsFolder:GetChildren()) do
    if part:IsA("Part") then
        for _, targetCFrame in pairs(targetCFrames) do
            if isCFrameClose(part.CFrame, targetCFrame, 0.1) then
                part.CanCollide = false
                part.Transparency = 0.7
                part.BrickColor = BrickColor.new("Bright blue")
                print("Modded CFrame: " .. tostring(targetCFrame))
            end
        end
    end
end

local fencesFolder = workspace:FindFirstChild("Map"):FindFirstChild("Content"):FindFirstChild("Models"):FindFirstChild("Fences")
if fencesFolder then
    for _, fence in pairs(fencesFolder:GetChildren()) do
        if fence:IsA("Part") and fence.Name == "Fence" then
            fence.CanCollide = false
            fence.BrickColor = BrickColor.new("Bright blue")
            print("Modded Fence: " .. fence.Name)
        end
    end
else
    print("detected")
end
