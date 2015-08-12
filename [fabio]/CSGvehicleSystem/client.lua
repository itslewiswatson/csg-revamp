local screenW,screenH = guiGetScreenSize()

vehicles = {}
-- spectate vars
local spectating = false
local preSpecData = {}

-- confirm sell gui
local sellVehicleID
local sellConfirmGUI = {}
function closeSellConfirmGUI()
	if isElement(sellConfirmGUI.window) then destroyElement(sellConfirmGUI.window) end
end

function openSellConfirmGUI(id,name,price)
	closeSellConfirmGUI()
	sellVehicleID = id
	
	local x,y = (screenW-250)/2,(screenH-150)/2
	
	sellConfirmGUI.window = guiCreateWindow(x,y,250,150,"Sell "..name.."?",false)
	guiWindowSetSizable	(sellConfirmGUI.window,false)
	guiWindowSetMovable	(sellConfirmGUI.window,false)
	guiSetProperty(sellConfirmGUI.window,"AlwaysOnTop","True")
	local labelText = "Are you sure you want to sell your "..name.." for $"..exports.server:convertNumber(tonumber(price)).."?"
	sellConfirmGUI.label = guiCreateLabel(0,0,225,80,labelText,false,sellConfirmGUI.window)
		guiLabelSetVerticalAlign(sellConfirmGUI.label,"center")
		guiLabelSetHorizontalAlign(sellConfirmGUI.label,"center",true)
	sellConfirmGUI.cancelBtn = guiCreateButton(25,100,75,25,"Cancel",false,sellConfirmGUI.window)
	sellConfirmGUI.sellBtn = guiCreateButton(150,100,75,25,"Sell",false,sellConfirmGUI.window)
	
	addEventHandler("onClientGUIClick",sellConfirmGUI.sellBtn,onSellConfirmed,false)
	addEventHandler("onClientGUIClick",sellConfirmGUI.cancelBtn,closeSellConfirmGUI,false)
	if isTimer(updateSellButton) then killTimer(updateSellButton) end
		sellCount = 60
		startSellCounter()
end

function onSellConfirmed()
	closeSellConfirmGUI()
	if sellVehicleID and vehicles[sellVehicleID] then
		triggerServerEvent("CSGplayerVehicles.sellVeh",localPlayer,sellVehicleID, vehicles[sellVehicleID].vehicleid, vehicles[sellVehicleID].sellPrice)
	end
	sellVehicleID = false
end

-- utility

_guiGridListClear = guiGridListClear
function guiGridListClear(grid)
	destroyElement(grid)
	for k,_ in pairs(vehicles) do
		vehicles[k].row = false
	end
	createGrid()
end

function trim(s)
  return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function getRelativeColor(percent)
	if percent > 60 then
		return 0,255,0
	elseif percent > 30 then
		return 255,255,0
	else
		return 255,0,0
	end
end

function getVehicleName(model)
	local name = getVehicleNameFromModel(model)
	return name
end

function getVehicleModel(id)
	local vehicleModel = vehicles[id].vehicleid
	if isElement(vehicles[id].element) then
		vehicleModel = getElementModel(vehicles[id].element)
	end
	return vehicleModel
end

function getVehicleFuel(id)
	local vehicleFuel = vehicles[id].fuel
	if isElement(vehicles[id].element) then
		vehicleFuel = getElementData(vehicles[id].element,"vehicleFuel")
	end
	return tonumber(vehicleFuel) or 100
end
function getVehicleHealth(id)
	local vehicleHealth = vehicles[id].vehiclehealth
	if isElement(vehicles[id].element) then
		vehicleHealth = getElementHealth(vehicles[id].element)
	end
	return math.floor(tonumber(vehicleHealth)/10) or 100
end
function getVehiclePosition(id)
	local x,y,z = vehicles[id].x,vehicles[id].y,vehicles[id].z
	if isElement(vehicles[id].element) then
		x,y,z = getElementPosition(vehicles[id].element)
	end
	return x,y,z
end

-- GUI, general

local vehGUI = { btn = {} }

function createGrid()
	vehGUI.grid = guiCreateGridList(10, 51, 491, 247, false, vehGUI.window)
		guiGridListAddColumn(vehGUI.grid,"Name",0.25)
		guiGridListAddColumn(vehGUI.grid,"Plate",0.1)
		guiGridListAddColumn(vehGUI.grid,"Health",0.1)
		guiGridListAddColumn(vehGUI.grid,"Fuel",0.1)
		guiGridListAddColumn(vehGUI.grid,"Locked",0.1)
		guiGridListAddColumn(vehGUI.grid,"Location",0.3)
	guiGridListSetSelectionMode(vehGUI.grid,1)
end

function createGUI()
	local x,y = (screenW-510)/2, (screenH-415)/2
	vehGUI.window = guiCreateWindow(x, y, 510, 415, "Community of Social Gaming ~ Vehicle Management", false)
		guiWindowSetSizable(vehGUI.window, false)
	
	createGrid()
	vehGUI.btn.tLock = guiCreateButton(10, 331, 116, 29, "(un)Lock", false, vehGUI.window)
	vehGUI.btn.sell = guiCreateButton(10, 370, 116, 29, "Sell", false, vehGUI.window)
	vehGUI.btn.tSpawn = guiCreateButton(136, 331, 116, 29, "(de)Spawn", false, vehGUI.window)
	vehGUI.btn.recover = guiCreateButton(136, 370, 116, 29, "Recover", false, vehGUI.window)
	vehGUI.btn.tMark = guiCreateButton(259, 331, 116, 29, "(un)Mark", false, vehGUI.window)
	vehGUI.btn.spectate = guiCreateButton(259, 370, 116, 29, "Spectate", false, vehGUI.window)
	vehGUI.btn.reset = guiCreateButton(385, 331, 116, 29, "Reset", false, vehGUI.window)
	vehGUI.btn.close = guiCreateButton(385, 370, 116, 29, "Close", false, vehGUI.window)
	vehGUI.labelInfo1 = guiCreateLabel(10, 22, 496, 30, "Your vehicles:", false, vehGUI.window)
		guiLabelSetVerticalAlign(vehGUI.labelInfo1,"center")
		guiLabelSetHorizontalAlign(vehGUI.labelInfo1,"center")
	vehGUI.labelInfo2 = guiCreateLabel(10, 298, 240, 32, "Options:", false, vehGUI.window)
		guiLabelSetVerticalAlign(vehGUI.labelInfo2,"center")
		guiLabelSetHorizontalAlign(vehGUI.labelInfo2,"left")		
	vehGUI.labelInfo3 = guiCreateLabel(250, 298, 240, 32, "Hold CTRL to select multiple vehicles.", false, vehGUI.window)
		guiLabelSetVerticalAlign(vehGUI.labelInfo3,"center")
		guiLabelSetHorizontalAlign(vehGUI.labelInfo3,"right")
	guiSetVisible(vehGUI.window,false)
	addEventHandler("onClientGUIClick",root,onGUIClick)
end
addEventHandler("onClientResourceStart",resourceRoot,createGUI)


addEvent("CSGplayerVehicles:client.receiveVehicles",true)
function onReceiveVehicles(tmpVehicles, elements)
	guiGridListClear(vehGUI.grid)
	for i=1,#tmpVehicles do
		local licenseplate = trim(tmpVehicles[i].licenseplate)
		local id = tonumber(tmpVehicles[i].uniqueid)
		local sellPrice = tonumber(tmpVehicles[i].sellPrice)
		vehicles[id] = tmpVehicles[i]
		vehicles[id].sellPrice = sellPrice
		vehicles[id].licenseplate = licenseplate
		vehicles[id].element = elements[i]
		updateVehicleGrid(id)
	end
end
addEventHandler("CSGplayerVehicles:client.receiveVehicles",root,onReceiveVehicles)

function updateVehicleGrid(id)
	if not vehicles[id] then return false end
	if not vehicles[id].row then
		vehicles[id].row = guiGridListAddRow(vehGUI.grid)
	end
	local row = vehicles[id].row
	
	guiGridListSetItemText(vehGUI.grid,row,1,getVehicleName(getVehicleModel(id)),false,false)
		if isElement(vehicles[id].element) then 
			guiGridListSetItemColor(vehGUI.grid,row,1,0,255,0)
		else 
			guiGridListSetItemColor(vehGUI.grid,row,1,255,0,0) 
		end
		
	guiGridListSetItemText(vehGUI.grid,row,2,vehicles[id].licenseplate or "",false,false)
	
	local health = getVehicleHealth(id)
	guiGridListSetItemText(vehGUI.grid,row,3,health.."%",false,false)
		guiGridListSetItemColor(vehGUI.grid,row,3,getRelativeColor(health))
		
	local fuel = getVehicleFuel(id)
	guiGridListSetItemText(vehGUI.grid,row,4,getVehicleFuel(id).."%",false,false)
		guiGridListSetItemColor(vehGUI.grid,row,4,getRelativeColor(fuel))
	
	local lr,lg,lb = 0,255,0
	local lockedString = "Yes"
	if vehicles[id].locked == 0 then
		lockedString = "No"
		lr,lg,lb = 255,0,0
	end
	guiGridListSetItemText(vehGUI.grid,row,5,lockedString,false,false)
		guiGridListSetItemColor(vehGUI.grid,row,5,lr,lg,lb)
	guiGridListSetItemText(vehGUI.grid,row,6,getZoneName(getVehiclePosition(id)),false,false)
		
	guiGridListSetItemData(vehGUI.grid,row,1,id)	
end

function updateAllVehiclesGrid()
	guiGridListClear(vehGUI.grid)
	for id,info in pairs(vehicles) do
		updateVehicleGrid(id)
	end
end

function toggleGUI()
	if guiGetVisible(vehGUI.window) then
		showCursor(false)
		guiSetVisible(vehGUI.window,false)
		closeSellConfirmGUI()
	else
		showCursor(true)
		guiSetVisible(vehGUI.window,true)
	end
end
bindKey("F3","down",toggleGUI)

function getSelectedVehicles()
	local selected = guiGridListGetSelectedItems(vehGUI.grid)
	local rowSelected = {}
	local ids = {}

	for i=1,#selected do
		if not rowSelected[selected[i].row] then
			local id = guiGridListGetItemData(vehGUI.grid,selected[i].row,1)
			if id  then
				rowSelected[selected[i].row] = true
				table.insert(ids,id)
			end
		end
	end
	if #ids > 0 then
		return ids
	else
		return false
	end
end

local antiButtonSpamTimer

function onGUIClick()
	local vehIDs = getSelectedVehicles()
	if source == vehGUI.btn.close then
		toggleGUI()
	elseif source == vehGUI.btn.reset then
		updateAllVehiclesGrid()
	elseif source == vehGUI.btn.spectate and spectating then
		stopSpectating()
	elseif vehIDs then
		if isTimer(antiButtonSpamTimer) then
			exports.dendxmsg:createNewDxMessage("Please wait before using the buttons again.",255,0,0)
			return false
		end
		for i=1,#vehIDs do
			local vehID = vehIDs[i]
			local vehicleElement = vehicles[vehID].element
			local vehicleModel = getVehicleModel(vehID)
			local vehicleName = getVehicleName(vehicleModel)
			local vehicleLocked = vehicles[vehID].locked or 0
			if isElement(vehicleElement) then
				vehicleLocked = isVehicleLocked(vehicleElement)
			else 
				vehicleElement = false
			end
			if source == vehGUI.btn.tSpawn then
				if vehicleElement then
					triggerServerEvent("CSGplayerVehicles.despawnVeh",localPlayer,vehID)
				else
					triggerServerEvent("CSGplayerVehicles.spawnVeh",localPlayer,vehID)
				end
			elseif source == vehGUI.btn.tLock then
				triggerServerEvent("CSGplayerVehicles.toggleLock",localPlayer,vehID,vehicleModel,vehicleLocked, #vehIDs > 1)
				if #vehIDs ~= 1 and i == 1 then
					exports.dendxmsg:createNewDxMessage("Your vehicles' lock statuses have been toggled!",0,255,0)
				end
			elseif source == vehGUI.btn.sell then
				if i == #vehIDs then
					openSellConfirmGUI(vehID,vehicleName,vehicles[vehID].sellPrice)
				end
			elseif source == vehGUI.btn.tMark then
				if isElement(vehicles[vehID].blip) then
					destroyElement(vehicles[vehID].blip)
					exports.dendxmsg:createNewDxMessage("Your "..vehicleName.." has been unmarked from the map!",0,255,0)
				elseif vehicleElement then
					vehicles[vehID].blip = createBlipAttachedTo(vehicleElement, 53)
					exports.dendxmsg:createNewDxMessage("Your "..vehicleName.." has been marked on the map!",0,255,0)
				else
					exports.dendxmsg:createNewDxMessage("This vehicle is not spawned!",255,0,0)
				end
			elseif source == vehGUI.btn.recover then
				triggerServerEvent("CSGplayerVehicles.recover",localPlayer,vehID, vehicleModel)
			elseif source == vehGUI.btn.spectate then
				if i == #vehIDs and not spectating then -- only attempt when it's the last in table
					if vehicleElement then
						if isPedOnGround(localPlayer) and not getPedOccupiedVehicle(localPlayer) then
							setElementFrozen(localPlayer,true)
							preSpecData.int = getElementInterior(localPlayer)
							preSpecData.dim = getElementDimension(localPlayer)
							setElementDimension(localPlayer,getElementDimension(vehicleElement))
							setElementInterior(localPlayer,getElementInterior(vehicleElement))
							addEventHandler("onClientRender",root,specateVehicleOnRender)
							spectating = vehID
							exports.dendxmsg:createNewDxMessage("You are now spectating your "..vehicleName.."!",0,255,0)
						else
							exports.dendxmsg:createNewDxMessage("You have to be on-foot standing on the ground!",255,0,0)
						end
					else
						exports.dendxmsg:createNewDxMessage("This vehicle is not spawned!",255,0,0)
					end
				end
			end
		end
		
		for k,v in pairs(vehGUI.btn) do -- if any button was clicked, start antiSpam timer
			if v == source then
				if isTimer(antiButtonSpamTimer) then killTimer(antiButtonSpamTimer) end
				antiButtonSpamTimer = setTimer(function () end, 650,1)
				break
			end
		end
	end
end

addEvent("CSGplayerVehicles:client.updateVehicleInfo",true)
function updateVehicleInfo(id,keyValueTable)
	if not keyValueTable then
		local row = vehicles[id].row
		vehicles[id] = false
		local newVehicles = {}
		for id,v in pairs(vehicles) do
			if v then
				newVehicles[id] = v
			end
		end
		vehicles = newVehicles
		guiGridListRemoveRow(vehGUI.grid,row)
		return true
	else
		if ( not keyValueTable.ownerid ) or ( keyValueTable.ownerid == exports.server:getPlayerAccountID(localPlayer) ) then
			if not vehicles[id] then
				vehicles[id] = {}
			end
			for k,v in pairs(keyValueTable) do
				vehicles[id][k] = v
			end
		else return false;
		end
	end
	updateVehicleGrid(id)
end
addEventHandler("CSGplayerVehicles:client.updateVehicleInfo",root,updateVehicleInfo)

-- spectating

local facing = 0
local zoom = 16
local zoomDuration = 12500
local zoomStart
function specateVehicleOnRender()
	if spectating and isElement(vehicles[spectating].element) then
		local tick = getTickCount()
		if not zoomStart or tick >= zoomDuration+zoomStart then
			zoomStart = tick
		end
		local zoomProgress = (getTickCount()-zoomStart)/zoomDuration
		local zoom = interpolateBetween(8,0,0,18,0,0,zoomProgress,"SineCurve")
		
		local x,y,z = getElementPosition(vehicles[spectating].element)
		local multiplier = zoom
		local vehType = getVehicleType( vehicles[spectating].element)
		local camX = x + math.cos( facing / math.pi * 180 ) * multiplier
		local camY = y + math.sin( facing / math.pi * 180 ) * multiplier
		facing = facing + 0.0001
		setCameraMatrix(camX,camY,z+3,x,y,z)
	else
		stopSpectating(false)
	end
end

function stopSpectating(onStop)
	if spectating then
		if not onStop then
			setTimer(setElementFrozen,3500,1,localPlayer,false)
		else
			local x,y,z = getElementPosition(localPlayer)
			setElementPosition(localPlayer,x,y,z+10) -- cant use timers :/
			setElementFrozen(localPlayer,false)
		end
		setElementDimension(localPlayer,preSpecData.dim)
		setElementInterior(localPlayer,preSpecData.int)
		removeEventHandler("onClientRender",root,specateVehicleOnRender)
		spectating = false
		setCameraTarget(localPlayer)
		exports.dendxmsg:createNewDxMessage("You have stopped spectating!",0,255,0)	
	end
end
addEventHandler("onClientResourceStop",resourceRoot,stopSpectating)

addCommandHandler("lock",
	function ()
		local px,py,pz = getElementPosition(localPlayer)
		local id
		local vehicle
		local distance
		if getPedOccupiedVehicle(localPlayer) and getElementData(getPedOccupiedVehicle(localPlayer),"vehicleOwner") == localPlayer then
			vehicle = getPedOccupiedVehicle(localPlayer)
			id = getElementData(vehicle,"vehicleID")
			distance = 0
		else	
			for i,veh in ipairs(getElementsByType("vehicle")) do
				if getElementData(veh,"vehicleOwner") == localPlayer then
					local vx,vy,vz = getElementPosition(veh)
					local dist = getDistanceBetweenPoints3D(px,py,pz,vx,vy,vz)
					if ( not distance ) or dist < distance then
						id = getElementData(veh,"vehicleID")
						distance = dist
						vehicle = veh
					end
				end
			end
		end
		if id and vehicle then
			if distance < 30 then
				triggerServerEvent("CSGplayerVehicles.toggleLock",localPlayer, id,getElementModel(vehicle),isVehicleLocked(vehicle), false)
			else
				exports.dendxmsg:createNewDxMessage("Your "..getVehicleName(getElementModel(vehicle)).." is too far away to toggle it's lock!",255,0,0)
			end
		else
			exports.dendxmsg:createNewDxMessage("You don't have any vehicles spawned!",255,0,0)
		end
	end
)

function startSellCounter()
updateSellButton = setTimer(
function ()
	sellCount = sellCount -1
	guiSetText(sell_accept,"Sell (".. tostring(sellCount) ..")")
		if sellCount == 0 then
			guiSetEnabled(sell_accept,true)
			killTimer(updateSellButton)
			guiSetText(sell_accept,"Sell")
		end
	end, 1000, 30)
end
