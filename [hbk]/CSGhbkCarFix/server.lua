
function repair (veh, player, accName)
fixVehicle (veh)
outputChatBox ("You have successfully repaired your vehicle", player, 0, 250, 0)
exports.dendxmsg:createNewDxMessage (player, "Get some rest before trying to fix your car again.", 250, 250, 0)
setElementData (player, "repairing", false)
ticks[accName] = getTickCount ()
setElementFrozen (player, false)
toggleControl (player, "fire", true)
toggleControl (player, "aim_weapon", true)
toggleControl (player, "enter_exit", true)

end

ticks = {}

function bindings (name)
local player = getPlayerFromName(name)
bindKey (player, "mouse2", "up", repairTrigger)
accName = exports.server:getPlayerAccountName(player)
if (ticks[accName] == nil) then
	ticks[accName] = getTickCount() - 100000
else return end
end
addEventHandler ("onPlayerConnect", root, bindings)

function bindings2 ()
players = getElementsByType ("player")
for k,v in pairs (players) do
	bindKey (v, "mouse2", "up", repairTrigger)
	accName = exports.server:getPlayerAccountName(v)
	if (ticks[accName] == nil) then
		ticks[accName] = getTickCount() - 100000
	else return end
end
end
addEventHandler ("onResourceStart", root, bindings2)

function repairTrigger (player)
local x, y, z = getElementPosition (player)
local col = createColSphere (x, y, z, 3)
local vehicles = getElementsWithinColShape(col,"vehicle")
local accName = exports.server:getPlayerAccountName(player)
local slot = getPedWeaponSlot (player)
local WP = getPlayerWantedLevel (player)
if isElement(col) then destroyElement(col) end

if (getElementData (player, "repairing") ~= true) and (WP == 0) and (slot == 0) and (not isPedInVehicle (player)) and ((ticks[accName] == nil) or (getTickCount() - ticks[accName] >= 100000)) then
	for k,v in pairs (vehicles) do
		if (getElementHealth (v) >= 800 and getElementHealth (v) <= 950) and (getElementData(v,"vehicleOwner") == player) then


			setTimer (repair, 5700, 1, v, player, accName)
			setElementData (player, "repairing", true)
			triggerClientEvent ("onRepair", player)
			setElementFrozen (player, true)
			toggleControl (player, "fire", false)
			toggleControl (player, "aim_weapon", false)
			toggleControl (player, "enter_exit", false)
			ticks[accName] = getTickCount ()
		elseif (getElementHealth (v) < 800) then
			exports.dendxmsg:createNewDxMessage (player, "You can only manually fix your car if it has more than 80% health", 250, 0, 0)
		elseif (getElementData(v,"vehicleOwner") ~= player) then
			exports.dendxmsg:createNewDxMessage (player, "You can only manually fix your own car.", 250, 0, 0)
		else return end
	end
--elseif (WP ~= 0) then
--	exports.dendxmsg:createNewDxMessage (player, "You can't fix your vehicle when wanted.", 250, 0, 0)
--elseif (ticks[accName]) and (getTickCount() - ticks[accName] < 100000) then

else return end
if isElement(col) then destroyElement (col) end
end
addCommandHandler ("fix", repairTrigger)

