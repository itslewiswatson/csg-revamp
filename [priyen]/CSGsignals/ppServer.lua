local sirenTimers = {}

local valids = {
	596,597,598,599,523,601,427,415,426,428,490
}

function isValidTeam(t)
	if t == "Police" or t == "SWAT" or t == "Military Forces" or t == "Government Agency" or t == "Paramedics" then
		return true
	else
		return false
	end
end

function isValidVeh(veh)
	if isElement(veh) == true then
		if getElementType(veh) == "vehicle" then
		else
			return false
		end
	else
		return false
	end
	local m = getElementModel(veh)
	for k,v in pairs(valids) do if m == v then
		local name = getElementData(veh,"vehicleTeam")
		if name == false then return false end
		if isValidTeam(name) == false then
			return false
		else
			return true
		end
		end
	end
	return false
end


p_lights = {}
p_timer = {}
p_lvar = {}
p_pvar = {}
p_lvar2 = {}
p_lvar3 = {}
p_lvar4 = {}


function toggleLights(ps)
	setTimer(toggleLights2,1000,1,ps)
end

function toggleLights2(thePlayer, cmd, level)
    local level = 1
	local veh = getPedOccupiedVehicle(thePlayer)
    if isValidVeh(veh) == true then
        if(level == 1) then
            if(p_lights[veh] == 0) or(p_lights[veh] == nil) then
				if getVehicleSirensOn(veh) == false then return end
                p_pvar[veh] = 1
                p_lights[veh] = 1
				setVehicleOverrideLights ( veh, 2 )
                p_timer[veh] = setTimer(
                function()
                    if(p_lvar[veh] == 0) or (p_lvar[veh] == nil) then
                        p_lvar[veh] = 1
                        setVehicleLightState ( veh, 1, 0)
                        setVehicleLightState ( veh, 2, 0)
                        setVehicleLightState ( veh, 0, 1)
                        setVehicleLightState ( veh, 3, 1)
                        setVehicleHeadLightColor(veh, 0, 0, 255)
                    else
                        setVehicleLightState ( veh, 3, 0)
                        setVehicleLightState ( veh, 0, 0)
                        setVehicleLightState ( veh, 1, 1)
                        setVehicleLightState ( veh, 2, 1)
                        setVehicleHeadLightColor(veh, 255, 0, 0)
                        p_lvar[veh] = 0
                    end
                end, 500, 0)
                else
					if getVehicleSirensOn(veh) == true then return end
					p_lights[veh] = 0
                    killTimer(p_timer[veh])
                    setVehicleLightState ( veh, 0, 0)
                    setVehicleLightState ( veh, 1, 0)
                    setVehicleLightState ( veh, 2, 0)
                    setVehicleLightState ( veh, 3, 0)
                    setVehicleHeadLightColor(veh, 255, 255, 255)
                    setVehicleOverrideLights ( veh, 0 )
                end
            elseif(level == 2) then
                if(p_lights[veh] == 0) or(p_lights[veh] == nil) then
                p_lights[veh] = 1
				if getVehicleSirensOn(veh) == false then return end
                setVehicleOverrideLights ( veh, 2 )
                p_timer[veh] = setTimer(
                function()
                    if(p_lvar3[veh] == 4) then
                        setTimer(function() p_lvar3[veh] = 0 end, 1000, 1)
                        setTimer(
                        function()
                            if(p_lvar4[veh] == 1)then
                                p_lvar4[veh] = 0
                                setVehicleLightState ( veh, 1, 0)
                                setVehicleLightState ( veh, 2, 0)
                                setVehicleLightState ( veh, 0, 1)
                                setVehicleLightState ( veh, 3, 1)
                                setVehicleHeadLightColor(veh, 77, 77, 255)
                            else
                                setVehicleLightState ( veh, 3, 0)
                              setVehicleLightState ( veh, 0, 0)
                                setVehicleLightState ( veh, 1, 1)
                                setVehicleLightState ( veh, 2, 1)
                                setVehicleHeadLightColor(veh, 255, 77, 77)
                                p_lvar4[veh] = 1
                            end
                        end, 50, 5)
                    return end
                    if(p_lvar2[veh] == 0) or (p_lvar2[veh] == nil) then
                        p_lvar2[veh] = 1
                        setVehicleLightState ( veh, 1, 0)
                        setVehicleLightState ( veh, 2, 0)
                        setVehicleLightState ( veh, 0, 1)
                        setVehicleLightState ( veh, 3, 1)
                        setVehicleHeadLightColor(veh, 0, 0, 255)
                    else
                        setVehicleLightState ( veh, 3, 0)
                        setVehicleLightState ( veh, 0, 0)
                        setVehicleLightState ( veh, 1, 1)
                        setVehicleLightState ( veh, 2, 1)
                        setVehicleHeadLightColor(veh, 255, 0, 0)
                        p_lvar2[veh] = 0
                    end
                    if(p_lvar3[veh] == nil) then p_lvar3[veh] = 0  end
                    p_lvar3[veh] = (p_lvar3[veh]+1)
                end, 500, 0)
                else
					if getVehicleSirensOn(veh) == true then return end
                    p_lights[veh] = 0
                   -- outputChatBox("#FFFFFFYour Police-lights has been #00FF00disabled.", thePlayer, 0, 200, 100, true)
                    killTimer(p_timer[veh])
                    setVehicleLightState ( veh, 0, 0)
                    setVehicleLightState ( veh, 1, 0)
                    setVehicleLightState ( veh, 2, 0)
                    setVehicleLightState ( veh, 3, 0)
                    setVehicleHeadLightColor(veh, 255, 255, 255)
                    setVehicleOverrideLights ( veh, 1 )
                end
                end
            end
end
addCommandHandler("lights", toggleLights)

for k,v in pairs(getElementsByType("player")) do
	bindKey(v,"h","down",toggleLights)
end

addEventHandler("onPlayerLogin",root,function() bindKey(source,"h","down",toggleLights) end)



addEventHandler ( "onVehicleExplode", getRootElement(),
function()
    if(p_lights[source] == 1) then
        killTimer(p_timer[source])
    end
end )

addEventHandler ( "onVehicleRespawn", getRootElement(),
function()
    if(p_lights[source] == 1) then
        killTimer(p_timer[source])
    end
end )

addEventHandler("onElementDestroy", getRootElement(),
function ()
    if getElementType(source) == "vehicle" then
        if(p_lights[source] == 1) then
            killTimer(p_timer[source])
        end
    end
end)

--[[
function toggleSiren(ps)
	if isPedInVehicle(ps) == true then
		local veh = getPedOccupiedVehicle(ps)
		if isValidVeh(veh) == true then
			if getPedOccupiedVehicleSeat(ps) == 0 then
				if getVehicleSirensOn(veh) == true then
					if sirenTimers[veh] == nil then
						setTimer(function()
							local r,g,b = getVehicleHeadLightColor(veh)
							if r == 255 then
								r,g,b=0,0,255
								setVehicleHeadLightColor(veh,r,g,b)
							else
								r,g,b=255,0,0
								setVehicleHeadLightColor(veh,r,g,b)
							end
						end,1000,0)
					end
				else

				end
			end
		end
	end
end
addCommandHandler("ts",toggleSiren)


addCommandHandler("addsir",function(ps)
	local veh = getPedOccupiedVehicle(ps)
	addVehicleSirens(veh,1,1)
      setVehicleSirens(veh,1,0,0,5,100,0,100)
end)
--]]
