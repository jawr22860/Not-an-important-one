
-- MMV RECOLOR SCOPE
-- Remade GUI by: Jawrrr
-- Pastel Yellow Edition
-- 45 STYLES TOTAL

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

local GUN_TOOL_NAME = "Gun"

-- TARGETS
local TARGET_NAMES = {
    GunDisplay = true,
    MatrixScope = true,
    VoidScope = true,
}

-- ORIGINAL TEXTURES
local RED_TEXTURE_ID = "rbxassetid://84961185975751"
local BLUE_TEXTURE_ID = "rbxassetid://82435090032680"
local PURPLE_TEXTURE_ID = "rbxassetid://88934686234709"
local VOIDSCOPE_TEXTURE_ID = "rbxassetid://119603354495392"
local ROSESCOPE_TEXTURE_ID = "rbxassetid://102809990017058"
local WHITESCOPE_TEXTURE_ID = "rbxassetid://87412774611144"

local YELLOW_TEXTURE_ID = "rbxassetid://93795820856629"
local MINT_TEXTURE_ID = "rbxassetid://125134794312287"
local ORANGE_TEXTURE_ID = "rbxassetid://105138266693343"
local CYAN_TEXTURE_ID = "rbxassetid://113306613929919"
local HOT_PINK_TEXTURE_ID = "rbxassetid://138828394340170"
local LIME_TEXTURE_ID = "rbxassetid://110519054036197"
local BROWN_TEXTURE_ID = "rbxassetid://104022943640860"
local GOLD_TEXTURE_ID = "rbxassetid://98592687867961"
local GRAY_TEXTURE_ID = "rbxassetid://128114825439511"
local NEON_PURPLE_TEXTURE_ID = "rbxassetid://123877165198496"

local STARSCOPE_TEXTURE_ID = "rbxassetid://132065259622013"
local STARSCOPE_VIOLET_TEXTURE_ID = "rbxassetid://97204233483116"
local PINK_STARSCOPE_TEXTURE_ID = "rbxassetid://83357177609156"
local PASTELBROWN_STARSCOPE_TEXTURE_ID = "rbxassetid://136763276707143"
local PASTELBROWN_POLKA_TEXTURE_ID = "rbxassetid://133416165666330"

-- NEW JAWRRR TEXTURES
local BELLSCOPE_TEXTURE_ID = "rbxassetid://96035691811143"
local REDSNOWFLAKE_TEXTURE_ID = "rbxassetid://139541788083071"
local SNOWFLAKE_TEXTURE_ID = "rbxassetid://89433726900538"
local REDGREEN_SPARKLE_TEXTURE_ID = "rbxassetid://116210802809012"
local CHRISTMAS_TEXTURE_ID = "rbxassetid://115110031304454"
local PURPLEFADE_TEXTURE_ID = "rbxassetid://97588859519956"
local PURPLEFADE_STAR_TEXTURE_ID = "rbxassetid://78446786720002"
local BEACH_TEXTURE_ID = "rbxassetid://80545248146319"
local BLUEFADE_TEXTURE_ID = "rbxassetid://125737439403687"
local BLUEFADE_STAR_TEXTURE_ID = "rbxassetid://109633219885103"
local CREATOR_TEXTURE_ID = "rbxassetid://76337763452474"
local BRUNETTE_CREATOR_TEXTURE_ID = "rbxassetid://127023492380129"
local GREEN_CREATOR_TEXTURE_ID = "rbxassetid://118951008426637"
local DARKBLUE_CREATOR_TEXTURE_ID = "rbxassetid://122486041566682"
local NAVYBLUE_CREATOR_TEXTURE_ID = "rbxassetid://96308590831490"
local PASTELPINK_CREATOR_TEXTURE_ID = "rbxassetid://73391128057872"
local SKYBLUE_CREATOR_TEXTURE_ID = "rbxassetid://125011308305429"
local PASTELBLUE_CREATOR_TEXTURE_ID = "rbxassetid://111823714949063"
local PASTELGREEN_CREATOR_TEXTURE_ID = "rbxassetid://92122062941137"
local PASTELPURPLE_CREATOR_TEXTURE_ID = "rbxassetid://135601043956623"
local PURPLE_CREATOR_TEXTURE_ID = "rbxassetid://115794159216362"
local PASTELYELLOW_CREATOR_TEXTURE_ID = "rbxassetid://134142528421803"

-- PASTEL YELLOW THEME
local YELLOW = Color3.fromRGB(255, 239, 160)
local YELLOW_DARK = Color3.fromRGB(235, 207, 105)
local YELLOW_LIGHT = Color3.fromRGB(255, 248, 205)
local WHITE = Color3.fromRGB(255, 255, 255)
local BLACK = Color3.fromRGB(25, 25, 25)

-- SETTINGS
local CURRENT_STYLE = "Normal"
local TEXTURE_ID
local BEAM_COLOR

local selectedStyle = nil
local status

local originalProperties = {}
local appliedDisplay = nil

-- ALL 45 STYLES
local Styles = {
    {Name="Normal"},

    -- ORIGINAL SCOPES
    {Name="RedScope", Texture=RED_TEXTURE_ID, Beam=Color3.fromRGB(170,0,0)},
    {Name="BlueScope", Texture=BLUE_TEXTURE_ID, Beam=Color3.fromRGB(20,45,110)},
    {Name="Purple", Texture=PURPLE_TEXTURE_ID, Beam=Color3.fromRGB(115,35,170)},
    {Name="VoidScope", Texture=VOIDSCOPE_TEXTURE_ID, Beam=WHITE},
    {Name="Rosescope", Texture=ROSESCOPE_TEXTURE_ID, Beam=Color3.fromRGB(255,105,180)},
    {Name="WhiteScope", Texture=WHITESCOPE_TEXTURE_ID, Beam=WHITE},
    {Name="GhostScope", Ghost=true, Beam=WHITE},

    -- ORIGINAL COLOR SCOPES
    {Name="Cyan", Texture=CYAN_TEXTURE_ID, Beam=Color3.fromRGB(0,172,181)},
    {Name="Lime", Texture=LIME_TEXTURE_ID, Beam=Color3.fromRGB(77,121,32)},
    {Name="Yellow", Texture=YELLOW_TEXTURE_ID, Beam=Color3.fromRGB(240,211,109)},
    {Name="Orange", Texture=ORANGE_TEXTURE_ID, Beam=Color3.fromRGB(229,93,5)},
    {Name="Hot Pink", Texture=HOT_PINK_TEXTURE_ID, Beam=Color3.fromRGB(192,116,162)},
    {Name="Mint", Texture=MINT_TEXTURE_ID, Beam=Color3.fromRGB(167,211,188)},
    {Name="Neon Purple", Texture=NEON_PURPLE_TEXTURE_ID, Beam=Color3.fromRGB(118,9,178)},
    {Name="Brown", Texture=BROWN_TEXTURE_ID, Beam=Color3.fromRGB(62,33,20)},
    {Name="Gray", Texture=GRAY_TEXTURE_ID, Beam=Color3.fromRGB(44,45,49)},
    {Name="Gold", Texture=GOLD_TEXTURE_ID, Beam=Color3.fromRGB(239,182,93)},

    -- ORIGINAL STAR SCOPES
    {Name="Starscope", Texture=STARSCOPE_TEXTURE_ID, Beam=Color3.fromRGB(0,0,0)},
    {Name="Starscope violet", Texture=STARSCOPE_VIOLET_TEXTURE_ID, Beam=Color3.fromRGB(0,0,0)},
    {Name="Pink starscope", Texture=PINK_STARSCOPE_TEXTURE_ID, Beam=Color3.fromRGB(240,221,225)},
    {Name="Pastelbrown starscope", Texture=PASTELBROWN_STARSCOPE_TEXTURE_ID, Beam=Color3.fromRGB(234,212,188)},
    {Name="Pastelbrown polka", Texture=PASTELBROWN_POLKA_TEXTURE_ID, Beam=Color3.fromRGB(234,212,188)},

    -- NEW JAWRRR SCOPES
    {Name="Bellscope", Texture=BELLSCOPE_TEXTURE_ID, Beam=Color3.fromRGB(255,255,255)},
    {Name="Redsnowflakescope", Texture=REDSNOWFLAKE_TEXTURE_ID, Beam=Color3.fromRGB(99,19,30)},
    {Name="Snowflakescope", Texture=SNOWFLAKE_TEXTURE_ID, Beam=Color3.fromRGB(255,255,255)},
    {Name="Red/green sparklescope", Texture=REDGREEN_SPARKLE_TEXTURE_ID, Beam=Color3.fromRGB(71,11,13)},
    {Name="Christmasscope", Texture=CHRISTMAS_TEXTURE_ID, Beam=Color3.fromRGB(255,255,255)},
    {Name="Purplefade scope", Texture=PURPLEFADE_TEXTURE_ID, Beam=Color3.fromRGB(48,17,52)},
    {Name="Purplefade starscope", Texture=PURPLEFADE_STAR_TEXTURE_ID, Beam=Color3.fromRGB(138,60,146)},
    {Name="Beachscope", Texture=BEACH_TEXTURE_ID, Beam=Color3.fromRGB(29,113,142)},
    {Name="Bluefade scope", Texture=BLUEFADE_TEXTURE_ID, Beam=Color3.fromRGB(98,125,195)},
    {Name="Bluefade starscope", Texture=BLUEFADE_STAR_TEXTURE_ID, Beam=Color3.fromRGB(191,182,227)},
    {Name="Creatorscope", Texture=CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(248,89,86)},
    {Name="Brunette creatorscope", Texture=BRUNETTE_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(102,60,34)},
    {Name="Green creatorscope", Texture=GREEN_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(39,167,68)},
    {Name="Darkblue creatorscope", Texture=DARKBLUE_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(9,28,143)},
    {Name="Navy blue creatorscope", Texture=NAVYBLUE_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(18,32,91)},
    {Name="Pastelpink creatorscope", Texture=PASTELPINK_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(246,175,205)},
    {Name="Skyblue creatorscope", Texture=SKYBLUE_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(106,190,247)},
    {Name="Pastelblue creatorscope", Texture=PASTELBLUE_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(155,188,228)},
    {Name="Pastelgreen creatorscope", Texture=PASTELGREEN_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(162,222,172)},
    {Name="Pastelpurple creatorscope", Texture=PASTELPURPLE_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(190,162,224)},
    {Name="Purple creatorscope", Texture=PURPLE_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(207,138,254)},
    {Name="Pastelyellow creatorscope", Texture=PASTELYELLOW_CREATOR_TEXTURE_ID, Beam=Color3.fromRGB(245,237,154)},
}

-- SAVE ORIGINAL PROPERTIES
local function saveProperty(object, property)
    if not originalProperties[object] then
        originalProperties[object] = {}
    end

    if originalProperties[object][property] == nil then
        local success, value = pcall(function()
            return object[property]
        end)

        if success then
            originalProperties[object][property] = value
        end
    end
end

local function setSaved(object, property, value)
    pcall(function()
        saveProperty(object, property)
        object[property] = value
    end)
end

local function restoreOriginal()
    for object, properties in pairs(originalProperties) do
        if object and object.Parent then
            for property, value in pairs(properties) do
                pcall(function()
                    object[property] = value
                end)
            end
        end
    end

    table.clear(originalProperties)
    appliedDisplay = nil
end

-- VISUAL CHILDREN
local function hasVisualChild(part)
    for _, child in ipairs(part:GetChildren()) do
        if child:IsA("SpecialMesh")
        or child:IsA("Decal")
        or child:IsA("Texture") then
            return true
        end
    end

    return false
end

-- BEAM AND TRAIL
local function applyBeam(object)
    if not (object:IsA("Beam") or object:IsA("Trail")) then
        return
    end

    if CURRENT_STYLE == "GhostScope" then
        setSaved(object, "Color", ColorSequence.new(WHITE))
        setSaved(object, "Transparency", NumberSequence.new(0.5))

    elseif CURRENT_STYLE == "VoidScope" then
        setSaved(object, "Color", ColorSequence.new({
            ColorSequenceKeypoint.new(0, WHITE),
            ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170,170,170)),
            ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0)),
        }))

    elseif BEAM_COLOR then
        setSaved(object, "Color", ColorSequence.new(BEAM_COLOR))
    end
end

-- APPLY TEXTURE
local function applyObject(object)

    if CURRENT_STYLE == "GhostScope" then

        if object:IsA("MeshPart") then
            setSaved(object, "Color", WHITE)
            setSaved(object, "Transparency", 0.5)
            setSaved(object, "TextureID", "")

        elseif object:IsA("BasePart") then
            setSaved(object, "Color", WHITE)
            setSaved(object, "Transparency", 0.5)

        elseif object:IsA("SpecialMesh") then
            setSaved(object, "TextureId", "")
            setSaved(object, "VertexColor", Vector3.new(1,1,1))

        elseif object:IsA("Decal") or object:IsA("Texture") then
            setSaved(object, "Transparency", 1)

        elseif object:IsA("Beam") or object:IsA("Trail") then
            applyBeam(object)
        end

        return
    end

    if TEXTURE_ID then

        if object:IsA("MeshPart") then
            setSaved(object, "TextureID", TEXTURE_ID)

        elseif object:IsA("SpecialMesh") then
            setSaved(object, "TextureId", TEXTURE_ID)
            setSaved(object, "VertexColor", Vector3.new(1,1,1))

        elseif object:IsA("Decal") or object:IsA("Texture") then
            setSaved(object, "Texture", TEXTURE_ID)
            setSaved(object, "Color3", WHITE)

        elseif object:IsA("BasePart") then
            if hasVisualChild(object) then
                setSaved(object, "Color", WHITE)
            end

        elseif object:IsA("Beam") or object:IsA("Trail") then
            applyBeam(object)
        end

        return
    end

    if object:IsA("Beam") or object:IsA("Trail") then
        applyBeam(object)
    end
end

-- FIND NEAREST GUN DISPLAY
local function getObjectPosition(object)
    if object:IsA("BasePart") then
        return object.Position
    end

    local part = object:FindFirstChildWhichIsA("BasePart", true)

    if part then
        return part.Position
    end

    return nil
end

local function findNearestDisplay()
    local character = player.Character

    if not character then
        return nil
    end

    local rootPart = character:FindFirstChild("HumanoidRootPart")

    if not rootPart then
        return nil
    end

    local nearest = nil
    local shortestDistance = math.huge

    for _, object in ipairs(workspace:GetDescendants()) do
        if TARGET_NAMES[object.Name] then

            local position = getObjectPosition(object)

            if position then
                local distance = (rootPart.Position - position).Magnitude

                if distance < shortestDistance then
                    shortestDistance = distance
                    nearest = object
                end
            end
        end
    end

    return nearest, shortestDistance
end

-- APPLY TO NEAREST GUN DISPLAY
local function applyNearestGun()

    if not selectedStyle then
        status.Text = "Select a style first!"
        return
    end

    local nearest, distance = findNearestDisplay()

    if not nearest then
        status.Text = "No GunDisplay found!"
        return
    end

    restoreOriginal()

    CURRENT_STYLE = selectedStyle.Name
    TEXTURE_ID = selectedStyle.Texture
    BEAM_COLOR = selectedStyle.Beam

    if CURRENT_STYLE == "Normal" then
        status.Text = "Normal style selected."
        return
    end

    appliedDisplay = nearest

    applyObject(nearest)

    for _, object in ipairs(nearest:GetDescendants()) do
        applyObject(object)
    end

    status.Text = selectedStyle.Name .. " applied! " ..
        math.floor(distance) .. " studs away."
end

-- RESET
local function resetStyle()
    restoreOriginal()

    CURRENT_STYLE = "Normal"
    TEXTURE_ID = nil
    BEAM_COLOR = nil
    selectedStyle = Styles[1]

    status.Text = "Reset to Normal!"
end

-- REMOVE OLD GUI
local oldGui = PlayerGui:FindFirstChild("MatrixVoidPanel")

if oldGui then
    oldGui:Destroy()
end

-- SCREEN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MatrixVoidPanel"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.Parent = PlayerGui

-- MAIN FRAME
local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 300, 0, 285)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -142)
mainFrame.BackgroundColor3 = YELLOW_LIGHT
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 18)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = YELLOW_DARK
mainStroke.Thickness = 2

-- TITLE BAR
local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, -16, 0, 48)
titleBar.Position = UDim2.new(0, 8, 0, 8)
titleBar.BackgroundColor3 = YELLOW
titleBar.BorderSizePixel = 0
titleBar.Active = true
titleBar.Parent = mainFrame

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 13)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -55, 1, 0)
title.Position = UDim2.new(0, 13, 0, 0)
title.BackgroundTransparency = 1
title.Text = "JAWRRR"
title.TextColor3 = BLACK
title.TextSize = 18
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.new(1, -55, 0, 12)
subtitle.Position = UDim2.new(0, 13, 1, -14)
subtitle.BackgroundTransparency = 1
subtitle.Text = "GUN CUSTOMIZER"
subtitle.TextColor3 = BLACK
subtitle.TextSize = 8
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = titleBar

-- CLOSE BUTTON
local closeBtn = Instance.new("TextButton")
closeBtn.Size = UDim2.new(0, 30, 0, 30)
closeBtn.Position = UDim2.new(1, -38, 0, 9)
closeBtn.BackgroundColor3 = WHITE
closeBtn.Text = "×"
closeBtn.TextColor3 = BLACK
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.BorderSizePixel = 0
closeBtn.Parent = titleBar

Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

-- BUTTON CREATOR
local function createButton(text, parent, height)

    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 0, 0, height or 40)
    button.BackgroundColor3 = WHITE
    button.Text = text
    button.TextColor3 = BLACK
    button.TextSize = 12
    button.Font = Enum.Font.GothamBold
    button.BorderSizePixel = 0
    button.AutoButtonColor = true
    button.Parent = parent

    Instance.new("UICorner", button).CornerRadius = UDim.new(0, 10)

    local stroke = Instance.new("UIStroke", button)
    stroke.Color = YELLOW_DARK
    stroke.Thickness = 1.2

    return button
end

-- CURRENT STYLE LABEL
local currentLabel = Instance.new("TextLabel")
currentLabel.Size = UDim2.new(1, -28, 0, 28)
currentLabel.Position = UDim2.new(0, 14, 0, 66)
currentLabel.BackgroundTransparency = 1
currentLabel.Text = "CURRENT STYLE: NORMAL"
currentLabel.TextColor3 = BLACK
currentLabel.TextSize = 11
currentLabel.Font = Enum.Font.GothamBold
currentLabel.TextXAlignment = Enum.TextXAlignment.Left
currentLabel.Parent = mainFrame

-- SELECT STYLE
local selectButton = createButton(
    "SELECT STYLE  ▼",
    mainFrame,
    38
)

selectButton.Position = UDim2.new(0, 14, 0, 96)
selectButton.Size = UDim2.new(1, -28, 0, 38)

-- APPLY BUTTON
local applyButton = createButton(
    "APPLY TO NEAREST GUNDISPLAY",
    mainFrame,
    38
)

applyButton.Position = UDim2.new(0, 14, 0, 145)
applyButton.Size = UDim2.new(1, -28, 0, 38)

-- RESET BUTTON
local resetButton = createButton(
    "RESET TO NORMAL",
    mainFrame,
    34
)

resetButton.Position = UDim2.new(0, 14, 0, 192)
resetButton.Size = UDim2.new(1, -28, 0, 34)

-- STATUS
status = Instance.new("TextLabel")
status.Size = UDim2.new(1, -20, 0, 22)
status.Position = UDim2.new(0, 10, 0, 237)
status.BackgroundTransparency = 1
status.Text = "Select a style."
status.TextColor3 = BLACK
status.TextSize = 10
status.Font = Enum.Font.Gotham
status.TextWrapped = true
status.Parent = mainFrame

-- STYLE SELECTION WINDOW
local styleWindow = Instance.new("Frame")
styleWindow.Name = "StyleWindow"
styleWindow.Size = UDim2.new(0, 235, 0, 245)
styleWindow.Position = UDim2.new(0.5, -117, 0.5, -122)
styleWindow.BackgroundColor3 = YELLOW_LIGHT
styleWindow.BorderSizePixel = 0
styleWindow.Visible = false
styleWindow.ZIndex = 10
styleWindow.Parent = screenGui

Instance.new("UICorner", styleWindow).CornerRadius = UDim.new(0, 15)

local windowStroke = Instance.new("UIStroke", styleWindow)
windowStroke.Color = YELLOW_DARK
windowStroke.Thickness = 2

local windowTitle = Instance.new("TextLabel")
windowTitle.Size = UDim2.new(1, -45, 0, 35)
windowTitle.Position = UDim2.new(0, 12, 0, 0)
windowTitle.BackgroundTransparency = 1
windowTitle.Text = "SELECT STYLE"
windowTitle.TextColor3 = BLACK
windowTitle.TextSize = 13
windowTitle.Font = Enum.Font.GothamBold
windowTitle.TextXAlignment = Enum.TextXAlignment.Left
windowTitle.ZIndex = 11
windowTitle.Parent = styleWindow

local windowClose = Instance.new("TextButton")
windowClose.Size = UDim2.new(0, 25, 0, 25)
windowClose.Position = UDim2.new(1, -32, 0, 5)
windowClose.BackgroundColor3 = WHITE
windowClose.Text = "×"
windowClose.TextColor3 = BLACK
windowClose.TextSize = 17
windowClose.Font = Enum.Font.GothamBold
windowClose.BorderSizePixel = 0
windowClose.ZIndex = 11
windowClose.Parent = styleWindow

Instance.new("UICorner", windowClose).CornerRadius = UDim.new(1, 0)

-- SCROLLABLE STYLE LIST
local styleScroll = Instance.new("ScrollingFrame")
styleScroll.Size = UDim2.new(1, -20, 1, -48)
styleScroll.Position = UDim2.new(0, 10, 0, 40)
styleScroll.BackgroundTransparency = 1
styleScroll.BorderSizePixel = 0
styleScroll.ScrollBarThickness = 4
styleScroll.ScrollBarImageColor3 = YELLOW_DARK
styleScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
styleScroll.ZIndex = 11
styleScroll.Parent = styleWindow

local styleLayout = Instance.new("UIListLayout")
styleLayout.SortOrder = Enum.SortOrder.LayoutOrder
styleLayout.Padding = UDim.new(0, 6)
styleLayout.Parent = styleScroll

styleLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    styleScroll.CanvasSize = UDim2.new(
        0, 0, 0, styleLayout.AbsoluteContentSize.Y + 8
    )
end)

-- CREATE ALL STYLE BUTTONS
for index, style in ipairs(Styles) do

    local styleButton = createButton(
        string.upper(style.Name),
        styleScroll,
        31
    )

    styleButton.LayoutOrder = index
    styleButton.ZIndex = 12

    styleButton.MouseButton1Click:Connect(function()

        selectedStyle = style

        currentLabel.Text = "CURRENT STYLE: " .. string.upper(style.Name)
        status.Text = style.Name .. " selected."

        styleWindow.Visible = false

    end)
end

-- BUTTON EVENTS
selectButton.MouseButton1Click:Connect(function()
    styleWindow.Visible = not styleWindow.Visible
end)

windowClose.MouseButton1Click:Connect(function()
    styleWindow.Visible = false
end)

applyButton.MouseButton1Click:Connect(function()
    applyNearestGun()
end)

resetButton.MouseButton1Click:Connect(function()
    resetStyle()
    currentLabel.Text = "CURRENT STYLE: NORMAL"
end)

-- MINIMIZE CIRCLE
local ballBtn = Instance.new("TextButton")
ballBtn.Name = "JawrrMinimize"
ballBtn.Size = UDim2.new(0, 52, 0, 52)
ballBtn.Position = UDim2.new(0.5, -26, 0.5, -26)
ballBtn.BackgroundColor3 = YELLOW
ballBtn.Text = "Jawrr"
ballBtn.TextColor3 = BLACK
ballBtn.TextSize = 12
ballBtn.Font = Enum.Font.GothamBold
ballBtn.BorderSizePixel = 0
ballBtn.Visible = false
ballBtn.Active = true
ballBtn.AutoButtonColor = false
ballBtn.Parent = screenGui

Instance.new("UICorner", ballBtn).CornerRadius = UDim.new(1, 0)

local ballStroke = Instance.new("UIStroke", ballBtn)
ballStroke.Color = YELLOW_DARK
ballStroke.Thickness = 2

-- DRAG SYSTEM
local function enableDrag(target, moveTarget)

    local dragging = false
    local dragInput
    local dragStart
    local startPosition

    target.InputBegan:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

            dragging = true
            dragStart = input.Position
            startPosition = moveTarget.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    target.InputChanged:Connect(function(input)

        if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then

            dragInput = input
        end
    end)

    UserInputService.InputChanged:Connect(function(input)

        if input == dragInput and dragging then

            local delta = input.Position - dragStart

            moveTarget.Position = UDim2.new(
                startPosition.X.Scale,
                startPosition.X.Offset + delta.X,
                startPosition.Y.Scale,
                startPosition.Y.Offset + delta.Y
            )
        end
    end)
end

enableDrag(titleBar, mainFrame)
enableDrag(ballBtn, ballBtn)

-- MINIMIZE
closeBtn.MouseButton1Click:Connect(function()

    styleWindow.Visible = false

    ballBtn.Position = UDim2.new(
        mainFrame.Position.X.Scale,
        mainFrame.Position.X.Offset + mainFrame.AbsoluteSize.X / 2 - 26,
        mainFrame.Position.Y.Scale,
        mainFrame.Position.Y.Offset + mainFrame.AbsoluteSize.Y / 2 - 26
    )

    mainFrame.Visible = false
    ballBtn.Visible = true
end)

-- RESTORE
ballBtn.MouseButton1Click:Connect(function()

    mainFrame.Position = UDim2.new(
        ballBtn.Position.X.Scale,
        ballBtn.Position.X.Offset - mainFrame.AbsoluteSize.X / 2 + 26,
        ballBtn.Position.Y.Scale,
        ballBtn.Position.Y.Offset - mainFrame.AbsoluteSize.Y / 2 + 26
    )

    ballBtn.Visible = false
    mainFrame.Visible = true
end)

-- INITIAL STYLE
selectedStyle = Styles[1]

print("[MMV] Jawrrr Recolor Scope loaded!")
print("[MMV] Pastel Yellow Edition | " .. #Styles .. " Styles")
