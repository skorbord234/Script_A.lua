-- [[ UNIVERSAL SCRIPT HUB - V10 ]] --
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")

if CoreGui:FindFirstChild("MyScriptHub") then
    CoreGui.MyScriptHub:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyScriptHub"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 550)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Active = true
MainFrame.Draggable = true 
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

-- Header
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Title.Text = "   DEVELOPER SUITE V10"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame
Instance.new("UICorner", Title)

-- Main Exit Button
local MainExit = Instance.new("TextButton")
MainExit.Size = UDim2.new(0, 30, 0, 30)
MainExit.Position = UDim2.new(1, -40, 0, 10)
MainExit.BackgroundColor3 = Color3.fromRGB(200, 60, 60)
MainExit.Text = "X"
MainExit.TextColor3 = Color3.fromRGB(255, 255, 255)
MainExit.Font = Enum.Font.GothamBold
MainExit.Parent = MainFrame
Instance.new("UICorner", MainExit).CornerRadius = UDim.new(1, 0)
MainExit.MouseButton1Click:Connect(function() ScreenGui:Destroy() end)

-- Scrolling Container
local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -30, 1, -80)
Container.Position = UDim2.new(0, 15, 0, 65)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 4
Container.Parent = MainFrame
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = Container
UIListLayout.Padding = UDim.new(0, 12)

-----------------------------------------------------------
-- DYNAMIC BUTTON SYSTEM
-----------------------------------------------------------
local function AddScriptButton(name, startFunc, stopFunc)
    local Frame = Instance.new("Frame")
    Frame.Size = UDim2.new(1, -10, 0, 55)
    Frame.BackgroundTransparency = 1
    Frame.Parent = Container

    local RunBtn = Instance.new("TextButton")
    RunBtn.Size = UDim2.new(0.8, -10, 1, 0)
    RunBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    RunBtn.Text = "Load " .. name
    RunBtn.TextColor3 = Color3.fromRGB(230, 230, 230)
    RunBtn.Font = Enum.Font.GothamMedium
    RunBtn.TextSize = 16
    RunBtn.Parent = Frame
    Instance.new("UICorner", RunBtn).CornerRadius = UDim.new(0, 6)

    local ClearBtn = Instance.new("TextButton")
    ClearBtn.Size = UDim2.new(0.2, 0, 1, 0)
    ClearBtn.Position = UDim2.new(0.8, 0, 0, 0)
    ClearBtn.BackgroundColor3 = Color3.fromRGB(80, 30, 30)
    ClearBtn.Text = "CLEAR"
    ClearBtn.TextColor3 = Color3.fromRGB(255, 100, 100)
    ClearBtn.Font = Enum.Font.GothamBold
    ClearBtn.TextSize = 10
    ClearBtn.Parent = Frame
    Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 6)

    RunBtn.MouseButton1Click:Connect(function()
        RunBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        RunBtn.Text = name .. " [ACTIVE]"
        task.spawn(startFunc)
    end)

    ClearBtn.MouseButton1Click:Connect(function()
        RunBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        RunBtn.Text = "Load " .. name
        if stopFunc then stopFunc() end
    end)
end

-----------------------------------------------------------
-- 1. BACK TP
-----------------------------------------------------------
local tpConn
AddScriptButton("Back TP", function()
    if tpConn then tpConn:Disconnect() end
    tpConn = UIS.InputBegan:Connect(function(input, gpe)
        if gpe then return end
        if input.UserInputType == Enum.UserInputType.MouseButton2 then
            local lp = game.Players.LocalPlayer
            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local closest, dist = nil, math.huge
            for _, p in ipairs(game.Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d closest = p end
                end
            end
            if closest then hrp.CFrame = closest.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
        end
    end)
end, function()
    if tpConn then tpConn:Disconnect() tpConn = nil end
end)

-----------------------------------------------------------
-- 2. JJS
-----------------------------------------------------------
local jjsConn
AddScriptButton("jjs", function()
    if jjsConn then jjsConn:Disconnect() end
    jjsConn = UIS.InputBegan:Connect(function(input, gpe)
        if gpe or input.KeyCode ~= Enum.KeyCode.V then return end
        local hrp = game.Players.LocalPlayer.Character.HumanoidRootPart
        local start = hrp.CFrame
        local flat = Vector3.new(start.LookVector.X, 0, start.LookVector.Z).Unit
        local info = TweenInfo.new(0.8, Enum.EasingStyle.Sine)
        TS:Create(hrp, info, {CFrame = start + Vector3.new(0, 120, 0)}):Play() task.wait(0.8)
        TS:Create(hrp, info, {CFrame = hrp.CFrame + (flat * 450)}):Play() task.wait(0.8)
        task.wait(2.5)
        TS:Create(hrp, info, {CFrame = start + Vector3.new(0, 120, 0)}):Play() task.wait(0.8)
        local ray = workspace:Raycast(hrp.Position, Vector3.new(0, -2000, 0))
        local gy = ray and ray.Position.Y or start.Position.Y
        local fin = Vector3.new(start.Position.X, gy + 50, start.Position.Z)
        TS:Create(hrp, info, {CFrame = CFrame.new(fin, fin + flat)}):Play()
    end)
end, function()
    if jjsConn then jjsConn:Disconnect() jjsConn = nil end
end)

-----------------------------------------------------------
-- 3. GHOST (UPDATED)
-----------------------------------------------------------
local ghostActive = false
local ghostInput, renderAnchor
local rotX, rotY = 0, 0
local currentCamPos = Vector3.new(0,0,0)

local function setGhostVisuals(char, isGhost)
    local transparency = isGhost and 1 or 0
    for _, part in pairs(char:GetDescendants()) do
        if part:IsA("BasePart") or part:IsA("Decal") then
            if part.Name ~= "HumanoidRootPart" then
                part.Transparency = transparency
            end
        end
    end
end

AddScriptButton("Ghost", function()
    local player = game.Players.LocalPlayer
    local camera = workspace.CurrentCamera
    
    if ghostInput then ghostInput:Disconnect() end
    
    ghostInput = UIS.InputBegan:Connect(function(input, proc)
        if proc then return end
        if input.KeyCode == Enum.KeyCode.V then
            local char = player.Character
            local root = char and char:FindFirstChild("HumanoidRootPart")
            local hum = char and char:FindFirstChild("Humanoid")
            if not root or not hum then return end

            ghostActive = not ghostActive
            
            if ghostActive then
                if not renderAnchor then
                    renderAnchor = Instance.new("Part")
                    renderAnchor.Transparency = 1
                    renderAnchor.CanCollide = false
                    renderAnchor.Anchored = true
                    renderAnchor.Parent = workspace
                end

                setGhostVisuals(char, true)
                currentCamPos = camera.CFrame.Position
                hum.PlatformStand = true
                
                local hideLocation = root.Position - Vector3.new(0, 500, 0)
                root.CFrame = CFrame.new(hideLocation)
                
                camera.CameraType = Enum.CameraType.Scriptable
                camera.CameraSubject = nil 
                player.ReplicationFocus = renderAnchor
                
                local look = camera.CFrame.LookVector
                rotY = math.atan2(-look.X, -look.Z)
                rotX = math.asin(look.Y)

                RunService:BindToRenderStep("GhostForce", 2001, function(dt)
                    root.Velocity = Vector3.zero
                    root.CFrame = CFrame.new(hideLocation)
                    UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
                    
                    local delta = UIS:GetMouseDelta()
                    rotY = rotY - (delta.X * 0.75 / 100) 
                    rotX = rotX - (delta.Y * 0.75 / 100)
                    rotX = math.clamp(rotX, -math.rad(80), math.rad(80))

                    local rotation = CFrame.Angles(0, rotY, 0) * CFrame.Angles(rotX, 0, 0)
                    local moveDir = Vector3.zero
                    if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += Vector3.new(0,0,-1) end
                    if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir += Vector3.new(0,0,1) end
                    if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir += Vector3.new(-1,0,0) end
                    if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += Vector3.new(1,0,0) end
                    
                    local vertical = 0
                    if UIS:IsKeyDown(Enum.KeyCode.Space) then vertical += 1 end
                    if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vertical -= 1 end

                    local multiplier = UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 2 or 1
                    local worldMove = rotation:VectorToWorldSpace(moveDir)
                    local finalMove = worldMove + Vector3.new(0, vertical, 0)
                    
                    if finalMove.Magnitude > 0 then
                        currentCamPos = currentCamPos + (finalMove.Unit * 50 * multiplier * dt)
                    end
                    
                    renderAnchor.CFrame = CFrame.new(currentCamPos)
                    camera.CFrame = CFrame.new(currentCamPos) * rotation
                    camera.Focus = camera.CFrame
                end)
            else
                RunService:UnbindFromRenderStep("GhostForce")
                player.ReplicationFocus = nil
                root.CFrame = camera.CFrame
                camera.CameraSubject = hum
                camera.CameraType = Enum.CameraType.Custom
                hum.PlatformStand = false
                setGhostVisuals(char, false)
                UIS.MouseBehavior = Enum.MouseBehavior.Default
            end
        end
    end)
end, function()
    -- CLEAR GHOST
    RunService:UnbindFromRenderStep("GhostForce")
    if ghostInput then ghostInput:Disconnect() ghostInput = nil end
    if renderAnchor then renderAnchor:Destroy() renderAnchor = nil end
    ghostActive = false
    
    local char = game.Players.LocalPlayer.Character
    if char then
        local hum = char:FindFirstChild("Humanoid")
        if hum then 
            hum.PlatformStand = false 
            workspace.CurrentCamera.CameraSubject = hum
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
        end
        setGhostVisuals(char, false)
    end
    UIS.MouseBehavior = Enum.MouseBehavior.Default
end)

-----------------------------------------------------------
-- 4. SNAPPY FLY
-----------------------------------------------------------
local flyInputConn, isFlying = nil, false
local bv, bg, targetVelocity = nil, nil, Vector3.new(0,0,0)

local function stopSnappyFly()
    isFlying = false
    RunService:UnbindFromRenderStep("SmoothFly")
    if bv then bv:Destroy() bv = nil end
    if bg then bg:Destroy() bg = nil end
    local lp = game.Players.LocalPlayer
    if lp.Character and lp.Character:FindFirstChild("Humanoid") then
        lp.Character.Humanoid.PlatformStand = false
    end
    targetVelocity = Vector3.new(0,0,0)
end

AddScriptButton("fly", function()
    if flyInputConn then flyInputConn:Disconnect() end
    flyInputConn = UIS.InputBegan:Connect(function(input, gpe)
        if gpe or input.KeyCode ~= Enum.KeyCode.B then return end
        isFlying = not isFlying
        
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        local cam = workspace.CurrentCamera
        
        if isFlying and root and hum then
            hum.PlatformStand = true
            bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bv.Velocity = Vector3.new(0,0,0)
            bg = Instance.new("BodyGyro", root)
            bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
            bg.D, bg.P = 100, 5000

            RunService:BindToRenderStep("SmoothFly", 200, function()
                if not isFlying or not root then return end
                bg.CFrame = cam.CFrame
                local moveDir = Vector3.new(0,0,0)
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= cam.CFrame.LookVector end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= cam.CFrame.RightVector end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += cam.CFrame.RightVector end
                local vert = UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or (UIS:IsKeyDown(Enum.KeyCode.LeftControl) and -1 or 0)
                local rawVelocity = (moveDir + Vector3.new(0, vert, 0))
                if rawVelocity.Magnitude > 0 then targetVelocity = rawVelocity.Unit * 70 else targetVelocity = Vector3.new(0,0,0) end
                bv.Velocity = bv.Velocity:Lerp(targetVelocity, 0.4)
            end)
        else
            stopSnappyFly()
        end
    end)
end, function()
    if flyInputConn then flyInputConn:Disconnect() flyInputConn = nil end
    stopSnappyFly()
end)

-----------------------------------------------------------
-- 5. NOCLIP
-----------------------------------------------------------
local noclipInputConn, noclipLoopConn, isNoclipActive = nil, nil, false

local function stopNoclip()
    isNoclipActive = false
    if noclipLoopConn then noclipLoopConn:Disconnect() noclipLoopConn = nil end
    local char = game.Players.LocalPlayer.Character
    if char then
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then root.CanCollide = true end
    end
end

AddScriptButton("noclip", function()
    if noclipInputConn then noclipInputConn:Disconnect() end
    noclipInputConn = UIS.InputBegan:Connect(function(input, gpe)
        if gpe or input.KeyCode ~= Enum.KeyCode.X then return end
        isNoclipActive = not isNoclipActive
        if isNoclipActive then
            noclipLoopConn = RunService.Stepped:Connect(function()
                if not isNoclipActive or not game.Players.LocalPlayer.Character then return end
                for _, part in pairs(game.Players.LocalPlayer.Character:GetDescendants()) do
                    if part:IsA("BasePart") then part.CanCollide = false end
                end
            end)
        else
            stopNoclip()
        end
    end)
end, function()
    if noclipInputConn then noclipInputConn:Disconnect() noclipInputConn = nil end
    stopNoclip()
end)

-----------------------------------------------------------
-- 6. JUMP AND SPEED
-----------------------------------------------------------
local jsPopUp
local currentWS = 16
local currentJP = 50

AddScriptButton("jump and speed", function()
    local player = game.Players.LocalPlayer
    if jsPopUp then jsPopUp.Enabled = true return end

    jsPopUp = Instance.new("ScreenGui", player.PlayerGui)
    jsPopUp.Name = "JSPopup"
    jsPopUp.ResetOnSpawn = false
    
    local f = Instance.new("Frame", jsPopUp)
    f.Size, f.Position, f.BackgroundColor3 = UDim2.new(0,220,0,160), UDim2.new(0.5,-110,0.5,-80), Color3.fromRGB(25,25,25)
    f.Active, f.Draggable = true, true
    Instance.new("UICorner", f)

    local function createSlider(name, pos, min, max, currentVal, cb)
        local l = Instance.new("TextLabel", f)
        l.Size, l.Position, l.Text, l.TextColor3, l.BackgroundTransparency = UDim2.new(1,0,0,20), pos, name..": "..currentVal, Color3.new(1,1,1), 1
        local b = Instance.new("Frame", f)
        b.Size, b.Position, b.BackgroundColor3 = UDim2.new(0.8,0,0,6), pos+UDim2.new(0.1,0,0,25), Color3.fromRGB(50,50,50)
        local s = Instance.new("TextButton", b)
        s.Size, s.Position, s.BackgroundColor3 = UDim2.new(0,16,0,16), UDim2.new((currentVal-min)/(max-min),-8,0.5,-8), Color3.fromRGB(0,200,255)
        s.Text = "" Instance.new("UICorner", s).CornerRadius = UDim.new(1,0)
        
        local drag = false
        s.MouseButton1Down:Connect(function() drag = true end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then drag = false end end)
        
        RunService.RenderStepped:Connect(function()
            if drag then
                local p = math.clamp((UIS:GetMouseLocation().X - b.AbsolutePosition.X)/b.AbsoluteSize.X, 0, 1)
                s.Position = UDim2.new(p,-8,0.5,-8)
                local v = math.floor(min + (p*(max-min)))
                l.Text = name..": "..v 
                cb(v)
            end
        end)
    end

    createSlider("WalkSpeed", UDim2.new(0,0,0,25), 16, 300, currentWS, function(v) 
        currentWS = v
        if player.Character and player.Character:FindFirstChild("Humanoid") then 
            player.Character.Humanoid.WalkSpeed = v 
        end 
    end)
    
    createSlider("JumpPower", UDim2.new(0,0,0,85), 50, 600, currentJP, function(v) 
        currentJP = v
        if player.Character and player.Character:FindFirstChild("Humanoid") then 
            player.Character.Humanoid.UseJumpPower = true 
            player.Character.Humanoid.JumpPower = v 
        end 
    end)
end, function()
    local player = game.Players.LocalPlayer
    currentWS, currentJP = 16, 50
    if player.Character and player.Character:FindFirstChild("Humanoid") then
        player.Character.Humanoid.WalkSpeed = 16
        player.Character.Humanoid.JumpPower = 50
    end
    if jsPopUp then jsPopUp:Destroy() jsPopUp = nil end
end)
