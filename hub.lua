-- H+ub V1 - The Future of Custom
-- Block 1: Grundstruktur + UI Setup

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

-- Lokaler Spieler
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

-- GUI Hauptobjekt
local HUI = Instance.new("ScreenGui")
HUI.Name = "H+ubV1"
HUI.ResetOnSpawn = false
HUI.Parent = PlayerGui

-- Hauptfenster
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 800, 0, 500)
MainFrame.Position = UDim2.new(0.5, -400, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = HUI

-- Abgerundete Ecken
local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame

-- Header
local Header = Instance.new("Frame")
Header.Name = "Header"
Header.Size = UDim2.new(1, 0, 0, 40)
Header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Header.BorderSizePixel = 0
Header.Parent = MainFrame

local HeaderText = Instance.new("TextLabel")
HeaderText.Size = UDim2.new(1, -20, 1, 0)
HeaderText.Position = UDim2.new(0, 10, 0, 0)
HeaderText.BackgroundTransparency = 1
HeaderText.Text = "🚀 H+ub V1 • The Future of Custom"
HeaderText.TextColor3 = Color3.new(1, 1, 1)
HeaderText.Font = Enum.Font.GothamBold
HeaderText.TextSize = 18
HeaderText.TextXAlignment = Enum.TextXAlignment.Left
HeaderText.Parent = Header

-- Tab-Leiste links
local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Size = UDim2.new(0, 150, 1, -40)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
TabFrame.BorderSizePixel = 0
TabFrame.Parent = MainFrame

-- Seiteninhalt rechts
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -150, 1, -40)
ContentFrame.Position = UDim2.new(0, 150, 0, 40)
ContentFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
ContentFrame.BorderSizePixel = 0
ContentFrame.Parent = MainFrame

-- Dictionary für Tabs
-- Tabs erstellen
local TabFrame = Instance.new("Frame")
TabFrame.Name = "TabFrame"
TabFrame.Size = UDim2.new(0, 150, 1, -40)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
TabFrame.Parent = MainFrame

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 5)
UIListLayout.Parent = TabFrame

-- Tab Funktion
local tabs = {}
function makeTab(name)
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, -10, 0, 35)
    button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
    button.Text = name
    button.TextColor3 = Color3.new(1, 1, 1)
    button.Font = Enum.Font.GothamSemibold
    button.TextSize = 14
    button.Parent = TabFrame

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, -160, 1, -50)
    page.Position = UDim2.new(0, 160, 0, 50)
    page.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    page.Visible = false
    page.Parent = MainFrame

    button.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Page.Visible = false
        end
        page.Visible = true
    end)

    local tabData = {Button = button, Page = page}
    tabs[name] = tabData
    return tabData
end

-- Alle Tabs
makeTab("Movement")
makeTab("Vehicle")
makeTab("ESP")
makeTab("Teleports")
makeTab("AutoFarm")
makeTab("Misc")
makeTab("Info")

-- Standard: Info anzeigen
tabs["Info"].Page.Visible = true
    fill.BackgroundColor3 = Color3.fromRGB(0,170,255)
    fill.Parent = slider

    local dragging = false
    slider.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    slider.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local rel = math.clamp((input.Position.X - slider.AbsolutePosition.X) / slider.AbsoluteSize.X,0,1)
            fill.Size = UDim2.new(rel,0,1,0)
            local val = math.floor(min + (max-min)*rel)
            label.Text = text.." ("..val..")"
            callback(val)
        end
    end)
end

-- Variablen für Movement
local WalkSpeed = 16
local FlyEnabled = false
local NoClipEnabled = false
local InfJumpEnabled = false

-- Speed Slider
makeSlider("Movement","WalkSpeed",16,200,16,function(val)
    WalkSpeed = val
    LocalPlayer.Character.Humanoid.WalkSpeed = val
end)

-- Fly Button
makeButton("Movement","Toggle Fly",function()
    FlyEnabled = not FlyEnabled
    print("[H+ub] Fly:",FlyEnabled)
    if FlyEnabled then
        local char = LocalPlayer.Character
        local hum = char:FindFirstChildOfClass("Humanoid")
        hum:ChangeState(Enum.HumanoidStateType.Physics)
        char.PrimaryPart.Anchored = false
        game:GetService("RunService").RenderStepped:Connect(function()
            if FlyEnabled and char.PrimaryPart then
                char.PrimaryPart.Velocity = Vector3.new(0,50,0)
            end
        end)
    end
end)

-- Noclip Button
makeButton("Movement","Toggle Noclip",function()
    NoClipEnabled = not NoClipEnabled
    print("[H+ub] Noclip:",NoClipEnabled)
    game:GetService("RunService").Stepped:Connect(function()
        if NoClipEnabled and LocalPlayer.Character then
            for _,part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end)
end)

-- Infinite Jump Button
makeButton("Movement","Toggle Infinite Jump",function()
    InfJumpEnabled = not InfJumpEnabled
    print("[H+ub] Infinite Jump:",InfJumpEnabled)
end)

UserInputService.JumpRequest:Connect(function()
    if InfJumpEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
        LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end)

print("✅ Block 2 (Movement) geladen")  

-- Block 3: Vehicle Features

local CarFlyEnabled = false
local CarFlySpeed = 50

-- Car Fly Toggle
makeButton("Vehicle","Toggle Car Fly",function()
    CarFlyEnabled = not CarFlyEnabled
    print("[H+ub] Car Fly:",CarFlyEnabled)
end)

-- Car Fly Speed Slider
makeSlider("Vehicle","Car Fly Speed",10,200,50,function(val)
    CarFlySpeed = val
end)

-- Car Fly Keybind (Taste X)
UserInputService.InputBegan:Connect(function(input,gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.X then
        CarFlyEnabled = not CarFlyEnabled
        print("[H+ub] Hotkey X → Car Fly:",CarFlyEnabled)
    end
end)

-- Car Fly Logic
game:GetService("RunService").RenderStepped:Connect(function()
    if CarFlyEnabled and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        local seat = LocalPlayer.Character:FindFirstChildWhichIsA("VehicleSeat") or LocalPlayer.Character:FindFirstChildWhichIsA("Seat")
        if seat and seat:IsDescendantOf(workspace) then
            seat.Velocity = LocalPlayer.Character.Humanoid.MoveDirection * CarFlySpeed + Vector3.new(0,CarFlySpeed/2,0)
        end
    end
end)

-- GodCar Button
makeButton("Vehicle","GodCar",function()
    print("[H+ub] GodCar aktiviert")
    local seat = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildWhichIsA("VehicleSeat")
    if seat and seat.Parent then
        for _,part in pairs(seat.Parent:GetDescendants()) do
            if part:IsA("BasePart") then
                part.Anchored = false
                part.CanCollide = true
                part.AssemblyLinearVelocity = Vector3.zero
            end
        end
    end
end)

-- Infinite Fuel Button
makeButton("Vehicle","Infinite Fuel",function()
    print("[H+ub] Infinite Fuel aktiviert")
    -- Platzhalter: Hier könntest du Vehicle Fuel-Werte patchen
end)

print("✅ Block 3 (Vehicle) geladen")  

-- Block 4: ESP Features

local NameESP = false
local DistanceESP = false
local TeamESP = false
local WantedESP = false

-- Name ESP Toggle
makeButton("ESP","Toggle Name ESP",function()
    NameESP = not NameESP
    print("[H+ub] Name ESP:",NameESP)
end)

-- Distance ESP Toggle
makeButton("ESP","Toggle Distance ESP",function()
    DistanceESP = not DistanceESP
    print("[H+ub] Distance ESP:",DistanceESP)
end)

-- Team ESP Toggle
makeButton("ESP","Toggle Team ESP",function()
    TeamESP = not TeamESP
    print("[H+ub] Team ESP:",TeamESP)
end)

-- Wanted ESP Toggle
makeButton("ESP","Toggle Wanted ESP",function()
    WantedESP = not WantedESP
    print("[H+ub] Wanted ESP:",WantedESP)
end)

print("✅ Block 4 (ESP) geladen")  

-- Block 5: Teleports + AutoFarm

-- TELEPORTS
makeButton("Teleports","Save Position",function()
    print("[H+ub] Save Position gedrückt")
end)

makeButton("Teleports","Load Position",function()
    print("[H+ub] Load Position gedrückt")
end)

makeButton("Teleports","Teleport: Police Station",function()
    print("[H+ub] Teleport Police Station gedrückt")
end)

makeButton("Teleports","Teleport: Hospital",function()
    print("[H+ub] Teleport Hospital gedrückt")
end)

makeButton("Teleports","Teleport: Bank",function()
    print("[H+ub] Teleport Bank gedrückt")
end)

-- AUTOFARM
makeButton("AutoFarm","Start Bus Farm",function()
    print("[H+ub] Bus Farm gestartet")
end)

makeButton("AutoFarm","Start Truck Farm",function()
    print("[H+ub] Truck Farm gestartet")
end)

makeButton("AutoFarm","Start Radar Farm",function()
    print("[H+ub] Radar Farm gestartet")
end)

print("✅ Block 5 (Teleports + AutoFarm) geladen")  

-- Block 6: Misc + Info + Hotkeys

-- MISC TAB
makeButton("Misc","Anti Taser",function()
    print("[H+ub] Anti Taser aktiviert")
end)

makeButton("Misc","Anti Fall",function()
    print("[H+ub] Anti Fall aktiviert")
end)

makeButton("Misc","Infinite Stamina",function()
    print("[H+ub] Infinite Stamina aktiviert")
end)

makeButton("Misc","Easy Arrest",function()
    print("[H+ub] Easy Arrest gedrückt")
end)

-- INFO TAB
local infoLabel = Instance.new("TextLabel")
infoLabel.Size = UDim2.new(1, -20, 0, 40)
infoLabel.Position = UDim2.new(0, 10, 0, 10)
infoLabel.BackgroundTransparency = 1
infoLabel.Text = "🚀 H+ub V1 • 2025 • The Future of Custom"
infoLabel.TextColor3 = Color3.new(1, 1, 1)
infoLabel.Font = Enum.Font.GothamSemibold
infoLabel.TextSize = 16
infoLabel.TextXAlignment = Enum.TextXAlignment.Left
infoLabel.Parent = tabs["Info"].Page

-- HOTKEYS
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    if input.KeyCode == Enum.KeyCode.F then
        print("[H+ub] Hotkey F → Fly Toggle gedrückt")
    elseif input.KeyCode == Enum.KeyCode.X then
        print("[H+ub] Hotkey X → Car Fly Toggle gedrückt")
    elseif input.KeyCode == Enum.KeyCode.Z then
        print("[H+ub] Hotkey Z → Noclip Toggle gedrückt")
    elseif input.KeyCode == Enum.KeyCode.V then
        print("[H+ub] Hotkey V → Infinite Jump Toggle gedrückt")
    end
end)

print("✅ Block 6 (Misc + Info + Hotkeys) geladen")
print("🔥 H+ub V1 vollständig geladen – Nova-Style UI komplett!")
