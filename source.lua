-- Moon UI Library
local Moon = {}

function Moon:CreateLibrary()
    -- Services
    local UserInputService = game:GetService("UserInputService")

    -- ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "MoonUI"
    ScreenGui.Parent = game.CoreGui

    -- Main Frame
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.Parent = ScreenGui

    -- Draggable logic
    local dragging, dragInput, dragStart, startPos

    MainFrame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    MainFrame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)

    -- Top bar for tabs
    local TabBar = Instance.new("Frame")
    TabBar.Name = "TabBar"
    TabBar.Size = UDim2.new(1, 0, 0, 30)
    TabBar.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabBar.BorderSizePixel = 0
    TabBar.Parent = MainFrame

    -- Tab container
    local Tabs = {}

    -- Togglable feature
    local toggleKey = Enum.KeyCode.RightShift
    local uiVisible = true

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and input.KeyCode == toggleKey then
            uiVisible = not uiVisible
            MainFrame.Visible = uiVisible
        end
    end)

    -- Function to create tabs
    function Moon:CreateTab(name)
        local TabButton = Instance.new("TextButton")
        TabButton.Name = name .. "Button"
        TabButton.Size = UDim2.new(0, 100, 1, 0)
        TabButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
        TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BorderSizePixel = 0
        TabButton.Text = name
        TabButton.Font = Enum.Font.SourceSans
        TabButton.TextSize = 18
        TabButton.Parent = TabBar

        -- Tab frame
        local TabFrame = Instance.new("Frame")
        TabFrame.Name = name .. "Frame"
        TabFrame.Size = UDim2.new(1, 0, 1, -30)
        TabFrame.Position = UDim2.new(0, 0, 0, 30)
        TabFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        TabFrame.BorderSizePixel = 0
        TabFrame.Visible = false
        TabFrame.Parent = MainFrame

        Tabs[name] = TabFrame

        -- Tab switching
        TabButton.MouseButton1Click:Connect(function()
            for _, frame in pairs(Tabs) do
                frame.Visible = false
            end
            TabFrame.Visible = true
        end)

        return TabFrame
    end

    return Moon
end

return Moon
