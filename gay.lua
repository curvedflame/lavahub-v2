local Players    = game:GetService("Players")
local Input      = game:GetService("UserInputService")
local player     = Players.LocalPlayer

local function createUI(name)
    local gui    = Instance.new("ScreenGui")
    local frame  = Instance.new("Frame")
    local title  = Instance.new("TextLabel")
    local holder = Instance.new("Frame")

    gui.Name         = name
    gui.ResetOnSpawn = false
    gui.Parent       = player:WaitForChild("PlayerGui")

    frame.Size             = UDim2.new(0, 200, 0, 50)
    frame.Position         = UDim2.new(0.5, -100, 0.5, -25)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BorderSizePixel  = 0
    frame.Parent           = gui

    title.Size                   = UDim2.new(1, 0, 0, 24)
    title.BackgroundTransparency = 1
    title.Text                   = name
    title.TextColor3             = Color3.fromRGB(220, 220, 220)
    title.Font                   = Enum.Font.GothamMedium
    title.TextSize               = 13
    title.Parent                 = frame

    holder.Size                   = UDim2.new(1, 0, 0, 0)
    holder.Position               = UDim2.new(0, 0, 0, 24)
    holder.BackgroundTransparency = 1
    holder.Parent                 = frame

    -- drag
    local dragging, dragStart, startPos

    title.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging  = true
            dragStart = i.Position
            startPos  = frame.Position
        end
    end)

    Input.InputChanged:Connect(function(i)
        if dragging and i.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = i.Position - dragStart
            frame.Position = UDim2.new(
                startPos.X.Scale,
                startPos.X.Offset + delta.X,
                startPos.Y.Scale,
                startPos.Y.Offset + delta.Y
            )
        end
    end)

    Input.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local yOffset = 0
    local win = {}

    function win:Toggle(label, default, callback)
        local state = default or false

        local row = Instance.new("Frame")
        local lbl = Instance.new("TextLabel")
        local btn = Instance.new("TextButton")

        row.Size                   = UDim2.new(1, 0, 0, 26)
        row.Position               = UDim2.new(0, 0, 0, yOffset)
        row.BackgroundTransparency = 1
        row.Parent                 = holder

        lbl.Size                   = UDim2.new(0.7, 0, 1, 0)
        lbl.Position               = UDim2.new(0, 6, 0, 0)
        lbl.BackgroundTransparency = 1
        lbl.Text                   = label
        lbl.TextColor3             = Color3.fromRGB(200, 200, 200)
        lbl.Font                   = Enum.Font.Gotham
        lbl.TextSize               = 12
        lbl.TextXAlignment         = Enum.TextXAlignment.Left
        lbl.Parent                 = row

        btn.Size             = UDim2.new(0, 36, 0, 16)
        btn.Position         = UDim2.new(1, -42, 0.5, -8)
        btn.BackgroundColor3 = state and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 80)
        btn.Text             = ""
        btn.BorderSizePixel  = 0
        btn.Parent           = row

        yOffset       += 26
        frame.Size     = UDim2.new(0, 200, 0, 50 + yOffset)
        holder.Size    = UDim2.new(1, 0, 0, yOffset)

        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(80, 200, 120) or Color3.fromRGB(80, 80, 80)
            if callback then callback(state) end
        end)
    end

    return win
end

-- usage
local win = createUI("My UI")

win:Toggle("God Mode", false, function(state)
    print("god mode:", state)
end)

win:Toggle("Fly", true, function(state)
    print("fly:", state)
end)
