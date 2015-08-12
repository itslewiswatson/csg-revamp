
p_lights = {}
p_timer = {}
p_lvar = {}
p_pvar = {}
p_lvar2 = {}
p_lvar3 = {}
p_lvar4 = {}



function toggleLights(thePlayer, cmd, level)
	local level = tonumber(level)
	if not(level) then outputChatBox("#FF0000 Please select a level![1-2]", thePlayer, 255, 255, 255, true) return end
	--if(level < 1) or (level > 0) then outputChatBox("#FF0000 Please select a level between 1-2!", thePlayer, 255, 255, 255, true) return end
	local veh = getPedOccupiedVehicle(thePlayer)
	local id = getElementModel(veh)
	if (id == 482) or (id == 598) or (id == 596) or (id == 597) or (id == 579) or (id == 599) or (id == 428) or (id == 490) then
		if(level == 1) then
			if(p_lights[veh] == 0) or(p_lights[veh] == nil) then
				p_pvar[veh] = 1
				p_lights[veh] = 1
				outputChatBox("#FFFFFFYour Police-lights has been #00FF00enabled.", thePlayer, 0, 200, 100, true)
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
					p_lights[veh] = 0
					outputChatBox("#FFFFFFYour Police-lights has been #00FF00disabled.", thePlayer, 0, 200, 100, true)
					killTimer(p_timer[veh])
					setVehicleLightState ( veh, 0, 0)
					setVehicleLightState ( veh, 1, 0)
					setVehicleLightState ( veh, 2, 0)
					setVehicleLightState ( veh, 3, 0)	
					setVehicleHeadLightColor(veh, 255, 255, 255)
					setVehicleOverrideLights ( veh, 1 )
				end
			elseif(level == 2) then
				if(p_lights[veh] == 0) or(p_lights[veh] == nil) then
				p_lights[veh] = 1
				outputChatBox("#FFFFFFYour Police-lights has been #00FF00enabled.", thePlayer, 0, 200, 100, true)
				setVehicleOverrideLights ( veh, 2 )
				p_timer[veh] = setTimer(
				function()
					if(p_lvar3[veh] == 4) then
						setTimer(function() p_lvar3[veh] = 0 end, 1000, 1)
						setTimer(
						function()
							if(p_lvar4[veh] == 1)then
								p_lvar4[veh] = 0
								-- 0 = vorne links 1 = vorne rechts 2 = hinten links 3 = hinten rechts
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
						-- 0 = vorne links 1 = vorne rechts 2 = hinten links 3 = hinten rechts
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
					p_lights[veh] = 0
					outputChatBox("#FFFFFFYour Police-lights has been #00FF00disabled.", thePlayer, 0, 200, 100, true)
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
addCommandHandler("flashing", toggleLights)



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