local banks = {-- name,                                        x   ,          y,              z,         min$      max$    Increase      balance$
[1] = {"Los Santos Bank in Downtown", 1470.35, -1177.03, 23.92, 5000, 12000, 80, 0},
[2] = {"Los Santos Bank in Rodeo", 595.55, -1250.59, 18.29,   3000, 10000, 70, 0},
[3] = {"San Fierro Bank in Financial",  -1814.39, 1078.63, 46.08,2000, 9000, 60, 0},
[4] = {"San Fierro Bank in King's", -2055.78, 455.79, 35.17,1000, 7000, 40, 0},

}
local bankManagerPos = {
[1] = {457.44, -2501.15, 58.43, 179},
[2] = {469.86, -2494.14, 58.44, 155},
[3] = {465.6, -2540.69, 64.24, 349},
[4] = {439.78, -2534.4, 70.04, 288},
[5] = {459.4, -2525.06, 70.04, 312},
[6] = {442.97, -2539.64, 70.04, 280},
}
local messages = {
[1] = {"Calm down, my code is: ", ""},
[2] = {"Don't shoot, don't shoot. My code is: ", ""},
[3] = {"Please, I have kids. Here is the code: ", ""},
[4] = {"Here's the code: ", ". I assume I get a share?"},
[5] = {"CALM DOWN, WOW!, my code is: ", ". GOD these robbers need anger management"},
}
local timers = { }
local alarmCheckTimers = { }
local bags = { }
function onStart ()
	for i=1,#banks do

		local bank = createMarker(banks[i][2], banks[i][3], banks[i][4] +1, "arrow", 1.5, 255, 128, 0 )--This marker represents the bank
			local blip = createBlipAttachedTo(bank, 52,2,255,0,0, 0, 255,500)
			setElementData(bank, "warpX", 475.52)
			setElementData(bank, "warpY", -2553.96)
			setElementData(bank, "warpZ", 52.63)
			setElementData(bank, "warpDim", i)
			setElementData(bank, "bankName", banks[i][1])
			setElementData(bank, "bankBlip", blip)
			banks[i][9] = bank
			local playersThatTookMoney = { }
			setElementData(bank, "playersThatTookMoney", playersThatTookMoney)
			addEventHandler("onMarkerHit", bank, warp)

			setElementData(bank, "isBankBeingRobbed", false)--Sec Door has been opened
			setElementData(bank, "isBankAlarmOn", false)--Cops have been warned
			setElementData(bank, "isBankOnStep1", false)-- Access Door has been opened
			setElementData(bank, "isBankOnStep2", false)--The Vault has been opened

		local interiorMarker = createMarker( 476.29, -2555.58, 52.63 +1, "arrow", 1.5, 255, 128, 0 )
			setElementDimension(interiorMarker, i)
			setElementData(interiorMarker, "warpX", banks[i][2])
			setElementData(interiorMarker, "warpY", banks[i][3])
			setElementData(interiorMarker, "warpZ", banks[i][4])
			setElementData(interiorMarker, "warpDim", 0)
			setElementData(interiorMarker, "bank", bank)
			addEventHandler("onMarkerHit", interiorMarker, warp)

		local secDoor = createObject (2949, 454.399, -2527.399, 63.299, 0,0,211)
			setElementDimension(secDoor, i)
			setElementData(bank, "bankSecDoor", secDoor)

		local accessDoor = createObject (3109, 477.70, -2526.69, 53, 0,0,210)
			setElementDimension(accessDoor, i)
			setElementData(bank, "bankAccessDoor", accessDoor)

		local vaultDoor = createObject (2634, 460.799, -2541.5, 40.70, 0,0,298)
			setElementDimension(vaultDoor, i)
			setElementData(bank, "bankVaultDoor", vaultDoor)

		local bankCashier = createPed(11, 460.95, -2529.32, 52.63)
			setElementDimension(bankCashier, i)
			setElementRotation(bankCashier, 0,0,212)
			setElementData(bankCashier, "isBankWorker", true)
			setElementData(bankCashier, "pedName", "Bank Cashier")
			setElementData(bankCashier, "bankCode", math.random(1000,9999))
			setElementData(bankCashier, "bank", bank)
			setElementData(bank, "bankCashier", bankCashier)

		local pos = math.random(1,#bankManagerPos)
		local bankManager = createPed(120, bankManagerPos[pos][1], bankManagerPos[pos][2], bankManagerPos[pos][3])
			setElementDimension(bankManager, i)
			setElementRotation(bankManager, 0,0,bankManagerPos[pos][4])
			setElementData(bankManager, "isBankWorker", true)
			setElementData(bankManager, "pedName", "Bank Manager")
			setElementData(bankManager, "bankCode", math.random(1000,9999))
			setElementData(bankManager, "bank", bank)
			setElementData(bank, "bankManager", bankManager)



	end
end
addEventHandler("onResourceStart", resourceRoot, onStart)


--++++++++++++++++++++++++++++++++--
------------------BANK BALANCE--------------
--++++++++++++++++++++++++++++++++--
function updateBalance ()
	if getPlayerCount() < 15 then return end
	for i=1, #banks do
		if getElementData(banks[i][9], "isBankBeingRobbed") then return end
		local minim = banks[i][5]
		local maxim = banks[i][6]
		local increase = banks[i][7]
		local currentBalance = banks[i][8]
		if currentBalance < minim or not currentBalance then currentBalance = minim end
		local newBalance = currentBalance + increase
		if newBalance > maxim then newBalance = maxim end
		banks[i][8] = newBalance
	end
end
setTimer(updateBalance,30000,0)
function showBalance ()
	for i=1, #banks do
		outputChatBox(banks[i][1]..": "..banks[i][8], source)
	end
end
addCommandHandler("balance", showBalance)


--++++++++++++++++++++++++++++++++--
----------------------WARPS---------------------
--++++++++++++++++++++++++++++++++--
function warp (hitElement, matchingDimension)
	if getElementType(hitElement) == "player"  and matchingDimension and not getPedOccupiedVehicle(hitElement) then
		local x, y, z, dim = getElementData(source,"warpX"),getElementData(source,"warpY"),getElementData(source,"warpZ"),getElementData(source,"warpDim")
		if dim == 0 then bank = getElementData(source, "bank") else bank = source end
		if getPlayerCount() < 15 then exports.DENdxmsg:createNewDxMessage(hitElement, "This bank is closed, please come back later.", 255,215,0) return end
		setElementDimension(hitElement, dim)
		setElementPosition(hitElement, x+1, y+1, z)
		if getElementData(hitElement, "br:bag") and isElement(getElementData(hitElement, "br:bag")) then setElementDimension(getElementData(hitElement, "br:bag"), dim) end
		setTimer(toggleStartTrigger, 1000, 1,hitElement, bank)
	end

end

function toggleStartTrigger(player, bank)--remove on kill/arrest
	if not getElementData(player, "isPlayerInsideBank") then
		setElementData(player, "bank", bank)
		setElementData(player, "isPlayerInsideBank", true)
		if getTeamName(getPlayerTeam(player)) == "Criminals" and not getElementData(player, "isPlayerRobbingBank") then addEventHandler("onPlayerTarget", player, triggerRob) end--Allow them to start/join the rob
		if getElementData(bank, "isBankAlarmOn") then setPedAnimation(getElementData(bank, "bankCashier"), "ped", "cower", -1, false) setPedAnimation(getElementData(bank, "bankManager"), "ped", "cower", -1, false)--Synchronize the peds
		elseif getElementData(bank, "isBankBeingRobbed") then setPedAnimation(getElementData(bank, "bankCashier"), "ped", "handsup", -1, false) setPedAnimation(getElementData(bank, "bankManager"), "ped", "handsup", -1, false)--Synchronize the peds
		end
	else
		removeEventHandler("onPlayerTarget", player, triggerRob)
		setElementData(player, "isPlayerInsideBank", false)
	end
end


--++++++++++++++++++++++++++++++++--
---------------START THE ROB-----------------
--++++++++++++++++++++++++++++++++--
function triggerRob (target)
	if target then
		local bank = getElementData(target, "bank")
		if not getElementData(source, "isPlayerRobbingBank") then
			setElementData(source, "isPlayerRobbingBank", true)
			if getElementData(bank, "isBankAlarmOn") then exports.CSGwanted:addWanted(source,28,false,x,y,z) end
		end
		if getPedWeaponSlot(source) ~= 0 and getElementData(target, "isBankWorker") and bank and not getElementData(bank, "isBankBeingRobbed") then
			setElementData(bank, "isBankBeingRobbed", true)
			timers[getElementData(bank, "warpDim")] = {setTimer(endRob, 15000,0 , bank)}
			setPedAnimation(target, "ped", "handsup", -1, false)
			moveObject(getElementData(bank, "bankSecDoor"),1000, 454.399, -2527.399, 63.299, 0,0,-90)
			alarmCheckTimers[getElementData(bank, "warpDim")] = {setTimer(alarmCheck, 1000, 0, source, target, bank)}
			triggerClientEvent("CSGbankrob:createSecMarker", bank, root)
			exports.DENdxmsg:createNewDxMessage(source, "You started robbing the bank. Get two security codes to open the door that leads to the vault!", 0,255,0)



		elseif getPedWeaponSlot(source) ~= 0 and getElementData(target, "isBankWorker") and getElementData(bank, "isBankBeingRobbed") and not getElementData(target, "spamTime") then
			sendPedMessage ( target )
			setElementData(target, "spamTime", true)
			setTimer(setElementData, 5000, 1, target, "spamTime", false)
		end
	end
end
function alarmCheck (player, target, bank)
	if getPedTarget(player) ~= target then
		local dim = getElementData(bank, "warpDim")
		killTimer(alarmCheckTimers[dim][1])
		local blip = getElementData(bank, "bankBlip")
		setBlipIcon(blip, 36)
		setBlipVisibleDistance(blip, 99999)
		setElementData(bank, "isBankAlarmOn", true)
		setPedAnimation(getElementData(bank, "bankCashier"), "ped", "cower", -1, false)
		setPedAnimation(getElementData(bank, "bankManager"), "ped", "cower", -1, false)
		--WARN COPS
		local players = getElementsByType("player")
		for i,v in ipairs(players) do
			if isPlayerLawEnforcer(v) then exports.DENdxmsg:createNewDxMessage(v, "Attention all units! The "..getElementData(bank, "bankName").." is being robbed, Please respond.", 0,0,255) end
		end
		-----------------------
		local x,y,z = banks[dim][2], banks[dim][3], banks[dim][4]
		exports.CSGwanted:addWanted(player,28,false,x,y,z)
		triggerClientEvent("CSGbankrob:startAlarm", root, bank)
	end
end
---------------------------------------------\
--+++++++++CLIENT+++++++++++++++>
---------------------------------------------/
function sendPedMessage ( ped )
	local posX, posY, posZ = getElementPosition ( ped )
	local chatSphere = createColSphere ( posX, posY, posZ, 50 )
	local nearbyPlayers = getElementsWithinColShape ( chatSphere, "player" )
	local messageID = math.random(1, #messages)
	local code = getElementData(ped, "bankCode")
	local strg = messages[messageID][1]..code..messages[messageID][2]
	destroyElement ( chatSphere )
		for index, nearbyPlayer in ipairs( nearbyPlayers ) do
			if getElementDimension(nearbyPlayer) == getElementDimension(ped) then outputChatBox( "#FFFF00"..getElementData(ped, "pedName")..": #FFFFFF".. strg, nearbyPlayer,255,255,255,true ) end
		end
end


--++++++++++++++++++++++++++++++++--
-----------------START STEP 1-----------------
--++++++++++++++++++++++++++++++++--


addEvent("CSGbankrob:openAccessDoor", true)
function openAccessDoor (bank)
		if isElement(getElementData(bank, "secMarker")) then destroyElement(getElementData(bank, "secMarker")) end
		moveObject(getElementData(bank, "bankAccessDoor"),1000, 477.70, -2526.69, 53,0,0,-90)
		local moneyMarker = createMarker( 460.39, -2545.15, 39.04,"cylinder", 2.5, 255, 0, 0)
		setElementDimension(moneyMarker,  getElementData (bank, "warpDim") )
		setElementData(bank, "isBankOnStep1", true)
		setElementData(bank, "moneyMarker", moneyMarker)
		local players = getElementsByType("player")
		for i,v in ipairs(players) do
			if getElementData(v, "isPlayerRobbingBank") then exports.DENdxmsg:createNewDxMessage(v, "The door that leads to the vault has been opened. Now, blow the vault door and get your money!", 0,255,0) end
		end
		addEventHandler("onMarkerHit", moneyMarker, pickMoney)
		addEventHandler("onMarkerLeave", moneyMarker, stopPickingMoney)
end
addEventHandler("CSGbankrob:openAccessDoor", root, openAccessDoor)


--++++++++++++++++++++++++++++++++--
-----------------START STEP 2-----------------
--++++++++++++++++++++++++++++++++--
addEvent("CSGbankrob:onVaultExplosion", true)
function onVaultExplosion()
	if isElement(source) then destroyElement(source) end
	setElementData(bank, "isBankOnStep2", true)
	local players = getElementsByType("player")
	for i,v in ipairs(players) do
		if getElementData(v, "isPlayerRobbingBank") then exports.DENdxmsg:createNewDxMessage(v, "The vault is open! Get the money from the safes!", 0,255,0) end
	end
end
addEventHandler("CSGbankrob:onVaultExplosion", root, onVaultExplosion)

function pickMoney (hitElement, matchingDimension)
	if getElementType(hitElement) == "player" and matchingDimension then
		local playersThatTookMoney = getElementData(getElementData(hitElement, "bank"), "playersThatTookMoney")
		for i,v in ipairs(playersThatTookMoney) do
			if v == hitElement then exports.DENdxmsg:createNewDxMessage(v, "You already got the money. Get out of here before you get arrested!", 0,255,0) return end
		end
		local x,y,z = getElementPosition(hitElement)
		local mx,my,mz = getElementPosition(source)
		local bank = getElementData(hitElement, "bank")
		if not (z-2 > mz) and not getElementData(hitElement, "bankrob:running") then
			if not getElementData(hitElement, "isPlayerRobbingBank") then
				setElementData(hitElement, "isPlayerRobbingBank", true)
				if getElementData(bank, "isBankAlarmOn") then exports.CSGwanted:addWanted(hitElement,28,false,x,y,z) end
			end
			triggerClientEvent("CSGbankrob:collectingMoney", hitElement, hitElement)
		end
	end
end
---------------------------------------------\
--+++++++++CLIENT+++++++++++++++>
---------------------------------------------/


function stopPickingMoney (hitElement)
	if getElementType(hitElement) == "player" and matchingDimension then
		triggerClientEvent("CSGbankrob:stopCollectingMoney", hitElement, hitElement)
	end
end
---------------------------------------------\
--+++++++++CLIENT+++++++++++++++>
---------------------------------------------/


addEvent("CSGbankrob:givebag", true)
function giveMoneyBag ()
	local bag = createObject(1550,0,0,0)
	setElementDimension(bag, getElementDimension(source))
	bags[#bags+1] = {source, bag}
	setElementDoubleSided(bag, true)
	exports.bone_attach:attachElementToBone(bag,source,3,0,-0.2,0,0,0,180)
	setElementData(source, "br:bag", bag)
	setElementCollisionsEnabled(bag, false)
	exports.DENdxmsg:createNewDxMessage(source, "You got the money, now get out of here before the police gets you.", 0,255,0)
end
addEventHandler("CSGbankrob:givebag", root, giveMoneyBag)


--++++++++++++++++++++++++++++++++--
----------END ROB FOR PLAYER--------------
--++++++++++++++++++++++++++++++++--
addEvent("CSGbankrob:robSuccess", true)
function robSuccess ()
	local bank = getElementData(source, "bank")
	local bag = getElementData(source, "br:bag")
	exports.bone_attach:detachElementFromBone(bag)
	destroyElement(bag)

	local playersThatTookMoney = getElementData(bank, "playersThatTookMoney")
	playersThatTookMoney[#playersThatTookMoney+1] = { source }
	setElementData(bank, "playersThatTookMoney", playersThatTookMoney)

	setElementData(source, "br:bag", false)
	local bankBalance = banks[getElementData(bank,"warpDim")][8]
	exports.CSGaccounts:addPlayerMoney(source, bankBalance)
	exports.CSGscore:givePlayerScore(source,10)
	exports.DENdxmsg:createNewDxMessage(source, "You successfully robbed the bank! ($"..bankBalance..") ", 0,255,0)
	setElementData(source, "bank", false)
end
addEventHandler("CSGbankrob:robSuccess", root, robSuccess)

addEvent("CSGbankrob:RobFailed", true)
function failedRoberry (player)
	if source then
		exports.bone_attach:detachElementFromBone(bag)
		destroyElement(source)
		setElementData(player, "br:bag", false)
		local bank = getElementData(player, "bank")
		setElementData(player, "bank", false)
		endRob(bank)
	end
end
addEventHandler("CSGbankrob:RobFailed", root, failedRoberry)

addEvent( "onPlayerArrest" )
addEventHandler( "onPlayerArrest", root,
	function ( theCop )
		if  getElementData(source, "isPlayerRobbingBank")  then
			triggerClientEvent("CSGbankrob:onArrest", source, source)
		end
	end
)


--++++++++++++++++++++++++++++++++--
--------------------END ROB --------------------
--++++++++++++++++++++++++++++++++--
function endRob(bank)
	if noMorePlayersRobbingBank(bank) then
		killTimer(timers[getElementData(bank, "warpDim")][1])
		setElementData(bank, "isBankBeingRobbed", false)
		setElementData(bank, "isBankAlarmOn", false)
		setElementData(bank, "isAccessDoorOpen", false)
		setElementData(bank, "isVaultOpen", false)
		local playersThatTookMoney = { }
		setElementData(bank, "playersThatTookMoney", playersThatTookMoney)
		banks[getElementData(bank,"warpDim")][8] = 0
		destroyElement(getElementData(bank, "bankSecDoor"))
		destroyElement(getElementData(bank, "bankAccessDoor"))
		local secDoor = createObject (2949, 454.399, -2527.399, 63.299, 0,0,211)
		local accessDoor = createObject (3109, 477.70, -2526.69, 53, 0,0,210)
		local vaultDoor = createObject (2634, 460.799, -2541.5, 40.70, 0,0,298)
		setElementDimension(secDoor, getElementData(bank, "warpDim"))
		setElementDimension(accessDoor, getElementData(bank, "warpDim"))
		setElementDimension(vaultDoor, getElementData(bank, "warpDim"))
		setElementData(bank, "bankSecDoor", secDoor)
		setElementData(bank, "bankAccessDoor", accessDoor)
		setElementData(bank, "bankVaultDoor", vaultDoor)


		local blip = getElementData(bank, "bankBlip")
		setBlipIcon(blip, 52)
		setBlipVisibleDistance(blip, 500)
		setPedAnimation(getElementData(bank, "bankCashier"))
		setElementData(getElementData(bank, "bankCashier"), "bankCode", math.random(1000,9999))
		setPedAnimation(getElementData(bank, "bankManager"))
		setElementData(getElementData(bank, "bankManager"), "bankCode", math.random(1000,9999))
		local pos = math.random(1,#bankManagerPos)
		setElementPosition(getElementData(bank, "bankManager"), bankManagerPos[pos][1], bankManagerPos[pos][2], bankManagerPos[pos][3])
		triggerClientEvent("CSGbankrob:endRob", bank, root)

	end
end
---------------------------------------------\
--+++++++++CLIENT+++++++++++++++>
---------------------------------------------/


function noMorePlayersRobbingBank (bank)
	local players = getElementsByType("player")
	for i, v in ipairs(players) do
		if getElementData(v, "isPlayerRobbingBank") and getElementData(v, "bank") == bank then return end
	end
	return true
end

---------------OTHER
function onPlayerQuit ()
	for i =1, #bags do
		if bags[i][1] == source and isElement(bags[i][2])then destroyElement(bags[i][2]) end
	end
end
addEventHandler("onPlayerQuit", root, onPlayerQuit)





local lawTeams = {
	"Police",
	"Military Forces",
	"SWAT",
	"Department of Defense",
}

function isPlayerLawEnforcer ( thePlayer )
	if ( isElement( thePlayer ) ) and ( getPlayerTeam ( thePlayer ) ) then
		for i=1,#lawTeams do
			if ( getTeamName( getPlayerTeam( thePlayer ) ) == lawTeams[i] ) then
				return true
			end
		end
		return false
	else
		return false
	end
end
