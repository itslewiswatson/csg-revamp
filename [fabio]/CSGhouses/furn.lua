local mode = "OFF"
local furnPos = { --USES HOUSE SYSTEM IDS, not the interiors
	[1] = {231.3134765625,1187.427734375,1080.2578125,0,0,146.3483581543,3},
	[2] = {223.4521484375,1247.03125,1082.140625,0,0,99.419555664062,2},
	[3] = {226.8798828125,1287.2646484375,1082.140625,0,0,215.88189697266,1},
	[4] = {327.1201171875,1481.798828125,1084.4375,0,0,214.43716430664,15},
	[5] = {2454.0302734375,-1697.9609375,1013.5078125,0,0,353.1032409668,2},
	[6] = {247.9013671875,1113.1826171875,1080.9921875,0,0,229.64797973633,5},
	[7] = {373.0244140625,1472.4287109375,1080.1875,0,0,62.955383300781,15},
	[8] = {225.693359375,1039.38671875,1084.0119628906,0,0,1.2277526855469,7}, -- empty open house
	[9] = {2806.9892578125,-1165.3701171875,1025.5703125,0,0,184.9878692627,8},
	[10] = {2264.1337890625,-1211.7802734375,1049.0234375,0,0,230.01052856445,10},
	[11] = {2497.921875,-1694.5625,1014.7421875,0,0,286.62942504883,3},
	[12] = {2264.931640625,-1141.9716796875,1050.6328125,0,0,200.77546691895,10},
	[13] = {2363.7900390625,-1125.802734375,1050.875,0,0,62.592803955078,8},
	[14] = {2235.43359375,-1111.9755859375,1050.8828125,0,0,273.44564819336,5},
	[15] = {2285.943359375,-1137.703125,1050.8984375,0,0,279.10919189453,11},
	[16] = {2188.8369140625,-1200.693359375,1049.0234375,0,0,4.3094482421875,6},
	[17] = {2305.6669921875,-1211.365234375,1049.0234375,0,0,96.409240722656,6},
	[18] = {2213.77734375,-1078.28125,1050.484375,0,0,186.65231323242,1},
	[19] = {2235.8876953125,-1071.4580078125,1049.0234375,0,0,273.9235534668,2},
	[20] = {2318.365234375,-1019.263671875,1050.2109375,0,0,88.542907714844,9},
	[21] = {2331.70703125,-1070.326171875,1049.0234375,0,0,110.54885864258,6},
	[22] = {1225.36328125,-807.109375,1084.0078125,0,0,350.13137817383,5},
	[23] = {249.2001953125,302.2255859375,999.1484375,0,0,175.22088623047,1},
	[24] = {273.453125,303.62109375,999.1484375,0,0,220.41381835938,2},
	[25] = {2332.5107421875,-1148.9560546875,1050.703125,0,0,86.521392822266,12},
	[26] = {316.19921875,1119.16015625,1083.8828125,0,0,105.07760620117,5},
	[27] = {249.08203125,302.0654296875,999.1484375,0,0,228.19775390625,1},
	[28] = {134.900390625,1366.173828125,1083.8609619141,0,0,132.31860351562,5},
	[29] = {231.283203125,1068.0166015625,1084.2059326172,0,0,213.01441955566,6},
	[30] = {83.8984375,1330,1083.859375,0,0,83.461669921875,9},
	[31] = {35.0595703125,1341.7080078125,1084.375,0,0,270.81439208984,10},
	[32] = {366.021484375,1418.2568359375,1081.328125,0,0,224.41290283203,15},
	[33] = {2532.83984375,-1680.5400390625,1015.4985961914,0,0,245.07301330566,1},
}

function kill(e)
	if isElement(e) then destroyElement(e) end
end

local icon=false
local marker=false
pickLabel=false
lp=localPlayer

addEvent("CSGhousing.enteredHouse",true)
addEventHandler("CSGhousing.enteredHouse",lp,function(theHouse,houseData,myAccName,interiorid)
	if hasAccess(lp) then addEventHandler("onClientRender",root,createText) end
	--if exports.server:getPlayerAccountName(lp) ~= "priyen" and exports.server:getPlayerAccountName(lp) ~= "tr2012" then return end
	kill(icon)
	kill(marker)
	local x,y,z = unpack(furnPos[interiorid])
	icon=createObject(1239,x,y,z-0.5)
	setElementDimension(icon,getElementDimension(lp))
	setElementInterior(icon,getElementInterior(lp))
	addEventHandler("onClientRender",root,rota)
	marker=createMarker(x,y,z-1,"cylinder",1,255,0,0,0)
	setElementDimension(marker,getElementDimension(lp))
	setElementInterior(marker,getElementInterior(lp))
	addEventHandler("onClientMarkerHit",marker,hit)
	addEventHandler("onClientMarkerLeave",marker,leave)
end)

addEvent("CSGhousing.leftHouse",true)
addEventHandler("CSGhousing.leftHouse",lp,function()
	removeEventHandler("onClientRender",root,createText)
	kill(icon)
	removeEventHandler("onClientRender",root,rota)
	removeEventHandler("onClientMarkerHit",marker,hit)
	removeEventHandler("onClientMarkerLeave",marker,leave)
	kill(marker)
end)

function leave(p,dim)
	--if dim==false then return end
	if p ~= localPlayer then return end
	unbindKey("x")
	if openLabel and isElement(openLabel) then
		destroyElement(openLabel)
		openLabel = nil
	end
end

function hasAccess()
	local access=false
	local user = exports.server:getPlayerAccountName(lp)
	if getElementData(houseEDATA,"2") == user then access=true end
	if access == false then
		local perms = houseData["perms"]
		perms=fromJSON(perms)
		for k,v in pairs(perms) do
			if v[1] == user then
				if v[4][12] == nil then
					access=false
				elseif v[4][12] == true then
					access=true
				elseif v[4][12] == false then
					access=false
				end
				break
			end
		end
	end
	return access
end

function hit(p,dim)
	if dim==false then return end
	if p ~= lp then return end

	triggerServerEvent("CSGhousing.hitInv",lp,he)
	if hasAccess() == true then
		exports.dendxmsg:createNewDxMessage("You have access to the House Decor System",0,255,0)
		bindKey("x", "down", openInv)
		if not openLabel then
			openLabel = guiCreateLabel(0, 0.85, 1, 0.1, "Press x to open the House Decor Storage", true)
			guiLabelSetHorizontalAlign(openLabel, "center", false)
		end
	else
 		exports.dendxmsg:createNewDxMessage("You do not have access to the House Decor System",255,0,0)
 	end
end

function rota()
	local _,_,rz=getElementRotation(icon)
	rz=rz+1
	if rz>360 then rz=rz-360 end
	setElementRotation(icon,0,0,rz)
 end

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
--addEvent("HS:closeTrunk", true)
--addEventHandler("HS:closeTrunk", root, onPlayerMarkerLeave)
---------------------------------------------------------------------------------------------------
---------------------------------------------------------------------------------------------------
function openInv(keyPressed,state)
	if 1+1 == 2 then
		exports.dendxmsg:createNewDxMessage("Feature enabled for Developers only",255,255,0)
		return
	end
		if mode=="OFF" then
			exports.dendxmsg:createNewDxMessage("You did not enable editor mode! Type /houseedit to toggle editor mode.",255,0,0)
		return
		end
		local inv = fromJSON(houseData["decorinv"])

		if invWindow then
			guiGridListClear(itemList)
			showCursor(true)
			guiSetVisible(invWindow, true)

			for i=1, #inv do
				local row = guiGridListAddRow(itemList)
				guiGridListSetItemText(itemList, row, itemId, inv[i][1], false, true)
				guiGridListSetItemText(itemList, row, itemName, inv[i][2], false, false)
				guiGridListSetItemText(itemList, row, itemQuantity, inv[i][3], false, true)
			end
			if getElementData(lp, "HS:hasObj") == true then
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
			invWindow = guiCreateWindow(X, Y, Width, Height, "CSG ~ Decor Inventory", false)
			guiWindowSetSizable(invWindow, false)
			btnClose = guiCreateButton(160, 300, 120, 30, "Close", false, invWindow)
				addEventHandler("onClientGUIClick", btnClose, closeGUI)
			btnTake = guiCreateButton(20, 300, 120, 30, "Take", false, invWindow)
				addEventHandler("onClientGUIClick", btnTake, takeObj)

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
			if getElementData(lp, "HS:hasObj") == true then
				guiSetText(btnTake, "Store object")
			end
			local inv = nil
		end

end

function closeGUI ()
	if source ~= btnClose then return end
		guiSetVisible(invWindow, false)
		showCursor(false)
		guiGridListClear(itemList)
		local veh = getElementData(btnTake,"HS:vehicle")

end
function hideGUI (btnORmarker)
	if invWindow then
		guiSetVisible(invWindow, false)
		showCursor(false)
	end
end

function barriersUnBreakable (object, thePlayer)
	local objectid = getElementModel(object)
	if objectid ~= 1238 then
		setObjectBreakable(object,false)
	end
end
addEvent("setBarriersUnBreakableHS", true)
addEventHandler("setBarriersUnBreakableHS", root, barriersUnBreakable)


function takeObj()
	if source ~= btnTake then return end
	local veh = getElementData(btnTake,"HS:vehicle")
	local lp = localPlayer
	if guiGetText(btnTake) == "Take" then
		local index = guiGridListGetSelectedItem(itemList)
		if index < 0 then return end
		local objId = tonumber(guiGridListGetItemText(itemList, index, itemId))
		local objQty = tonumber(guiGridListGetItemText(itemList, index, itemQuantity))
		if objQty <= 0 then return end
		updateVehInv(objId, veh, lp, "-")
		spawnObject(lp, objId )
		hideGUI (btnTake)

		local index = nil
		local objId = nil
		local veh = nil
	elseif guiGetText(btnTake) == "Store object" then
		local objs = getAttachedElements(localPlayer)
		local inv = fromJSON(houseData["decorinv"])
			for i,v in ipairs (objs) do
				if getElementType(v) == "object" then
					for i=1, #inv do
						if inv[i][1] == getElementModel(v) then
							objId = getElementModel(v)
							obj = v
							updateVehInv(objId, veh, lp, "+")

							hideGUI (btnTake)
							unbindKey("mouse2")
							triggerServerEvent("destroyObjHS", obj )
							setElementData(localPlayer,"HS:hasObj",false,true)
							toggleEffects(localPlayer)
							if placeLabel and isElement(placeLabel) then
								destroyElement(placeLabel)
								placeLabel = nil
							end
						end
					end
				end
			end
		if not objId then exports.DENdxmsg:createNewDxMessage( "You can't store that object in this house!", 255, 0, 0 ) setControlState("walk", true) end
		objId = nil
		veh = nil
		obj = nil
	end
end

function updateVehInv (objID, veh, lp, action)
if localPlayer == lp then
	local inv = fromJSON(houseData["decorinv"])
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

			qty = nil
		end
	end
	houseData["decorinv"] = toJSON(inv)
	triggerServerEvent("CSGhousing.syncTableKey",localPlayer,houseEDATA,"decorinv",houseData["decorinv"])
	updateGUI(veh, localPlayer)
	local inv = nil
end
end

function updateGUI (veh, lp)
if localPlayer == lp then
	if invWindow then
		guiGridListClear(itemList)
		local inv = fromJSON(houseData["decorinv"])
		--showCursor(true)
		--guiSetVisible(invWindow, true)
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

addEvent("CSGhousing.sync",true)
addEventHandler("CSGhousing.sync",localPlayer,function(house,dataa)
	updateGUI(_,lp)
end)

---------------------------------------------------------------------------------------------------
-------------------------------Obj functions (pick/drop/spawn/despawn)-----------------
function spawnObject (thePlayer, objID)
	if thePlayer == localPlayer and objID and getElementData(thePlayer, "HS:hasObj") ~= true and hasAccess()==true then
		unbindKey("x")
		triggerServerEvent("spawnObjHS", thePlayer, objID)
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


-------------------------
function destroyPickObj (hitElement)
	local e = getElementAttachedTo(source)
	if isElement(e) == true then else return end
	local objID = getElementModel (e)
	if hitElement == localPlayer and not getPedOccupiedVehicle(localPlayer) and getElementData(localPlayer, "HS:hasObj") ~= true and isLaw(localPlayer)==true then
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

-----------------------------------------------------------------------------
---------------Effects while carrying object---------------------------
addEvent("toggleEffectsHS", true)
function toggleEffects(lp)
	if source == localPlayer or lp == localPlayer then
		local state = getElementData(localPlayer, "HS:effects")
		if state ~= true then
			setPedWeaponSlot(localPlayer, 0)
			addEventHandler("onClientPlayerWeaponSwitch", localPlayer, onWeaponSwitch)
			setControlState("walk", true)
			toggleControl("jump", false)
			toggleControl("sprint", false)
			toggleControl("enter_exit", false)
			setElementData(localPlayer, "HS:effects", true)
		elseif state == true then
			removeEventHandler("onClientPlayerWeaponSwitch", localPlayer, onWeaponSwitch)
			setControlState("walk", false)
			toggleControl("jump", true)
			toggleControl("sprint", true)
			toggleControl("enter_exit", true)
			setElementData(localPlayer, "HS:effects", false)
			if placeLabel and isElement(placeLabel) then
				destroyElement(placeLabel)
				placeLabel = nil
			end
		end
	end
end
addEventHandler("toggleEffectsHS", root, toggleEffects)
function onWeaponSwitch ()
	setPedWeaponSlot(source, 0)
end

function addColHandlers()

	addEventHandler("onClientColShapeHit", source, destroyPickObj)
	addEventHandler("onClientColShapeLeave", source, onColLeave)
end
addEvent("addColHandlersHS", true)
addEventHandler("addColHandlersHS", root, addColHandlers)

function destroyPickObj (hitElement)
	if mode == "OFF" then return end
	local e = getElementAttachedTo(source)
	if isElement(e) == true then else return end
	local objID = getElementModel (e)
	if hitElement == localPlayer and getElementData(localPlayer, "HS:hasObj") ~= true and hasAccess(localPlayer) then
		if not pickLabel then
			pickLabel = guiCreateLabel(0, 0.8, 1, 0.1, "Press x to pick the object.", true)
			guiLabelSetHorizontalAlign(pickLabel, "center", false)
		end
		bindKey("x", "down", deleteObj, hitElement, objID, source)
	end
end

function deleteObj (key, keyState, thePlayer , objID, col)
	if 	isElementWithinColShape(thePlayer, col) then
		triggerServerEvent("onBarrierGetDestroyedHS", col)
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
	if hitElement == localPlayer then
		unbindKey("x")
		if pickLabel and isElement(pickLabel) then
			destroyElement(pickLabel)
			pickLabel = nil
		end
	end
end
-------------------------
screenWidth,screenHeight = guiGetScreenSize()

function createText()
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Editor: #33FF33"..mode.."", screenWidth*0.09, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Editor: #33FF33"..mode.."", screenWidth*0.09, screenHeight*0.95, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
end


addCommandHandler("houseedit",function()
	if mode == "ON" then
		mode="OFF"
		destroyElement(infoLabel)
		exports.dendxmsg:createNewDxMessage("House Editing Mode: Off.",255,0,0)
	elseif mode == "OFF" then
		infoLabel=guiCreateLabel(0, 0.9, 1, 0.1, "Press M to use cursor - Click an object for advanced controls", true)
		guiLabelSetHorizontalAlign(infoLabel, "center", false)
		mode="ON"
		exports.dendxmsg:createNewDxMessage("House Editing Mode: On. Press M to use cursor when needed.",0,255,0)
	end
end)

local waitingReply=false
clicked=false
function clickDetect( button, state, absoluteX, absoluteY, worldX, worldY, worldZ, clickedElement )
	if (clickedElement) and isElement(clickedElement) then
		if waitingReply==true then return end
		waitingReply=true
		clicked=clickedElement
		triggerServerEvent("HSobjClickCheck",lp,clickedElement)
	end
end


function HSobjClickCheckRec(s)
	waitingReply=false
	if s == true then
		outputChatBox("valid")
	end
end
addEvent("HSobjClickCheckRec",true)
addEventHandler("HSobjClickCheckRec",lp,HSobjClickCheckRec)

bindKey("m","down",function()
	if hasAccess(lp) then
		if mode == "ON" then
			if isCursorShowing() then
				showCursor(false)
				removeEventHandler("onClientClick",root,clickDetect)
			else
				showCursor(true)
				addEventHandler("onClientClick",root,clickDetect)
			end
		else

		end
	end
end)
