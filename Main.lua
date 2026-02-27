-- [[ UNIVERSAL SCRIPT HUB - V29 ]] --
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")
local TS = game:GetService("TweenService")
local Players = game:GetService("Players")

if CoreGui:FindFirstChild("MyScriptHub") then
    CoreGui.MyScriptHub:Destroy()
end

-----------------------------------------------------------
-- CUSTOM SMOOTH DRAGGING
-----------------------------------------------------------
local function MakeSmooth(Frame)
    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
    Frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = Frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then dragging = false end
            end)
        end
    end)
    Frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    UIS.InputChanged:Connect(function(input)
        if input == dragInput and dragging then update(input) end
    end)
end

-----------------------------------------------------------
-- MAIN UI SETUP
-----------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MyScriptHub"
ScreenGui.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 550)
MainFrame.Position = UDim2.new(0.1, 0, 0.1, 0)
MainFrame.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
MainFrame.Active = true
MainFrame.Parent = ScreenGui
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 10)

MakeSmooth(MainFrame)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(22, 22, 22)
Title.Text = "   DEVELOPER SUITE V29"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = MainFrame
Instance.new("UICorner", Title)

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

local Container = Instance.new("ScrollingFrame")
Container.Size = UDim2.new(1, -30, 1, -80)
Container.Position = UDim2.new(0, 15, 0, 65)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 4
Container.Parent = MainFrame
Instance.new("UIListLayout", Container).Padding = UDim.new(0, 12)

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
    ClearBtn.Parent = Frame
    Instance.new("UICorner", ClearBtn).CornerRadius = UDim.new(0, 6)
    RunBtn.MouseButton1Click:Connect(function()
        RunBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 200)
        task.spawn(startFunc)
    end)
    ClearBtn.MouseButton1Click:Connect(function()
        RunBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        if stopFunc then stopFunc() end
    end)
end

-----------------------------------------------------------
-- 1. BACK TP (R-CLICK)
-----------------------------------------------------------
local tpConn
AddScriptButton("Back TP", function()
    if tpConn then tpConn:Disconnect() end
    tpConn = UIS.InputBegan:Connect(function(input, gpe)
        if not gpe and input.UserInputType == Enum.UserInputType.MouseButton2 then
            local lp = Players.LocalPlayer
            local hrp = lp.Character and lp.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            local closest, dist = nil, math.huge
            for _, p in ipairs(Players:GetPlayers()) do
                if p ~= lp and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                    local d = (hrp.Position - p.Character.HumanoidRootPart.Position).Magnitude
                    if d < dist then dist = d closest = p end
                end
            end
            if closest then hrp.CFrame = closest.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 3) end
        end
    end)
end, function() if tpConn then tpConn:Disconnect() tpConn = nil end end)

-----------------------------------------------------------
-- 2. JJS (V KEY)
-----------------------------------------------------------
local jjsConn
AddScriptButton("jjs", function()
    if jjsConn then jjsConn:Disconnect() end
    jjsConn = UIS.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.V then
            local hrp = Players.LocalPlayer.Character.HumanoidRootPart
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
        end
    end)
end, function() if jjsConn then jjsConn:Disconnect() jjsConn = nil end end)

-----------------------------------------------------------
-- 3. GHOST (V KEY)
-----------------------------------------------------------
local ghostInp
AddScriptButton("Ghost", function()
    if ghostInp then ghostInp:Disconnect() end
    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local active = false
    local speed, sensitivity, undergroundDepth = 50, 0.75, -500
    local rotX, rotY = 0, 0
    local currentCamPos = Vector3.new(0,0,0)
    local renderAnchor = Instance.new("Part", workspace)
    renderAnchor.Transparency, renderAnchor.CanCollide, renderAnchor.Anchored = 1, false, true

    local function setGhostVisuals(char, isGhost)
        local transparency = isGhost and 1 or 0
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") or part:IsA("Decal") then
                if part.Name ~= "HumanoidRootPart" then part.Transparency = transparency end
            end
        end
    end

    local function toggleGhost()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not root or not hum then return end
        active = not active
        if active then
            setGhostVisuals(char, true)
            currentCamPos = camera.CFrame.Position
            hum.PlatformStand = true
            local hideLocation = root.Position - Vector3.new(0, undergroundDepth, 0)
            root.CFrame = CFrame.new(hideLocation)
            camera.CameraType = Enum.CameraType.Scriptable
            camera.CameraSubject = nil 
            player.ReplicationFocus = renderAnchor
            local look = camera.CFrame.LookVector
            rotY, rotX = math.atan2(-look.X, -look.Z), math.asin(look.Y)
            RunService:BindToRenderStep("GhostForce", 2001, function(dt)
                root.Velocity = Vector3.zero
                root.CFrame = CFrame.new(hideLocation)
                UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
                local delta = UIS:GetMouseDelta()
                rotY = rotY - (delta.X * sensitivity / 100) 
                rotX = math.clamp(rotX - (delta.Y * sensitivity / 100), -math.rad(80), math.rad(80))
                local rotation = CFrame.Angles(0, rotY, 0) * CFrame.Angles(rotX, 0, 0)
                local moveDir = Vector3.zero
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += Vector3.new(0,0,-1) end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir += Vector3.new(0,0,1) end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir += Vector3.new(-1,0,0) end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += Vector3.new(1,0,0) end
                local v = (UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0)
                local finalMove = rotation:VectorToWorldSpace(moveDir) + Vector3.new(0, v, 0)
                if finalMove.Magnitude > 0 then
                    currentCamPos = currentCamPos + (finalMove.Unit * speed * (UIS:IsKeyDown(Enum.KeyCode.LeftShift) and 2 or 1) * dt)
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
    ghostInp = UIS.InputBegan:Connect(function(input, proc)
        if not proc and input.KeyCode == Enum.KeyCode.V then toggleGhost() end
    end)
end, function() 
    RunService:UnbindFromRenderStep("GhostForce") 
    if ghostInp then ghostInp:Disconnect() end 
end)

-----------------------------------------------------------
-- 4. FLY (B KEY)
-----------------------------------------------------------
local flyInp
AddScriptButton("fly", function()
    if flyInp then flyInp:Disconnect() end
    local player = Players.LocalPlayer
    local camera = workspace.CurrentCamera
    local flying = false
    local speed, lerpSpeed = 70, 0.4
    local bv, bg
    local targetVelocity = Vector3.new(0, 0, 0)

    local function toggleFly()
        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        local hum = char and char:FindFirstChild("Humanoid")
        if not root or not hum then return end
        flying = not flying
        if flying then
            hum.PlatformStand = true
            bv = Instance.new("BodyVelocity", root)
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bg = Instance.new("BodyGyro", root)
            bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
            bg.D, bg.P = 100, 5000
            RunService:BindToRenderStep("SmoothFly", 200, function()
                bg.CFrame = camera.CFrame
                local moveDir = Vector3.new(0, 0, 0)
                local look, right = camera.CFrame.LookVector, camera.CFrame.RightVector
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += look end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= look end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= right end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += right end
                local vertical = (UIS:IsKeyDown(Enum.KeyCode.Space) and 1 or 0) - (UIS:IsKeyDown(Enum.KeyCode.LeftControl) and 1 or 0)
                local rawVelocity = (moveDir + Vector3.new(0, vertical, 0))
                targetVelocity = rawVelocity.Magnitude > 0 and rawVelocity.Unit * speed or Vector3.new(0,0,0)
                bv.Velocity = bv.Velocity:Lerp(targetVelocity, lerpSpeed)
            end)
        else
            RunService:UnbindFromRenderStep("SmoothFly")
            if bv then bv:Destroy() end if bg then bg:Destroy() end
            hum.PlatformStand = false
        end
    end
    flyInp = UIS.InputBegan:Connect(function(input, proc)
        if not proc and input.KeyCode == Enum.KeyCode.B then toggleFly() end
    end)
end, function() 
    RunService:UnbindFromRenderStep("SmoothFly") 
    if flyInp then flyInp:Disconnect() end 
end)

-----------------------------------------------------------
-- 5. NOCLIP (X KEY - FIXED)
-----------------------------------------------------------
local ncl = false
local nclInp, nclLoop
AddScriptButton("noclip", function()
    if nclInp then nclInp:Disconnect() end
    if nclLoop then nclLoop:Disconnect() end
    nclInp = UIS.InputBegan:Connect(function(i, g)
        if not g and i.KeyCode == Enum.KeyCode.X then 
            ncl = not ncl 
            local char = Players.LocalPlayer.Character
            if not ncl and char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then hrp.Anchored = true end
                for _, v in pairs(char:GetDescendants()) do
                    if v:IsA("BasePart") then
                        v.CanCollide = true
                        v.Velocity = Vector3.zero
                        v.RotVelocity = Vector3.zero
                    end
                end
                task.wait(0.1)
                if hrp then hrp.Anchored = false end
            end
        end
    end)
    nclLoop = RunService.Stepped:Connect(function()
        if ncl and Players.LocalPlayer.Character then
            for _, v in pairs(Players.LocalPlayer.Character:GetDescendants()) do
                if v:IsA("BasePart") then v.CanCollide = false end
            end
        end
    end)
end, function() 
    ncl = false 
    if nclInp then nclInp:Disconnect() end
    if nclLoop then nclLoop:Disconnect() end
    if Players.LocalPlayer.Character then
        for _, v in pairs(Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then v.CanCollide = true end
        end
    end
end)

-----------------------------------------------------------
-- 6. JUMP AND SPEED
-----------------------------------------------------------
local jsGui
AddScriptButton("jump and speed", function()
    if jsGui then jsGui.Enabled = true return end
    jsGui = Instance.new("ScreenGui", CoreGui)
    local f = Instance.new("Frame", jsGui)
    f.Size, f.Position, f.BackgroundColor3 = UDim2.new(0,220,0,160), UDim2.new(0.5,-110,0.5,-80), Color3.fromRGB(25,25,25)
    f.Active = true Instance.new("UICorner", f)
    MakeSmooth(f)
    local function slider(n, p, mi, ma, c, cb)
        local l = Instance.new("TextLabel", f) l.Size, l.Position, l.Text, l.TextColor3, l.BackgroundTransparency = UDim2.new(1,0,0,20), p, n..": "..c, Color3.new(1,1,1), 1
        local b = Instance.new("Frame", f) b.Size, b.Position, b.BackgroundColor3 = UDim2.new(0.8,0,0,6), p+UDim2.new(0.1,0,0,25), Color3.fromRGB(50,50,50)
        local s = Instance.new("TextButton", b) s.Size, s.Position, s.BackgroundColor3 = UDim2.new(0,16,0,16), UDim2.new((c-mi)/(ma-mi),-8,0.5,-8), Color3.fromRGB(0,200,255)
        s.Text = "" Instance.new("UICorner", s).CornerRadius = UDim.new(1,0)
        local d = false s.MouseButton1Down:Connect(function() d = true end)
        UIS.InputEnded:Connect(function(i) if i.UserInputType == Enum.UserInputType.MouseButton1 then d = false end end)
        RunService.RenderStepped:Connect(function() if d then
            local pct = math.clamp((UIS:GetMouseLocation().X - b.AbsolutePosition.X)/b.AbsoluteSize.X, 0, 1)
            s.Position = UDim2.new(pct,-8,0.5,-8) local v = math.floor(mi + (pct*(ma-mi))) l.Text = n..": "..v cb(v)
        end end)
    end
    slider("Speed", UDim2.new(0,0,0,25), 16, 300, 16, function(v) if Players.LocalPlayer.Character then Players.LocalPlayer.Character.Humanoid.WalkSpeed = v end end)
    slider("Jump", UDim2.new(0,0,0,85), 50, 600, 50, function(v) if Players.LocalPlayer.Character then Players.LocalPlayer.Character.Humanoid.JumpPower = v end end)
end, function() 
    if Players.LocalPlayer.Character and Players.LocalPlayer.Character:FindFirstChild("Humanoid") then
        Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16
        Players.LocalPlayer.Character.Humanoid.JumpPower = 50
    end
    if jsGui then jsGui:Destroy() jsGui = nil end 
end)

-----------------------------------------------------------
-- 7. ESP (RAINBOW)
-----------------------------------------------------------
local espOn = false
AddScriptButton("esp", function()
    espOn = true
    RunService.RenderStepped:Connect(function()
        if not espOn then return end
        local c = Color3.fromHSV((tick() % 5) / 5, 1, 1)
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= Players.LocalPlayer and p.Character then
                local h = p.Character:FindFirstChild("Glow") or Instance.new("Highlight", p.Character)
                h.Name = "Glow" h.FillTransparency = 0.8 h.OutlineColor = c h.FillColor = c h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
            end
        end
    end)
end, function() espOn = false for _, p in pairs(Players:GetPlayers()) do if p.Character and p.Character:FindFirstChild("Glow") then p.Character.Glow:Destroy() end end end)

-----------------------------------------------------------
-- 8. AIMBOT (M3)
-----------------------------------------------------------
local abActive, abInp, abLp = false, nil, nil
AddScriptButton("aimbot", function()
    if abInp then abInp:Disconnect() end
    if abLp then abLp:Disconnect() end
    abInp = UIS.InputBegan:Connect(function(input, proc)
        if not proc and input.UserInputType == Enum.UserInputType.MouseButton3 then abActive = not abActive end
    end)
    abLp = RunService.RenderStepped:Connect(function()
        if abActive then
            local closest, dist = nil, math.huge
            local mouse = UIS:GetMouseLocation()
            for _, p in pairs(Players:GetPlayers()) do
                if p ~= Players.LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
                    local pos, onS = workspace.CurrentCamera:WorldToViewportPoint(p.Character.Head.Position)
                    if onS then
                        local d = (Vector2.new(pos.X, pos.Y) - mouse).Magnitude
                        if d < dist then closest = p dist = d end
                    end
                end
            end
            if closest then workspace.CurrentCamera.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position, closest.Character.Head.Position) end
        end
    end)
end, function() abActive = false if abInp then abInp:Disconnect() end if abLp then abLp:Disconnect() end end)
