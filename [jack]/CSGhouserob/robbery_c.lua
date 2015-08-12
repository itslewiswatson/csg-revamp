houseRobTable = {
{2077.62, -965.61, 53.88},
{2259.56, -1019.3, 59.29},
{2429.03, -1011.13, 54.34},
{2591.46, -1072.72, 69.83},
{2525.53, -1641.17, 14.35},
{2521.6, -1687.91, 13.61},
{2247.43, -1810.04, 13.55},
{1931.61, -1906.53, 15.02},
{1934.28, -1896.45, 15.03},
{1850.1, -1914.27, 15.25},
{920.24, -1817.36, 13.3},
{260.59, -1765.55, 4.75},
{808.28, -759.46, 76.53},
{950.56, -705.33, 122.21},
{1342.1, -629.76, 109.13}
}

-------------------------------------
houseRob = false

function onResourceStart()
	setTimer(triggerRobbableHouse, 20000,0,localPlayer)
end
addEventHandler("onClientResourceStart",resourceRoot,onResourceStart)

function triggerRobbableHouse(player)
	if (player) then
		if (getPlayerTeam(player) == getTeamFromName("Criminals")) then
			if (houseRob == false) then
				local randomHouse = math.random(1,#houseRobTable)
				if randomHouse then
					robMarker = createMarker(houseRobTable[randomHouse][1],houseRobTable[randomHouse][2],houseRobTable[randomHouse][3]-1,"cylinder",2,255,0,0)
					robMarkerBlip = createBlipAttachedTo(robMarker,32,2,0,0,0,255,0,99999)
					exports.DENdxmsg:createNewDxMessage("A owner left a house unlocked, go rob the house!",255,0,0)
					setTimer(function() exports.DENdxmsg:createNewDxMessage("Head to the red house blip to rob the house.",255,0,0) end,1000,1)
					houseRob = true
					--outputDebugString("Creating house rob for player: "..getPlayerName(player))
				end
			end
		elseif not(getPlayerTeam(player) == getTeamFromName("Criminals")) then
			if (houseRob == true) then
				destroyElement(robMarker)
				destroyElement(robMarkerBlip)
				houseRob = false
			end
		end
	end
end

function secondMessage(message)
	exports.DENdxmsg:createNewDxMessage(message,255,0,0)
end

function robMarkerHit(hitElement,matchingDimension)
	if (hitElement == localPlayer) and (source == robMarker) and not(isPlayerInVehicle(hitElement)) then
		houseRobbed = math.random(1,3)
		if (houseRobbed == 1) or (houseRobbed == 3) then
			winnedCash = math.random(200,1000)
			fadeCamera(false,1.0)
			setTimer(fadeCamera,2500,1,true,1.0)
			exports.CSGscore:givePlayerScore(localPlayer,0.25)
			exports.DENdxmsg:createNewDxMessage("House robbed, you managed to find $"..exports.server:convertNumber(winnedCash),0,255,0)
			exports.DENdxmsg:createNewDxMessage("Earned +0.25 Score",0,255,0)
			destroyElement(robMarker)
			destroyElement(robMarkerBlip)
			houseRob = false
			luck = math.random(1,4)
			if (luck == 1) then
				triggerServerEvent("givePlayerHouseRobEarnings",localPlayer,winnedCash,true)
			else
				triggerServerEvent("givePlayerHouseRobEarnings",localPlayer,winnedCash,false)
			end
		else
			fadeCamera(false,1.0)
			setTimer(fadeCamera,2500,1,true,1.0)
			exports.DENdxmsg:createNewDxMessage("The owner returned home early and caught you, you took a beating..",255,0,0)
			destroyElement(robMarker)
			destroyElement(robMarkerBlip)
			houseRob = false
			setElementHealth(localPlayer,getElementHealth(localPlayer)-5)
			callCops = math.random(1,2)
			if (callCops == 2) then
				triggerServerEvent("givePlayerHouseRobEarnings",localPlayer,0,true)--don't give him cash, but wanted level..
			end
		end
	end
end
addEventHandler("onClientMarkerHit",root,robMarkerHit)
