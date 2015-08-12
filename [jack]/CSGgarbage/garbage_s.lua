earnMoney = 1323 --$75 * [amount]
addEvent("addTrashUnits",true)
function addTrashUnit(vehicle,newAmount)
	local player=source
	if vehicle and (getElementType(vehicle) == "vehicle") then --check..
		unit = getElementData(vehicle,"trash:Unit")
		if not unit then
			setElementData(vehicle,"trash:Unit",newAmount)
			newUnit = getElementData(vehicle,"trash:Unit")
			toggleSpeed(player,vehicle,newUnit)
			--outputDebugString("New unit: "..newUnit)
		else
			trashUnit = unit + newAmount
			setElementData(vehicle,"trash:Unit",trashUnit) --add new amount
			newUnit = getElementData(vehicle,"trash:Unit")
			toggleSpeed(player,vehicle,newUnit)
			--outputDebugString("New unit: "..newUnit)
		end
		exports.CSGscore:givePlayerScore(player,0.4)
	else
		--outputDebugString("[TRASH] Vehicle was not passed through, instead it was "..getElementType(vehicle)..". Returning!")
		return false
	end
end
addEventHandler("addTrashUnits",root,addTrashUnit)

function toggleSpeed(player,vehicle,units)
	if units > 5 then -- normal speed
		output1 = false
		output2 = false
		output3 = false
		setVehicleHandling(vehicle,"engineAcceleration",10)
	elseif units < 5 and units > 10 then --slice the speed by 25%
		output1 = false
		setVehicleHandling(vehicle,"engineAcceleration",7)
		if output == false then
			exports.DENdxmsg:createNewDxMessage(player,"The vehicle seemed to got heavier, seems the acceleration has slowed down.",255,255,0)
		end
	elseif units < 10 and units > 15 then
		output2 = false
		setVehicleHandling(vehicle,"engineAcceleration",5)
		if output == false then
			exports.DENdxmsg:createNewDxMessage(player,"The vehicle seemed to got heavier, seems the acceleration has slowed down.",255,255,0)
		end
	elseif units < 15 and units > 20 then
		output3 = false
		setVehicleHandling(vehicle,"engineAcceleration",3) --heavy vehicle
		if output == false then
			exports.DENdxmsg:createNewDxMessage(player,"The vehicle seemed to got heavier, seems the acceleration has slowed down.",255,255,0)
		end
	else
		return
	end
end

addEvent("collectUnitData",true)
addEventHandler("collectUnitData",root,
function(player,vehicle)
	if player and vehicle then
		units = getTrashUnits(vehicle)
		if units then
			--outputDebugString("Server units collected, sending back to clientside...")
			triggerClientEvent(player,"unitDataReciever",player,player,vehicle,unit)
			toggleSpeed(vehicle,units)
		end
	end
end)

addEvent("getTrashUnits",true)
function getTrashUnits(vehicle)
	if vehicle and (getElementType(vehicle) == "vehicle") then
		unit = getElementData(vehicle,"trash:Unit")
		if not unit then
			return 0
		else
			return unit
		end
	end
end
addEventHandler("getTrashUnits",root,getTrashUnits)

addEventHandler("onResourceStop",resourceRoot,
function()
	for k,v in ipairs(getElementsByType("vehicle")) do
		setElementData(v,"trash:Unit",0)
	end
end)

addEvent("onGarbageDropoff",true)
function giveCashForGarbage(player,vehicle,backupUnits)
	--outputDebugString("Dropoff (SERVER) Toggled")
	if player and vehicle and backupUnits then
		--outputDebugString("Player and vehicle found, resuming...")
		units = getTrashUnits(vehicle)
		if units then
			if units == 0 then --it bugged
				units = backupUnits
			end
			--outputDebugString("Unit found, calculating money...")
			totalMoney = earnMoney * units
			if totalMoney then
				--outputDebugString("Calculations done, total: $"..totalMoney)
				givePlayerMoney(player,totalMoney)
				setElementData(vehicle,"trash:Unit",0)
				exports.DENdxmsg:createNewDxMessage(player,"Trash dumped and recycled, You earned $"..exports.server:convertNumber(totalMoney).." from "..units.." units of trash.",0,255,0)
				toggleSpeed(vehicle,0)
			end
		else
			--outputDebugString("Failed to pay "..getPlayerName(player),1)
		end
	end
end
addEventHandler("onGarbageDropoff",root,giveCashForGarbage)

addCommandHandler("setpoints",
function(player,cmd)
	addTrashUnit(player,getPedOccupiedVehicle(player),1)
end)
