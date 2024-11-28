-- Moon UI Library
local Moon = {}
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

function Moon:CreateUI(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabsHolder = Instance.new("Frame")
    local ContentFrame = Instance.new("Frame")
    
    -- ScreenGui
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "MoonUI"
    
    -- MainFrame
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- TopBar
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    -- Title
    Title.Name = "Title"
    Title.Parent = TopBar
    Title.BackgroundTransparency = 1
    Title.Size = UDim2.new(1, -10, 1, 0)
    Title.Position = UDim2.new(0, 5, 0, 0)
    Title.Font = Enum.Font.SourceSansBold
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Text = title or "Moon UI"

    -- TabsHolder
    TabsHolder.Name = "TabsHolder"
    TabsHolder.Parent = MainFrame
    TabsHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabsHolder.Size = UDim2.new(1, 0, 0, 30)
    TabsHolder.Position = UDim2.new(0, 0, 0, 30)

    -- ContentFrame
    ContentFrame.Name = "ContentFrame"
    ContentFrame.Parent = MainFrame
    ContentFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    ContentFrame.Size = UDim2.new(1, 0, 1, -60)
    ContentFrame.Position = UDim2.new(0, 0, 0, 60)
    ContentFrame.ClipsDescendants = true
    
    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TopBar = TopBar,
        TabsHolder = TabsHolder,
        ContentFrame = ContentFrame
    }
end

function Moon:AddTab(ui, name)
    local TabButton = Instance.new("TextButton")
    local TabFrame = Instance.new("Frame")

    -- TabButton
    TabButton.Name = name
    TabButton.Parent = ui.TabsHolder
    TabButton.Text = name
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Size = UDim2.new(0, 80, 1, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.BorderSizePixel = 0

    -- TabFrame (Content)
    TabFrame.Name = name
    TabFrame.Parent = ui.ContentFrame
    TabFrame.Size = UDim2.new(1, 0, 1, 0)
    TabFrame.BackgroundTransparency = 1
    TabFrame.Visible = false

    TabButton.MouseButton1Click:Connect(function()
        for _, frame in pairs(ui.ContentFrame:GetChildren()) do
            if frame:IsA("Frame") then
                frame.Visible = false
            end
        end
        TabFrame.Visible = true
    end)
    
    return TabFrame
end

function Moon:AddButton(tab, name, callback)
    local Button = Instance.new("TextButton")

    Button.Parent = tab
    Button.Text = name
    Button.Font = Enum.Font.SourceSansBold
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Size = UDim2.new(1, -10, 0, 30)
    Button.Position = UDim2.new(0, 5, 0, #tab:GetChildren() * 35)
    Button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Button.BorderSizePixel = 0

    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)
end

function Moon:AddToggle(tab, name, callback)
    local Toggle = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local Button = Instance.new("TextButton")
    local toggled = false

    -- Toggle Frame
    Toggle.Parent = tab
    Toggle.Size = UDim2.new(1, -10, 0, 30)
    Toggle.Position = UDim2.new(0, 5, 0, #tab:GetChildren() * 35)
    Toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Toggle.BorderSizePixel = 0

    -- TextLabel
    TextLabel.Parent = Toggle
    TextLabel.Text = name
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Size = UDim2.new(0.8, 0, 1, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- Button
    Button.Parent = Toggle
    Button.Text = "OFF"
    Button.Font = Enum.Font.SourceSansBold
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.Size = UDim2.new(0.2, 0, 1, 0)
    Button.Position = UDim2.new(0.8, 0, 0, 0)
    Button.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Button.BorderSizePixel = 0

    Button.MouseButton1Click:Connect(function()
        toggled = not toggled
        Button.Text = toggled and "ON" or "OFF"
        if callback then
            callback(toggled)
        end
    end)
end

function Moon:AddSlider(tab, name, min, max, callback)
    local Slider = Instance.new("Frame")
    local TextLabel = Instance.new("TextLabel")
    local SliderBar = Instance.new("Frame")
    local SliderButton = Instance.new("TextButton")
    local value = min

    -- Slider Frame
    Slider.Parent = tab
    Slider.Size = UDim2.new(1, -10, 0, 40)
    Slider.Position = UDim2.new(0, 5, 0, #tab:GetChildren() * 45)
    Slider.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Slider.BorderSizePixel = 0

    -- TextLabel
    TextLabel.Parent = Slider
    TextLabel.Text = name
    TextLabel.Font = Enum.Font.SourceSansBold
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.Size = UDim2.new(1, 0, 0.5, 0)
    TextLabel.BackgroundTransparency = 1
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    -- SliderBar
    SliderBar.Parent = Slider
    SliderBar.Size = UDim2.new(1, -20, 0.3, 0)
    SliderBar.Position = UDim2.new(0, 10, 0.6, 0)
    SliderBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)

    -- SliderButton
    SliderButton.Parent = SliderBar
    SliderButton.Size = UDim2.new(0, 10, 1, 0)
    SliderButton.Position = UDim2.new(0, 0, 0, 0)
    SliderButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    SliderButton.BorderSizePixel = 0

    local dragging = false
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)

    UIS.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    UIS.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local x = math.clamp(input.Position.X - SliderBar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
            SliderButton.Position = UDim2.new(0, x, 0, 0)
            value = math.floor(((x / SliderBar.AbsoluteSize.X) * (max - min)) + min)
            if callback then
                callback(value)
            end
        end
    end)
end

return Moon
