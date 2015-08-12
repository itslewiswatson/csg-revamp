--[[
Player Element Data	-- changing these to an invalid value can break this script
	"Led.on"	-- tells you player has turned Led on
	"Led.aim"  -- tells you player is aiming and Led is drawn
	"Led.red", "Led.green", "Led.blue", "Led.alpha"

Exported Functions:
	SetLedEnabled(player, state)    -- (element:player, bool:state)    -- returns false if invalid params, true otherwise
	IsLedEnabled(player)    -- (element:player)    -- returns true or false
	SetLedColor(player, r,g,b,a)    -- (element:player, int:r, int:g, int:b, int:a)   -- returns true
	GetLedColor(player)    -- (element:player)   -- returns r,g,b,a (int:) or false but shouldnt happen.
	IsPlayerWeaponValidForLed(player)    -- (element:player)    -- returns true or false
]]

local dots = {} -- store markers for each players Led pointer
CMD_Led = "flash"
dotSize	= 2 -- size of the dot at the end of line

localPlayer = getLocalPlayer()
-- for colorpicker
pickLedcolor = 0
colorPickerInitialized = 0
oldcolors = {r=255,g=255,b=255,a=70}


addEventHandler("onClientResourceStart", getRootElement(), function(res)
	if res == getThisResource() then
		SetLedEnabled(localPlayer, false)
		SetLedColor(localPlayer, oldcolors.r,oldcolors.g,oldcolors.b,oldcolors.a)

		if colorPickerInitialized == 0 then -- attempt to init colorpicker stuff
			initColorPicker()
		end

	elseif res == getResourceFromName("colorpicker") then
		if colorPickerInitialized == 0 then -- attempt to init colorpicker stuff
			initColorPicker()
		end
	end
end )
addEventHandler("onClientResourceStop", getRootElement(), function(res)
	if res == getThisResource() then

		SetLedEnabled(localPlayer, true)
	end
end )

addEventHandler("onClientElementDataChange", localPlayer,
	function(dataName, oldValue)
		if getElementType(source) == "player" and source == localPlayer and dataName == "Led.on" then
			local newValue = getElementData(source, dataName)
			if oldValue == true and newValue == false then
				unbindKey("aim_weapon", "both", AimKeyPressed)
			elseif oldValue == false and newValue == true then
				bindKey("aim_weapon", "both", AimKeyPressed)
			end
		end
	end
)

addEventHandler( "onClientRender",  getRootElement(),
	function()
		local players = getElementsByType("player")
		for k,v in ipairs(players) do
			if getElementData(v, "Led.on") then
				DrawLed(v)
			end
		end
	end
)
addEventHandler( "onClientPreRender",  getRootElement(),
	function()
		local players = getElementsByType("player")
		for k,v in ipairs(players) do
			if getElementData(v, "Led.on") then
				--DrawLed(v)
			end
		end
	end
)

function AimKeyPressed(key, state) -- attempt to sync when aiming with binds, getPedControlState seems weird...
	if state == "down" then
		setElementData(localPlayer, "Led.aim", true, true)
	elseif state == "up" then
		setElementData(localPlayer, "Led.aim", false, true)
	end
	--exports.DENdxmsg:createNewDxMessage(key .. " " .. state)
end

function DrawLed(player)
	if getElementData(player, "Led.on") then
		local targetself = getPedTarget(player)
		if targetself and targetself == player then
			targetself = true
		else
			targetself = false
		end

		if getElementData(player, "Led.aim") and IsPlayerWeaponValidForLed(player) == true and targetself == false then
			local x,y,z = getPedWeaponMuzzlePosition(player)
			if not x then
				outputDebugString("getPedWeaponMuzzlePosition failed")
				x,y,z = getPedTargetStart(player)
			end
			local x2,y2,z2 = getPedTargetEnd(player)
			if not x2 then
				--outputDebugString("getPedTargetEnd failed")
				return
			end
			local x3,y3,z3 = getPedTargetCollision(player)
			local r,g,b,a = GetLedColor(player)
			if x3 then -- collision detected, draw til collision and add a dot
				--dxDrawLine3D(x,y,z,x3,y3,z3, tocolor(r,g,b,a), LedWidth)
				DrawLedDot(player, x3,y3,z3)
			else -- no collision, draw til end of weapons range
				--dxDrawLine3D(x,y,z,x2,y2,z2, tocolor(r,g,b,a), LedWidth)
				DestroyLedDot(player)
			end
		else
			DestroyLedDot(player) -- not aiming, remove dot, no Led
		end
	else
		DestroyLedDot(player)
	end
end
function DrawLedDot (player, x,y,z)
	if not dots[player] then
		local size = 1
		local x2,y2,z2 = getElementPosition(player)
		local dist = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
		if dist > 10 then size = 1.8 end
		if dist > 20 then size = 1.6 end
		if dist > 30 then size = 1.4 end
		if dist > 40 then size = 1.2 end
		if dist > 50 then size = 1 end
		dots[player] = createMarker(x,y,z, "corona", size, GetLedColor(player))
	else
		setElementPosition(dots[player], x,y,z)
	end
end
function DestroyLedDot(player)
	if dots[player] and isElement(dots[player]) then
		destroyElement(dots[player])
		dots[player] = nil
	end
end

function SetLedColor(player,r,g,b,a)
	setElementData(player, "Led.red", r)
	setElementData(player, "Led.green", g)
	setElementData(player, "Led.blue", b)
	setElementData(player, "Led.alpha", a)
	return true
end
function GetLedColor(player)
	r = getElementData(player, "Led.red")
	g = getElementData(player, "Led.green")
	b = getElementData(player, "Led.blue")
	a = getElementData(player, "Led.alpha")

	return r,g,b,a
end
function IsPlayerWeaponValidForLed(player) -- returns false for unarmed and awkward weapons
	local weapon = getPedWeapon(player)
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 and weapon ~= 22 and weapon ~= 26 and weapon ~= 28 and weapon ~= 32 and weapon ~= 40 and weapon ~= 46 and weapon ~= 45 and weapon ~= 44 and weapon ~= 41 and weapon ~= 42 and weapon ~= 43 and weapon ~= 16 and weapon ~= 17 and weapon ~= 34 and weapon ~= 33 then
		return true
	end
	return false
end

function SetLedEnabled(player, state) -- returns false if invalid params passed, true if successful changed Led enabled
	if not player or isElement(player) == false then return false end
	if getElementType(player) ~= "player" then return false end
	if state == nil then return false end

	if state == true then -- enable Led
		setElementData(player, "Led.on", true, true)
		setElementData(player, "Led.aim", false, true)
		--bindKey("aim_weapon", "both", AimKeyPressed)   -- done in onClientElementDataChange
		return true
	elseif state == false then -- disable Led
		setElementData(player, "Led.on", false, true)
		setElementData(player, "Led.aim", false, true)
		--unbindKey("aim_weapon", "both", AimKeyPressed)   -- done in onClientElementDataChange
		return true
	end
	return false
end
function IsLedEnabled(player) -- returns true or false based on player elementdata "Led.on"
	if getElementData(player, "Led.on") == true then
		return true
	else
		return false
	end
end

function ToggleLedEnabled(cmd)
	player = localPlayer
	if IsLedEnabled(player) == false then
		SetLedEnabled(player, true)
		exports.DENdxmsg:createNewDxMessage("Flashlight Enabled (On)", 255,255,255)
	    local sound = playSound("1.wav")
		flashlight = createObject(15060,0,0,0,0,0,0,true)
	exports.bone_attach:attachElementToBone(flashlight,player,12,0,0.015,0.2,0,0,0)
	else
		SetLedEnabled(player, false)
		exports.DENdxmsg:createNewDxMessage("Flashlight Disabled (Off)", 255,0,0)
		exports.bone_attach:detachElementFromBone(flashlight)
	destroyElement(flashlight)
	end
end
addCommandHandler(CMD_Led, ToggleLedEnabled)

-- if color picker resource running, initialize events for it
function initColorPicker()
	if getResourceFromName("colorpicker") == false then
		return false
	end

	addEventHandler("onClientPickedColor", localPlayer, function(r,g,b,a)
		if pickLedcolor == 1 then
			SetLedColor(source,r,g,b,a)
		end
	end	)

	addEventHandler("onClientCancelColorPick", localPlayer, function()
		if pickLedcolor == 1 then
			SetLedColor(source,oldcolors.r,oldcolors.g,oldcolors.b,oldcolors.a)
			pickLedcolor = 0
		end
	end )

	--[[ -- not in colorpicker yet
	addEventHandler("onClientColorSelectionChanged", localPlayer, function(r,g,b,a)
		if pickLedcolor == 1 then
			SetLedColor(source,r,g,b,a)
		end
	end )
	]]
	colorPickerInitialized = 1
	return true
end




function shaderResourceStart()

engineImportTXD( engineLoadTXD( "objects/flashlight.txd" ), 15060 )
engineReplaceModel ( engineLoadDFF( "objects/flashlight.dff", 0 ), 15060,true)

--addCommandHandler("flash",ToggleLedEnabled)
end

---------------------------------------------------------------------------------------------------

addEventHandler("onClientResourceStart", getResourceRootElement( getThisResource()), shaderResourceStart)
