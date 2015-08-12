-- laserpointer client.lua
-- by vick

--[[
Player Element Data	-- changing these to an invalid value can break this script
	"laser.on"	-- tells you player has turned laser on
	"laser.aim"  -- tells you player is aiming and laser is drawn
	"laser.red", "laser.green", "laser.blue", "laser.alpha"

Exported Functions:
	SetLaserEnabled(player, state)    -- (element:player, bool:state)    -- returns false if invalid params, true otherwise
	IsLaserEnabled(player)    -- (element:player)    -- returns true or false
	SetLaserColor(player, r,g,b,a)    -- (element:player, int:r, int:g, int:b, int:a)   -- returns true
	GetLaserColor(player)    -- (element:player)   -- returns r,g,b,a (int:) or false but shouldnt happen.
	IsPlayerWeaponValidForLaser(player)    -- (element:player)    -- returns true or false
]]

local dots = {} -- store markers for each players laser pointer
CMD_LASER = "laser"	-- command to toggle laser on/off
CMD_LASERCOLOR = "lasercolor" -- command to change laser color
laserWidth = 2 -- width of the dx line
dotSize	= .05	-- size of the dot at the end of line


localPlayer = getLocalPlayer()
-- for colorpicker
picklasercolor = 0
colorPickerInitialized = 0
oldcolors = {r=255,g=0,b=0,a=255}

function AbsoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/1280)
    local y = math.floor(Y*rY/768)
    return x, y
end

local percent = 0

addEventHandler("onClientRender", root,
    function()
		if getElementData(localPlayer, "laser.on") then
			local x1, y1 = AbsoluteToRelativ2( 995, 174 )
			local x2, y2 = AbsoluteToRelativ2( 993, 173 )
			local x3, y3 = AbsoluteToRelativ2( 994, 172 )
			local x4, y4 = AbsoluteToRelativ2( 993, 184 )
			local dx1,dy1= AbsoluteToRelativ2( 220, 9 )
			local dx2,dy2= AbsoluteToRelativ2( 1217, 173)
			local dx3,dy3= AbsoluteToRelativ2( 994, 184 )
			local dx4,dy4= AbsoluteToRelativ2( 1217, 184 )
			dxDrawRectangle(x1,y1,dx1*(percent/100),dy1, tocolor(108, 253, 1, 255), true)
			dxDrawLine(x2,y2,dx2,dy2, tocolor(0, 0, 0, 255), 4, true)
			dxDrawLine(x3,y3,dx3,dy3, tocolor(0, 0, 0, 255), 4, true)
			dxDrawLine(x4,y4,dx4,dy4, tocolor(0, 0, 0, 255), 4, true)
		end
    end
)

function deplete()
	if getElementData(localPlayer, "laser.on") then
		if percent > 2 then
			if percent-(100/3600) < 2 then
				triggerServerEvent("CSGlaser.batteryDone",localPlayer)
			end
			percent=percent-(1000/3600)
		end
	end
end
setTimer(deplete,1000,0)

function updateServ()
	if percent > 2 then
		triggerServerEvent("CSGlaser.update",localPlayer,percent)
	end
end
setTimer(updateServ,60000,0)

 addEventHandler("onClientResourceStart", getRootElement(), function(res)
	if res == getThisResource() then
		SetLaserEnabled(localPlayer, true)
		SetLaserColor(localPlayer, oldcolors.r,oldcolors.g,oldcolors.b,oldcolors.a)

		if colorPickerInitialized == 0 then -- attempt to init colorpicker stuff
			--initColorPicker()
		end

	elseif res == getResourceFromName("colorpicker") then
		if colorPickerInitialized == 0 then -- attempt to init colorpicker stuff
			--initColorPicker()
		end
	end
end )
addEventHandler("onClientResourceStop", getRootElement(), function(res)
	if res == getThisResource() then
		SetLaserEnabled(localPlayer, false)
	end
end )

addEventHandler("onClientElementDataChange", localPlayer,
	function(dataName, oldValue)
		if getElementType(source) == "player" and source == localPlayer and dataName == "laser.on" then
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
			if getElementData(v, "laser.on") then
				DrawLaser(v)
			end
		end
	end
)
addEventHandler( "onClientPreRender",  getRootElement(),
	function()
		local players = getElementsByType("player")
		for k,v in ipairs(players) do
			if getElementData(v, "laser.on") then
				--DrawLaser(v)
			end
		end
	end
)

function AimKeyPressed(key, state) -- attempt to sync when aiming with binds, getPedControlState seems weird...
	if state == "down" then
		setElementData(localPlayer, "laser.aim", true, true)
	elseif state == "up" then
		setElementData(localPlayer, "laser.aim", false, true)
	end
	--outputChatBox(key .. " " .. state)
end

function DrawLaser(player)
	if getElementData(player, "laser.on") then
		local targetself = getPedTarget(player)
		if targetself and targetself == player then
			targetself = true
		else
			targetself = false
		end

		if getElementData(player, "laser.aim") and IsPlayerWeaponValidForLaser(player) == true and targetself == false then
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
			local r,g,b,a = GetLaserColor(player)
			if x3 then -- collision detected, draw til collision and add a dot
				dxDrawLine3D(x,y,z,x3,y3,z3, tocolor(r,g,b,a), laserWidth)
				DrawLaserDot(player, x3,y3,z3)
			else -- no collision, draw til end of weapons range
				dxDrawLine3D(x,y,z,x2,y2,z2, tocolor(r,g,b,a), laserWidth)
				DestroyLaserDot(player)
			end
		else
			DestroyLaserDot(player) -- not aiming, remove dot, no laser
		end
	else
		DestroyLaserDot(player)
	end
end
function DrawLaserDot (player, x,y,z)
	if not dots[player] then
		dots[player] = createMarker(x,y,z, "corona", .05, GetLaserColor(player))
	else
		setElementPosition(dots[player], x,y,z)
	end
end
function DestroyLaserDot(player)
	if dots[player] and isElement(dots[player]) then
		destroyElement(dots[player])
		dots[player] = nil
	end
end

function SetLaserColor(player,r,g,b,a)
	setElementData(player, "laser.red", r)
	setElementData(player, "laser.green", g)
	setElementData(player, "laser.blue", b)
	setElementData(player, "laser.alpha", a)
	return true
end
function GetLaserColor(player)
	r = getElementData(player, "laser.red")
	g = getElementData(player, "laser.green")
	b = getElementData(player, "laser.blue")
	a = getElementData(player, "laser.alpha")

	return r,g,b,a
end
function IsPlayerWeaponValidForLaser(player) -- returns false for unarmed and awkward weapons
	local weapon = getPedWeapon(player)
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 then
		return true
	end
	return false
end

function SetLaserEnabled(player, state) -- returns false if invalid params passed, true if successful changed laser enabled
	if not player or isElement(player) == false then return false end
	if getElementType(player) ~= "player" then return false end
	if state == nil then return false end

	if state == true then -- enable laser
		setElementData(player, "laser.on", true, true)
		setElementData(player, "laser.aim", false, true)
		--bindKey("aim_weapon", "both", AimKeyPressed)   -- done in onClientElementDataChange
		return true
	elseif state == false then -- disable laser
		setElementData(player, "laser.on", false, true)
		setElementData(player, "laser.aim", false, true)
		--unbindKey("aim_weapon", "both", AimKeyPressed)   -- done in onClientElementDataChange
		return true
	end
	return false
end
function IsLaserEnabled(player) -- returns true or false based on player elementdata "laser.on"
	if getElementData(player, "laser.on") == true then
		return true
	else
		return false
	end
end

function ToggleLaserEnabled(cmd)
	player = localPlayer
	if tonumber(percent) > 2 then
		if IsLaserEnabled(player) == false then
			SetLaserEnabled(player, true)
			exports.dendxmsg:createNewDxMessage("Laser: Equipped and turned on",0,255,0)
		else
			SetLaserEnabled(player, false)
			exports.dendxmsg:createNewDxMessage("Laser: Unequipped and turned off",0,255,0)
		end
	end
end
bindKey("l","down",ToggleLaserEnabled)
--[[
function ChangeLaserColor(cmd, r,g,b,a)
	local player = localPlayer
	if colorPickerInitialized == 1 and getResourceFromName("colorpicker") then
		oldcolors.r, oldcolors.g, oldcolors.b, oldcolors.a = GetLaserColor(player)
		picklasercolor = 1
		if exports.colorpicker:requestPickColor(true,true,"Choose Laser Color",oldcolors.r,oldcolors.g,oldcolors.b,oldcolors.a) == false then
			exports.colorpicker:cancelPickColor()
			return false
		end
		return true
	else
		if r and g and b and a then
			r,g,b,a = tonumber(r), tonumber(g), tonumber(b), tonumber(a)
			if r and g and b and a then
				if r < 0 or g < 0 or b < 0 or a < 0 or r > 255 or g > 255 or b > 255 or a > 255 then
					outputChatBox("Invalid colors: (0-255) usage: /" ..CMD_LASERCOLOR.. " r g b a", 245,0,0)
					return false
				else
					outputChatBox("Changed Laser Color to: "..r.." "..g.." "..b.." ".. a, r,g,b)
					SetLaserColor(player,r,g,b,a)
					return true
				end
			end
		end
	end
	outputChatBox("Invalid colors: (0-255) usage: /" ..CMD_LASERCOLOR.. " r g b a", 245,0,0)
	return false
end

addCommandHandler(CMD_LASERCOLOR, ChangeLaserColor)
--]]
addCommandHandler(CMD_LASER, ToggleLaserEnabled)
-- if color picker resource running, initialize events for it

addEvent("CSGlaser.recData",true)
addEventHandler("CSGlaser.recData",localPlayer,function(t)
	percent=t[1]
	local r,g,b = t[2],t[3],t[4]
	SetLaserEnabled(localPlayer,t[5])
end)

SetLaserEnabled(localPlayer,false)
