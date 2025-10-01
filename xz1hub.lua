-- XZ1Hub Easy-to-Use GUI Library (Kavo Style)
-- Made by XZ1Hub Team

local XZ1Hub = {}
XZ1Hub.__index = XZ1Hub

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local CoreGui = game:GetService("CoreGui")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Beautiful Themes
local Themes = {
    Default = {
        name = "XZ1 Signature",
        bg = Color3.fromRGB(8, 8, 15),
        bgLight = Color3.fromRGB(15, 15, 25),
        primary = Color3.fromRGB(0, 162, 255),
        secondary = Color3.fromRGB(50, 205, 50),
        accent = Color3.fromRGB(100, 220, 255),
        text = Color3.fromRGB(255, 255, 255)
    },
    Matrix = {
        name = "Matrix Green",
        bg = Color3.fromRGB(5, 15, 5),
        bgLight = Color3.fromRGB(10, 25, 10),
        primary = Color3.fromRGB(0, 255, 100),
        secondary = Color3.fromRGB(50, 255, 150),
        accent = Color3.fromRGB(150, 255, 200),
        text = Color3.fromRGB(255, 255, 255)
    },
    Purple = {
        name = "Cyber Purple",
        bg = Color3.fromRGB(12, 8, 20),
        bgLight = Color3.fromRGB(20, 15, 30),
        primary = Color3.fromRGB(138, 43, 226),
        secondary = Color3.fromRGB(186, 85, 211),
        accent = Color3.fromRGB(218, 112, 214),
        text = Color3.fromRGB(255, 255, 255)
    },
    Fire = {
        name = "Fire Red",
        bg = Color3.fromRGB(20, 8, 8),
        bgLight = Color3.fromRGB(30, 15, 15),
        primary = Color3.fromRGB(255, 69, 0),
        secondary = Color3.fromRGB(255, 140, 0),
        accent = Color3.fromRGB(255, 165, 0),
        text = Color3.fromRGB(255, 255, 255)
    }
}

-- Helper Functions
local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 10)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Transparency = 0.5
    stroke.Parent = parent
    return stroke
end

local function tweenSize(obj, targetSize, duration)
    TweenService:Create(obj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quart), {
        Size = targetSize
    }):Play()
end

local function tweenPosition(obj, targetPos, duration)
    TweenService:Create(obj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quart), {
        Position = targetPos
    }):Play()
end

local function tweenColor(obj, targetColor, duration)
    TweenService:Create(obj, TweenInfo.new(duration or 0.3, Enum.EasingStyle.Quart), {
        BackgroundColor3 = targetColor
    }):Play()
end

-- Main Library
function XZ1Hub:CreateWindow(config)
    local window = {
        Tabs = {},
        CurrentTab = nil,
        Theme = Themes[config.Theme] or Themes.Default
    }
    
    -- Create ScreenGui
    local gui = Instance.new("ScreenGui")
    gui.Name = "XZ1HubGUI"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 999999999
    gui.Parent = CoreGui
    
    -- Check if mobile
    local isMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
    
    -- Variables
    local isOpen = false
    
    -- Icon Button
    local iconFrame = Instance.new("Frame")
    iconFrame.Size = UDim2.new(0, 70, 0, 70)
    iconFrame.Position = UDim2.new(0, 20, 0, 20)
    iconFrame.BackgroundColor3 = window.Theme.bg
    iconFrame.BorderSizePixel = 0
    iconFrame.ZIndex = 1000
    iconFrame.Parent = gui
    createCorner(iconFrame, 15)
    
    local iconStroke = createStroke(iconFrame, window.Theme.primary, 2)
    
    local iconButton = Instance.new("TextButton")
    iconButton.Size = UDim2.new(1, 0, 1, 0)
    iconButton.BackgroundTransparency = 1
    iconButton.Text = ""
    iconButton.ZIndex = 1001
    iconButton.Parent = iconFrame
    
    -- XZ Logo
    local logoX = Instance.new("TextLabel")
    logoX.Size = UDim2.new(0.5, 0, 0.6, 0)
    logoX.Position = UDim2.new(0.05, 0, 0.1, 0)
    logoX.BackgroundTransparency = 1
    logoX.Text = "X"
    logoX.Font = Enum.Font.GothamBold
    logoX.TextSize = 22
    logoX.TextColor3 = window.Theme.primary
    logoX.ZIndex = 1002
    logoX.Parent = iconFrame
    
    local logoZ = Instance.new("TextLabel")
    logoZ.Size = UDim2.new(0.5, 0, 0.6, 0)
    logoZ.Position = UDim2.new(0.45, 0, 0.1, 0)
    logoZ.BackgroundTransparency = 1
    logoZ.Text = "Z"
    logoZ.Font = Enum.Font.GothamBold
    logoZ.TextSize = 22
    logoZ.TextColor3 = window.Theme.secondary
    logoZ.ZIndex = 1002
    logoZ.Parent = iconFrame
    
    local logoHub = Instance.new("TextLabel")
    logoHub.Size = UDim2.new(1, 0, 0.3, 0)
    logoHub.Position = UDim2.new(0, 0, 0.7, 0)
    logoHub.BackgroundTransparency = 1
    logoHub.Text = "Hub"
    logoHub.Font = Enum.Font.Gotham
    logoHub.TextSize = 10
    logoHub.TextColor3 = window.Theme.accent
    logoHub.ZIndex = 1002
    logoHub.Parent = iconFrame
    
    -- Main Window
    local mainSize = isMobile and {w = 650, h = 400} or {w = 800, h = 450}
    
    local main = Instance.new("Frame")
    main.Size = UDim2.new(0, mainSize.w, 0, mainSize.h)
    main.Position = UDim2.new(0.5, -mainSize.w/2, 0.5, -mainSize.h/2)
    main.BackgroundColor3 = window.Theme.bg
    main.BorderSizePixel = 0
    main.Visible = false
    main.ZIndex = 500
    main.Parent = gui
    createCorner(main, 15)
    createStroke(main, window.Theme.primary, 2)
    
    -- Top Bar
    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 45)
    topBar.BackgroundColor3 = window.Theme.bgLight
    topBar.BorderSizePixel = 0
    topBar.ZIndex = 501
    topBar.Parent = main
    createCorner(topBar, 15)
    
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(0.7, 0, 1, 0)
    title.Position = UDim2.new(0, 15, 0, 0)
    title.BackgroundTransparency = 1
    title.Text = config.Title or "XZ1Hub"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 18
    title.TextColor3 = window.Theme.primary
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.ZIndex = 502
    title.Parent = topBar
    
    local closeBtn = Instance.new("TextButton")
    closeBtn.Size = UDim2.new(0, 35, 0, 35)
    closeBtn.Position = UDim2.new(1, -40, 0.5, -17.5)
    closeBtn.BackgroundColor3 = Color3.fromRGB(220, 60, 60)
    closeBtn.Text = "X"
    closeBtn.Font = Enum.Font.GothamBold
    closeBtn.TextSize = 16
    closeBtn.TextColor3 = Color3.new(1,1,1)
    closeBtn.BorderSizePixel = 0
    closeBtn.ZIndex = 502
    closeBtn.Parent = topBar
    createCorner(closeBtn, 8)
    
    -- Tab Container
    local tabContainer = Instance.new("Frame")
    tabContainer.Size = UDim2.new(0, 150, 1, -50)
    tabContainer.Position = UDim2.new(0, 5, 0, 50)
    tabContainer.BackgroundTransparency = 1
    tabContainer.ZIndex = 501
    tabContainer.Parent = main
    
    -- Content Container
    local contentContainer = Instance.new("Frame")
    contentContainer.Size = UDim2.new(1, -165, 1, -55)
    contentContainer.Position = UDim2.new(0, 160, 0, 50)
    contentContainer.BackgroundTransparency = 1
    contentContainer.ZIndex = 501
    contentContainer.Parent = main
    
    -- Functions
    local function openWindow()
        if isOpen then return end
        isOpen = true
        main.Visible = true
        main.Size = UDim2.new(0, 0, 0, 0)
        tweenSize(main, UDim2.new(0, mainSize.w, 0, mainSize.h), 0.4)
    end
    
    local function closeWindow()
        if not isOpen then return end
        isOpen = false
        tweenSize(main, UDim2.new(0, 0, 0, 0), 0.3)
        wait(0.3)
        main.Visible = false
    end
    
    iconButton.MouseButton1Click:Connect(function()
        if isOpen then closeWindow() else openWindow() end
    end)
    
    closeBtn.MouseButton1Click:Connect(closeWindow)
    
    -- Dragging
    local dragging, dragInput, dragStart, startPos
    
    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
    
    topBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - dragStart
            main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    
    -- Tab System
    function window:CreateTab(tabName)
        local tab = {
            Name = tabName,
            Elements = {},
            Content = nil,
            Button = nil
        }
        
        -- Tab Button
        local tabBtn = Instance.new("TextButton")
        tabBtn.Size = UDim2.new(1, -10, 0, 35)
        tabBtn.Position = UDim2.new(0, 5, 0, (#self.Tabs * 40) + 5)
        tabBtn.BackgroundColor3 = #self.Tabs == 0 and window.Theme.primary or window.Theme.bgLight
        tabBtn.Text = tabName
        tabBtn.Font = Enum.Font.GothamSemibold
        tabBtn.TextSize = 14
        tabBtn.TextColor3 = Color3.new(1,1,1)
        tabBtn.BorderSizePixel = 0
        tabBtn.ZIndex = 502
        tabBtn.Parent = tabContainer
        createCorner(tabBtn, 8)
        
        tab.Button = tabBtn
        
        -- Tab Content
        local content = Instance.new("ScrollingFrame")
        content.Size = UDim2.new(1, 0, 1, 0)
        content.BackgroundTransparency = 1
        content.BorderSizePixel = 0
        content.ScrollBarThickness = 6
        content.ScrollBarImageColor3 = window.Theme.primary
        content.CanvasSize = UDim2.new(0, 0, 0, 0)
        content.Visible = #self.Tabs == 0
        content.ZIndex = 502
        content.Parent = contentContainer
        
        local listLayout = Instance.new("UIListLayout")
        listLayout.Padding = UDim.new(0, 8)
        listLayout.Parent = content
        
        listLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            content.CanvasSize = UDim2.new(0, 0, 0, listLayout.AbsoluteContentSize.Y + 10)
        end)
        
        tab.Content = content
        
        -- Tab switching
        tabBtn.MouseButton1Click:Connect(function()
            for _, t in pairs(self.Tabs) do
                t.Content.Visible = false
                tweenColor(t.Button, window.Theme.bgLight, 0.2)
            end
            
            content.Visible = true
            tweenColor(tabBtn, window.Theme.primary, 0.2)
            self.CurrentTab = tab
        end)
        
        if #self.Tabs == 0 then
            self.CurrentTab = tab
        end
        
        table.insert(self.Tabs, tab)
        
        -- Section System
        function tab:CreateSection(sectionName)
            local section = {
                Name = sectionName,
                Container = nil
            }
            
            local sectionFrame = Instance.new("Frame")
            sectionFrame.Size = UDim2.new(1, -10, 0, 40)
            sectionFrame.BackgroundColor3 = window.Theme.bgLight
            sectionFrame.BorderSizePixel = 0
            sectionFrame.ZIndex = 503
            sectionFrame.Parent = content
            createCorner(sectionFrame, 10)
            createStroke(sectionFrame, window.Theme.primary, 1)
            
            local sectionLabel = Instance.new("TextLabel")
            sectionLabel.Size = UDim2.new(1, -20, 1, 0)
            sectionLabel.Position = UDim2.new(0, 10, 0, 0)
            sectionLabel.BackgroundTransparency = 1
            sectionLabel.Text = sectionName
            sectionLabel.Font = Enum.Font.GothamBold
            sectionLabel.TextSize = 15
            sectionLabel.TextColor3 = window.Theme.primary
            sectionLabel.TextXAlignment = Enum.TextXAlignment.Left
            sectionLabel.ZIndex = 504
            sectionLabel.Parent = sectionFrame
            
            section.Container = sectionFrame
            
            return section
        end
        
        -- Button
        function tab:CreateButton(config)
            local btnFrame = Instance.new("Frame")
            btnFrame.Size = UDim2.new(1, -10, 0, 40)
            btnFrame.BackgroundColor3 = window.Theme.bgLight
            btnFrame.BorderSizePixel = 0
            btnFrame.ZIndex = 503
            btnFrame.Parent = content
            createCorner(btnFrame, 10)
            
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1, -10, 0, 30)
            btn.Position = UDim2.new(0, 5, 0, 5)
            btn.BackgroundColor3 = window.Theme.primary
            btn.Text = config.Name or "Button"
            btn.Font = Enum.Font.GothamSemibold
            btn.TextSize = 13
            btn.TextColor3 = Color3.new(1,1,1)
            btn.BorderSizePixel = 0
            btn.ZIndex = 504
            btn.Parent = btnFrame
            createCorner(btn, 8)
            
            btn.MouseButton1Click:Connect(function()
                tweenColor(btn, window.Theme.secondary, 0.1)
                wait(0.1)
                tweenColor(btn, window.Theme.primary, 0.1)
                
                if config.Callback then
                    config.Callback()
                end
            end)
        end
        
        -- Toggle
        function tab:CreateToggle(config)
            local toggleFrame = Instance.new("Frame")
            toggleFrame.Size = UDim2.new(1, -10, 0, 40)
            toggleFrame.BackgroundColor3 = window.Theme.bgLight
            toggleFrame.BorderSizePixel = 0
            toggleFrame.ZIndex = 503
            toggleFrame.Parent = content
            createCorner(toggleFrame, 10)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.7, 0, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Toggle"
            label.Font = Enum.Font.GothamSemibold
            label.TextSize = 13
            label.TextColor3 = Color3.new(1,1,1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 504
            label.Parent = toggleFrame
            
            local toggleBg = Instance.new("Frame")
            toggleBg.Size = UDim2.new(0, 45, 0, 25)
            toggleBg.Position = UDim2.new(1, -55, 0.5, -12.5)
            toggleBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            toggleBg.BorderSizePixel = 0
            toggleBg.ZIndex = 504
            toggleBg.Parent = toggleFrame
            createCorner(toggleBg, 12)
            
            local toggleCircle = Instance.new("Frame")
            toggleCircle.Size = UDim2.new(0, 19, 0, 19)
            toggleCircle.Position = UDim2.new(0, 3, 0.5, -9.5)
            toggleCircle.BackgroundColor3 = Color3.new(1,1,1)
            toggleCircle.BorderSizePixel = 0
            toggleCircle.ZIndex = 505
            toggleCircle.Parent = toggleBg
            createCorner(toggleCircle, 10)
            
            local enabled = config.Default or false
            
            if enabled then
                toggleBg.BackgroundColor3 = window.Theme.primary
                toggleCircle.Position = UDim2.new(1, -22, 0.5, -9.5)
            end
            
            local toggleBtn = Instance.new("TextButton")
            toggleBtn.Size = UDim2.new(1, 0, 1, 0)
            toggleBtn.BackgroundTransparency = 1
            toggleBtn.Text = ""
            toggleBtn.ZIndex = 506
            toggleBtn.Parent = toggleBg
            
            toggleBtn.MouseButton1Click:Connect(function()
                enabled = not enabled
                
                if enabled then
                    tweenPosition(toggleCircle, UDim2.new(1, -22, 0.5, -9.5), 0.2)
                    tweenColor(toggleBg, window.Theme.primary, 0.2)
                else
                    tweenPosition(toggleCircle, UDim2.new(0, 3, 0.5, -9.5), 0.2)
                    tweenColor(toggleBg, Color3.fromRGB(60, 60, 80), 0.2)
                end
                
                if config.Callback then
                    config.Callback(enabled)
                end
            end)
        end
        
        -- Slider
        function tab:CreateSlider(config)
            local min = config.Min or 0
            local max = config.Max or 100
            local default = config.Default or min
            local currentValue = default
            
            local sliderFrame = Instance.new("Frame")
            sliderFrame.Size = UDim2.new(1, -10, 0, 55)
            sliderFrame.BackgroundColor3 = window.Theme.bgLight
            sliderFrame.BorderSizePixel = 0
            sliderFrame.ZIndex = 503
            sliderFrame.Parent = content
            createCorner(sliderFrame, 10)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.7, 0, 0, 20)
            label.Position = UDim2.new(0, 10, 0, 5)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Slider"
            label.Font = Enum.Font.GothamSemibold
            label.TextSize = 13
            label.TextColor3 = Color3.new(1,1,1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 504
            label.Parent = sliderFrame
            
            local valueLabel = Instance.new("TextLabel")
            valueLabel.Size = UDim2.new(0.3, 0, 0, 20)
            valueLabel.Position = UDim2.new(0.7, 0, 0, 5)
            valueLabel.BackgroundTransparency = 1
            valueLabel.Text = tostring(default)
            valueLabel.Font = Enum.Font.GothamBold
            valueLabel.TextSize = 13
            valueLabel.TextColor3 = window.Theme.primary
            valueLabel.TextXAlignment = Enum.TextXAlignment.Right
            valueLabel.ZIndex = 504
            valueLabel.Parent = sliderFrame
            
            local sliderBg = Instance.new("Frame")
            sliderBg.Size = UDim2.new(1, -20, 0, 8)
            sliderBg.Position = UDim2.new(0, 10, 1, -15)
            sliderBg.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            sliderBg.BorderSizePixel = 0
            sliderBg.ZIndex = 504
            sliderBg.Parent = sliderFrame
            createCorner(sliderBg, 4)
            
            local sliderFill = Instance.new("Frame")
            sliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
            sliderFill.BackgroundColor3 = window.Theme.primary
            sliderFill.BorderSizePixel = 0
            sliderFill.ZIndex = 505
            sliderFill.Parent = sliderBg
            createCorner(sliderFill, 4)
            
            local dragging = false
            
            sliderBg.InputBegan:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = true
                end
            end)
            
            UserInputService.InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    dragging = false
                end
            end)
            
            UserInputService.InputChanged:Connect(function(input)
                if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                    local pos = math.clamp((input.Position.X - sliderBg.AbsolutePosition.X) / sliderBg.AbsoluteSize.X, 0, 1)
                    currentValue = math.floor(min + (max - min) * pos)
                    
                    sliderFill.Size = UDim2.new(pos, 0, 1, 0)
                    valueLabel.Text = tostring(currentValue)
                    
                    if config.Callback then
                        config.Callback(currentValue)
                    end
                end
            end)
        end
        
        -- Dropdown
        function tab:CreateDropdown(config)
            local options = config.Options or {}
            local selected = config.Default or options[1]
            local isOpen = false
            
            local dropFrame = Instance.new("Frame")
            dropFrame.Size = UDim2.new(1, -10, 0, 40)
            dropFrame.BackgroundColor3 = window.Theme.bgLight
            dropFrame.BorderSizePixel = 0
            dropFrame.ZIndex = 503
            dropFrame.Parent = content
            createCorner(dropFrame, 10)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.4, 0, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Dropdown"
            label.Font = Enum.Font.GothamSemibold
            label.TextSize = 13
            label.TextColor3 = Color3.new(1,1,1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 504
            label.Parent = dropFrame
            
            local dropBtn = Instance.new("TextButton")
            dropBtn.Size = UDim2.new(0.55, 0, 0, 30)
            dropBtn.Position = UDim2.new(0.43, 0, 0.5, -15)
            dropBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            dropBtn.Text = selected
            dropBtn.Font = Enum.Font.Gotham
            dropBtn.TextSize = 12
            dropBtn.TextColor3 = Color3.new(1,1,1)
            dropBtn.BorderSizePixel = 0
            dropBtn.ZIndex = 504
            dropBtn.Parent = dropFrame
            createCorner(dropBtn, 8)
            
            local optionsFrame = Instance.new("Frame")
            optionsFrame.Size = UDim2.new(0.55, 0, 0, 0)
            optionsFrame.Position = UDim2.new(0.43, 0, 1, 5)
            optionsFrame.BackgroundColor3 = window.Theme.bgLight
            optionsFrame.BorderSizePixel = 0
            optionsFrame.Visible = false
            optionsFrame.ZIndex = 600
            optionsFrame.ClipsDescendants = true
            optionsFrame.Parent = dropFrame
            createCorner(optionsFrame, 8)
            createStroke(optionsFrame, window.Theme.primary, 1)
            
            for i, option in pairs(options) do
                local optionBtn = Instance.new("TextButton")
                optionBtn.Size = UDim2.new(1, 0, 0, 25)
                optionBtn.Position = UDim2.new(0, 0, 0, (i-1) * 25)
                optionBtn.BackgroundTransparency = 1
                optionBtn.Text = option
                optionBtn.Font = Enum.Font.Gotham
                optionBtn.TextSize = 11
                optionBtn.TextColor3 = Color3.new(1,1,1)
                optionBtn.ZIndex = 601
                optionBtn.Parent = optionsFrame
                
                optionBtn.MouseButton1Click:Connect(function()
                    selected = option
                    dropBtn.Text = option
                    isOpen = false
                    tweenSize(optionsFrame, UDim2.new(0.55, 0, 0, 0), 0.2)
                    wait(0.2)
                    optionsFrame.Visible = false
                    
                    if config.Callback then
                        config.Callback(option)
                    end
                end)
            end
            
            dropBtn.MouseButton1Click:Connect(function()
                isOpen = not isOpen
                if isOpen then
                    optionsFrame.Visible = true
                    tweenSize(optionsFrame, UDim2.new(0.55, 0, 0, #options * 25), 0.2)
                else
                    tweenSize(optionsFrame, UDim2.new(0.55, 0, 0, 0), 0.2)
                    wait(0.2)
                    optionsFrame.Visible = false
                end
            end)
        end
        
        -- Input
        function tab:CreateInput(config)
            local inputFrame = Instance.new("Frame")
            inputFrame.Size = UDim2.new(1, -10, 0, 40)
            inputFrame.BackgroundColor3 = window.Theme.bgLight
            inputFrame.BorderSizePixel = 0
            inputFrame.ZIndex = 503
            inputFrame.Parent = content
            createCorner(inputFrame, 10)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.35, 0, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Input"
            label.Font = Enum.Font.GothamSemibold
            label.TextSize = 13
            label.TextColor3 = Color3.new(1,1,1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 504
            label.Parent = inputFrame
            
            local inputBox = Instance.new("TextBox")
            inputBox.Size = UDim2.new(0.6, 0, 0, 30)
            inputBox.Position = UDim2.new(0.38, 0, 0.5, -15)
            inputBox.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            inputBox.PlaceholderText = config.Placeholder or "Enter text..."
            inputBox.Text = config.Default or ""
            inputBox.Font = Enum.Font.Gotham
            inputBox.TextSize = 12
            inputBox.TextColor3 = Color3.new(1,1,1)
            inputBox.PlaceholderColor3 = Color3.fromRGB(150, 150, 150)
            inputBox.BorderSizePixel = 0
            inputBox.ZIndex = 504
            inputBox.Parent = inputFrame
            createCorner(inputBox, 8)
            
            inputBox.FocusLost:Connect(function(enterPressed)
                if enterPressed and config.Callback then
                    config.Callback(inputBox.Text)
                end
            end)
        end
        
        -- Label
        function tab:CreateLabel(text)
            local labelFrame = Instance.new("Frame")
            labelFrame.Size = UDim2.new(1, -10, 0, 35)
            labelFrame.BackgroundColor3 = window.Theme.bgLight
            labelFrame.BorderSizePixel = 0
            labelFrame.ZIndex = 503
            labelFrame.Parent = content
            createCorner(labelFrame, 10)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(1, -20, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = text or "Label"
            label.Font = Enum.Font.Gotham
            label.TextSize = 13
            label.TextColor3 = window.Theme.accent
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 504
            label.Parent = labelFrame
            
            return {
                UpdateText = function(self, newText)
                    label.Text = newText
                end
            }
        end
        
        -- Keybind
        function tab:CreateKeybind(config)
            local currentKey = config.Default or Enum.KeyCode.E
            local binding = false
            
            local keybindFrame = Instance.new("Frame")
            keybindFrame.Size = UDim2.new(1, -10, 0, 40)
            keybindFrame.BackgroundColor3 = window.Theme.bgLight
            keybindFrame.BorderSizePixel = 0
            keybindFrame.ZIndex = 503
            keybindFrame.Parent = content
            createCorner(keybindFrame, 10)
            
            local label = Instance.new("TextLabel")
            label.Size = UDim2.new(0.5, 0, 1, 0)
            label.Position = UDim2.new(0, 10, 0, 0)
            label.BackgroundTransparency = 1
            label.Text = config.Name or "Keybind"
            label.Font = Enum.Font.GothamSemibold
            label.TextSize = 13
            label.TextColor3 = Color3.new(1,1,1)
            label.TextXAlignment = Enum.TextXAlignment.Left
            label.ZIndex = 504
            label.Parent = keybindFrame
            
            local keyBtn = Instance.new("TextButton")
            keyBtn.Size = UDim2.new(0.35, 0, 0, 30)
            keyBtn.Position = UDim2.new(0.63, 0, 0.5, -15)
            keyBtn.BackgroundColor3 = window.Theme.primary
            keyBtn.Text = currentKey.Name
            keyBtn.Font = Enum.Font.GothamBold
            keyBtn.TextSize = 12
            keyBtn.TextColor3 = Color3.new(1,1,1)
            keyBtn.BorderSizePixel = 0
            keyBtn.ZIndex = 504
            keyBtn.Parent = keybindFrame
            createCorner(keyBtn, 8)
            
            keyBtn.MouseButton1Click:Connect(function()
                binding = true
                keyBtn.Text = "..."
            end)
            
            UserInputService.InputBegan:Connect(function(input, processed)
                if binding then
                    if input.KeyCode ~= Enum.KeyCode.Unknown then
                        currentKey = input.KeyCode
                        keyBtn.Text = currentKey.Name
                        binding = false
                    end
                elseif not processed and input.KeyCode == currentKey and config.Callback then
                    config.Callback()
                end
            end)
        end
        
        return tab
    end
    
    return window
end

return XZ1Hub
