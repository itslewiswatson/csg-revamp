local jobInitialized

addEvent('onPlayerJobCall', true )
function onPlayerCall()
	if jobInitialized then	
		local zone = "near "..getZoneName(x,y,z)
		if getZoneName(x,y,z) == "Unknown" then
			zone = "in "..getZoneName(x,y,z,true)
		end
		exports.dendxmsg:createNewDxMessage(getPlayerName(source).." has requested a mechanic "..zone..".", 0, 255, 0 )		
	end
end

function onElementDataChange( dataName, oldValue )
	if dataName == "Occupation" and getElementData(localPlayer,dataName) == "Mechanic" then
		initMechanicJob()	
	elseif dataName == "Occupation" then
		stopMechanicJob()	
	end
end

addEventHandler ( "onClientElementDataChange", localPlayer, onElementDataChange, false ) 

addEvent( "onClientPlayerTeamChange" )
function onMechanicTeamChange ( oldTeam, newTeam )
	if getElementData ( localPlayer, "Occupation" ) == "Mechanic" and source == localPlayer then
		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local newTeam = getTeamName ( getPlayerTeam( localPlayer ) )
				if newTeam == "Unoccupied" then
					stopMechanicJob()
				elseif getElementData ( localPlayer, "Occupation" ) == "Mechanic" and newTeam == "Civilian Workers" then
					initMechanicJob()	
				end
			end	
		end, 200, 1 )		
	end
end

addEventHandler( "onClientPlayerTeamChange", localPlayer, onMechanicTeamChange, false )	
function initMechanicJob()
	if not jobInitialized then
		jobInitialized = true
		bindKey( 'aim_weapon', 'down', onPlayerAim )
		bindKey ( "F5", "down", showMechPanel )
		addEventHandler("onPlayerJobCall", root,onPlayerCall)
	end	
end

function stopMechanicJob()
	if jobInitialized then
		onRemoveAllBlips ()
		hideMechanicGUI()
		jobInitialized = false
		unbindKey( 'aim_weapon', 'down', onPlayerAim )
		unbindKey ( "F5", "down", showMechPanel )
		removeEventHandler("onPlayerJobCall", root,onPlayerCall)		
	end
end

local updateBlipsTimer

function createMechPanel()
	mechPanelWindow = guiCreateWindow(409,182,441,459,"CSG ~ Mechanic Panel",false)
	mechPanelGrid = guiCreateGridList(9,23,423,249,false,mechPanelWindow)
	guiGridListSetSelectionMode(mechPanelGrid,0)

	local column1 = guiGridListAddColumn(mechPanelGrid,"Vehicle name and owner:",0.47)
	local column2 = guiGridListAddColumn(mechPanelGrid,"Health:",0.10)
	local column3 = guiGridListAddColumn(mechPanelGrid,"Location:",0.38)

	mechPanelButton1 = guiCreateButton(10,277,134,33,"Mark vehicle",false,mechPanelWindow)
	mechPanelButton2 = guiCreateButton(148,277,137,33,"Mark all vehicles",false,mechPanelWindow)
	mechPanelButton3 = guiCreateButton(290,277,141,33,"Delete blips",false,mechPanelWindow)

	mechPanelRadio1 = guiCreateRadioButton(14,320,361,22,"Show all damaged vehicles",false,mechPanelWindow)
	mechPanelRadio2 = guiCreateRadioButton(14,346,361,22,"Show only vehicles with less than 80% health",false,mechPanelWindow)
	mechPanelRadio3 = guiCreateRadioButton(14,372,361,22,"Show only vehicles with less than 60% health",false,mechPanelWindow)
	mechPanelRadio4 = guiCreateRadioButton(14,398,361,22,"Show only vehicles with less than 40% health",false,mechPanelWindow)
	mechPanelRadio5 = guiCreateRadioButton(14,424,361,22,"Show only vehicles with less than 20% health",false,mechPanelWindow)

	guiRadioButtonSetSelected(mechPanelRadio1,true)

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(mechPanelWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(mechPanelWindow,x,y,false)

	guiWindowSetSizable (mechPanelWindow, false)
end

function showMechPanel ()	
	local showPanel = true	
	if not isElement(mechPanelWindow) then		
		createMechPanel()
	else	
		if guiGetVisible(mechPanelWindow) then
			showPanel = false
			guiSetVisible(mechPanelWindow, false)
		else
			guiSetVisible(mechPanelWindow,true)
		end
	end	
	if showPanel then	
		showCursor(true)
		loadInjuredVehicles()
		addEventHandler("onClientGUIClick", mechPanelButton1, onMarkSelectedVehicle, false)
		addEventHandler ( "onClientGUIClick", root, onUserChangedMechPanelSetting )
		addEventHandler("onClientGUIClick", mechPanelButton2, onMarkAllVehicles, false)
		addEventHandler("onClientGUIClick", mechPanelButton3, onRemoveAllBlipsButton, false)		
	else
		showCursor(false)
		removeEventHandler("onClientGUIClick", mechPanelButton1, onMarkSelectedVehicle, false)
		removeEventHandler("onClientGUIClick", root, onUserChangedMechPanelSetting )
		removeEventHandler("onClientGUIClick", mechPanelButton2, onMarkAllVehicles, false)
		removeEventHandler("onClientGUIClick", mechPanelButton3, onRemoveAllBlipsButton, false)		
	end
end

function onRemoveAllBlipsButton()

	if isTimer(updateBlipsTimer) then killTimer(updateBlipsTimer) end
	onRemoveAllBlips()

end

function onUserChangedMechPanelSetting ()
	if ( source == mechPanelRadio1 ) or ( source == mechPanelRadio2 ) or ( source == mechPanelRadio3 ) or ( source == mechPanelRadio4 ) or ( source == mechPanelRadio5 ) then
		loadInjuredVehicles()
	end
end

local doAutoUpdateBlips = false

function onMarkSelectedVehicle ()
	local theVehicle = guiGridListGetItemData(mechPanelGrid, guiGridListGetSelectedItem ( mechPanelGrid ), 1)
	if not ( isElement( theVehicle ) ) then
		exports.DENdxmsg:createNewDxMessage("You didn't select a player!", 225 ,0 ,0)
	else
		if ( isElement( theVehicle ) ) then
			local attachedElements = getAttachedElements ( theVehicle )
			if ( attachedElements ) then
				for ElementKey, ElementValue in ipairs ( attachedElements ) do
					if ( getElementType ( ElementValue ) == "blip" ) and getBlipIcon ( ElementValue ) == 22 then
						return
					end
				end
			end
			local theBlip = createBlipAttachedTo ( theVehicle, 22 )
		end
	end
end

function onMarkAllVehicles ()
	local healthSetting = 100
	if ( guiRadioButtonGetSelected( mechPanelRadio1 ) ) then healthSetting = 100 end
	if ( guiRadioButtonGetSelected( mechPanelRadio2 ) ) then healthSetting = 80  end
	if ( guiRadioButtonGetSelected( mechPanelRadio3 ) ) then healthSetting = 60  end
	if ( guiRadioButtonGetSelected( mechPanelRadio4 ) ) then healthSetting = 40  end
	if ( guiRadioButtonGetSelected( mechPanelRadio5 ) ) then healthSetting = 20  end
	
	onRemoveAllBlips()
	
	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		if ( math.floor(getElementHealth( vehicle ) / 10 ) < math.floor(tonumber(healthSetting) )) then
			if getElementData(vehicle, "vehicleOwner") or getVehicleController(vehicle) then
				local theBlip = createBlipAttachedTo ( vehicle, 22 )
				doAutoUpdateBlips = true
				if not isTimer(updateBlipsTimer) then updateBlipsTimer = setTimer ( onMarkAllVehicles, 10000, 0) end
			end
		end
	end
end

function onRemoveAllBlips ()
	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		local attachedElements = getAttachedElements ( vehicle )
		if ( attachedElements ) then 
			for ElementKey, ElementValue in ipairs ( attachedElements ) do
				if ( getElementType ( ElementValue ) == "blip" ) then
					if ( getBlipIcon ( ElementValue ) == 22 ) then
						destroyElement( ElementValue )
						doAutoUpdateBlips = false
					end
				end
			end
		end
	end
end

function loadInjuredVehicles()
	local healthSetting = 100
	if ( guiRadioButtonGetSelected( mechPanelRadio1 ) ) then healthSetting = 100
	elseif ( guiRadioButtonGetSelected( mechPanelRadio2 ) ) then healthSetting = 80
	elseif ( guiRadioButtonGetSelected( mechPanelRadio3 ) ) then healthSetting = 60
	elseif ( guiRadioButtonGetSelected( mechPanelRadio4 ) ) then healthSetting = 40
	elseif ( guiRadioButtonGetSelected( mechPanelRadio5 ) ) then healthSetting = 20  end
	
	local vehicleFound = false
	
	guiGridListClear ( mechPanelGrid )
	for id, vehicle in ipairs(getElementsByType("vehicle")) do
		if ( math.floor(getElementHealth( vehicle ) / 10) < tonumber(healthSetting) ) then
			if getElementData(vehicle, "vehicleOwner") or getVehicleController(vehicle) then
 				vehicleFound = true
				local vehicleOwner = getElementData(vehicle, "vehicleOwner") or getVehicleController(vehicle)
				local x, y, z = getElementPosition ( vehicle )
				local row = guiGridListAddRow ( mechPanelGrid )
				guiGridListSetItemText ( mechPanelGrid, row, 1, getVehicleName ( vehicle ).." / "..getPlayerName(vehicleOwner), false, false )
				guiGridListSetItemText ( mechPanelGrid, row, 2, math.floor(getElementHealth ( vehicle )  / 10).."%", false, false )
				guiGridListSetItemText ( mechPanelGrid, row, 3, getZoneName ( x, y, z ).." ("..calculateVehicleZone( x, y, z )..")", false, false )
				guiGridListSetItemData ( mechPanelGrid, row, 1, vehicle)
				
				if ( math.floor(getElementHealth ( vehicle ) / 10 ) < 30 ) then
					guiGridListSetItemColor ( mechPanelGrid, row, 2, 225, 0, 0 )
				elseif ( math.floor(getElementHealth ( vehicle ) / 10 ) > 290 ) and  ( math.floor(getElementHealth ( vehicle ) / 10 ) < 70 ) then
					guiGridListSetItemColor ( mechPanelGrid, row, 2, 225, 165, 0 )
				else
					guiGridListSetItemColor ( mechPanelGrid, row, 2, 0, 225, 0 )
				end
			end
		end
	end
	
	if not ( vehicleFound ) then
		local row = guiGridListAddRow ( mechPanelGrid )
		guiGridListSetItemText ( mechPanelGrid, row, 1, "No vehicles found", false, false )
		guiGridListSetItemText ( mechPanelGrid, row, 2, "  N/A", false, false )
		guiGridListSetItemText ( mechPanelGrid, row, 3, "  N/A", false, false )
	end
end

function calculateVehicleZone( x, y, z )
	if x < -920 then
		return "SF"
	elseif y < 420 then
		return "LS"
	else
		return "LV"
	end
end