-- laserpointer server.lua
-- by vick

--[[
Player Element Data	-- changing these to an invalid value can break this script
	"l.on"	-- tells you player has turned laser on
	"l.aim"  -- tells you player is aiming and laser is drawn
	"l.red", "l.green", "l.blue", "l.alpha"

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
		setElementData(player, "l.on", true, true)
		setElementData(player, "l.aim", false, true)
		return true
	elseif state == false then -- disable laser
		setElementData(player, "l.on", false, true)
		setElementData(player, "l.aim", false, true)
		return true
	end
	return false
end

function IsLaserEnabled(player) -- returns true or false based on player elementdata "l.on"
	if getElementData(player, "l.on") == true then
		return true
	else
		return false
	end
end

function SetLaserColor(player,r,g,b,a)
	setElementData(player, "l.red", r)
	setElementData(player, "l.green", g)
	setElementData(player, "l.blue", b)
	setElementData(player, "l.alpha", a)
	return true
end

function GetLaserColor(player)
	r = getElementData(player, "l.red")
	g = getElementData(player, "l.green")
	b = getElementData(player, "l.blue")
	a = getElementData(player, "l.alpha")

	return r,g,b,a
end

function IsPlayerWeaponValidForLaser(player) -- returns false for unarmed and awkward weapons
	local weapon = getPedWeapon(player)
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
	SetLaserEnabled(source,false)
	local accountID = exports.server:getPlayerAccountID(source)
	local t = {0,0,0,0,false}
	exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE userid=?",toJSON(t),accountID)
end)


addEventHandler("onPlayerLogin",root,function()
	local accountID = exports.server:getPlayerAccountID(source)
	local t = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?",accountID)
	if t == nil then
		t = {0,0,0,0,false}
	elseif t.laster ~= nil then
		t=t.laser
		t=fromJSON(t)
	end
	if t==nil or t[1] == nil then
		t = {0,0,0,0,false}
	end
	SetLaserColor(source,t[2],t[3],t[4],255)
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
	exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE userid=?",toJSON(t),accountID)
end)

addEventHandler("onPlayerQuit",root,function()
	local accountID = exports.server:getPlayerAccountID(source)
	if accountID == nil or type(tonumber(accountID)) ~= "number" then return end
	local oldt = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?",accountID)
	if oldt == nil then oldt = {0,0,0,0,false} else
		oldt=oldt.laser
		oldt=fromJSON(oldt)

	end
	if oldt == nil then oldt = {0,0,0,0,false} end
	local per = oldt[1]
	local r,g,b = GetLaserColor(source)
	local bool = IsLaserEnabled(source)
	if r == nil then r,g,b = 0,0,0 end
	if bool == nil then bool = false end
	local t = {per,r,g,b,bool}
	exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE userid=?",toJSON(t),accountID)
end)

setTimer(function()
for k,v in pairs(getElementsByType("player")) do
	if exports.server:isPlayerLoggedIn(v) == true then
		local accountID = exports.server:getPlayerAccountID(v)
	local oldt = exports.DENmysql:querySingle("SELECT * FROM playerstats WHERE userid=?",accountID)
	if oldt == nil then oldt = {0,0,0,0,false} else
	oldt=oldt.laser
	oldt=fromJSON(oldt)
	end
	local needUp = false
	if oldt == nil then needUp = true oldt = {0,0,0,0,false} end
	local per = oldt[1]
	local r,g,b = GetLaserColor(v)
	local bool = IsLaserEnabled(v)

	if r == nil then  needUp=true r,g,b = 0,0,0 end
	if bool == nil then   needUp=true bool = false end
	local t = {per,r,g,b,bool}
	if needUp == true then
		exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE userid=?",toJSON(t),accountID)
	end
	triggerClientEvent(v,"CSGlaser.recData",v,t)
	end
end
end,5000,1)

