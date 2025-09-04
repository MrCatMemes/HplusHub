-- H+ub V1 • The Future of Custom (Block 1 – UI + Grundstruktur)

if not game:IsLoaded() then game.Loaded:Wait() end

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- ScreenGui
local gui = Instance.new("ScreenGui")
gui.Name = "HplusUI_"..tostring(math.random(1000,9999))
gui.ResetOnSpawn = false
gui.IgnoreGuiInset = true

local parentGui
pcall(function() parentGui = game:GetService("CoreGui") end)
if not parentGui then parentGui = LocalPlayer:WaitForChild("PlayerGui") end
gui.Parent = parentGui

-- Main Frame
local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 800, 0, 500)
frame.Position = UDim2.new(0.5, -400, 0.5, -250)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.Active = true
frame.Draggable = true
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 12)

-- Header
local header = Instance.new("Frame")
header.Size = UDim2.new(1, 0, 0, 40)
header.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
header.Parent = frame
Instance.new("UICorner", header).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -20, 1, 0)
title.Position = UDim2.new(0, 10, 0, 0)
title.BackgroundTransparency = 1
title.Text = "🚀 H+ub V1 • The Future of Custom"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = header

-- Sidebar
local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 200, 1, -40)
sidebar.Position = UDim2.new(0, 0, 0, 40)
sidebar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sidebar.Parent = frame

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 5)
sideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
sideLayout.Parent = sidebar

-- Content Area
local content = Instance.new("Frame")
content.Size = UDim2.new(1, -210, 1, -50)
content.Position = UDim2.new(0, 210, 0, 50)
content.BackgroundTransparency = 1
content.Parent = frame

-- Tabs
local tabs = {}
local function makeTab(name)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    btn.Text = name
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = sidebar
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("Frame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 10)
    layout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    layout.Parent = page

    tabs[name] = {Button = btn, Page = page}

    btn.MouseButton1Click:Connect(function()
        for _, t in pairs(tabs) do
            t.Page.Visible = false
            t.Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        end
        page.Visible = true
        btn.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
    end)
end

-- Create Tabs
makeTab("Movement")
makeTab("Vehicle")
makeTab("ESP")
makeTab("Teleports")
makeTab("AutoFarm")
makeTab("Misc")
makeTab("Info")

-- Helper: Button
local function makeButton(tabName, text, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    btn.Text = text
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = tabs[tabName].Page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
    btn.MouseButton1Click:Connect(callback)
    return btn
end

-- Helper: Toggle
local function makeToggle(tabName, text, default, callback)
    local state = default or false
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1, -20, 0, 40)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
    btn.Text = text.." ["..(state and "ON" or "OFF").."]"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 14
    btn.Parent = tabs[tabName].Page
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = text.." ["..(state and "ON" or "OFF").."]"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 170, 0) or Color3.fromRGB(50, 50, 50)
        callback(state)
    end)

    return btn, function() return state end
end

-- Helper: Slider
local function makeSlider(tabName, text, min, max, default, callback)
    local value = default or min

    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -20, 0, 60)
    holder.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    holder.Parent = tabs[tabName].Page
    Instance.new("UICorner", holder).CornerRadius = UDim.new(0, 8)

    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, -20, 0, 20)
    label.Position = UDim2.new(0, 10, 0, 5)
    label.BackgroundTransparency = 1
    label.Text = text..": "..tostring(value)
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Font = Enum.Font.GothamSemibold
    label.TextSize = 14
    label.Parent = holder

    local bar = Instance.new("Frame")
    bar.Size = UDim2.new(1, -20, 0, 10)
    bar.Position = UDim2.new(0, 10, 0, 35)
    bar.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    bar.Parent = holder

    local fill = Instance.new("Frame")
    fill.Size = UDim2.new((value-min)/(max-min), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
    fill.Parent = bar

    local dragging = false
    bar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)
    bar.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local pos = math.clamp((input.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
            value = math.floor(min + (max-min)*pos)
            fill.Size = UDim2.new(pos, 0, 1, 0)
            label.Text = text..": "..tostring(value)
            callback(value)
        end
    end)

    return holder, function() return value end
end

-- Default Tab sichtbar machen
tabs["Movement"].Page.Visible = true
tabs["Movement"].Button.BackgroundColor3 = Color3.fromRGB(55,55,55)

print("✅ Block 1 (UI System + Grundstruktur) geladen") 

-- 🚀 H+ub V1 (Block 2 - Movement Tab)

-- Speed Slider
makeSlider("Movement", "WalkSpeed", 16, 200, 16, function(value)
    print("[H+ub] WalkSpeed Slider auf: "..value)
end)

-- Infinite Jump Toggle
makeToggle("Movement", "Infinite Jump", false, function(state)
    print("[H+ub] Infinite Jump: "..tostring(state))
end)

-- Fly Toggle
makeToggle("Movement", "Fly", false, function(state)
    print("[H+ub] Fly: "..tostring(state))
end)

-- Fly Speed Slider
makeSlider("Movement", "Fly Speed", 10, 200, 50, function(value)
    print("[H+ub] Fly Speed Slider auf: "..value)
end)

-- Noclip Toggle
makeToggle("Movement", "Noclip", false, function(state)
    print("[H+ub] Noclip: "..tostring(state))
end)

-- Escape Car Button
makeButton("Movement", "Escape Car", function()
    print("[H+ub] Escape Car gedrückt")
end)

print("✅ Block 2 (Movement Tab) geladen")  

-- 🚀 H+ub V1 (Block 3 - Vehicle Tab)

-- Car Fly Toggle
makeToggle("Vehicle", "Car Fly", false, function(state)
    print("[H+ub] Car Fly: "..tostring(state))
end)

-- Car Fly Speed Slider
makeSlider("Vehicle", "Car Fly Speed", 50, 500, 150, function(value)
    print("[H+ub] Car Fly Speed Slider auf: "..value)
end)

-- Infinite Fuel Toggle
makeToggle("Vehicle", "Infinite Fuel", false, function(state)
    print("[H+ub] Infinite Fuel: "..tostring(state))
end)

-- God Car Toggle
makeToggle("Vehicle", "God Car", false, function(state)
    print("[H+ub] God Car: "..tostring(state))
end)

print("✅ Block 3 (Vehicle Tab) geladen")  

Hu-- 🚀 H+ub V1 (Block 4 - ESP Tab)

-- Name ESP Toggle
makeToggle("ESP", "Name ESP", false, function(state)
    print("[H+ub] Name ESP: "..tostring(state))
end)

-- Distance ESP Toggle
makeToggle("ESP", "Distance ESP", false, function(state)
    print("[H+ub] Distance ESP: "..tostring(state))
end)

-- Team ESP Toggle
makeToggle("ESP", "Team ESP", false, function(state)
    print("[H+ub] Team ESP: "..tostring(state))
end)

-- Wanted ESP Toggle
makeToggle("ESP", "Wanted ESP", false, function(state)
    print("[H+ub] Wanted ESP: "..tostring(state))
end)

print("✅ Block 4 (ESP Tab) geladen")  

-- 🚀 H+ub V1 (Block 5 - Teleports + AutoFarm Tabs)

-- TELEPORTS TAB

-- Save Position Button
makeButton("Teleports", "Save Position", function()
    print("[H+ub] Save Position gedrückt")
end)

-- Load Position Button
makeButton("Teleports", "Load Position", function()
    print("[H+ub] Load Position gedrückt")
end)

-- Example Locations (z. B. Police Station, Hospital, Bank)
makeButton("Teleports", "Teleport: Police Station", function()
    print("[H+ub] Teleport Police Station gedrückt")
end)

makeButton("Teleports", "Teleport: Hospital", function()
    print("[H+ub] Teleport Hospital gedrückt")
end)

makeButton("Teleports", "Teleport: Bank", function()
    print("[H+ub] Teleport Bank gedrückt")
end)


-- AUTOFARM TAB

-- Bus Farm Button
makeButton("AutoFarm", "Start Bus Farm", function()
    print("[H+ub] Bus Farm gestartet")
end)

-- Truck Farm Button
makeButton("AutoFarm", "Start Truck Farm", function()
    print("[H+ub] Truck Farm gestartet")
end)

-- Radar Farm Button
makeButton("AutoFarm", "Start Radar Farm", function()
    print("[H+ub] Radar Farm gestartet")
end)

-- 🔥 BLOCK 5: Misc Tab Features

-- Easy Arrest Button
makeButton("Misc", "Easy Arrest", function()
    print("[H+ub] Easy Arrest gedrückt")
end)

-- Anti Taser
makeButton("Misc", "Anti Taser", function()
    print("[H+ub] Anti Taser aktiviert")
end)

-- Anti Fall
makeButton("Misc", "Anti Fall", function()
    print("[H+ub] Anti Fall aktiviert")
end)

-- Anti Downed
makeButton("Misc", "Anti Downed", function()
    print("[H+ub] Anti Downed aktiviert")
end)

-- Anti Dying
makeButton("Misc", "Anti Dying", function()
    print("[H+ub] Anti Dying aktiviert")
end)


-- 🔥 BLOCK 6: Info Tab + Hotkeys

-- Info Tab
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

-- Hotkeys Setup
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

print("✅ Block 5 (Misc Features) geladen")
print("✅ Block 6 (Info + Hotkeys) geladen")
print("🔥 H+ub V1 vollständig geladen – Nova-Style UI komplett!")
