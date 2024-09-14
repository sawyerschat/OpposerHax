local player = game.Players.LocalPlayer

local function createLaser(character)
    local rightArm = character:WaitForChild("Right Arm")
    print("Character and right arm found")

    local startAttachment = Instance.new("Attachment")
    startAttachment.Name = "LaserStart"
    startAttachment.Position = Vector3.new(0, -rightArm.Size.Y/2, 0)
    startAttachment.Parent = rightArm
    print("Start attachment created")

    local endAttachment = Instance.new("Attachment")
    endAttachment.Name = "LaserEnd"
    endAttachment.Position = Vector3.new(0, -rightArm.Size.Y/2 - 1000, 100)
    endAttachment.Parent = rightArm
    print("End attachment created")

    local beam = Instance.new("Beam")
    beam.Name = "Lazers204"
    beam.Attachment0 = startAttachment
    beam.Attachment1 = endAttachment
    beam.Width0 = 0.1
    beam.Width1 = 0.1
    beam.FaceCamera = true
    beam.Color = ColorSequence.new(Color3.fromRGB(0, 0, 255))
    beam.Transparency = NumberSequence.new(0.5)
    beam.Parent = rightArm
    print("Beam created and parented")

    local function updateBeamEnd()
        local armCFrame = rightArm.CFrame
        local rotatedCFrame = armCFrame * CFrame.Angles(math.rad(90), 0, 0)
        
        local startPos = armCFrame * startAttachment.Position
        local endPos = startPos - rotatedCFrame.LookVector * 1000 + Vector3.new(0, -5, 0)

        local relativeEndPos = rightArm.CFrame:ToObjectSpace(CFrame.new(endPos)).Position
        endAttachment.Position = relativeEndPos
    end

    game:GetService("RunService").RenderStepped:Connect(updateBeamEnd)
    print("Beam update function connected")
end

local function onCharacterAdded(character)
    createLaser(character)
end
if player.Character then
    onCharacterAdded(player.Character)
end
player.CharacterAdded:Connect(onCharacterAdded)
