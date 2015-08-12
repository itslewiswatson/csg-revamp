function switchLights (thePlayer)
  if (isPedInVehicle (thePlayer)) then
    local veh = getPedOccupiedVehicle (thePlayer)
    if (getVehicleOverrideLights(veh) ~= 2) then
          setVehicleOverrideLights(veh, 2)
      exports.dendxmsg:createNewDxMessage ("Vehicle lights turned on.", thePlayer, 255, 0, 0)
    elseif (getVehicleOverrideLights(veh) ~= 1) then
      setVehicleOverrideLights(veh, 1)
      exports.dendxmsg:createNewDxMessage ("Vehicle lights turned off.", thePlayer, 255, 0, 0)
    end
  else
    exports.dendxmsg:createNewDxMessage ("You aren't in a vehicle!", thePlayer, 255, 0, 0)
  end
end
addCommandHandler("lights", switchLights)