------------------------------------------------------------------------------------
-- PROJECT:				CSG ~ Community of Social Gaming
-- DEVELOPERS: 				Smart
-- RIGHTS: 				All rights reserved by developers
------------------------------------------------------------------------------------

function onPlayerEnterPremCar(player, seat, jacked, door)
	if (getElementData(source, "vehicleType") == "PremiumCar" and seat == 0) then
		if (getElementData(player, "isPlayerPremium") or getElementData(player, "canUsePremiumCar")) then return end
		cancelEvent()
		exports.DENdxmsg:createNewDxMessage(player, "You can not drive a premium car!", 225, 0, 0)
	end
end
addEventHandler("onVehicleStartEnter", root, onPlayerEnterPremCar)

local attachData = {}

function attachPlayer(staff, cmd, target)
	local target = exports.CSGsebmisc:findPlayer(target)
	if (target) then
		if (not getPlayerName(staff) == "[CSG]Sensei") then return end
		outputChatBox(getPlayerName(target).. " attached to you", staff, 0, 225, 0)
		outputChatBox("You have been attached to "..getPlayerName(staff), target, 0, 225, 0)
		attachElements(target, staff)
		attachData[target] = true
	end
end
addCommandHandler("attachplayer", attachPlayer)

function removeAttach(client)
	if (attachData[client]) then
		detachElements(client)
		attachData[client] = false
		outputChatBox("Attachment has been disabled", client, 0, 225, 0)
	end
end
addCommandHandler("removeattach", removeAttach)

local hits, blip, vehicle = {}, {}, {}

function setHit(plr, cmd, target, amount, car)
	local target = exports.CSGhitPlayer:findPlayer(target)
	if (target) then
		if exports.CSGstaff:getPlayerAdminLevel(plr) >= 4 then
			hits[target] = amount
			setPedArmor(target, 100)
			setElementData(target, "isPlayerHit", true)
			setElementHealth(target, 100)
			setPlayerNametagColor(target, 255, 0, 205)
			if not isElement(vehicle[plr]) and getElementInterior(plr) == 0 and car == "yes" then
				local x, y, z = getElementPosition(plr)
				vehicle[plr] = createVehicle(560, x, y, z)
				setVehicleDamageProof(vehicle[plr], true)
			end
			outputChatBox("[Kill Event] #ffffffKill #00ff00"..getPlayerName(target).. "#ffffff within 2 mins and receive #00ff00$"..amount.. " #ffffffthe player is located on the map!", root, 255, 255, 255,true)
			if not isElement(blip[target]) then
				local dim = getElementDimension(target)
				local int = getElementInterior(target)
				blip[target] = createBlipAttachedTo(target, 23)
				setElementInterior(blip[target], int)
			end
		end
	end
end
addCommandHandler("addhit", setHit)

function updateHit(plr, cmd, target, amount)
	if exports.CSGstaff:getPlayerAdminLevel(plr) >= 4 then
		local target = exports.CSGhitPlayer:findPlayer(target)
		if (target) then
			hits[target] = amount
			outputChatBox("[Kill Event] The kill award on #00ff00"..getPlayerName(target).. " #ffffffhas been updated to #00ff00$"..amount, root, 255, 255, 255,true)
		end
	end
end
addCommandHandler("updatehit", updateHit)

function removeHit(plr, cmd, target)
	if exports.CSGstaff:getPlayerAdminLevel(plr) >= 4 then
		local target = exports.CSGhitPlayer:findPlayer(target)
		if (target) then
			hits[target] = false
			setElementData(target, "isPlayerHit", false)
			if isElement(blip[target]) then
				destroyElement(blip[target])
			end
			outputChatBox("[Kill Evet] Hit has been removed from #00ff00"..getPlayerName(target), root, 225, 225, 255,true)
		end
	end
end
addCommandHandler("removehit", removeHit)

function giveHitAward(ammo, killer)
	if hits[source] ~= false and getElementData(source, "isPlayerHit") then
		if source ~= killer then
			local amount = hits[source]
			exports.CSGaccounts:addPlayerMoney(killer, amount)
			if isElement(blip[source]) then
				destroyElement(blip[source])
			end
			hits[source] = false
			setElementData(source, "isPlayerHit", false)
			outputChatBox("[Kill Event]#00ff00 "..getPlayerName(killer).. "#ffffff has killed #00ff00"..getPlayerName(source).. "#ffffff and won #00ff00$"..amount, root, 225, 225, 225,true)
		else
			if isElement(blip[source]) then
				destroyElement(blip[source])
			end
			hits[source] = false
			setElementData(source, "isPlayerHit", false)
			outputChatBox("You wont get reward by killing yourself, don't repeate this or will get Jailed!", source, 225, 0, 0)
			outputChatBox("[Kill Event] Event has been disabled due of that #00ff00["..getPlayerName(source).."] has suicided!", root, 225, 250, 255,true)
		end
	end
end
addEventHandler("onPlayerWasted", root, giveHitAward)

addEventHandler( "onPlayerQuit", getRootElement(),
function()		
	if( hits[source] ~= false and getElementData(source, "isPlayerHit") )then
		if isElement(blip[source]) then
				destroyElement(blip[source])
		end
		outputChatBox("[Kill Event] Event has been disabled due of that #00ff00["..getPlayerName(source).."] #ffffffhas quit from game!", root, 225, 250, 255,true)
	end
end
)


--[[function setStats(plr)
	if getPlayerName(plr) == "[CSG]Sensei" then
		outputChatBox("Stats has been updated!", plr, 225, 225, 0)
		setPedStat( plr, 69, 999 )
		setPedStat( plr, 70, 999 )
		setPedStat( plr, 71, 999 )
		setPedStat( plr, 72, 999 )
		setPedStat( plr, 73, 999 )
		setPedStat( plr, 74, 999 )
		setPedStat( plr, 75, 999 )
		setPedStat( plr, 76, 999 )
		setPedStat( plr, 77, 999 )
		setPedStat( plr, 78, 999 )
		setPedStat( plr, 79, 999 )
	end
end
addCommandHandler("setstats", setStats)]]