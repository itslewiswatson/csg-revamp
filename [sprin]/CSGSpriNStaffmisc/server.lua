ggun_enabled = {}

function togglePlayerGravityGun(player,on)
	if not (isElement(player) and getElementType(player) == "player") then return false end
	if on ~= true and on ~= false then return false end
	if ggun_enabled[player] == (on == true) then return false end
	ggun_enabled[player] = on == true
	if on then
		setElementData(player,"ggun_takenn",true)
	else
		removeElementData(player,"ggun_takenn")
	end
	toggleControl(player,"fire",not on)
	return true
end

function isGravityGunEnabled(player)
	return ggun_enabled[player] or false
end

addEventHandler("onPlayerQuit",root,function()
	ggun_enabled[source] = nil
end)

addEvent("ggun_takee",true)
addEventHandler("ggun_takee",root,function()
	if not isElement(getElementData(source,"ggun_takerr")) and not isElement(getElementData(client,"ggun_takenn")) then
		setElementData(client,"ggun_takenn",source)
		setElementData(source,"ggun_takerr",client)
	end
end)

addEvent("ggun_dropp",true)
addEventHandler("ggun_dropp",root,function()
	removeElementData(getElementData(client,"ggun_takenn"),"ggun_takerr")
	setElementData(client,"ggun_takenn",true)
end)

addEvent("ggun_pushh",true)
addEventHandler("ggun_pushh",root,function(vx,vy,vz)
	local taker = getElementData(source,"ggun_takerr")
	if isElement(taker) then setElementData(taker,"ggun_takenn",true) end
	removeElementData(source,"ggun_takerr")
	setElementVelocity(source,vx,vy,vz)
end)

function toggleGGun(player)
	if ((type(exports.csgstaff:getPlayerAdminLevel(player)) == "number") and (exports.csgstaff:getPlayerAdminLevel(player) >= 4)) then
	local on = not isGravityGunEnabled(player)
	togglePlayerGravityGun(player,on)
	outputChatBox("gravity gun "..(on and "on" or "off"),player)
	end
end
addCommandHandler("sgun",toggleGGun)
