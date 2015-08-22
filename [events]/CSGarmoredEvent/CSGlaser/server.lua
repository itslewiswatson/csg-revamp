-- laserpointer server.lua
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


function SetLaserEnabled(player, state) -- returns false if invalid params passed, true if successful changed laser enabled
	if not player or not isElement(player) or getElementType(player) ~= "player" then return false end
	if not state then return false end

	if state == true then -- enable laser
		setElementData(player, "laser.on", true, true)
		setElementData(player, "laser.aim", false, true)
		return true
	elseif state == false then -- disable laser
		setElementData(player, "laser.on", false, true)
		setElementData(player, "laser.aim", false, true)
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
	local weapon = getPlayerWeapon(player)
	if weapon and weapon > 21 and weapon < 39 and weapon ~= 35 and weapon ~= 36 then
		return true
	end
	return false
end

addEvent("CSGammu.boughtLaser",true)
addEventHandler("CSGammu.boughtLaser",root,function(t)
	triggerClientEvent(source,"CSGlaser.recData",source,t)
end)

addEvent("CSGlaser.batteryDone",true)
addEventHandler("CSGlaser.batteryDone",root,function()
	exports.dendxmsg:createNewDxMessage(source,"Your laser's battery has depleted and the laser have been removed.",0,255,0)
	local accountID = exports.server:getPlayerAccountID(source)
	local t = {0,0,0,0,false}
	exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE id=?",toJSON(t),accountID)
end)

addEventHandler("onPlayerLogin",true)
addEventHandler("onPlayerLogin",root,function()
	local accountID = exports.server:getPlayerAccountID(source)
	local t = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",accountID)
	t=t.laser
	t=fromJSON(t)
	if t == nil or t[1] == nil then
		t = {0,0,0,0,false}
	end
	triggerClientEvent(source,"CSGlaser.recData",source,t)
end)

addEvent("CSGlaser.update",true)
addEventHandler("CSGlaser.update",root,function(per)
	local accountID = exports.server:getPlayerAccountID(source)
	local r,g,b = GetLaserColor(source)
	local bool = IsLaserEnabled(source)
	local t = {per,r,g,b,bool}
	exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE id=?",toJSON(t),accountID)
end)

addEventHandler("onPlayerQuit",root,function()
	local accountID = exports.server:getPlayerAccountID(source)
	local oldt = exports.DENmysql:querySingle("SELECT * FROM accounts WHERE id=?",accountID)
	oldt=oldt.laser
	oldt=fromJSON(oldt)
	local per = oldt[1]
	local r,g,b = GetLaserColor(source)
	local bool = IsLaserEnabled(source)
	local t = {per,r,g,b,bool}
	exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE id=?",toJSON(t),accountID)
end)
