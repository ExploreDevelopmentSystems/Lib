local UI_Library = {}
local ScreenGui = Instance.new("ScreenGui")
local TweenService = game:GetService("TweenService")

ScreenGui.Name = "DrawingUILibrary"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

function UI_Library:CreateWindow(title)
    local window = Instance.new("Frame")
    window.Name = "Window"
    window.Size = UDim2.new(0, 300, 0, 400)
    window.Position = UDim2.new(0.5, -150, 0.5, -200)
    window.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    window.BorderSizePixel = 0
    window.Parent = ScreenGui

    local header = Instance.new("TextLabel")
    header.Size = UDim2.new(1, 0, 0, 30)
    header.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    header.TextColor3 = Color3.fromRGB(255, 255, 255)
    header.Text = title
    header.Font = Enum.Font.SourceSansBold
    header.TextSize = 20
    header.Parent = window

    local tabHolder = Instance.new("Frame")
    tabHolder.Size = UDim2.new(1, 0, 1, -30)
    tabHolder.Position = UDim2.new(0, 0, 0, 30)
    tabHolder.BackgroundTransparency = 1
    tabHolder.Parent = window

    local tabs = {}

    function tabs:CreateTab(tabTitle)
        local tabButton = Instance.new("TextButton")
        tabButton.Size = UDim2.new(1, -10, 0, 25)
        tabButton.Position = UDim2.new(0.5, -145, 0, (#tabHolder:GetChildren() - 1) * 30)
        tabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
        tabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        tabButton.Text = tabTitle
        tabButton.Font = Enum.Font.SourceSansBold
        tabButton.TextSize = 18
        tabButton.Parent = tabHolder

        local tabContent = Instance.new("Frame")
        tabContent.Size = UDim2.new(1, 0, 1, 0)
        tabContent.Position = UDim2.new(0, 0, 0, 0)
        tabContent.Visible = false
        tabContent.BackgroundTransparency = 1
        tabContent.Parent = window

        tabButton.MouseButton1Click:Connect(function()
            for _, v in ipairs(tabHolder:GetChildren()) do
                if v:IsA("TextButton") or v:IsA("Frame") then
                    v.Visible = false
                end
            end
            tabContent.Visible = true
        end)

        local tabFunctions = {}

        function tabFunctions:CreateButton(text, callback)
            local button = Instance.new("TextButton")
            button.Size = UDim2.new(0, 260, 0, 30)
            button.Position = UDim2.new(0.5, -130, 0, #tabContent:GetChildren() * 35)
            button.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            button.TextColor3 = Color3.fromRGB(255, 255, 255)
            button.Text = text
            button.Font = Enum.Font.SourceSansBold
            button.TextSize = 18
            button.Parent = tabContent

            button.MouseButton1Click:Connect(callback)
        end

        function tabFunctions:CreateToggle(text, callback)
            local toggle = Instance.new("TextButton")
            toggle.Size = UDim2.new(0, 260, 0, 30)
            toggle.Position = UDim2.new(0.5, -130, 0, #tabContent:GetChildren() * 35)
            toggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
            toggle.Text = text .. ": OFF"
            toggle.Font = Enum.Font.SourceSansBold
            toggle.TextSize = 18
            toggle.Parent = tabContent

            local toggled = false
            toggle.MouseButton1Click:Connect(function()
                toggled = not toggled
                toggle.Text = text .. (toggled and ": ON" or ": OFF")
                callback(toggled)
            end)
        end

        function tabFunctions:CreateSlider(text, min, max, default, callback)
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(0, 260, 0, 50)
            sliderFrame.Position = UDim2.new(0.5, -130, 0, #tabContent:GetChildren() * 55)
            sliderFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            sliderFrame.Parent = tabContent

            local sliderLabel = Instance.new("TextLabel")
            sliderLabel.Size = UDim2.new(1, 0, 0, 20)
            sliderLabel.Position = UDim2.new(0, 0, 0, 0)
            sliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            sliderLabel.Text = text .. ": " .. default
            sliderLabel.Font = Enum.Font.SourceSansBold
            sliderLabel.TextSize = 18
            sliderLabel.BackgroundTransparency = 1
            sliderLabel.Parent = sliderFrame

            local sliderBar = Instance.new("Frame")
            sliderBar.Size = UDim2.new(1, -20, 0, 10)
            sliderBar.Position = UDim2.new(0, 10, 0.5, 0)
            sliderBar.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
            sliderBar.Parent = sliderFrame

            local sliderKnob = Instance.new("Frame")
            sliderKnob.Size = UDim2.new(0, 10, 1, 0)
            sliderKnob.Position = UDim2.new((default - min) / (max - min), -5, 0, 0)
            sliderKnob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            sliderKnob.Parent = sliderBar

            local function updateSlider(inputPosition)
                local percentage = math.clamp((inputPosition - sliderBar.AbsolutePosition.X) / sliderBar.AbsoluteSize.X, 0, 1)
                local value = math.floor(min + (max - min) * percentage)
                sliderKnob.Position = UDim2.new(percentage, -5, 0, 0)
                sliderLabel.Text = text .. ": " .. value
                callback(value)
            end

            sliderKnob.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    local connection
                    connection = game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement then
                            updateSlider(input.Position.X)
                        end
                    end)
                    input.InputEnded:Connect(function()
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            connection:Disconnect()
                        end
                    end)
                end
            end)
        end

        return tabFunctions
    end

    return tabs
end

return UI_Library
