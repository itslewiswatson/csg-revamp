function createTrunk ()
	local name=getVehicleName(source)
	for i=1, #markerPosOnVeh do
		if name == markerPosOnVeh[i][1] then
			local marker = createMarker ( 0, 0, 0 ,"cylinder", 3, 0, 0, 255, 0)
			attachElements(marker, source, 0,markerPosOnVeh[i][2],-1)
			local inv = {}
			local tempInv = {}
			local invType = markerPosOnVeh[i][3]
			local occ = getElementData(source,"vehicleOccupation")
			if occ == "Police Officer" or occ == "Traffic Officer" or occ == "K9 Unit Officer" then
				invType=1
			end
			local owner = getElementData(source,"vehicleOwner")
			if owner ~= false then
				if isElement(owner) == true then
					if getElementData(owner,"skill") == "The Mechanic" then
						invType=invType+3
					end
				end
			end
			local slot1, slot2, slot3, slot4, slot5 = unpack(invTypes[invType])
			table.insert(tempInv,slot1)
			table.insert(tempInv,slot2)
			table.insert(tempInv,slot3)
			table.insert(tempInv,slot4)
			table.insert(tempInv,slot5)
			for i,v in ipairs(tempInv) do
				local idNameQty = split(v, ":")
				local index = 1
				for i,v in ipairs(idNameQty) do
					if index == 1 then
						objid = v
						index = 2
					elseif index ==2 then
						name = v
						index = 3
					elseif index == 3 then
						qty = v
						inv[#inv+1] = {objid, name, qty}
						index = 1
					end
				end
			end
			setElementData(source, "VI:inventory", inv)
			setElementData(source, "VI:opened", false)
			addEventHandler("onMarkerHit",marker, openTrunk)
			addEventHandler("onMarkerLeave",marker, closeTrunk)
			objectsTable[#objectsTable+1] = {getVehicleController(source), marker}
			setElementData(marker,"VI:vehicle", source)
		end
	end
end
addEvent("VI:createTrunk", true)
addEventHandler("VI:createTrunk", root, createTrunk)

markerPosOnVeh ={--vehicle name, y offset, inventory type
[1]={"Enforcer", -3.5,3},
[2]={"Premier", -2, 2},
[3]={"Police LV", -2,2},
[4]={"Police LS", -2, 2},
[5]={"Police SF", -2, 2},
[6]={"FBI Rancher", -3, 3},
[7]={"Police Ranger", -3, 2},
--[8]={"Barracks", -5, 3},
--[9]={"Patriot", -2,2},
--[10]={"Huntley", -2, 2},
[9]={"Cheetah", 2, 2},
[10]={"S.W.A.T.", -2.5, 1},
--[13]={"Rhino",-4,1}
}
invTypes = {--id:name:quatity
[1] = {"1238:Traffic cone:3"}, --very light gear
[2] = {"1238:Traffic cone:3", "2060:Flare:1", "2892:Stinger:1"}, --medium gear
[3] = {"1238:Traffic cone:3", "2060:Flare:1", "1228:Barrier1:2", "1459:Barrier2:2", "2892:Stinger:1"}, --heavy gear
[4] = {"1238:Traffic cone:5"}, -- add very light gear
[5] = {"1238:Traffic cone:5", "2060:Flare:2", "2892:Stinger:1"}, --add medium gear
[6] = {"1238:Traffic cone:5", "2060:Flare:2", "1228:Barrier1:3", "1459:Barrier2:3", "2892:Stinger:1"} --add heavy gear

}
--[[
cone: 1238
barrier1: 1228
barrier2: 1459
flare: 354 - 2060
]]
objectsTable = { }
function openTrunk (hitElement, vehicle)
	local x1,y1,z1 = getElementPosition(hitElement)
	local x2,y2,z2 = getElementPosition(source)
	local distance = getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2)
	if hitElement and distance < 5 then triggerClientEvent("VI:openTrunk", hitElement, source, vehicle)end
end

function closeTrunk(hitElement, vehicle)
	if hitElement then triggerClientEvent("VI:closeTrunk", hitElement, source, vehicle)end
end

---------------------------------------------------------------------------------------------------
-------------------------------Obj functions (pick/drop/spawn/despawn)-----------------
---------------------------------------------------------------------------------------------------
function createBarrier (id)
	if ( not isPedInVehicle(source) ) and getElementData(source, "VI:hasObj") ~= true then
		unbindKey(source,"mouse2")
		local obj = createObject(id, 0, 0, 0, 0, 0, 0)
		setElementCollisionsEnabled(obj, false)
		objectsTable[#objectsTable+1] = {source, obj}
		triggerClientEvent("toggleEffects",source)
		if id == 1238 then --traffic cone
			attachElements(obj, source, 0,1,0,0,0,180)
			local ssize = 1
			bindKey(source, "mouse2", "down", dropObj, obj, ssize)
			setElementData(source, "VI:hasObj", true)

		elseif id == 1228 then --barrier1
			attachElements(obj, source, 0,1,0,0,0,90)
			local ssize = 1.5
			bindKey(source, "mouse2", "down", dropObj, obj, ssize)
			setElementData(source, "VI:hasObj", true)

		elseif id == 1459 then --barrier2
			attachElements(obj, source, 0,1,0,0,0,180)
			local ssize = 1.5
			bindKey(source, "mouse2", "down", dropObj, obj, ssize)
			setElementData(source, "VI:hasObj", true)

		elseif id == 2060 then --flare
			attachElements(obj, source, 0,1,0,0,0,180)
			local ssize = 1
			bindKey(source, "mouse2", "down", dropObj, obj, ssize)
			setElementData(source, "VI:hasObj", true)
		elseif id == 2892 then
			attachElements(obj, source, 0,5,0,0,0,180)
			local ssize = 1.5
			bindKey(source, "mouse2", "down", dropObj, obj, ssize)
			setElementData(source, "VI:hasObj", true)
		end
	end
end
addEvent("spawnObj",true)
addEventHandler("spawnObj",root, createBarrier)
stingers = {}
colShapes={}
function dropObj (player, key, keyState, objToDelete, size)
	unbindKey(player,"mouse2")
	local px, py, pz = getElementPosition(player)
	local rX, rY, rZ = getElementRotation(player)
	if isElement(objToDelete) then
		detachElements(objToDelete)
		id = getElementModel(objToDelete)
		destroyElement(objToDelete)
	end
	if  id == 1238 then
		pz = pz - 0.6
	else
		pz = pz - 0.5
	end
	if id == 1228 then
		rZ = rZ+90
	end
	local obj = createObject(id, px , py , pz, rX , rY , rZ)
	if id == 2060 then
		setElementCollisionsEnabled(obj, false)
	end
	if id == 2892 then
		destroyElement(obj)
		local x,y,z = getPointFrontOfElement( player , 5 )
		pz=pz-0.5
		obj=createObject(2892, x,y,pz, rx, ry, rz )
		px,py=x,y
		setElementPosition(obj,x,y,z)
		setElementData(obj,"isStinger2",true,true)
		table.insert(stingers,obj)
		for k,v in pairs(getElementsByType("player")) do
			triggerClientEvent(v,"CSGrecStinger",v,obj)
		end
		stingerPlant(player)
	end
	if isElement(obj) == false then return end
	local pivot = createObject(id, px, py , pz-100, rX , rY , rZ)
	id = nil
	triggerClientEvent("toggleEffects",player)
	setElementCollisionsEnabled(pivot, false)
	setElementAlpha(pivot, 0)
	triggerUnbreakable (obj, player)
	local col = createColSphere( 0, 0, 0, size )
	triggerClientEvent("addColHandlers", col)
	if id == 2892 then
		attachElements(col, obj, 0,0,1)
	else
		attachElements(col, obj, 0,0,0)
	end
	attachElements(obj, pivot, 0,0,100)
	colShapes[#colShapes+1] = {col, obj, pivot}
	setElementData(player, "VI:hasObj", false)
	objectsTable[#objectsTable+1] = {player, obj}
	objectsTable[#objectsTable+1] = {player, pivot}
	objectsTable[#objectsTable+1] = {player, col}
end

function stingerPlant( thePlayer )
	setPedAnimation( thePlayer, "BOMBER", "BOM_plant", 3000, false, false, false )
	setTimer( setPedAnimation, 2000, 1, thePlayer )
end

addEventHandler("onPlayerLogin",root,function()
	for k,v in pairs(colShapes) do
		if v ~= nil then
			if isElement(v[1]) == true then
				triggerClientEvent(source,"addColHandlers",v[1])
			end
		end
	end
end)

function getPointFrontOfElement( element, distance )
    local x, y, z = getElementPosition ( element )
    local rx, ry, rz = getElementRotation ( element )
    x = x + (distance * (math.sin(math.rad(-rz))) )
    y = y + (distance * (math.cos(math.rad(-rz))) )
	return x,y,z
end

addEvent("onBarrierGetDestroyed", true)
function onBarrierGetDestroyed()
	for i=1, #colShapes do
		if colShapes[i][1] == source then
			if isElement(colShapes[i][1]) and isElement(colShapes[i][2]) and isElement(colShapes[i][3]) then
				destroyElement(colShapes[i][1])
				destroyElement(colShapes[i][2])
				destroyElement(colShapes[i][3])
			end
		end
	end
end
addEventHandler("onBarrierGetDestroyed", root, onBarrierGetDestroyed)

addEvent("destroyObj", true)
function destroyObj()
	if isElement(source) then
		destroyElement(source)
	end
end
addEventHandler("destroyObj", root, destroyObj)

function triggerUnbreakable (object)
	for i,thePlayer in ipairs( getElementsByType("player") ) do
		if ( exports.server:getPlayerAccountID(thePlayer) ) then
			triggerClientEvent("setBarriersUnBreakable", thePlayer, object )
		end
	end
end

addEventHandler("onPlayerLogin",root,function()
	for k,v in pairs(stingers) do
		triggerClientEvent(source,"CSGrecStinger",source,v)
	end
end)
-------------------------------------------------------
function onVehDespawn (player)
	triggerClientEvent("clearLabels", player )
	for i=1, #objectsTable do
		if objectsTable[i][1] == player and isElement(objectsTable[i][2]) then
			destroyElement(objectsTable[i][2])
			objectsTable[i] = {nil}
		end
	end
end
addEvent("CSGvehicles.despawnedVehicle")
addEventHandler("CSGvehicles.despawnedVehicle", root, onVehDespawn)

function onPlayerQuit ()
	for i=1, #objectsTable do
		if objectsTable[i][1] == source and isElement(objectsTable[i][2]) then
			destroyElement(objectsTable[i][2])
			objectsTable[i] = {nil}
		end
	end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)

addEventHandler("onElementDestroy", getRootElement(),
function ()
	if getElementData(source,"VI:inventory") ~= false then
		onVehDespawn(getElementData(source,"vehicleOwner"))
	end
end)
