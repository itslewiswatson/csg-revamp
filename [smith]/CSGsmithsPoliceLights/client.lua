-- Emergency Lights resource by vovo4ka
-- please, do not remove copyright

local strobo_interval = 10		-- strobo light freq. 10 = 0.5 sec
local is_strobo_enabled = enable	-- enable/disable stroboscopic lights mode
-- lamps
local flash_interval = 1		-- flash freq
-- led blink mode
local blink_interval = 20		-- blink interval
local blink_duration = 2		-- 1..blink_interval

local car_lights_table = {
-- Huntley
[579] = {["mode"]="lamp",
[1]={["pos"]={-0.08, 0.45, 0.99}, ["color"]={255,0,0}, ["size"]=0.09, ["phase"]=0.0},
[2]={["pos"]={-0.2, 0.45, 0.99}, ["color"]={255,0,0}, ["size"]=0.09, ["phase"]=0.0},
[3]={["pos"]={0.2, 0.45, 0.99}, ["color"]={0,0,255}, ["size"]=0.09, ["phase"]=10.0},
[4]={["pos"]={0.08, 0.45, 0.99}, ["color"]={0,0,255}, ["size"]=0.09, ["phase"]=10.0}
},

-- Ambulance Hummer
 [529] = {["mode"]="lamp", 
[1]={["pos"]={-0.22, 0.38, 1.0}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=5.0}, 
[2]={["pos"]={0.22, 0.38, 1.0}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=5.0},
[3]={["pos"]={-0.35, 0.38, 1.0}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=0.0}, 
[4]={["pos"]={0.35, 0.38, 1.0}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=0.0},
[5]={["pos"]={-0.48, 0.38, 1.0}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=10.0}, 
[6]={["pos"]={0.48, 0.38, 1.0}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=10.0},
},

-- Patriot
[470] = {["mode"]="lamp",
[1]={["pos"]={-0.1, 0.55, 0.85}, ["color"]={255,0,0}, ["size"]=0.09, ["phase"]=0.0},
[2]={["pos"]={-0.22, 0.55, 0.85}, ["color"]={255,0,0}, ["size"]=0.09, ["phase"]=0.0},
[3]={["pos"]={0.22, 0.55, 0.85}, ["color"]={0,0,255}, ["size"]=0.09, ["phase"]=10.0},
[4]={["pos"]={0.1, 0.55, 0.85}, ["color"]={0,0,255}, ["size"]=0.09, ["phase"]=10.0}
},

-- Premier
[426] = {["mode"]="lamp",
[1]={["pos"]={0.65, 0.4, 0.65}, ["color"]={255,0,0}, ["size"]=0.08, ["phase"]=0.0},
[2]={["pos"]={0.55, 0.4, 0.65}, ["color"]={255,0,0}, ["size"]=0.08, ["phase"]=0.0},
[3]={["pos"]={0.48, 0.4, 0.65}, ["color"]={0,0,255}, ["size"]=0.08, ["phase"]=10.0},
[4]={["pos"]={0.38, 0.4, 0.65}, ["color"]={0,0,255}, ["size"]=0.08, ["phase"]=10.0}
},

-- Merit
[551] = {["mode"]="lamp",
[1]={["pos"]={0.60, 0.4, 0.65}, ["color"]={255,0,0}, ["size"]=0.08, ["phase"]=0.0},
[2]={["pos"]={0.50, 0.4, 0.65}, ["color"]={255,0,0}, ["size"]=0.08, ["phase"]=0.0},
[3]={["pos"]={0.43, 0.4, 0.65}, ["color"]={0,0,255}, ["size"]=0.08, ["phase"]=10.0},
[4]={["pos"]={0.33, 0.4, 0.65}, ["color"]={0,0,255}, ["size"]=0.08, ["phase"]=10.0}
},

-- Enforcer
[427] = {["mode"]="lamp", 
[1]={["pos"]={0.45, 1.1, 1.42}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=10.0}, 
[2]={["pos"]={-0.45, 1.1, 1.42}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=10.0},
[3]={["pos"]={0.22, 1.1, 1.42}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=0.0}, 
[4]={["pos"]={-0.22, 1.1, 1.42}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=0.0},
[5]={["pos"]={-1.18, 0.1, 0.94}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=0.0}, 
[6]={["pos"]={-1.18, -1.63, 0.94}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=5.0},
[7]={["pos"]={-1.18, -3.37, 0.94}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=10.0}, 
[8]={["pos"]={1.18, 0.1, 0.94}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=0.0}, 
[9]={["pos"]={1.18, -1.63, 0.94}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=5.0},
[10]={["pos"]={1.18, -3.37, 0.94}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=10.0}
},

-- Securicar
[428] = {["mode"]="lamp",
[1]={["pos"]={-1.1, 1.3, 1.2}, ["color"]={255,128,0}, ["size"]=0.15, ["phase"]=0.0},
[2]={["pos"]={-1.1, -3, 1.5}, ["color"]={255,128,0}, ["size"]=0.15, ["phase"]=5.0},
[3]={["pos"]={0, 1.3, 1.2}, ["color"]={255,128,0}, ["size"]=0.15, ["phase"]=10.0},
[4]={["pos"]={1.1, 1.3, 1.2}, ["color"]={255,128,0}, ["size"]=0.15, ["phase"]=0.0},
[5]={["pos"]={1.1, -3, 1.5}, ["color"]={255,128,0}, ["size"]=0.15, ["phase"]=5.0},
[6]={["pos"]={0, -3, 1.5}, ["color"]={255,128,0}, ["size"]=0.15, ["phase"]=10.0}
},

-- Police LS
 [596] = {["mode"]="lamp", 
[1]={["pos"]={-0.2, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=5.0}, 
[2]={["pos"]={0.2, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=5.0},
[3]={["pos"]={-0.45, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=0.0}, 
[4]={["pos"]={0.45, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=0.0},
[5]={["pos"]={-0.7, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=10.0}, 
[6]={["pos"]={0.7, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=10.0},
[7]={["pos"]={-0.25, 2.46, -0.038}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=0.0}, 
[8]={["pos"]={0.25, 2.46, -0.038}, ["color"]={0,0,255}, ["size"]=0.12, ["phase"]=10.0}
},

-- Police SF
[597] = {["mode"]="lamp", 
[1]={["pos"]={-0.2, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=5.0}, 
[2]={["pos"]={0.2, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=5.0},
[3]={["pos"]={-0.45, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=0.0}, 
[4]={["pos"]={0.45, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=0.0},
[5]={["pos"]={-0.7, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=10.0}, 
[6]={["pos"]={0.7, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=10.0},
[7]={["pos"]={-0.25, 2.46, -0.038}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=0.0}, 
[8]={["pos"]={0.25, 2.46, -0.038}, ["color"]={0,0,255}, ["size"]=0.12, ["phase"]=10.0}
},

-- Police SF
--[[[597] = {["mode"]="led", 
[1]={["pos"]={-0.2, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=0.0}, 
[2]={["pos"]={0.2, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=10.0},
[3]={["pos"]={-0.45, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=0.0}, 
[4]={["pos"]={0.45, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=10.0},
[5]={["pos"]={-0.7, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=0.0}, 
[6]={["pos"]={0.7, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=10.0},
[7]={["pos"]={-0.25, 2.46, -0.038}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=10.0}, 
[8]={["pos"]={0.25, 2.46, -0.038}, ["color"]={0,0,255}, ["size"]=0.12, ["phase"]=0.0}
},]]

-- Police LV
 [598] = {["mode"]="lamp", 
[1]={["pos"]={-0.2, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=5.0}, 
[2]={["pos"]={0.2, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=5.0},
[3]={["pos"]={-0.45, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=0.0}, 
[4]={["pos"]={0.45, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=0.0},
[5]={["pos"]={-0.7, -0.35, 0.95}, ["color"]={255,0,0}, ["size"]=0.18, ["phase"]=10.0}, 
[6]={["pos"]={0.7, -0.35, 0.95}, ["color"]={0,0,255}, ["size"]=0.18, ["phase"]=10.0},
[7]={["pos"]={-0.25, 2.46, -0.038}, ["color"]={255,0,0}, ["size"]=0.12, ["phase"]=0.0}, 
[8]={["pos"]={0.25, 2.46, -0.038}, ["color"]={0,0,255}, ["size"]=0.12, ["phase"]=10.0}
},

-- Police Ranger
  [599] = {["mode"]="lamp",
[1]={["pos"]={-0.3, 0, 1.2}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=10.0},
[2]={["pos"]={-0.7, 0, 1.2}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=0.0}, 
[3]={["pos"]={-0.5, 0, 1.2}, ["color"]={255,0,0}, ["size"]=0.2, ["phase"]=5.0},
[4]={["pos"]={0.3, 0, 1.2}, ["color"]={0,0,255}, ["size"]=0.21, ["phase"]=5.0},
[5]={["pos"]={0.5, 0, 1.2}, ["color"]={0,0,255}, ["size"]=0.21, ["phase"]=0.0},
[6]={["pos"]={0.7, 0, 1.2}, ["color"]={0,0,255}, ["size"]=0.21, ["phase"]=10.0},
[7]={["pos"]={-0.40, 2.46, -0.038}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=0.0}, 
[8]={["pos"]={-0.29, 2.46, -0.038}, ["color"]={255,0,0}, ["size"]=0.1, ["phase"]=0.0}, 
[9]={["pos"]={0.29, 2.46, -0.038}, ["color"]={0,0,255}, ["size"]=0.1, ["phase"]=10.0},
[10]={["pos"]={0.40, 2.46, -0.038}, ["color"]={0,0,255}, ["size"]=0.1, ["phase"]=10.0}
},
 
-- FBI Rancher
[490] = {["mode"]="lamp",
[1]={["pos"]={-0.94, 3.3, -0.45}, ["color"]={255,0,0}, ["size"]=0.13, ["phase"]=0.0}, 
[2]={["pos"]={-0.8, 3.3, -0.45}, ["color"]={255,0,0}, ["size"]=0.13, ["phase"]=0.0}, 
[3]={["pos"]={0.8, 3.3, -0.45}, ["color"]={0,0,255}, ["size"]=0.13, ["phase"]=10.0},
[4]={["pos"]={0.94, 3.3, -0.45}, ["color"]={0,0,255}, ["size"]=0.13, ["phase"]=10.0},
[5]={["pos"]={-0.63, -2.9, 0.85}, ["color"]={255,0,0}, ["size"]=0.11, ["phase"]=0.0}, 
[6]={["pos"]={-0.75, -2.9, 0.85}, ["color"]={255,0,0}, ["size"]=0.11, ["phase"]=0.0}, 
[7]={["pos"]={0.75, -2.9, 0.85}, ["color"]={0,0,255}, ["size"]=0.11, ["phase"]=10.0},
[8]={["pos"]={0.63, -2.9, 0.85}, ["color"]={0,0,255}, ["size"]=0.11, ["phase"]=10.0},
}
-- since 0.8 there are no default lights position, because only emergency and pre-defined vehicles can use lights
--["default"] = {["mode"]="lamp", [1]={["pos"]={0.5, 0, 0.8}, ["color"]={255,0,0}, ["size"]=0.25, ["phase"]=0.0}, [2]={["pos"]={-0.5, 0, 0.8}, ["color"]={0,0,255}, ["size"]=0.25, ["phase"]=10.0}}
}

-- do not modify --------------------------------------------
local vehicles = {}
local timers = {}

local base_freq = 50	-- freq of timer for light change

-------------------------------------------------------------
function release_vehicle(vehicle)
	if (isElement(vehicle)) then
		if (is_strobo_enabled) then
			setVehicleOverrideLights ( vehicle, 0)
			setVehicleLightState ( vehicle, 0,  1 )
			setVehicleLightState ( vehicle, 1,  1 )
			setVehicleLightState ( vehicle, 2,  1 )
			setVehicleLightState ( vehicle, 3,  1 )
		end
	end
	if (vehicles[vehicle]~=nil) then	
		-- release the markers
		for key, value in pairs(vehicles[vehicle]["flist"]) do
			destroyElement (value["m"])
		end
		
		vehicles[vehicle] = nil
	end
	if (timers[vehicle]~=nil) then
		-- kill the strobo timer
		killTimer(timers[vehicle])
		timers[vehicle] = nil
		
		if (isElement(vehicle)) then
			if (getElementData( vehicle, "emerlights_source")==getPlayerName(getLocalPlayer())) then
				triggerEvent ( "onPlayerEmergencyLightStateChange", getRootElement(), 0 )
			end
		end
	end
end

function checkForAbility(vehicle)
	local veh_model = getElementModel ( vehicle )
	if (car_lights_table[veh_model]==nil)or(getElementData( vehicle, "emerlights_enabled" )=="false") then
		return false
	end
	return true
end

function strobo_state_update (vehicle)
	-- check for valid vehicle
	if (isElement(vehicle)) then
		if (vehicles[vehicle]==nil) then
			-- check for disallowing to use lights
			-- its enabled by default
			if (checkForAbility(vehicle)==false) then
				release_vehicle(vehicle)
				return
			end
			local veh_model = getElementModel ( vehicle )
			
			--if (car_lights_table[veh_model]==nil) then
			--veh_model = "default"
			--end
			
			local occupant = getVehicleOccupant( vehicle, 0)
			if (getElementType(occupant)=="player") then	-- peds also can use emerlights
				local src = getPlayerName(occupant)
				setElementData( vehicle, "emerlights_source", src, false)
				if (src==getPlayerName(getLocalPlayer())) then
					triggerEvent ( "onPlayerEmergencyLightStateChange", getRootElement(), 1 )
				end
			end
			-- init state variable
			
			vehicles[vehicle] = {}
			vehicles[vehicle]["lstate"] = 0 	-- strobo lights state
			vehicles[vehicle]["fstate"] = 0	-- flash light state
			vehicles[vehicle]["flist"] = {}		-- flash lights list (marker ids)
			
			-- create flash lights

			
			local mode = car_lights_table[veh_model]["mode"]
			if (mode==nil) then
				mode = "lamp"
			end
			
			local coeff = 0
			if (mode=="lamp") then
				coeff = 3.141592654/10.0
			else
				coeff = blink_interval/20.0
			end
			
			vehicles[vehicle]["fmode"] = mode
			
			for light_id, light_desc in pairs(car_lights_table[veh_model]) do
				if (light_id~="mode") then
					vehicles[vehicle]["flist"][light_id] = {}
					vehicles[vehicle]["flist"][light_id]["m"] = createMarker( 0.0001, 0.0001, 0.0001, "corona", light_desc["size"], light_desc["color"][1], light_desc["color"][2], light_desc["color"][3], 100)
					vehicles[vehicle]["flist"][light_id]["p"] = light_desc["phase"]*coeff
					attachElements ( vehicles[vehicle]["flist"][light_id]["m"], vehicle, light_desc["pos"][1], light_desc["pos"][2], light_desc["pos"][3] )
				end
			end
				
		end
		
		-- strobo light
		if (is_strobo_enabled) then
			setVehicleOverrideLights ( vehicle, 2)
			if (vehicles[vehicle]["lstate"]<strobo_interval) then
				setVehicleLightState ( vehicle, 0,  1 )
				setVehicleLightState ( vehicle, 1,  0 )
				setVehicleLightState ( vehicle, 2,  0 )
				setVehicleLightState ( vehicle, 3,  1 )	
			else
				setVehicleLightState ( vehicle, 0,  0 )
				setVehicleLightState ( vehicle, 1,  1 )
				setVehicleLightState ( vehicle, 2,  1 )
				setVehicleLightState ( vehicle, 3,  0 )	 
			end
			if (vehicles[vehicle]["lstate"]>=strobo_interval*2) then
				vehicles[vehicle]["lstate"] = 0
			else
				vehicles[vehicle]["lstate"] = vehicles[vehicle]["lstate"] + 1
			end
		end
		-- flash light
		if (vehicles[vehicle]["fmode"]=="lamp") then
		-- lamp mode
			local tmp_fstate = vehicles[vehicle]["fstate"]
			for key, value in pairs(vehicles[vehicle]["flist"]) do
				local R, G, B, A = getMarkerColor( value["m"] )
				setMarkerColor(value["m"], R, G, B, (math.sin(tmp_fstate+value["p"])+1.0)*128.0)
			end
			
			vehicles[vehicle]["fstate"] = vehicles[vehicle]["fstate"] + flash_interval
			
		else
		-- led mode
			local tmp_fstate = vehicles[vehicle]["fstate"]

			for key, value in pairs(vehicles[vehicle]["flist"]) do
				local R, G, B, A = getMarkerColor(value["m"])
				-- blinking mode
				local tmp_val = tmp_fstate+value["p"]
				if (tmp_val>blink_interval) then
					tmp_val = tmp_val - blink_interval
				end
				if ((tmp_val>=0)and(tmp_val<blink_duration))or((tmp_val>=blink_duration+1)and(tmp_val<blink_duration*2+1)) then
					setMarkerColor(value["m"], R, G, B, 255)
				else
					setMarkerColor(value["m"], R, G, B, 0)
				end
			end		
			vehicles[vehicle]["fstate"] = vehicles[vehicle]["fstate"] + 1
			if (vehicles[vehicle]["fstate"]>blink_interval) then
				vehicles[vehicle]["fstate"] = vehicles[vehicle]["fstate"] - blink_interval
			end
		end
	else
		-- if vehicle is no more exists
		release_vehicle(vehicle)
	end
end

-- not used anymore
function stroboLightOn()
    playerVehicle = getPedOccupiedVehicle ( getLocalPlayer()  )  -- get the player's vehicle

	--setElementData( playerVehicle, "emerlights_enabled", "true" )	-- debug
	
    if ( playerVehicle ) then
		-- if player is not a driver
		if (getLocalPlayer()~=getVehicleOccupant( playerVehicle )) then
			--outputChatBox("you're not a driver!")
			return
		end
		
		setStroboLightsOn(playerVehicle, nil)
    end
end

function isStroboLightsOn (vehicle_id)
	if (timers[vehicle_id]) then
		return 1
	else
		return 0
	end
end

function setStroboLightsOn(vehicle_id, value)
    if ( vehicle_id ) then
		if (value==nil) then
			if (isStroboLightsOn(vehicle_id)==1) then
				value = 0
			else
				value = 1
			end;
		end;
		if (value==0) then
			if (timers[vehicle_id]) then
				release_vehicle(vehicle_id)
				end
		end
		if (value==1) then
			if (timers[vehicle_id]) then
				release_vehicle(vehicle_id)
			end
			-- create strobo timer
			timers[vehicle_id] = setTimer ( strobo_state_update, base_freq, 0,  vehicle_id )
		end
    end
end

-- only local effect
function enableStroboLightsMode(source, value)
	if (value=="0")or(value=="false") then
		is_strobo_enabled = false
		outputConsole("Stroboscopic mode disabled")
	else
		if (value=="1")or(value=="true") then
			is_strobo_enabled = true
			outputConsole("Stroboscopic mode enabled")
		else
			outputConsole("Usage: strobo 0 or strobo 1  for disable/enable stroboscopic lights mode")
		end
	end
end
addCommandHandler("strobo", enableStroboLightsMode)

-- triggered by server
function setEmerlightsState(value, state)
	local player = getPlayerFromName ( value )
	local vehicle = getPedOccupiedVehicle(player)
	if (vehicle) then
		setStroboLightsOn(vehicle, state)
	end
end
addEvent("setEmerlights", true)
addEventHandler("setEmerlights", getRootElement(), setEmerlightsState)

function requestEmerlights()
	-- check for driver
    playerVehicle = getPedOccupiedVehicle (getLocalPlayer())  -- get the player's vehicle

    if (playerVehicle) then
		-- if player is not a driver
		if (getLocalPlayer()~=getVehicleOccupant( playerVehicle )) then
			--outputChatBox("you're not a driver!")
			return
		end
		if (checkForAbility(playerVehicle)) then
			-- sync
			triggerServerEvent("requestEmerlightChangeState", getLocalPlayer(), 1-isStroboLightsOn(getPedOccupiedVehicle(getLocalPlayer())))
		else
			-- not able to use lights for this vehicle
				--outputChatBox("unknown car!")
		end
    end

end

addCommandHandler("Strobo Light On", requestEmerlights)--stroboLightOn)
bindKey("h", "down", "Strobo Light On")

addEvent("onPlayerEmergencyLightStateChange")
