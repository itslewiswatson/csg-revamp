local mechanicFixWindow
local GUIIsShowing

function getUpgradePrice(upgrade,mechanicIsLocalPlayer,vehicle)

	local price
	local needsUpgrade = true
	local vehicleUpgrades
	local upgradesOwned	
	if vehicle then
		vehicleUpgrades = getVehicleUpgrades(vehicle)
		upgradesOwned = {}
		for key,value in ipairs(vehicleUpgrades) do
			upgradesOwned[tonumber(value)] = true
		end
	end
	if not upgrade then return false end 

	if upgrade == 1 then
		-- Nitro option
		if mechanicIsLocalPlayer then price = 2000 else price = 5000 end
	elseif upgrade == 2 then
		-- Hydraulics option
		if vehicle then if upgradesOwned[1087] then needsUpgrade = "Your vehicle already has hydraulics!" end end
		if mechanicIsLocalPlayer then price = 1500 else price = 4000 end
	elseif upgrade == 3 then
		-- Fixing wheels option
		if vehicle then
			local w1,w2,w3,w4 = getVehicleWheelStates(vehicle)
			local wheels = {w1,w2,w3,w4}
			local numberOfWheelsDamaged = 0
			for i=1,#wheels do	
				if wheels[i] > 0 then			
					numberOfWheelsDamaged = numberOfWheelsDamaged +1			
				end		
			end
			if mechanicIsLocalPlayer then price = numberOfWheelsDamaged*100 else price = numberOfWheelsDamaged*200 end
			if numberOfWheelsDamaged < 1 then needsUpgrade = "Your vehicle's wheels aren't damaged!" end			
		else		
			if mechanicIsLocalPlayer then price = '100-400' else price = '200-800' end			
		end		
	elseif upgrade == 4 then
		-- Complete vehicle repair option
		if vehicle then
			local vehHealth = getElementHealth(vehicle)
			local panelsDamaged = areVehiclePanelsDamaged(vehicle)
			if vehHealth >= 1000 and panelsDamaged < 1 then needsUpgrade = "Your vehicle isn't damaged!" end
			local panelsPrice = panelsDamaged * 50
			price = panelsPrice + math.ceil((1000-math.min(vehHealth,1000))/10)*50
			if mechanicIsLocalPlayer then
				price = math.ceil((math.max(price*0.75,0))/10)*10
			end
		else		
			price = '50-5200'
			if mechanicIsLocalPlayer then
				price = '40-3900'
			end		
		end
	elseif upgrade == 5 then
		if vehicle then
			local fuel = getElementData(vehicle,"vehicleFuel")
			local fuelNeeded = 100 - fuel
			if fuelNeeded > 0 then
				price = fuelNeeded*10
				if mechanicIsLocalPlayer then
					price = math.ceil(fuelNeeded*7.5)
				end
			else
				needsUpgrade = "Your vehicle does not need fuel!"
			end
		else
			price = '100-1000'
			if mechanicIsLocalPlayer then
				price = '75-750'
			end		
		end
	end

	return price, needsUpgrade
end

local radioButtons = { { getUpgradePrice(1,false,false), "Buy 5 NOS", nil },
	{ getUpgradePrice(2,false,false), "Buy hydraulics", nil },
	{ getUpgradePrice(3,false,false), "Fix vehicle wheels", nil },
	{ getUpgradePrice(4,false,false), "Fix entire vehicle", nil },
	{ getUpgradePrice(5,false,false), "Refuel vehicle", nil }
}

addEventHandler( "onClientResourceStart", resourceRoot,
    function ()
       
	    local windowHeight = 100+(#radioButtons*21)
		mechanicFixWindow = guiCreateWindow(557,364,281,windowHeight,"CSG ~ Mechanic",false)
		guiSetVisible (mechanicFixWindow, false)
		mechanicFixLabel = guiCreateLabel(8,27,266,18,"",false,mechanicFixWindow)
		guiLabelSetColor(mechanicFixLabel,0,200,0)
		guiLabelSetHorizontalAlign(mechanicFixLabel,"center",false)
		guiSetFont(mechanicFixLabel,"default-bold-small")
		for i=1,#radioButtons do	
			local x,y,width,height = 11,34+(i*21),230,21
			local gui = guiCreateRadioButton(x,y,width,height, radioButtons[i][2].."( $"..radioButtons[i][1].." )", false, mechanicFixWindow)
			radioButtons[i][3] = gui	
		end
		mechanicFixBuyButton = guiCreateButton(9,windowHeight-40,130,30,"Buy selected",false,mechanicFixWindow)
		mechanicFixCloseButton = guiCreateButton(143,windowHeight-40,129,30,"Cancel",false,mechanicFixWindow)
		guiSetSize(mechanicFixWindow,557,windowHeight,false)
		local screenW,screenH=guiGetScreenSize()
		local windowW,windowH=guiGetSize(mechanicFixWindow,false)
		local x,y = (screenW-windowW)/2,(screenH-windowH)/2
		guiSetPosition(mechanicFixWindow,x,y,false)

		guiWindowSetSizable (mechanicFixWindow, false)
		
		setTimer ( function ()
			if getPlayerTeam( localPlayer ) then
				local team = getTeamName ( getPlayerTeam( localPlayer ) )
				if getElementData ( localPlayer, "Occupation" ) == "Mechanic" and team == "Civilian Workers" then	
					initMechanicJob()		
				end	
			end				
		end, 2500, 1 )		
		
    end
)

function showMechanicGUI()

	if not GUIIsShowing then

		GUIIsShowing = true
		guiSetVisible(mechanicFixWindow, true)
		showCursor(true)
		addEventHandler("onClientGUIClick", mechanicFixCloseButton, onMechanicReject, false)
		addEventHandler("onClientGUIClick", mechanicFixBuyButton, onMechanicAccept, false)
		
	end
	
end

function hideMechanicGUI()

	if GUIIsShowing then

		GUIIsShowing = false
		guiSetVisible(mechanicFixWindow, false)
		showCursor(false)
		removeEventHandler("onClientGUIClick", mechanicFixCloseButton, onMechanicReject, false)
		removeEventHandler("onClientGUIClick", mechanicFixBuyButton, onMechanicAccept, false)
		
	end

end

function onMechanicReject ()

	hideMechanicGUI()
	if thePlayerMechanic ~= localPlayer then
		triggerServerEvent("notifyMechanic", thePlayerMechanic, getPlayerName(localPlayer).." doesn't need your services at the moment.")
	end
end

function onMechanicAccept ()

	if not isElement(theVehicle) then 
		if thePlayerMechanic ~= localPlayer then
			triggerServerEvent("notifyMechanic", thePlayerMechanic, getPlayerName(localPlayer).."'s vehicle is missing, request cancelled.")
		end
		exports.DENdxmsg:createNewDxMessage( "Your vehicle is missing!", 255, 0, 0)
		return false
	end
	local hideWindow = true
	local option = nil

	for i=1, #radioButtons do
	
		if guiRadioButtonGetSelected(radioButtons[i][3]) then
		
			option = i 
			break
			
		end
		
	end
	if not option then
		hideWindow = false
		exports.DENdxmsg:createNewDxMessage("Please select a option!", 255, 0, 0)
	end	
	local price, isNeeded = getUpgradePrice(option,thePlayerMechanic == localPlayer,theVehicle)
	if isNeeded ~= true then
	
		exports.DENdxmsg:createNewDxMessage(isNeeded, 255, 0, 0)
		hideWindow = false
	end
	local px, py, pz = getElementPosition(localPlayer)
	local vx, vy, vz = getElementPosition(theVehicle)
	if getDistanceBetweenPoints2D ( px, py, vx, vy ) > 3 then
		exports.DENdxmsg:createNewDxMessage("Your vehicle is too far away from the mechanic!", 255, 0, 0)
		isNeeded = false
	end
	if option and price and isNeeded == true then triggerServerEvent("doVehicleRepair", localPlayer, option, thePlayerMechanic, theVehicle, price) end
	if hideWindow then hideMechanicGUI() end
end

function areVehiclePanelsDamaged(vehicle)
	local numberOfPanelsDamaged = 0
	for i=0,6 do	
		if getVehiclePanelState(vehicle,i) > 0 then		
			numberOfPanelsDamaged = numberOfPanelsDamaged+1			
		end	
	end
	return numberOfPanelsDamaged
end

function onPlayerAim(player)
	if not jobInitialized then return false end
	local target = getPedTarget(localPlayer)

	if getPedWeapon(localPlayer) == 0 and not isPedInVehicle(localPlayer) and isElement (target) and getElementType (target) == "vehicle" then
		local px, py, pz = getElementPosition(localPlayer)
		local vx, vy, vz = getElementPosition(target)
		if getDistanceBetweenPoints2D ( px, py, vx, vy ) < 3 then
		
			local owner = getElementData(target, "vehicleOwner")
			if not owner then
				owner = getVehicleController(target)
			end
			if owner then
				local sx, sy, sz = getElementVelocity(target)  
				local speed = (sx^2 + sy^2 + sz^2)^(0.5)*100
				if speed < 12 then
					triggerServerEvent("onMechanicPickVehicle", localPlayer ,owner, target)
					exports.DENdxmsg:createNewDxMessage( "Waiting for customer's response.", 0, 200, 0)
				end
			end
		end
	end
end


function onMechanicShowGUI (theMechanic, vehicle)

	guiSetText(mechanicFixLabel,getPlayerName(theMechanic) .. " wants to fix your vehicle.")
	
	for i=1, #radioButtons do
	
		local price, isNeeded = getUpgradePrice(i,theMechanic == localPlayer, vehicle)
		if isNeeded == true then
			guiSetText(radioButtons[i][3], radioButtons[i][2].."( $"..price.." )")
			guiSetEnabled(radioButtons[i][3],true)
		else
			guiSetText(radioButtons[i][3], radioButtons[i][2].."( $"..radioButtons[i][1].." )")
			guiRadioButtonSetSelected(radioButtons[i][3],false)
			guiSetEnabled(radioButtons[i][3],false)
		end
	
	end
	
	showMechanicGUI()
	guiBringToFront( mechanicFixWindow )
	thePlayerMechanic = theMechanic
	theVehicle = vehicle
	
end
addEvent("onMechanicShowGUI", true)
addEventHandler("onMechanicShowGUI", getRootElement(), onMechanicShowGUI)

addEventHandler("onClientVehicleEnter",root,
	function (player)
		if player == localPlayer then
			hideMechanicGUI()
		end
	end
)
