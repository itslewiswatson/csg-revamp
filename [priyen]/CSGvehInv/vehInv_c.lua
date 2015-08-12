function createTrunkMarker(veh)
	if source ~= localPlayer then return end
		local occ = getElementData(veh, "vehicleOccupation")
		if  occ == "SWAT Team" or occ == "Military Forces" or occ == "Federal Agent" or occ == "Police Officer" or occ == "Traffic Officer" or occ == "K9 Unit Officer" then
			if getElementData(veh,"VI:inventory") ~= false then return end
			triggerServerEvent("VI:createTrunk", veh)
			setElementData(source, "VI:hasObj", false)
			setElementData(source, "VI:effects", false)
		end
end
--addCommandHandler("trunk", createTrunkMarker)
addEvent("onClientPlayerVehicleEnter", true)
addEventHandler("onClientPlayerVehicleEnter", root, createTrunkMarker)

---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------

function isLaw(p)
	local n =getTeamName(getPlayerTeam(p))
	if n == "SWAT" or n == "Military Forces" or n == "Government Agency" or n == "Police" then
		return true
	else
		return false
	end
end



function onPlayerMarkerHit (marker)
	local vehicle = getElementAttachedTo(marker)
	if source == localPlayer and not getPedOccupiedVehicle(localPlayer) then
		if isLaw(source) == true then
			bindKey("x", "down", openInv, marker, source, vehicle)
			if not openLabel then
				openLabel = guiCreateLabel(0, 0.85, 1, 0.1, "Press x to open the vehicle's trunk.", true)
				guiLabelSetHorizontalAlign(openLabel, "center", false)
			end
		end
	end
end
addEvent("VI:openTrunk", true)
addEventHandler("VI:openTrunk", root, onPlayerMarkerHit)
function onPlayerMarkerLeave (marker)
	if source == localPlayer and not getPedOccupiedVehicle(localPlayer) then
		unbindKey("x")
		if invWindow then
			hideGUI (marker)
		end
		if openLabel and isElement(openLabel) then
			destroyElement(openLabel)
			openLabel = nil
		end
	end
end
addEvent("VI:closeTrunk", true)
addEventHandler("VI:closeTrunk", root, onPlayerMarkerLeave)
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
function openInv(keyPressed,state, marker, player, veh)
	local vehicle = getElementAttachedTo(marker)
	if player == localPlayer and vehicle == veh and getElementData(veh, "VI:opened") == false and not getPedOccupiedVehicle(player)  then
		local inv = getElementData(veh, "VI:inventory")
		setElementData(veh, "VI:opened", true)
		if invWindow then
			guiGridListClear(itemList)
			showCursor(true)
			guiSetVisible(invWindow, true)
			setElementData(btnTake,"VI:vehicle", veh)
			for i=1, #inv do
				local row = guiGridListAddRow(itemList)
				guiGridListSetItemText(itemList, row, itemId, inv[i][1], false, true)
				guiGridListSetItemText(itemList, row, itemName, inv[i][2], false, false)
				guiGridListSetItemText(itemList, row, itemQuantity, inv[i][3], false, true)
			end
			if getElementData(player, "VI:hasObj") == true then
				guiSetText(btnTake, "Store object")
			else guiSetText(btnTake, "Take")
			end
			local inv = nil
		else
			local Width, Height = 300, 350
			local screenWidth, screenHeight = guiGetScreenSize()
			local X = ( screenWidth/2 ) - ( Width/2 )
			local Y = ( screenHeight/2 ) - ( Height/2 )
			showCursor(true)
			invWindow = guiCreateWindow(X, Y, Width, Height, "CSG ~ Vehicle Inventory", false)
			guiWindowSetSizable(invWindow, false)
			btnClose = guiCreateButton(160, 300, 120, 30, "Close", false, invWindow)
				addEventHandler("onClientGUIClick", btnClose, closeGUI)
			btnTake = guiCreateButton(20, 300, 120, 30, "Take", false, invWindow)
				addEventHandler("onClientGUIClick", btnTake, takeObj)
				setElementData(btnTake,"VI:vehicle", veh)
			itemList = guiCreateGridList(10, 25, 280, 250, false, invWindow)
			itemId = guiGridListAddColumn(itemList, "Id:", 0.25)
			itemName = guiGridListAddColumn(itemList, "Object:", 0.40)
			itemQuantity = guiGridListAddColumn(itemList, "Quantity:", 0.25)
			for i=1, #inv do
				local row = guiGridListAddRow(itemList)
				guiGridListSetItemText(itemList, row, itemId, inv[i][1], false, true)
				guiGridListSetItemText(itemList, row, itemName, inv[i][2], false, false)
				guiGridListSetItemText(itemList, row, itemQuantity, inv[i][3], false, true)
			end
			if getElementData(player, "VI:hasObj") == true then
				guiSetText(btnTake, "Store object")
			end
			local inv = nil
		end
	elseif player == localPlayer and vehicle == veh and getElementData(veh, "VI:opened") == true then exports.DENdxmsg:createNewDxMessage( "This vehicle's trunk is currently being used by a player, please wait!", 255, 0, 0 )
	end
end

function closeGUI ()
	if source ~= btnClose then return end
		guiSetVisible(invWindow, false)
		showCursor(false)
		guiGridListClear(itemList)
		local veh = getElementData(btnTake,"VI:vehicle")
		setElementData(veh, "VI:opened", false)
end
function hideGUI (btnORmarker)
	if invWindow then
		guiSetVisible(invWindow, false)
		showCursor(false)
		local veh = getElementData(btnORmarker,"VI:vehicle")
		setElementData(veh, "VI:opened", false)
	end
end

function takeObj()
	if source ~= btnTake then return end
	local veh = getElementData(btnTake,"VI:vehicle")
	local player = localPlayer
	if guiGetText(btnTake) == "Take" then
		local index = guiGridListGetSelectedItem(itemList)
		if index < 0 then return end
		local objId = tonumber(guiGridListGetItemText(itemList, index, itemId))
		local objQty = tonumber(guiGridListGetItemText(itemList, index, itemQuantity))
		if objQty <= 0 then return end
		updateVehInv(objId, veh, player, "-")
		spawnObject(player, objId )
		hideGUI (btnTake)
		setElementData(veh, "VI:opened", false)
		local index = nil
		local objId = nil
		local veh = nil
	elseif guiGetText(btnTake) == "Store object" then
		local objs = getAttachedElements(localPlayer)
		local inv =  getElementData(veh, "VI:inventory")
			for i,v in ipairs (objs) do
				if getElementType(v) == "object" then
					for i=1, #inv do
						if inv[i][1] == tostring(getElementModel(v)) then
							objId = getElementModel(v)
							obj = v
							updateVehInv(objId, veh, player, "+")
							setElementData(veh, "VI:opened", false)
							hideGUI (btnTake)
							unbindKey("mouse2")
							triggerServerEvent("destroyObj", obj )
							setElementData(player, "VI:hasObj", false)
							toggleEffects(localPlayer)
							if placeLabel and isElement(placeLabel) then
								destroyElement(placeLabel)
								placeLabel = nil
							end
						end
					end
				end
			end
		if not objId then exports.DENdxmsg:createNewDxMessage( "You can't store that object in this vehicle!", 255, 0, 0 ) setControlState("walk", true) end
		objId = nil
		veh = nil
		obj = nil
	end
end

function updateVehInv (objID, veh, player, action)
if localPlayer == player then
	local inv = getElementData(veh, "VI:inventory")
	for i=1,#inv do
		if tonumber(inv[i][1]) == objID then
			local id = inv[i][1]
			local name = inv[i][2]
			if action == "-" then
				qty = tonumber(inv[i][3]) - 1
			elseif action == "+" then
				qty = tonumber(inv[i][3]) + 1
			end
			inv[i]= {id, name, qty}
			setElementData(veh, "VI:inventory", inv)
			qty = nil
		end
	end
	updateGUI(veh, localPlayer)
	local inv = nil
end
end

function updateGUI (veh, player)
if localPlayer == player then
	if invWindow then
		guiGridListClear(itemList)
		local inv = getElementData(veh, "VI:inventory")
		showCursor(true)
		guiSetVisible(invWindow, true)
		for i=1, #inv do
			local row = guiGridListAddRow(itemList)
			guiGridListSetItemText(itemList, row, itemId, inv[i][1], false, true)
			guiGridListSetItemText(itemList, row, itemName, inv[i][2], false, false)
			guiGridListSetItemText(itemList, row, itemQuantity, inv[i][3], false, true)
		end
		local inv = nil
	end
end
end
---------------------------------------------------------------------------------------------------
-------------------------------Obj functions (pick/drop/spawn/despawn)-----------------
function spawnObject (thePlayer, objID)
	if thePlayer == localPlayer and objID and getElementData(thePlayer, "VI:hasObj") ~= true and isLaw(thePlayer)==true then
		unbindKey("x")
		triggerServerEvent("spawnObj", thePlayer, objID)
		if openLabel and isElement(openLabel) then
			destroyElement(openLabel)
			openLabel = nil
		end
		if not placeLabel then
			placeLabel = guiCreateLabel(0, 0.8, 1, 0.1, "Press RMB to place the object.", true)
			guiLabelSetHorizontalAlign(placeLabel, "center", false)
		end
	end
end


-------------------------------------------------------------------------------
-------------------------------------------------------------------------------
local handlersAdded = {}
function addColHandlers ()
	if not handlersAdded[source] then
		addEventHandler("onClientColShapeHit", source, destroyPickObj)
		addEventHandler("onClientColShapeLeave", source, onColLeave)
		handlersAdded[source] = true
	end
end
addEvent("addColHandlers", true)
addEventHandler("addColHandlers", root, addColHandlers)
-------------------------
function destroyPickObj (hitElement)
	local e = getElementAttachedTo(source)
	if isElement(e) == true then else return end
	local objID = getElementModel (e)
	if hitElement == localPlayer and not getPedOccupiedVehicle(localPlayer) and getElementData(localPlayer, "VI:hasObj") ~= true and isLaw(localPlayer)==true then
		if not pickLabel then
			pickLabel = guiCreateLabel(0, 0.8, 1, 0.1, "Press x to pick the object.", true)
			guiLabelSetHorizontalAlign(pickLabel, "center", false)
		end
		bindKey("x", "down", deleteObj, hitElement, objID, source)
	end
end
function deleteObj (key, keyState, thePlayer , objID, col)
	if 	isElementWithinColShape(thePlayer, col) then
		triggerServerEvent("onBarrierGetDestroyed", col)
		spawnObject(thePlayer, objID)
	end
	unbindKey("x")
	if pickLabel and isElement(pickLabel) then
		destroyElement(pickLabel)
		pickLabel = nil
	end
end

---------------------
function onColLeave (hitElement)
	if hitElement == localPlayer and not getPedOccupiedVehicle(localPlayer)  and isLaw(hitElement) == true then
		unbindKey("x")
		if pickLabel and isElement(pickLabel) then
			destroyElement(pickLabel)
			pickLabel = nil
		end
	end
end
-----------------------------------------------------------------------------
---------------Effects while carrying object---------------------------
addEvent("toggleEffects", true)
function toggleEffects(player)
	if source == localPlayer or player == localPlayer then
		local state = getElementData(localPlayer, "VI:effects")
		if state ~= true then
			setPedWeaponSlot(localPlayer, 0)
			addEventHandler("onClientPlayerWeaponSwitch", localPlayer, onWeaponSwitch)
			setControlState("walk", true)
			toggleControl("jump", false)
			toggleControl("sprint", false)
			toggleControl("enter_exit", false)
			setElementData(localPlayer, "VI:effects", true)
		elseif state == true then
			removeEventHandler("onClientPlayerWeaponSwitch", localPlayer, onWeaponSwitch)
			setControlState("walk", false)
			toggleControl("jump", true)
			toggleControl("sprint", true)
			toggleControl("enter_exit", true)
			setElementData(localPlayer, "VI:effects", false)
			if placeLabel and isElement(placeLabel) then
				destroyElement(placeLabel)
				placeLabel = nil
			end
		end
	end
end
addEventHandler("toggleEffects", root, toggleEffects)
function onWeaponSwitch ()
	setPedWeaponSlot(source, 0)
end
-----------------------------------------------------------------------------
-----------------------------------------------------------------------------

function onBarrierHitByExplosion( x, y, z, theType )
	for index, barrier in ipairs(getElementsByType("object")) do
		if (getElementModel ( barrier ) == 1228) or (getElementModel ( barrier ) == 1238) or (getElementModel ( barrier ) == 1459) or (getElementModel ( barrier ) == 2060)  then
			local barrierx, barriery, barrierz = getElementPosition(barrier)
			local distance = getDistanceBetweenPoints2D(barrierx, barriery, x, y)
			if (distance <= 8) then
				local attached = getAttachedElements(barrier)
				for i,v in ipairs (attached) do
					if getElementType(v) == "colshape" then
						triggerServerEvent("onBarrierGetDestroyed", v )
					end
				end
			end
		end
	end
end
addEventHandler("onClientExplosion", root, onBarrierHitByExplosion)

function onBarrierHitByVehicle ( hitElement, force )
	if hitElement and getElementType(hitElement) == "object" then
		if (getElementModel ( hitElement ) == 1228 or getElementModel ( hitElement ) == 1459  and force >30) or  (getElementModel ( hitElement ) == 1238 or getElementModel ( hitElement ) == 2060)  then
			local attached = getAttachedElements(hitElement)
			for i,v in ipairs (attached) do
				if getElementType(v) == "colshape" then
					triggerServerEvent("onBarrierGetDestroyed", v )
				end
			end
		end
	end
end
addEventHandler("onClientVehicleCollision", root, onBarrierHitByVehicle)

function barriersUnBreakable (object, thePlayer)
	local objectid = getElementModel(object)
	if objectid ~= 1238 then
		setObjectBreakable(object,false)
	end
end
addEvent("setBarriersUnBreakable", true)
addEventHandler("setBarriersUnBreakable", root, barriersUnBreakable)

addEvent("clearLabels", true)
function onVehicleEnterDeleteLabels()
	if source == localPlayer  then
		unbindKey("x")
		unbindKey("mouse2")
		if pickLabel and isElement(pickLabel) then
			destroyElement(pickLabel)
			pickLabel = nil
		end
		if openLabel and isElement(openLabel) then
			destroyElement(openLabel)
			openLabel = nil
		end
		if placeLabel and isElement(placeLabel) then
			destroyElement(placeLabel)
			placeLabel = nil
		end
	end
end
addEventHandler("clearLabels", root, onVehicleEnterDeleteLabels)
addEventHandler("onClientPlayerVehicleEnter", root, onVehicleEnterDeleteLabels)

function getPositionFromElementAtOffset( element, x, y, z )
	if not x or not y or not z then
		return x, y, z
	end

	local matrix = getElementMatrix ( element )
	local offX = x * matrix[1][1] + y * matrix[2][1] + z * matrix[3][1] + matrix[4][1]
	local offY = x * matrix[1][2] + y * matrix[2][2] + z * matrix[3][2] + matrix[4][2]
	local offZ = x * matrix[1][3] + y * matrix[2][3] + z * matrix[3][3] + matrix[4][3]
	return offX, offY, offZ
end

function getVehicleWheelPosition( vehicle, wheel)
	local x, y, z = 0, 0, 0
	local minX, minY, minZ, maxX, maxY, maxZ = getElementBoundingBox(vehicle)
	if wheel == 1 then
		x, y, z = getPositionFromElementAtOffset(vehicle, minX, maxY, minZ)
	elseif wheel == 2 then
		x, y, z = getPositionFromElementAtOffset(vehicle, minX, -maxY, minZ)
	elseif wheel == 3 then
		x, y, z = getPositionFromElementAtOffset(vehicle, maxX, maxY, minZ)
	elseif wheel == 4 then
		x, y, z = getPositionFromElementAtOffset(vehicle, maxX, -maxY, minZ)
	end
	return x, y, z
end

stingers = {}
addEvent("CSGrecStinger",true)
addEventHandler("CSGrecStinger",localPlayer,function(v) table.insert(stingers,v) end)

addEventHandler("onClientRender", root,
	function ()
		if ( isPedInVehicle( localPlayer ) ) and ( getPlayerWantedLevel() >= 1 ) then
			local theVehicle = getPedOccupiedVehicle( localPlayer )
			if ( theVehicle ) then
				local wx1, wy1, wz1 = getVehicleWheelPosition( theVehicle, 1 )
				local wx2, wy2, wz2 = getVehicleWheelPosition( theVehicle, 2 )
				local wx3, wy3, wz3 = getVehicleWheelPosition( theVehicle, 3 )
				local wx4, wy4, wz4 = getVehicleWheelPosition( theVehicle, 4 )

				for k, v in ipairs(stingers) do
					if isElement(v) then
					if getElementData( v, "isStinger2" ) == true then
							local x,y,z = getElementPosition(localPlayer)

							local vx, vy, vz = getElementPosition( v )
							if getDistanceBetweenPoints2D(x,y,vx,vy) > 10 then return end
							if getDistanceBetweenPoints2D( wx1, wy1, vx, vy ) <= 2.33 then
								setVehicleWheelStates( theVehicle, 1, -1, -1, -1 )
							end
							if getDistanceBetweenPoints2D( wx2, wy2, vx, vy ) <= 2.33 then
								setVehicleWheelStates( theVehicle, -1, 1, -1, -1 )
							end
							if getDistanceBetweenPoints2D( wx3, wy3, vx, vy ) <= 2.33 then
								setVehicleWheelStates( theVehicle, -1, -1, 1, -1 )
							end
							if getDistanceBetweenPoints2D( wx4, wy4, vx, vy ) <= 2.33 then
								setVehicleWheelStates( theVehicle, -1, -1, -1, 1 )
							end
						end
					end
				end
			end
		end
	end
)
