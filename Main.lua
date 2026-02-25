-- [[ UNIVERSAL SCRIPT HUB - LARGE VERSION ]] --
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
Title.Text = "   DEVELOPER SUITE V9"
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
-- 3. GHOST
-----------------------------------------------------------
local ghostConn, isGhostActive = nil, false
AddScriptButton("Ghost", function()
    if ghostConn then ghostConn:Disconnect() end
    ghostConn = UIS.InputBegan:Connect(function(input, gpe)
        if gpe or input.KeyCode ~= Enum.KeyCode.V then return end
        isGhostActive = not isGhostActive
        local lp = game.Players.LocalPlayer
        local char = lp.Character
        if isGhostActive then
            lp.Character.Humanoid.PlatformStand = true
            workspace.CurrentCamera.CameraType = Enum.CameraType.Scriptable
            RunService:BindToRenderStep("GhostForce", 2001, function()
                char.HumanoidRootPart.Velocity = Vector3.zero
                char.HumanoidRootPart.CFrame = CFrame.new(workspace.CurrentCamera.CFrame.Position - Vector3.new(0, 500, 0))
                UIS.MouseBehavior = Enum.MouseBehavior.LockCenter
            end)
        else
            RunService:UnbindFromRenderStep("GhostForce")
            lp.Character.Humanoid.PlatformStand = false
            workspace.CurrentCamera.CameraSubject = lp.Character.Humanoid
            workspace.CurrentCamera.CameraType = Enum.CameraType.Custom
            UIS.MouseBehavior = Enum.MouseBehavior.Default
        end
    end)
end, function()
    if ghostConn then ghostConn:Disconnect() ghostConn = nil end
    RunService:UnbindFromRenderStep("GhostForce")
end)

-----------------------------------------------------------
-- 4. SNAPPY FLY (B KEY - IMPROVED VERSION)
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
            
            bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bv.Velocity = Vector3.new(0,0,0)
            bv.Parent = root
            
            bg = Instance.new("BodyGyro")
            bg.MaxTorque = Vector3.new(1e6, 1e6, 1e6)
            bg.D = 100 -- Lower damping for snappy turning
            bg.P = 5000 -- Higher power
            bg.Parent = root

            RunService:BindToRenderStep("SmoothFly", 200, function()
                if not isFlying or not root then return end
                bg.CFrame = cam.CFrame
                
                local moveDir = Vector3.new(0,0,0)
                local look = cam.CFrame.LookVector
                local right = cam.CFrame.RightVector
                
                if UIS:IsKeyDown(Enum.KeyCode.W) then moveDir += look end
                if UIS:IsKeyDown(Enum.KeyCode.S) then moveDir -= look end
                if UIS:IsKeyDown(Enum.KeyCode.A) then moveDir -= right end
                if UIS:IsKeyDown(Enum.KeyCode.D) then moveDir += right end
                
                local vert = 0
                if UIS:IsKeyDown(Enum.KeyCode.Space) then vert = 1
                elseif UIS:IsKeyDown(Enum.KeyCode.LeftControl) then vert = -1 end
                
                local rawVelocity = (moveDir + Vector3.new(0, vert, 0))
                if rawVelocity.Magnitude > 0 then
                    targetVelocity = rawVelocity.Unit * 70
                else
                    targetVelocity = Vector3.new(0,0,0)
                end
                
                bv.Velocity = bv.Velocity:Lerp(targetVelocity, 0.4) -- Faster stopping
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
-- 5. NOCLIP (X KEY)
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
        
        local char = game.Players.LocalPlayer.Character
        if isNoclipActive and char then
            noclipLoopConn = RunService.Stepped:Connect(function()
                if not isNoclipActive or not char then return end
                for _, part in pairs(char:GetDescendants()) do
                    if part:IsA("BasePart") then
                        part.CanCollide = false
                    end
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
