-- MMV Recolor Scope — Black/Purple Edition
-- Updated by: Jawrrr (Holstered/Waist Gun + Local Gun-only filter & instant shot/beam fix, without neon square bomb)
-- Client-side visual script. Use only where permitted.

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Detect scopes, GunDisplay, and holstered/waist gun models attached to the character
local TARGET_NAMES = {
	GunDisplay = true,
	MatrixScope = true,
	VoidScope = true,
	Holster = true,
	GunHolster = true,
	HolsteredGun = true,
	WaistGun = true,
	BackGun = true,
	GunModel = true,
	Gun = true,
}

-- Exclude non-gun items (knives, bombs, etc.)
local EXCLUDED_KEYWORDS = {
	"knife",
	"faca",
	"blade",
	"dagger",
	"karambit",
	"butterfly",
	"katana",
	"sword",
	"scythe",
	"machete",
	"bomb",
	"bomba",
	"c4",
	"grenade",
	"explosive",
	"radio",
	"emote",
	"toy",
}

-- ORIGINAL TEXTURES
local RED_TEXTURE_ID = "rbxassetid://84961185975751"
local BLUE_TEXTURE_ID = "rbxassetid://82435090032680"
local PURPLE_TEXTURE_ID = "rbxassetid://88934686234709"
local VOIDSCOPE_TEXTURE_ID = "rbxassetid://119603354495392"
local ROSESCOPE_TEXTURE_ID = "rbxassetid://102809990017058"
local WHITESCOPE_TEXTURE_ID = "rbxassetid://87412774611144"

-- INDIVIDUAL COLOR TEXTURES
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

-- STARSCOPE TEXTURES
local STARSCOPE_TEXTURE_ID = "rbxassetid://132065259622013"
local STARSCOPE_VIOLET_TEXTURE_ID = "rbxassetid://97204233483116"
local PINK_STARSCOPE_TEXTURE_ID = "rbxassetid://83357177609156"
local PASTELBROWN_STARSCOPE_TEXTURE_ID = "rbxassetid://136763276707143"
local PASTELBROWN_POLKA_TEXTURE_ID = "rbxassetid://133416165666330"

-- NEW TEXTURES
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

-- THEME
local BLACK = Color3.fromRGB(8, 7, 13)
local BLACK_PANEL = Color3.fromRGB(15, 12, 23)
local PURPLE = Color3.fromRGB(145, 65, 220)
local PURPLE_DARK = Color3.fromRGB(75, 32, 120)
local PURPLE_LIGHT = Color3.fromRGB(190, 135, 255)
local WHITE = Color3.fromRGB(245, 240, 255)

local CURRENT_STYLE = "Normal"
local TEXTURE_ID, BEAM_COLOR

local equippedTool: Tool? = nil
local originalGunProperties = {}
local originalDisplayProperties = {}
local connectedTools = {}
local shotBurstToken = 0
local status

-- OWNERSHIP CHECK (prevents affecting other players' weapons/displays)
local function isOwnedByLocalPlayer(instance: Instance?): boolean
	if not instance then
		return false
	end

	local char = player.Character
	if char and instance:IsDescendantOf(char) then
		return true
	end

	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack and instance:IsDescendantOf(backpack) then
		return true
	end

	-- Reject objects belonging to another player's character or backpack
	for _, otherPlayer in ipairs(Players:GetPlayers()) do
		if otherPlayer ~= player then
			if otherPlayer.Character and instance:IsDescendantOf(otherPlayer.Character) then
				return false
			end
			local otherBackpack = otherPlayer:FindFirstChildOfClass("Backpack")
			if otherBackpack and instance:IsDescendantOf(otherBackpack) then
				return false
			end
		end
	end

	return false
end

-- CHECK IF NAME IS EXCLUDED (Knife, Bomb, etc.)
local function isExcludedName(name: string): boolean
	local lowerName = string.lower(name)
	for _, keyword in ipairs(EXCLUDED_KEYWORDS) do
		if string.find(lowerName, keyword, 1, true) then
			return true
		end
	end
	return false
end

-- CHECK IF AN OBJECT ON CHARACTER IS A HOLSTERED / WAIST GUN DISPLAY OR ACCESSORY
local function isHolsteredGunObject(object: Instance?): boolean
	if not object or not isOwnedByLocalPlayer(object) then
		return false
	end

	if isExcludedName(object.Name) then
		return false
	end

	-- Do not confuse standard body parts or normal avatar clothing/hats with a gun
	if object:IsA("Humanoid") or object:IsA("BodyColors") or object:IsA("Shirt") or object:IsA("Pants") then
		return false
	end

	if TARGET_NAMES[object.Name] then
		return true
	end

	local lowerName = string.lower(object.Name)
	if string.find(lowerName, "gun", 1, true)
		or string.find(lowerName, "holster", 1, true)
		or string.find(lowerName, "scope", 1, true)
		or string.find(lowerName, "revolver", 1, true)
		or string.find(lowerName, "pistol", 1, true)
		or string.find(lowerName, "sheriff", 1, true) then
		return true
	end

	-- Also check Accessories/Models welded to LowerTorso / UpperTorso / HumanoidRootPart / RightLeg / LeftLeg (waist/hip holster)
	if object:IsA("Accessory") or object:IsA("Model") then
		local parentTool = object:FindFirstAncestorWhichIsA("Tool")
		if parentTool and isExcludedName(parentTool.Name) then
			return false
		end

		for _, desc in ipairs(object:GetDescendants()) do
			if desc:IsA("Weld") or desc:IsA("WeldConstraint") or desc:IsA("Motor6D") then
				local p0 = desc.Part0
				local p1 = desc.Part1
				local attachTarget = (p0 and not p0:IsDescendantOf(object) and p0.Name)
					or (p1 and not p1:IsDescendantOf(object) and p1.Name)
					or ""
				if attachTarget == "LowerTorso"
					or attachTarget == "UpperTorso"
					or attachTarget == "Torso"
					or attachTarget == "RightUpperLeg"
					or attachTarget == "LeftUpperLeg"
					or attachTarget == "Right Leg"
					or attachTarget == "Left Leg" then
					if object:IsA("Model") or string.find(lowerName, "gun", 1, true) or string.find(lowerName, "holster", 1, true) then
						return true
					end
				end
			end
		end
	end

	return false
end

-- CHECK IF TOOL IS A GUN ONLY (excludes Knife, Bomb, etc.)
local function isGunTool(tool: Instance?): boolean
	if not tool or not tool:IsA("Tool") then
		return false
	end

	if not isOwnedByLocalPlayer(tool) then
		return false
	end

	if isExcludedName(tool.Name) then
		return false
	end

	local lowerName = string.lower(tool.Name)

	if lowerName == "gun" or string.find(lowerName, "gun", 1, true) then
		return true
	end

	for _, desc in ipairs(tool:GetDescendants()) do
		local descName = string.lower(desc.Name)
		if desc:IsA("Beam")
			or descName == "muzzle"
			or descName == "fire"
			or descName == "bullet"
			or descName == "gunscript"
			or TARGET_NAMES[desc.Name] then
			return true
		end
	end

	return false
end

-- SAVE / RESTORE
local function saveProperty(store, object, property)
	if not store[object] then
		store[object] = {}
	end

	if store[object][property] == nil then
		local ok, value = pcall(function()
			return object[property]
		end)

		if ok then
			store[object][property] = value
		end
	end
end

local function setSaved(store, object, property, value)
	pcall(function()
		saveProperty(store, object, property)
		object[property] = value
	end)
end

local function restoreStore(store)
	for object, properties in pairs(store) do
		if object and object.Parent then
			for property, value in pairs(properties) do
				pcall(function()
					object[property] = value
				end)
			end
		end
	end

	table.clear(store)
end

local function restoreGun(tool: Tool?)
	restoreStore(originalGunProperties)

	if not tool or equippedTool == tool then
		equippedTool = nil
	end
end

local function restoreDisplay()
	restoreStore(originalDisplayProperties)
end

-- FIND ALL LOCAL GUN TOOLS ONLY (equipped + in backpack, never Knife or Bomb)
local function findAllLocalGuns(): {Tool}
	local guns = {}
	local char = player.Character
	if char then
		for _, child in ipairs(char:GetChildren()) do
			if isGunTool(child) then
				table.insert(guns, child)
			end
		end
	end

	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then
		for _, child in ipairs(backpack:GetChildren()) do
			if isGunTool(child) then
				table.insert(guns, child)
			end
		end
	end

	return guns
end

-- FIND LOCAL PLAYER'S SCOPE DISPLAYS & WAIST/HOLSTERED GUN MODELS ONLY
local function findLocalGunDisplays()
	local displays = {}
	local searchRoots = {}

	if player.Character then
		table.insert(searchRoots, player.Character)
	end

	local backpack = player:FindFirstChildOfClass("Backpack")
	if backpack then
		table.insert(searchRoots, backpack)
	end

	for _, root in ipairs(searchRoots) do
		for _, object in ipairs(root:GetDescendants()) do
			if isHolsteredGunObject(object) then
				table.insert(displays, object)
			end
		end
	end

	return displays
end

-- Ensure any lingering GhostScope values on unrecorded parts are reset cleanly
local function clearLingeringGhostValues(root: Instance?, store)
	if not root then
		return
	end

	local function cleanObj(obj: Instance)
		if store[obj] then
			return
		end
		if obj:IsA("BasePart") then
			pcall(function()
				if obj.Transparency == 0.5 then
					obj.Transparency = 0
				end
			end)
		elseif obj:IsA("Decal") or obj:IsA("Texture") then
			pcall(function()
				if obj.Transparency == 1 then
					obj.Transparency = 0
				end
			end)
		elseif obj:IsA("Beam") or obj:IsA("Trail") then
			pcall(function()
				obj.Transparency = NumberSequence.new(0)
			end)
		end
	end

	cleanObj(root)
	for _, desc in ipairs(root:GetDescendants()) do
		cleanObj(desc)
	end
end

local function forceClearAllGhostOverrides()
	for _, gun in ipairs(findAllLocalGuns()) do
		clearLingeringGhostValues(gun, originalGunProperties)
	end
	for _, display in ipairs(findLocalGunDisplays()) do
		clearLingeringGhostValues(display, originalDisplayProperties)
	end
end

-- BEAM COLORS
local function applyBeam(object, store)
	if not (object:IsA("Beam") or object:IsA("Trail")) then
		return
	end

	if CURRENT_STYLE == "GhostScope" then
		setSaved(store, object, "Color", ColorSequence.new(WHITE))
		setSaved(store, object, "Transparency", NumberSequence.new(0.5))

	elseif CURRENT_STYLE == "VoidScope" then
		setSaved(store, object, "Color", ColorSequence.new({
			ColorSequenceKeypoint.new(0, WHITE),
			ColorSequenceKeypoint.new(0.5, Color3.fromRGB(170, 170, 170)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
		}))

	elseif BEAM_COLOR then
		setSaved(store, object, "Color", ColorSequence.new(BEAM_COLOR))
	end
end

-- CHECK VISUAL CHILDREN
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

-- APPLY COLORS AND TEXTURES
local function applyObject(object, store)
	if CURRENT_STYLE == "GhostScope" then
		if object:IsA("MeshPart") then
			setSaved(store, object, "Color", WHITE)
			setSaved(store, object, "Transparency", 0.5)
			setSaved(store, object, "TextureID", "")

		elseif object:IsA("BasePart") then
			setSaved(store, object, "Color", WHITE)
			setSaved(store, object, "Transparency", 0.5)

		elseif object:IsA("SpecialMesh") then
			setSaved(store, object, "TextureId", "")
			setSaved(store, object, "VertexColor", Vector3.new(1, 1, 1))

			local parent = object.Parent
			if parent and parent:IsA("BasePart") then
				setSaved(store, parent, "Color", WHITE)
				setSaved(store, parent, "Transparency", 0.5)
			end

		elseif object:IsA("Decal") or object:IsA("Texture") then
			setSaved(store, object, "Transparency", 1)

		elseif object:IsA("Beam") or object:IsA("Trail") then
			applyBeam(object, store)
		end

		return
	end

	if TEXTURE_ID then
		if object:IsA("MeshPart") then
			setSaved(store, object, "TextureID", TEXTURE_ID)

		elseif object:IsA("SpecialMesh") then
			setSaved(store, object, "TextureId", TEXTURE_ID)
			setSaved(store, object, "VertexColor", Vector3.new(1, 1, 1))

		elseif object:IsA("Decal") or object:IsA("Texture") then
			setSaved(store, object, "Texture", TEXTURE_ID)
			setSaved(store, object, "Color3", WHITE)

		elseif object:IsA("BasePart") then
			if hasVisualChild(object) then
				setSaved(store, object, "Color", WHITE)
			end

		elseif object:IsA("Beam") or object:IsA("Trail") then
			applyBeam(object, store)
		end

		return
	end

	if object:IsA("Beam") or object:IsA("Trail") then
		applyBeam(object, store)
	end
end

-- ALL STYLES
local Styles = {
	{ Name = "Normal" },

	{ Name = "RedScope", Texture = RED_TEXTURE_ID, Beam = Color3.fromRGB(170, 0, 0) },
	{ Name = "BlueScope", Texture = BLUE_TEXTURE_ID, Beam = Color3.fromRGB(20, 45, 110) },
	{ Name = "Purple", Texture = PURPLE_TEXTURE_ID, Beam = Color3.fromRGB(115, 35, 170) },
	{ Name = "VoidScope", Texture = VOIDSCOPE_TEXTURE_ID, Beam = WHITE },
	{ Name = "Rosescope", Texture = ROSESCOPE_TEXTURE_ID, Beam = Color3.fromRGB(255, 105, 180) },
	{ Name = "WhiteScope", Texture = WHITESCOPE_TEXTURE_ID, Beam = WHITE },
	{ Name = "GhostScope", Ghost = true, Beam = WHITE },

	-- INDIVIDUAL TEXTURES
	{ Name = "Cyan", Texture = CYAN_TEXTURE_ID, Beam = Color3.fromRGB(0, 172, 181) },
	{ Name = "Lime", Texture = LIME_TEXTURE_ID, Beam = Color3.fromRGB(77, 121, 32) },
	{ Name = "Yellow", Texture = YELLOW_TEXTURE_ID, Beam = Color3.fromRGB(240, 211, 109) },
	{ Name = "Orange", Texture = ORANGE_TEXTURE_ID, Beam = Color3.fromRGB(229, 93, 5) },
	{ Name = "Hot Pink", Texture = HOT_PINK_TEXTURE_ID, Beam = Color3.fromRGB(192, 116, 162) },
	{ Name = "Mint", Texture = MINT_TEXTURE_ID, Beam = Color3.fromRGB(167, 211, 188) },
	{ Name = "Neon Purple", Texture = NEON_PURPLE_TEXTURE_ID, Beam = Color3.fromRGB(118, 9, 178) },
	{ Name = "Brown", Texture = BROWN_TEXTURE_ID, Beam = Color3.fromRGB(62, 33, 20) },
	{ Name = "Gray", Texture = GRAY_TEXTURE_ID, Beam = Color3.fromRGB(44, 45, 49) },
	{ Name = "Gold", Texture = GOLD_TEXTURE_ID, Beam = Color3.fromRGB(239, 182, 93) },

	-- STARSCOPE TEXTURES
	{ Name = "Starscope", Texture = STARSCOPE_TEXTURE_ID, Beam = Color3.fromRGB(0, 0, 0) },
	{ Name = "Starscope violet", Texture = STARSCOPE_VIOLET_TEXTURE_ID, Beam = Color3.fromRGB(0, 0, 0) },
	{ Name = "Pink starscope", Texture = PINK_STARSCOPE_TEXTURE_ID, Beam = Color3.fromRGB(240, 221, 225) },
	{ Name = "Pastelbrown starscope", Texture = PASTELBROWN_STARSCOPE_TEXTURE_ID, Beam = Color3.fromRGB(234, 212, 188) },
	{ Name = "Pastelbrown polka", Texture = PASTELBROWN_POLKA_TEXTURE_ID, Beam = Color3.fromRGB(234, 212, 188) },

	-- NEW CHRISTMAS, FADE, BEACH AND CREATOR STYLES
	{ Name = "Bellscope", Texture = BELLSCOPE_TEXTURE_ID, Beam = Color3.fromRGB(255, 255, 255) },
	{ Name = "Redsnowflakescope", Texture = REDSNOWFLAKE_TEXTURE_ID, Beam = Color3.fromRGB(99, 19, 30) },
	{ Name = "Snowflakescope", Texture = SNOWFLAKE_TEXTURE_ID, Beam = Color3.fromRGB(255, 255, 255) },
	{ Name = "Red/green sparklescope", Texture = REDGREEN_SPARKLE_TEXTURE_ID, Beam = Color3.fromRGB(71, 11, 13) },
	{ Name = "Christmasscope", Texture = CHRISTMAS_TEXTURE_ID, Beam = Color3.fromRGB(255, 255, 255) },
	{ Name = "Purplefade scope", Texture = PURPLEFADE_TEXTURE_ID, Beam = Color3.fromRGB(48, 17, 52) },
	{ Name = "Purplefade starscope", Texture = PURPLEFADE_STAR_TEXTURE_ID, Beam = Color3.fromRGB(138, 60, 146) },
	{ Name = "Beachscope", Texture = BEACH_TEXTURE_ID, Beam = Color3.fromRGB(29, 113, 142) },
	{ Name = "Bluefade scope", Texture = BLUEFADE_TEXTURE_ID, Beam = Color3.fromRGB(98, 125, 195) },
	{ Name = "Bluefade starscope", Texture = BLUEFADE_STAR_TEXTURE_ID, Beam = Color3.fromRGB(191, 182, 227) },
	{ Name = "Creatorscope", Texture = CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(248, 89, 86) },
	{ Name = "Brunette creatorscope", Texture = BRUNETTE_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(102, 60, 34) },
	{ Name = "Green creatorscope", Texture = GREEN_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(39, 167, 68) },
	{ Name = "Darkblue creatorscope", Texture = DARKBLUE_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(9, 28, 143) },
	{ Name = "Navy blue creatorscope", Texture = NAVYBLUE_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(18, 32, 91) },
	{ Name = "Pastelpink creatorscope", Texture = PASTELPINK_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(246, 175, 205) },
	{ Name = "Skyblue creatorscope", Texture = SKYBLUE_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(106, 190, 247) },
	{ Name = "Pastelblue creatorscope", Texture = PASTELBLUE_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(155, 188, 228) },
	{ Name = "Pastelgreen creatorscope", Texture = PASTELGREEN_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(162, 222, 172) },
	{ Name = "Pastelpurple creatorscope", Texture = PASTELPURPLE_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(190, 162, 224) },
	{ Name = "Purple creatorscope", Texture = PURPLE_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(207, 138, 254) },
	{ Name = "Pastelyellow creatorscope", Texture = PASTELYELLOW_CREATOR_TEXTURE_ID, Beam = Color3.fromRGB(245, 237, 154) },
}

-- APPLY TO ONE DISPLAY OR HOLSTERED GUN
local function applyToDisplay(root)
	if not root or not root.Parent or not isOwnedByLocalPlayer(root) then
		return
	end

	if isExcludedName(root.Name) then
		return
	end

	applyObject(root, originalDisplayProperties)

	for _, object in ipairs(root:GetDescendants()) do
		if not isExcludedName(object.Name) then
			applyObject(object, originalDisplayProperties)
		end
	end
end

-- APPLY TO LOCAL SCOPES & WAIST GUN ONLY
local function applyToAllDisplays()
	for _, display in ipairs(findLocalGunDisplays()) do
		applyToDisplay(display)
	end
end

-- APPLY TO GUN TOOL ONLY
local function applyToGun(tool: Tool)
	if not isGunTool(tool) then
		return
	end

	if player.Character and tool.Parent == player.Character then
		equippedTool = tool
	end

	applyObject(tool, originalGunProperties)

	for _, object in ipairs(tool:GetDescendants()) do
		applyObject(object, originalGunProperties)
	end
end

-- APPLY TO ALL LOCAL GUN TOOLS AT ONCE
local function applyToAllLocalGuns()
	for _, gun in ipairs(findAllLocalGuns()) do
		applyToGun(gun)
	end
end

-- IMMEDIATE APPLICATION WHEN FIRING / EQUIPPING FAST
local function triggerShotSync(tool: Tool)
	if CURRENT_STYLE == "Normal" or not isGunTool(tool) then
		return
	end

	shotBurstToken += 1
	local currentToken = shotBurstToken

	applyToGun(tool)
	applyToAllDisplays()

	-- Catch beams, trails, or tracers spawned milliseconds after firing/equipping
	task.spawn(function()
		for _ = 1, 8 do
			task.wait(0.025)
			if currentToken ~= shotBurstToken or CURRENT_STYLE == "Normal" then
				return
			end
			if tool and tool.Parent == player.Character then
				for _, desc in ipairs(tool:GetDescendants()) do
					if desc:IsA("Beam") or desc:IsA("Trail") or desc:IsA("BasePart") then
						applyObject(desc, originalGunProperties)
					end
				end
			end
		end
	end)
end

-- STYLE SELECTION (clicking GhostScope toggles semi-transparent Ghost on/off instantly)
local function selectStyle(styleName)
	local selected

	for _, style in ipairs(Styles) do
		if style.Name == styleName then
			selected = style
			break
		end
	end

	if not selected then
		return
	end

	local wasGhost = (CURRENT_STYLE == "GhostScope")
	pcall(restoreDisplay)
	pcall(function()
		restoreGun(nil)
	end)
	if wasGhost then
		pcall(forceClearAllGhostOverrides)
	end

	if selected.Ghost then
		if wasGhost then
			CURRENT_STYLE = "Normal"
			TEXTURE_ID = nil
			BEAM_COLOR = nil
			status.Text = "Style: Normal (Ghost OFF)"
			return
		else
			CURRENT_STYLE = "GhostScope"
			TEXTURE_ID = nil
			BEAM_COLOR = selected.Beam
			status.Text = "Style: GhostScope (ON)"
			pcall(applyToAllDisplays)
			pcall(applyToAllLocalGuns)
			return
		end
	end

	CURRENT_STYLE = selected.Name
	TEXTURE_ID = selected.Texture
	BEAM_COLOR = selected.Beam

	status.Text = "Style: " .. CURRENT_STYLE

	if CURRENT_STYLE == "Normal" then
		return
	end

	pcall(applyToAllDisplays)
	pcall(applyToAllLocalGuns)

	-- Re-apply once on next frames so game scripts don't block the texture right after GhostScope
	local appliedStyle = CURRENT_STYLE
	task.delay(0.03, function()
		if CURRENT_STYLE == appliedStyle and CURRENT_STYLE ~= "Normal" then
			pcall(applyToAllDisplays)
			pcall(applyToAllLocalGuns)
		end
	end)
end

-- REMOVE OLD PANEL
local oldGui = PlayerGui:FindFirstChild("MatrixVoidPanel")
if oldGui then
	oldGui:Destroy()
end

-- MAIN GUI
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MatrixVoidPanel"
screenGui.ResetOnSpawn = false
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
screenGui.IgnoreGuiInset = true
screenGui.DisplayOrder = 999
screenGui.Enabled = true
screenGui.Parent = PlayerGui

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 260, 0, 390)
mainFrame.Position = UDim2.new(0.5, -130, 0.4, -195)
mainFrame.BackgroundColor3 = BLACK
mainFrame.BackgroundTransparency = 0.05
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Visible = true
mainFrame.ClipsDescendants = true
mainFrame.Parent = screenGui

Instance.new("UICorner", mainFrame).CornerRadius = UDim.new(0, 16)

local mainStroke = Instance.new("UIStroke", mainFrame)
mainStroke.Color = PURPLE
mainStroke.Thickness = 2.5

local titleBar = Instance.new("Frame")
titleBar.Size = UDim2.new(1, 0, 0, 35)
titleBar.BackgroundColor3 = BLACK_PANEL
titleBar.BorderSizePixel = 0
titleBar.Active = true
titleBar.Parent = mainFrame

Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 16)

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, -35, 1, 0)
titleLabel.Position = UDim2.new(0, 10, 0, 0)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "By:Jawrrr"
titleLabel.TextColor3 = PURPLE_LIGHT
titleLabel.TextSize = 13
titleLabel.Font = Enum.Font.GothamBold
titleLabel.TextXAlignment = Enum.TextXAlignment.Left
titleLabel.Parent = titleBar

local minimizeBtn = Instance.new("TextButton")
minimizeBtn.Size = UDim2.new(0, 22, 0, 22)
minimizeBtn.Position = UDim2.new(1, -28, 0, 6)
minimizeBtn.BackgroundColor3 = PURPLE_DARK
minimizeBtn.Text = "-"
minimizeBtn.TextColor3 = WHITE
minimizeBtn.TextSize = 16
minimizeBtn.Font = Enum.Font.GothamBold
minimizeBtn.BorderSizePixel = 0
minimizeBtn.Parent = titleBar

Instance.new("UICorner", minimizeBtn).CornerRadius = UDim.new(1, 0)

local contentFrame = Instance.new("Frame")
contentFrame.Size = UDim2.new(1, -24, 1, -65)
contentFrame.Position = UDim2.new(0, 12, 0, 38)
contentFrame.BackgroundTransparency = 1
contentFrame.Parent = mainFrame

local listLayout = Instance.new("UIListLayout", contentFrame)
listLayout.SortOrder = Enum.SortOrder.LayoutOrder
listLayout.Padding = UDim.new(0, 8)

-- CREATE BUTTON
local function createButton(text)
	local button = Instance.new("TextButton")
	button.Size = UDim2.new(1, 0, 0, 30)
	button.BackgroundColor3 = BLACK_PANEL
	button.BackgroundTransparency = 0
	button.Text = text
	button.TextColor3 = WHITE
	button.TextSize = 12
	button.Font = Enum.Font.GothamBold
	button.BorderSizePixel = 0

	Instance.new("UICorner", button).CornerRadius = UDim.new(0, 12)

	local stroke = Instance.new("UIStroke", button)
	stroke.Color = PURPLE_DARK
	stroke.Thickness = 1.5

	return button
end

local texturesLabel = Instance.new("TextLabel")
texturesLabel.Size = UDim2.new(1, 0, 0, 18)
texturesLabel.BackgroundTransparency = 1
texturesLabel.Text = "TEXTURES + COLORS"
texturesLabel.TextColor3 = PURPLE_LIGHT
texturesLabel.TextSize = 12
texturesLabel.Font = Enum.Font.GothamBold
texturesLabel.TextXAlignment = Enum.TextXAlignment.Left
texturesLabel.LayoutOrder = 1
texturesLabel.Parent = contentFrame

local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(1, 0, 0, 230)
scrollFrame.BackgroundTransparency = 1
scrollFrame.BorderSizePixel = 0
scrollFrame.ScrollBarThickness = 4
scrollFrame.ScrollBarImageColor3 = PURPLE
scrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
scrollFrame.LayoutOrder = 2
scrollFrame.Parent = contentFrame

local scrollLayout = Instance.new("UIListLayout", scrollFrame)
scrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
scrollLayout.Padding = UDim.new(0, 6)

scrollLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(
		0, 0, 0, scrollLayout.AbsoluteContentSize.Y + 5
	)
end)

status = Instance.new("TextLabel")
status.Size = UDim2.new(1, 0, 0, 18)
status.BackgroundTransparency = 1
status.Text = "Ready."
status.TextColor3 = PURPLE_LIGHT
status.TextSize = 10
status.Font = Enum.Font.Gotham
status.LayoutOrder = 3
status.Parent = contentFrame

-- AUTOMATIC STYLE BUTTONS
for index, style in ipairs(Styles) do
	local button = createButton(string.upper(style.Name))
	button.LayoutOrder = index
	button.Parent = scrollFrame

	button.MouseButton1Click:Connect(function()
		selectStyle(style.Name)
	end)
end

local footerLabel = Instance.new("TextLabel")
footerLabel.Size = UDim2.new(1, 0, 0, 20)
footerLabel.Position = UDim2.new(0, 0, 1, -22)
footerLabel.BackgroundTransparency = 1
footerLabel.Text = "MMV RECOLOR SCOPE • BLACK / PURPLE"
footerLabel.TextColor3 = PURPLE_LIGHT
footerLabel.TextSize = 9
footerLabel.Font = Enum.Font.GothamBold
footerLabel.Parent = mainFrame

-- MINIMIZE BALL WITH CENTERED "Jawrr" TEXT
local ballBtn = Instance.new("TextButton")
ballBtn.Name = "MinimizeBall"
ballBtn.Size = UDim2.new(0, 50, 0, 50)
ballBtn.Position = UDim2.new(0.82, -25, 0.2, 0)
ballBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ballBtn.BackgroundTransparency = 0
ballBtn.Text = "Jawrr"
ballBtn.TextColor3 = PURPLE_LIGHT
ballBtn.TextSize = 12
ballBtn.TextScaled = true
ballBtn.Font = Enum.Font.GothamBold
ballBtn.TextXAlignment = Enum.TextXAlignment.Center
ballBtn.TextYAlignment = Enum.TextYAlignment.Center
ballBtn.TextWrapped = false
ballBtn.Active = true
ballBtn.Visible = false
ballBtn.BorderSizePixel = 0
ballBtn.AutoButtonColor = false
ballBtn.Parent = screenGui

local ballTextLimit = Instance.new("UITextSizeConstraint")
ballTextLimit.MinTextSize = 9
ballTextLimit.MaxTextSize = 12
ballTextLimit.Parent = ballBtn

local ballCorner = Instance.new("UICorner")
ballCorner.CornerRadius = UDim.new(1, 0)
ballCorner.Parent = ballBtn

local ballStroke = Instance.new("UIStroke")
ballStroke.Color = PURPLE
ballStroke.Thickness = 2
ballStroke.Parent = ballBtn

-- DRAG SYSTEM
local function enableDrag(dragTarget, moveTarget)
	local dragging = false
	local dragInput, dragStart, startPosition

	local function update(input)
		local delta = input.Position - dragStart

		moveTarget.Position = UDim2.new(
			startPosition.X.Scale,
			startPosition.X.Offset + delta.X,
			startPosition.Y.Scale,
			startPosition.Y.Offset + delta.Y
		)
	end

	dragTarget.InputBegan:Connect(function(input)
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

	dragTarget.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

enableDrag(titleBar, mainFrame)
enableDrag(ballBtn, ballBtn)

-- Independent positions + smooth open/close animations
local MAIN_FULL_SIZE = mainFrame.Size
local BALL_FULL_SIZE = ballBtn.Size
local isAnimatingUI = false
local animToken = 0

local function animateMinimize()
	if isAnimatingUI or not mainFrame.Visible then
		return
	end
	isAnimatingUI = true
	animToken += 1
	local token = animToken

	local closeTween = TweenService:Create(
		mainFrame,
		TweenInfo.new(0.18, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{
			Size = UDim2.new(0, 10, 0, 10),
			BackgroundTransparency = 1,
		}
	)
	closeTween:Play()
	closeTween.Completed:Once(function()
		if token ~= animToken then
			return
		end
		mainFrame.Visible = false
		mainFrame.Size = MAIN_FULL_SIZE
		mainFrame.BackgroundTransparency = 0.05

		ballBtn.Size = UDim2.new(0, 6, 0, 6)
		ballBtn.BackgroundTransparency = 1
		ballBtn.Visible = true

		local ballOpenTween = TweenService:Create(
			ballBtn,
			TweenInfo.new(0.18, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{
				Size = BALL_FULL_SIZE,
				BackgroundTransparency = 0,
			}
		)
		ballOpenTween:Play()
		ballOpenTween.Completed:Once(function()
			if token == animToken then
				ballBtn.Size = BALL_FULL_SIZE
				ballBtn.BackgroundTransparency = 0
				isAnimatingUI = false
			end
		end)
	end)
end

local function animateOpenMain()
	if isAnimatingUI or mainFrame.Visible then
		return
	end
	isAnimatingUI = true
	animToken += 1
	local token = animToken

	local ballCloseTween = TweenService:Create(
		ballBtn,
		TweenInfo.new(0.14, Enum.EasingStyle.Quad, Enum.EasingDirection.In),
		{
			Size = UDim2.new(0, 6, 0, 6),
			BackgroundTransparency = 1,
		}
	)
	ballCloseTween:Play()
	ballCloseTween.Completed:Once(function()
		if token ~= animToken then
			return
		end
		ballBtn.Visible = false
		ballBtn.Size = BALL_FULL_SIZE
		ballBtn.BackgroundTransparency = 0

		mainFrame.Size = UDim2.new(0, 20, 0, 20)
		mainFrame.BackgroundTransparency = 1
		mainFrame.Visible = true

		local openTween = TweenService:Create(
			mainFrame,
			TweenInfo.new(0.22, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
			{
				Size = MAIN_FULL_SIZE,
				BackgroundTransparency = 0.05,
			}
		)
		openTween:Play()
		openTween.Completed:Once(function()
			if token == animToken then
				mainFrame.Size = MAIN_FULL_SIZE
				mainFrame.BackgroundTransparency = 0.05
				isAnimatingUI = false
			end
		end)
	end)
end

local ballPressPos = nil
local ballMovedDuringPress = false
local BALL_CLICK_DRAG_THRESHOLD = 8

ballBtn.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		ballPressPos = input.Position
		ballMovedDuringPress = false
	end
end)

ballBtn.InputChanged:Connect(function(input)
	if (input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch)
		and ballPressPos then
		local dist = (input.Position - ballPressPos).Magnitude
		if dist > BALL_CLICK_DRAG_THRESHOLD then
			ballMovedDuringPress = true
		end
	end
end)

ballBtn.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
		or input.UserInputType == Enum.UserInputType.Touch then
		local wasClick = not ballMovedDuringPress
		ballPressPos = nil
		ballMovedDuringPress = false

		if wasClick then
			animateOpenMain()
		end
	end
end)

minimizeBtn.MouseButton1Click:Connect(function()
	animateMinimize()
end)

-- TOOL CONNECTIONS (applies ONLY to local Gun tools, ignores Knife and Bomb)
local function setupTool(tool: Tool)
	if not tool:IsA("Tool") or connectedTools[tool] then
		return
	end

	task.defer(function()
		if not tool or not tool.Parent or not isGunTool(tool) or connectedTools[tool] then
			return
		end

		connectedTools[tool] = true

		if CURRENT_STYLE ~= "Normal" then
			applyToGun(tool)
		end

		tool.Equipped:Connect(function()
			equippedTool = tool

			if CURRENT_STYLE ~= "Normal" then
				triggerShotSync(tool)
			end
		end)

		tool.Activated:Connect(function()
			if CURRENT_STYLE ~= "Normal" then
				triggerShotSync(tool)
			end
		end)

		tool.DescendantAdded:Connect(function(descendant)
			if CURRENT_STYLE ~= "Normal" then
				applyObject(descendant, originalGunProperties)
			end
		end)

		tool.Unequipped:Connect(function()
			if CURRENT_STYLE == "Normal" then
				restoreGun(tool)
			else
				task.delay(0.05, function()
					if CURRENT_STYLE ~= "Normal" then
						applyToAllDisplays()
					end
				end)
			end
		end)

		tool.Destroying:Connect(function()
			connectedTools[tool] = nil

			if equippedTool == tool then
				equippedTool = nil
			end
		end)
	end)
end

local function setupCharacter(character)
	for _, object in ipairs(character:GetChildren()) do
		if object:IsA("Tool") then
			setupTool(object)
		elseif isHolsteredGunObject(object) and CURRENT_STYLE ~= "Normal" then
			applyToDisplay(object)
		end
	end

	character.ChildAdded:Connect(function(object)
		if object:IsA("Tool") then
			setupTool(object)
		elseif CURRENT_STYLE ~= "Normal" then
			task.defer(function()
				if isHolsteredGunObject(object) then
					applyToDisplay(object)
				end
			end)
		end
	end)

	character.DescendantAdded:Connect(function(object)
		if CURRENT_STYLE == "Normal" then
			return
		end

		task.defer(function()
			if isHolsteredGunObject(object) then
				applyToDisplay(object)
			end
		end)
	end)
end

local function setupBackpack()
	local backpack = player:WaitForChild("Backpack")

	for _, object in ipairs(backpack:GetChildren()) do
		if object:IsA("Tool") then
			setupTool(object)
		end
	end

	backpack.ChildAdded:Connect(function(object)
		if object:IsA("Tool") then
			setupTool(object)
		end
	end)
end

if player.Character then
	setupCharacter(player.Character)
end

player.CharacterAdded:Connect(function(character)
	equippedTool = nil
	table.clear(originalGunProperties)
	table.clear(originalDisplayProperties)
	setupCharacter(character)
	setupBackpack()
end)

setupBackpack()

workspace.DescendantAdded:Connect(function(object)
	if not isOwnedByLocalPlayer(object) then
		return
	end

	if not isHolsteredGunObject(object) then
		return
	end

	task.delay(0.05, function()
		if CURRENT_STYLE == "Normal" or not isOwnedByLocalPlayer(object) then
			return
		end

		applyToDisplay(object)
	end)
end)

print("[MMV] Recolor Scope v18 loaded — By:Jawrrr | Fixed texture application after GhostScope.")
