armedVehicles = {[425]=true, [520]=true, [476]=true, [447]=true, [340]=true, [432]=true, [464]=true, [407]=true}
heat = 0
decrease = nil
increase = nil
drawing = false
--15 = 100 = 206

function showDXt()
			size = (heat * 206)/10
			dxDrawRectangle(1094, 577, 222, 29, tocolor(17, 16, 14, 216), true)
			dxDrawRectangle(1100, 583, size+1, 19, tocolor(9, 62, 52, 216), true)
			dxDrawText("Vehicle Heat", 1170, 582, 1311, 602, tocolor(255, 255, 255, 255), 1.00, "default", "left", "top", false, false, true, false, false)
end

function showDX(thePlayer)
    if thePlayer == localPlayer and not drawing then
		local vehModel = getElementModel(source)
		if (armedVehicles[vehModel]) then
			addEventHandler("onClientRender", root, showDXt)
			drawing = true
		end
    end
end
addEventHandler ("onClientVehicleEnter", getRootElement(), showDX)

function hideDX(thePlayer)
    if thePlayer == localPlayer and drawing then
	local vehModel = getElementModel(source)
	if (armedVehicles[vehModel]) then
        removeEventHandler("onClientRender", root, showDXt)
        drawing = false
	end	
	end
end
addEventHandler ("onClientVehicleExit", getRootElement(), hideDX)


function checkKeyState(key)
 local vehicle = getPedOccupiedVehicle(localPlayer)
   if (vehicle) then
	if ( getVehicleController(vehicle) ) then
	if (armedVehicles[getElementModel(vehicle)]) then
		if gunHeated == true then
			exports.dendxmsg:createNewDxMessage("You can't shoot now, wait till your vehicle heat decreases",255,0,0)
			return false
		else	
		if key == "vehicle_secondary_fire" then
			if (isTimer(increase)) then killTimer(increase) end
			if heat ~= 0 then
				increasing2()
				increase = setTimer(increasing, 1000, 0)
			else
				increase = setTimer(increasing, 1000, 0)
			end	
		elseif key == "vehicle_fire" then
			increasing2()
		end	
		if (isTimer(decrease)) then
			killTimer(decrease)
		 end
		 end
	   end
    end
  end
end
bindKey("vehicle_secondary_fire", "down", checkKeyState)
bindKey("vehicle_fire", "down", checkKeyState)

function decreaseHeat()
	if isTimer(decrease) then killTimer(decrease) end
	decrease = setTimer(decreasing, 1000, 0)
	if isTimer(increase) then killTimer(increase) end
end
bindKey("vehicle_secondary_fire", "up", decreaseHeat)
bindKey("vehicle_fire", "up", decreaseHeat)

gunHeated = false

function increasing()
	if (heat < 10) then
		heat = heat + 0.3
	end
	if (heat >= 10) then
		heat = 10
		exports.dendxmsg:createNewDxMessage("Your Vehicle is overheated, wait till your vehicle heat decreases",255,0,0)
		toggleControl("vehicle_secondary_fire", false)
		toggleControl("vehicle_fire", false)
		gunHeated = true
	end
end		

function increasing2()
	if (heat < 10) then
		heat = heat + 0.4	
	end
	if (heat >= 10) then
		heat = 10
		exports.dendxmsg:createNewDxMessage("Your Vehicle is overheated, wait till your vehicle heat decreases",255,0,0)
		toggleControl("vehicle_secondary_fire", false)
		toggleControl("vehicle_fire", false)
		gunHeated = true
	end
end		

function decreasing()
	if (heat > 0) then
		heat = heat - 0.3
		if (heat <= 7) then
			if (gunHeated) then
				exports.dendxmsg:createNewDxMessage("You can now shoot with your vehicle",0,255,0)
				toggleControl("vehicle_secondary_fire", true)
				toggleControl("vehicle_fire", true)
				gunHeated = false
			end
		end
	elseif (heat <= 0) then
		if (isTimer(decrease)) then
			killTimer(decrease)
		end
		heat = 0
	end
end