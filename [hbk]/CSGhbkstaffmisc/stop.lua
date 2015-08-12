
function stop(key, keyState)
--if ( getElementDimension(getPedOccupiedVehicle(getLocalPlayer())) ~= 1 ) then
--if getElementModel(getLocalPlayer()) == 217 or getElementModel(getLocalPlayer()) == 211 then
local HD = exports.csgstaff:isPlayerStaff(getLocalPlayer())
if ( HD ) then
local vehicle = getPedOccupiedVehicle ( getLocalPlayer () )
if ( vehicle ) then
setElementVelocity ( vehicle, 0, 0, 0)
exports.DENdxmsg:createNewDxMessage ("Super Brake enabled", 255, 0, 0)

end
end

end
addCommandHandler("SBS",stop)
addCommandHandler("sbs",stop)
