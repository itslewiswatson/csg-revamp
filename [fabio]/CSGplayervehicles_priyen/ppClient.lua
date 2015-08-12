GUIEditor = {
    gridlist = {},
    button = {},
    label = {},
    window = {},
}
window = guiCreateWindow(369, 189, 529, 390, "Community of Social Gaming ~ Vehicle Management", false)
guiWindowSetSizable(window, false)

grid = guiCreateGridList(10, 40, 515, 197, false, window)
guiGridListAddColumn(grid, "Vehicle", 0.23)
guiGridListAddColumn(grid, "License Plate", 0.23)
guiGridListAddColumn(grid, "Health", 0.1)
guiGridListAddColumn(grid, "Fuel", 0.1)
guiGridListAddColumn(grid, "Locked", 0.1)
guiGridListAddColumn(grid, "Location", 0.3)
GUIEditor.label[1] = guiCreateLabel(7, 21, 514, 15, "Your vehicles:", false, window)
guiSetFont(GUIEditor.label[1], "default-bold-small")
guiLabelSetColor(GUIEditor.label[1], 238, 154, 0)
GUIEditor.label[2] = guiCreateLabel(7, 243, 518, 15, "Vehicle options:", false, window)
guiSetFont(GUIEditor.label[2], "default-bold-small")
guiLabelSetColor(GUIEditor.label[2], 238, 154, 0)
btnSpawn = guiCreateButton(11, 264, 245, 24, "Spawn", false, window)
btnUnspawn = guiCreateButton(265, 264, 255, 24, "Despawn", false, window)
btnSell = guiCreateButton(12, 294, 245, 24, "Sell Vehicle", false, window)
btnRecover = guiCreateButton(266, 293, 254, 24, "Recover Vehicle", false, window)
btnToggleMark = guiCreateButton(13, 324, 244, 24, "Mark/Unmark Vehicle", false, window)
btnSpec = guiCreateButton(267, 324, 253, 24, "Spectate Vehicle", false, window)
btnToggleLock = guiCreateButton(13, 354, 246, 24, "Lock/Unlock Vehicle", false, window)
btnClose = guiCreateButton(268, 354, 252, 24, "Close Window", false, window)
guiSetVisible(window,false)

sellWarnWindow = guiCreateWindow(571,390,269,128,"CSG ~ Vehicle System System",false)
sellvehYesButton = guiCreateButton(9,80,125,38,"Yes",false,sellWarnWindow)
sellvehNoButton = guiCreateButton(136,80,124,38,"No",false,sellWarnWindow)
sellvehLabel1 = guiCreateLabel(19,44,235,22,"",false,sellWarnWindow)
guiSetFont(sellvehLabel1,"default-bold-small")
sellvehLabel2 = guiCreateLabel(50,25,200,22,"         Sell vehicle to dealer?",false,sellWarnWindow)
guiLabelSetColor(sellvehLabel2,200,0,0)
guiSetFont(sellvehLabel2,"default-bold-small")
guiWindowSetMovable (sellWarnWindow, true)
guiWindowSetSizable (sellWarnWindow, false)
guiSetVisible(sellWarnWindow,false)


local idToVeh = {}
 blips = {}
 specing=false
tse = triggerServerEvent
ggv = guiGetVisible
gsv = guiSetVisible
ae = addEvent
aeh = addEventHandler
msg = function(msg,r,g,b)
	exports.dendxmsg:createNewDxMessage(msg,r,g,b)
end

function show()
	updateGUI()
	gsv(window,true)
	showCursor(true)
end

function hide()
	gsv(window,false)
	showCursor(false)
end

function updateGUI()
	guiGridListClear(grid)
	if vehData==nil then vehData={} end
	for k,v in pairs(vehData) do
		local name = getVehicleNameFromModel(v.vehicleid)
		if v.vehicleid == 401 then name = "Ferrari" end
		if v.vehicleid == 503 then name = "Lamborghini" end
		if v.spawned == 1 and idToVeh[v.uniqueid] ~= nil then
			fuel=math.floor(getElementData(idToVeh[v.uniqueid],"vehicleFuel"))
			locked=isVehicleLocked(idToVeh[v.uniqueid])
			health=math.floor((getElementHealth(idToVeh[v.uniqueid])))
			x,y,z = getElementPosition(idToVeh[v.uniqueid])
			vehData[k].locked=locked
			vehData[k].fuel=fuel
			vehData[k].vehiclehealth=health
			vehData[k].x=x
			vehData[k].y=y
			vehData[k].z=z
			health=math.floor(health/10)
			if locked == true then locked="Yes" else locked = "No" end
		else
			fuel=math.floor(v.fuel)
			health=math.floor((v.vehiclehealth/10))
			x,y,z = v.x,v.y,v.z
			locked=v.locked
			if locked == 1 then locked="Yes" else locked="No" end
		end
		zoneName=getZoneName(x,y,z)
		plate=v.licenseplate
		if plate == nil then plate="CSG" end
		row=guiGridListAddRow(grid)
		guiGridListSetItemText(grid,row,1,name,false,false)
		guiGridListSetItemData(grid,row,1,v.uniqueid)
		guiGridListSetItemText(grid,row,2,plate,false,false)
		guiGridListSetItemText(grid,row,3,health.."%",false,false)
		guiGridListSetItemText(grid,row,4,fuel.."%",false,false)
		guiGridListSetItemText(grid,row,5,locked,false,false)
		guiGridListSetItemText(grid,row,6,zoneName,false,false)
		if v.spawned==1 and isElement(blips[v.uniqueid]) == false then
			guiGridListSetItemColor(grid,row,6,255,0,0)
		elseif v.spawned==1 then
			guiGridListSetItemColor(grid,row,6,0,255,0)
		end
		if health > 60 then
			guiGridListSetItemColor(grid,row,3,0,255,0)
		elseif health > 30 then
			guiGridListSetItemColor(grid,row,3,255,255,0)
		else
			guiGridListSetItemColor(grid,row,3,255,0,0)
		end
		if fuel > 60 then
			guiGridListSetItemColor(grid,row,4,0,255,0)
		elseif fuel > 30 then
			guiGridListSetItemColor(grid,row,4,255,255,0)
		else
			guiGridListSetItemColor(grid,row,4,255,0,0)
		end
		if locked == "Yes" then
			guiGridListSetItemColor(grid,row,5,0,255,0)
		else
			guiGridListSetItemColor(grid,row,5,255,255,0)
		end
		if v.spawned == 1 then
			guiGridListSetItemColor(grid,row,1,0,255,0)
		end
	end
end

ae("spawnedID",true)
aeh("spawnedID",localPlayer,function(i,state,veh,shop)
	for k,v in pairs(vehData) do
		if v.uniqueid == i then
			vehData[k]["spawned"] = state
			local name = getVehicleNameFromModel(v.vehicleid)
				if v.vehicleid == 401 then name = "Ferrari" end
				if v.vehicleid == 503 then name = "Lamborghini" end
			if state == 1 then

				if (shop ~= nil) and (shop == true) then

					exports.dendxmsg:createNewDxMessage("Your newly bought $"..vehData[k].boughtprice.." "..name.." has been spawned",0,255,0)
				else
					exports.dendxmsg:createNewDxMessage("Your "..name.." has been spawned",0,255,0)
				end
			else
				if blips[i] ~= nil and blips[i] ~= false then
					if isElement(blips[i]) then destroyElement(blips[i]) blips[i] = false end
				end
					if (shop ~= nil) and (shop == true) then
						exports.dendxmsg:createNewDxMessage("Your "..name.." has been de-spawned to make room for your newly bought vehicle",0,255,0)
					else
						exports.dendxmsg:createNewDxMessage("Your "..name.." has been de-spawned",0,255,0)
					end
			end
			break
		end
	end
	if (veh) then idToVeh[i]=veh else idToVeh[i]=nil end
	updateGUI()
end)

function toggle()
	if vehData == nil then msg("Please wait a few seconds before using your vehicle panel",255,255,0) return end
	if ggv(window) == true then hide() else show() end
end
bindKey("F3","down",toggle)

ae("recVehs",true)
aeh("recVehs",localPlayer,function(t) vehData=t updateGUI() end)


local recoverPlaces = {
	{1584.91, -1019.05, 23.9},
	{1956.64, 2164.12, 10.82},
	{-1730.2, -78.31, 3.55},
}

aeh("onClientGUIClick",root,function()
	if source == btnSpawn then
		local row = guiGridListGetSelectedItem(grid)
		if row ~= nil and row ~= -1 and row ~= false then
			local id = guiGridListGetItemData(grid,row,1)
			local count=0
			for k,v in pairs(vehData) do
				if v.spawned == 1 then count=count+1 end
				if v.uniqueid == id and v.spawned==1 then
					msg("This vehicle is already spawned",255,255,0)
					return
				end
			end
			if count > 2 then msg("You already have 2 vehicles spawned, you can't spawn more.",255,255,0) return end

			tse("spawnVeh",localPlayer,id)
		else
			msg("You didn't select a vehicle to spawn",255,0,0)
		end
	elseif source == btnUnspawn then
		local row = guiGridListGetSelectedItem(grid)
		if row ~= nil and row ~= -1 and row ~= false then
			local id = guiGridListGetItemData(grid,row,1)
			for k,v in pairs(vehData) do
				if v.uniqueid == id then
					if v.spawned ~= 1 then
						msg("This vehicle is already de-spawned",255,255,0)
						return
					end
				end
			end
			if specing==true and specingVeh==idToVeh[id] then
				msg("You can't despawn a vehicle you are spectating",255,255,0)
				return
			end
			tse("unspawnVeh",localPlayer,id)
		else
			msg("You didn't select a vehicle to despawn",255,0,0)
		end
	elseif source == btnToggleLock then
		local row = guiGridListGetSelectedItem(grid)
		if row ~= nil and row ~= -1 and row ~= false then
			local id = guiGridListGetItemData(grid,row,1)
			for k,v in pairs(vehData) do
				if v.uniqueid == id then
					if v.spawned==0 then
						msg("This vehicle is not spawned, you cannot change its locked status",255,0,0)
						return
					end
				end
			end
			lock(_,_,_,id)
		else
			msg("You didn't select a vehicle",255,0,0)
		end
	elseif source == btnClose then
		hide()
	elseif source == btnSell then
		local row = guiGridListGetSelectedItem(grid)
		if row ~= nil and row ~= -1 and row ~= false then
			local id = guiGridListGetItemData(grid,row,1)
			sellingID=id
			gsv(sellWarnWindow,true)
			local health = 0
			for k,v in pairs(vehData) do
				if v.uniqueid == id then
					health=math.floor(v.vehiclehealth/10)
					sellingPrice=math.floor(v.boughtprice*((health*0.95)/100))
				break
				end
			end
			guiSetText(sellvehLabel1,"Health: "..health.."%, Selling Price: $"..sellingPrice.."")
			guiBringToFront(sellWarnWindow)
		else
			msg("You didn't select a vehicle",255,0,0)
		end

	elseif source == sellvehYesButton then
		if specing==true and idToVeh[sellingID] ~= nil and specingVeh==idToVeh[sellingID] then
			msg("You can't sell a vehicle you are spectating",255,255,0)
			return
		end
		tse("onPlayerSellVehicle",localPlayer,sellingID,sellingPrice)
		local i = sellingID
		if blips[i] ~= nil and blips[i] ~= false then
			if isElement(blips[i]) then destroyElement(blips[i]) blips[i] = false end
		end
		gsv(sellWarnWindow,false)
		if ggv(window) == true then else hide() end
	elseif source == sellvehNoButton then
		gsv(sellWarnWindow,false)
		if ggv(window) == true then else hide() end
	elseif source == btnToggleMark then
		local row = guiGridListGetSelectedItem(grid)
		if row ~= nil and row ~= -1 and row ~= false then
			local id = guiGridListGetItemData(grid,row,1)
			for k,v in pairs(vehData) do
				if v.uniqueid == id then
					if v.spawned == 0 then
						msg("You can't hide/show a vehicle that isn't spawned",255,255,0)
						return
					else
						toggleMark(id)
					end
				end
			end
		else
			msg("You didn't select a vehicle",255,0,0)
		end
	elseif source == btnSpec then
		if getElementData(localPlayer,"isPlayerArrested") == true then
			msg("You cannot spectate a vehicle while arrested",0,255,0)
			specing=false
			return
		end
		if getElementData(localPlayer,"isPlayerJailed") == true then
			msg("You cannot spectate a vehicle while jailed",0,255,0)
			specing=false
			return
		end
		if specing == true then specing=false msg("You are no longer spectating your vehicle",0,255,0) setCameraTarget(localPlayer)
		setTimer(function() setElementFrozen(localPlayer,false) end,5000,1)
		return end
		local row = guiGridListGetSelectedItem(grid)
		if row ~= nil and row ~= -1 and row ~= false then
			local id = guiGridListGetItemData(grid,row,1)
			for k,v in pairs(vehData) do
				if v.uniqueid == id then
					if v.spawned == 1 then
						local name = getVehicleNameFromModel(v.vehicleid)
						if v.vehicleid == 401 then name="Ferrari" end
						if v.vehicleid == 503 then name = "Lamborghini" end
						msg("You are now spectating your "..name.."",0,255,0)
						specingVeh=idToVeh[id]
						setElementFrozen(localPlayer,true)
						specing=true
					else
						msg("You can't spectate a vehicle thats not spawned",255,255,0)
					end
				end
			end
		else
			msg("You didn't select a vehicle",255,0,0)
		end
	elseif source == btnRecover then
		local row = guiGridListGetSelectedItem(grid)
		if row ~= nil and row ~= -1 and row ~= false then
			local id = guiGridListGetItemData(grid,row,1)
			for k,v in pairs(vehData) do
				if v.uniqueid == id then
					if v.spawned == 1 then
						local x2,y2,z2 = getElementPosition(idToVeh[id])
						local x,y,z = getElementPosition(localPlayer)
						if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) > 50 then
							local inWater=false
							if type(getWaterLevel(x2,y2,z2)) == "boolean" then
								inWater=true
							end
							if inWater==false then
								msg("Your too far from this vehicle to recover it, go closer!",255,255,0)
								return
							end
						end
						if specing == false then
							local rID=1
							local smallestDist=999999999
							if isPedInVehicle(localPlayer) == true then
								if getPedOccupiedVehicle(localPlayer) == idToVeh[id] then
									msg("You can't recover a vehicle while your inside it",255,255,0)
									return
								end
							end
							for k,v in pairs(recoverPlaces) do
								local x,y,z = v[1],v[2],v[3]
								local dist = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
								if dist<smallestDist then smallestDist=dist rID=k end
							end
							tse("recoverVeh",localPlayer,id,rID)
							local name = getVehicleNameFromModel(v.vehicleid)
							if v.vehicleid == 401 then name="Ferrari" end
							if v.vehicleid == 503 then name = "Lamborghini" end
							msg("Your "..name.." has been recovered to "..getZoneName(recoverPlaces[rID][1],recoverPlaces[rID][2],recoverPlaces[rID][3]).."",0,255,0)
							return
						else
							msg("You cannot recover a vehicle while spectating",255,255,0)
							return
						end
					else
						msg("You can't recover a vehicle thats not spawned",255,255,0)
					end
				end
			end
		else
			msg("You didn't select a vehicle",255,0,0)
		end
	end
end)

function toggleMark(id)
	if blips[id] == nil then blips[id]=false end
	if blips[id] ~= false then
		destroyElement(blips[id])
		for k,v in pairs(vehData) do
			if v.uniqueid == id then
				local name = getVehicleNameFromModel(v.vehicleid)
						if v.vehicleid == 401 then name="Ferrari" end
						if v.vehicleid == 503 then name = "Lamborghini" end
				msg("Your "..name.." is no longer visible on your map",0,255,0)
				blips[id]=false
			end
		end
	else
		blips[id] = createBlipAttachedTo(idToVeh[id],53)
		for k,v in pairs(vehData) do
			if v.uniqueid == id then
			local name = getVehicleNameFromModel(v.vehicleid)
						if v.vehicleid == 401 then name="Ferrari" end
						if v.vehicleid == 503 then name = "Lamborghini" end
				msg("Your "..name.." is now visible on your map",0,255,0)
			end
		end
	end
	updateGUI()
end

local myCol = createColCircle(1,1,30)
attachElements(myCol,localPlayer)

aeh("onClientPreRender",root,function()
	if specing==true then
		local x, y, z = getElementPosition ( specingVeh )
		setCameraMatrix ( x, y, z + 20, x, y, z )
	end
end)

function lock(_,_,_,id)
	local gotID	 = false
	if type(tonumber(id)) == "number" then
		gotID=true
	else
		id = 0
	end
	local veh=false
	local smallestDist = 9999999
	local x,y,z = getElementPosition(localPlayer)
	for k,v in pairs(getElementsByType("vehicle")) do
		if getElementData(v,"vehicleOwner") == localPlayer then
			local x2,y2,z2 = getElementPosition(v)
			local dist = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
			if dist < smallestDist then
				id = getElementData(v,"vehicleID")
				smallestDist=dist
				veh=v
			end
		end
	end
	if (gotID) == false then
		if isElement(veh) == false then
			msg("There is no vehicle of yours near you",255,255,0)
			return
		else
			tse("CSGveh.toggleLock",localPlayer,id)
		end
	else
		local x2,y2,z2 = getElementPosition(idToVeh[id])
		local dist = getDistanceBetweenPoints3D(x,y,z,x2,y2,z2)
		if dist < 30 then
			tse("CSGveh.toggleLock",localPlayer,id)
		else
			local name = getVehicleName(idToVeh[id])
			if getElementModel(idToVeh[id]) == 401 then name="Ferrari" end
			msg("Your too far away to toggle your "..name.."'s lock",255,255,0)
			return
		end
	end

end
addCommandHandler("lock",lock)
addCommandHandler("lk",lock)

ae("playLocked",true)
aeh("playLocked",localPlayer,function(x,y,z)
	playSound3D("lock.ogg",x,y,z)
end)

ae("vehLockStatus",true)
aeh("vehLockStatus",localPlayer,function(id,state)
	for k,v in pairs(vehData) do
		if v.uniqueid == id then
			vehData[k]["locked"]=state
			break
		end
	end
	updateGUI()
end)
