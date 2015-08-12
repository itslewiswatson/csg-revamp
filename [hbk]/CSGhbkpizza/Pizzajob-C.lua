markersPosition = {
{ 2498 , -1684, 12 },
{ 2442 , -1303, 22 },
{ 2555 , -1192, 60 },
{ 2504 , -1028, 69 },
{ 2243 , -1238, 24 },
{ 2246 , -1904, 12 },
{ 1983 , -1728, 14 },
{ 1569 , -1882, 12 },
{ 1351 , -1750, 12 },
{ 982 , -1771, 13 },
{ 895 , -1524, 12 },
{ 860 , -1527, 12 },
{ 1185 , -1266, 14 },
{ 1276 , -1060, 28 },
{ 1423 , -920, 35 },
{ 961 , -919, 44 },
{ 335 , -1349, 13 },
{ 165 , -1771, 3 },

}

local ms = {}

local tick
local totalTime
local remainingTime
local locTimer=false
local pizzas = 0
local resourcesMarker = createMarker(2098.2185058594, -1797.8568115234, 12, "cylinder", 1.5, 255, 150, 0)

function convertTime (ms)
	local min = tostring(math.floor(ms/60000))
	local sec = tostring(math.floor((ms/1000)%60))
	if (#sec == 1) then
		sec = "0"..sec
	end
	return min, sec
end

function getNewLocation()
	if (isElement(marker) or isElement(blip) or isElement(rblip)) then return end
	exports.DENdxmsg:createNewDxMessage("A new location has been marked in your map! Deliver the pizza on time.", 0, 255, 0)
	local num = math.random(#markersPosition)
	local px, py, pz = getElementPosition(localPlayer)
	distance = math.floor(getDistanceBetweenPoints3D(markersPosition[num][1], markersPosition[num][2], markersPosition[num][3], px, py, pz))
	if (distance < 30) then
		getNewLocation()
		return
	end
	marker = createMarker(markersPosition[num][1], markersPosition[num][2], markersPosition[num][3], "cylinder", 2, 255, 100, 0)
	blip = createBlipAttachedTo(marker, 31)
	tick = getTickCount()
	table.insert(ms,{marker,blip})
	totalTime = (( distance / 10) * 1000)
	--addEventHandler("onClientRender", root, drawCountdown)
	addEventHandler("onClientMarkerHit", marker, getPositionsOnMarkerHit)
end

function getPositionsOnVehicleJobTake(veh)
	if (pizzas == 0) then
		pizzas = 5
	end
	if (isElement(veh)) then
		local id = getElementModel(veh)
		if (id == 448) then
			setTimer(getNewLocation, 1000, 1)
		end
	end
end
addEvent("onClientJobVehicleGet", true)
addEventHandler("onClientJobVehicleGet", root, getPositionsOnVehicleJobTake)

function getPositionsOnVehicleEnter(player)
	if (player == localPlayer and pizzas == 0 and getElementModel(source) == 448) then
		if (not isElement(rblip)) then
			exports.DENdxmsg:createNewDxMessage("Go Pizza shop and hit marker to get some Pizza for delivery", 255, 255, 0)
			rblip = createBlipAttachedTo(resourcesMarker, 48)
		end
	end
end
addEventHandler("onClientVehicleEnter", root, getPositionsOnVehicleEnter)

function getPositionsOnMarkerHit(hitElement)
	if (hitElement and getElementType(hitElement) == "player" and hitElement == localPlayer) then
		local vehicle = getPedOccupiedVehicle(hitElement)
		if (not isElement(vehicle)) then
			return
		end
		local id = getElementModel(vehicle)
		if (id == 448) then
			if (pizzas > 0) then
				local finishTick = getTickCount()
				local remainingTime = (totalTime - (finishTick - tick))
				local bonusTime = (20 * 1000)
				pizzas = pizzas - 1
				for k,v in pairs(ms) do
					if v[1] == marker then
						table.remove(ms,k)
						break
					end
				end
				setElementVelocity(vehicle, 0, 0, 0)
				triggerServerEvent("CSGpizza.pay", localPlayer, distance, remainingTime >= bonusTime)
				removeEventHandler("onClientRender", root, drawCountdown)
				destroyElement(marker)
				destroyElement(blip)
				if (pizzas == 0) then
					exports.DENdxmsg:createNewDxMessage("You don't have anymore pizzas to deliver, go back to the station to get more", 0, 255, 0)
					rblip = createBlipAttachedTo(resourcesMarker, 48)
				else
					if (isElement(marker) and isElement(blip) and isElement(rblip)) then return end
					setTimer(getNewLocation, 1500, 1, localPlayer)
				end
			end
		end
	end
end

function FailedDelivery()
	exports.DENdxmsg:createNewDxMessage("Your time is over, you haven't delivered the pizza on time", 0, 255, 0)
	destroyElement(marker)
	destroyElement(blip)
	setTimer(getNewLocation, 1500, 1, localPlayer)
end

function drawCountdown()
	local endTick = getTickCount ( )
	if ( endTick - tick <= totalTime ) then
		local mins, secs = convertTime ( totalTime - endTick + tick )
	else
		removeEventHandler("onClientRender", root, drawCountdown)
		--setTimer(FailedDelivery, 100, 1)
	end
end

local cr=false
setElementAlpha(resourcesMarker,0)

function refitPizzas(hitElement)
	if cr==false then return end
 	if (isElement(marker) and isElement(blip)) then return end
	if (isElement(rblip)) then
		if (isElement(hitElement) and hitElement == localPlayer) then

			local vehicle = getPedOccupiedVehicle(localPlayer)
			if (not vehicle) then exports.DENdxmsg:createNewDxMessage("Refill Pizza Marker: You must be in a Pizza Bike to get some pizza to deleiver",255,0,0) return end
			local id = getElementModel(vehicle)
			if (id == 448) then
				pizzas = 5
				destroyElement(rblip)
				locTimer = setTimer(getNewLocation, 2000, 1, localPlayer)
			end
		end
	end
end
addEventHandler("onClientMarkerHit", resourcesMarker, refitPizzas)


addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if oldJob == "Pizza Boy" then
		setElementAlpha(resourcesMarker,0)
		if isElement(rblip) then destroyElement(rblip) end
		if isTimer(locTimer) then killTimer(locTimer) end
		if isElement(blip) then destroyElement(blip) end
		if isElement(marker) then destroyElement(marker) end
		for k,v in pairs(ms) do
			if isElement(v[1]) then destroyElement(v[1]) end
			if isElement(v[2]) then destroyElement(v[2]) end
		end
		pizzas=0
		cr=false
		removeEventHandler("onClientRender",root,drawText)
	elseif nJob == "Pizza Boy" then
		cr=true
		setElementAlpha(resourcesMarker,100)
		addEventHandler("onClientRender",root,drawText)
	end
end
addEventHandler("onPlayerJobChange",localPlayer,jobChange)

addEvent("csgpizzalogin",true)
addEventHandler("csgpizzalogin",localPlayer,function()
	if getElementData(localPlayer,"Occupation") == "Pizza Boy" and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		cr=true
		setElementAlpha(resourcesMarker,100)
	end
end)

addEventHandler("onClientPlayerWasted",localPlayer,function()
	if isTimer(locTimer) then killTimer(locTimer) end
	if isElement(blip) then destroyElement(blip) end
	if isElement(marker) then destroyElement(marker) end
	for k,v in pairs(ms) do
			if isElement(v[1]) then destroyElement(v[1]) end
			if isElement(v[2]) then destroyElement(v[2]) end
		end
		pizzas=0
end)
screenWidth,screenHeight = guiGetScreenSize()
function drawText()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (vehicle) then
		if getElementModel(vehicle) == 448 then
			else
			return
		end
	else
		return
	end

	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Pizza's Left: #33FF33"..pizzas.."", screenWidth*0.08, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )

end

