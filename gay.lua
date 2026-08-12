-- gay.lua yes its ai and i do not care rn
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function createUI(title)
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 400)
    frame.Position = UDim2.new(0.5, -150, 0.5, -200)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.BackgroundTransparency = 0.5
    frame.Parent = screenGui
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = title
    titleLabel.Size = UDim2.new(1, 0, 0, 30)
    titleLabel.BackgroundTransparency = 1
    titleLabel.TextColor3 = Color3.new(1,1,1)
    titleLabel.Parent = frame
    
    local y = 40
    local win = {}
    
    function win:Toggle(name, default, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(0.9, 0, 0, 30)
        btn.Position = UDim2.new(0.05, 0, 0, y)
        btn.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        btn.Text = name .. " (" .. tostring(default) .. ")"
        btn.TextColor3 = Color3.new(1,1,1)
        btn.Parent = frame
        
        local state = default
        btn.MouseButton1Click:Connect(function()
            state = not state
            btn.BackgroundColor3 = state and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
            btn.Text = name .. " (" .. tostring(state) .. ")"
            if callback then callback(state) end
        end)
        if callback then callback(default) end  -- set initial state
        y = y + 35
    end
    
    return win
end

return { createUI = createUI }
