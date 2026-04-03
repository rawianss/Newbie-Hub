-- [[ NEWBIE ELITE UI LIBRARY - OFFICIAL ]] --
-- Professional UI Engine for High-End Scripts

local Library = {}
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()

function Library:CreateWindow(hubName)
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "NewbieEliteUI"
    ScreenGui.Parent = game:GetService("CoreGui")
    ScreenGui.ResetOnSpawn = false

    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15) -- Luxury Dark
    MainFrame.BorderSizePixel = 0
    MainFrame.Position = UDim2.new(0.5, -225, 0.5, -150)
    MainFrame.Size = UDim2.new(0, 450, 0, 300)
    
    local Corner = Instance.new("UICorner", MainFrame)
    Corner.CornerRadius = UDim.new(0, 10)

    local Title = Instance.new("TextLabel", MainFrame)
    Title.Name = "Title"
    Title.Text = hubName or "NEWBIE ELITE"
    Title.Size = UDim2.new(1, 0, 0, 40)
    Title.BackgroundTransparency = 1
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16

    local Container = Instance.new("ScrollingFrame", MainFrame)
    Container.Name = "Container"
    Container.Position = UDim2.new(0, 10, 0, 50)
    Container.Size = UDim2.new(1, -20, 1, -60)
    Container.BackgroundTransparency = 1
    Container.ScrollBarThickness = 2
    Container.CanvasSize = UDim2.new(0, 0, 0, 0)
    
    local UIListLayout = Instance.new("UIListLayout", Container)
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

    -- Sürükleme Özelliği (Draggable)
    local dragging, dragInput, dragStart, startPos
    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    local Elements = {}

    function Elements:CreateButton(name, callback)
        local Button = Instance.new("TextButton", Container)
        Button.Name = name .. "Btn"
        Button.Text = name
        Button.Size = UDim2.new(1, 0, 0, 35)
        Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Button.TextColor3 = Color3.fromRGB(255, 255, 255)
        Button.Font = Enum.Font.GothamMedium
        Button.TextSize = 14
        Instance.new("UICorner", Button).CornerRadius = UDim.new(0, 6)
        
        Button.MouseButton1Click:Connect(function()
            callback()
            -- Efekt (Tween)
            Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            task.wait(0.1)
            Button.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        end)
        
        Container.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
    end

    function Elements:Destroy()
        ScreenGui:Destroy()
    end

    return Elements
end

print("Newbie Elite UI Library Loaded Successfully!")
return Library