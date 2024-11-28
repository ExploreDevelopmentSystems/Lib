-- Moon Library
local Moon = {}
local UIS = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

-- Create main UI
function Moon:CreateUI(title)
    local ScreenGui = Instance.new("ScreenGui")
    local MainFrame = Instance.new("Frame")
    local TopBar = Instance.new("Frame")
    local Title = Instance.new("TextLabel")
    local TabsHolder = Instance.new("Frame")
    
    -- ScreenGui setup
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.Name = "MoonUI"
    
    -- MainFrame setup
    MainFrame.Name = "MainFrame"
    MainFrame.Parent = ScreenGui
    MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    MainFrame.Size = UDim2.new(0, 400, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
    MainFrame.Active = true
    MainFrame.Draggable = true

    -- TopBar setup
    TopBar.Name = "TopBar"
    TopBar.Parent = MainFrame
    TopBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TopBar.Size = UDim2.new(1, 0, 0, 30)

    -- Title setup
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

    -- TabsHolder setup
    TabsHolder.Name = "TabsHolder"
    TabsHolder.Parent = MainFrame
    TabsHolder.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    TabsHolder.Size = UDim2.new(1, 0, 0, 30)
    TabsHolder.Position = UDim2.new(0, 0, 0, 30)
    
    return {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TopBar = TopBar,
        TabsHolder = TabsHolder
    }
end

-- Add a tab
function Moon:AddTab(ui, name)
    local TabButton = Instance.new("TextButton")

    TabButton.Name = name
    TabButton.Parent = ui.TabsHolder
    TabButton.Text = name
    TabButton.Font = Enum.Font.SourceSansBold
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.Size = UDim2.new(0, 80, 1, 0)
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.BorderSizePixel = 0

    return TabButton
end

-- Toggling visibility
function Moon:ToggleUI(ui)
    ui.MainFrame.Visible = not ui.MainFrame.Visible
end

return Moon
