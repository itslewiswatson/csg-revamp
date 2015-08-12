createPickup ( 245.19, -1816.03, 5.06, 2, 10, 0 )
createPickup ( 255.73, -1824.67, 4.66, 2, 11, 0 )
createPickup ( 294.44, -1823.15, 12.42, 2, 12, 0 )
createPickup ( 295.81, -1821.58, 12.42, 2, 14, 0 )

local freeVehicle = { 
[1]={205.15, -1843.12, 3.55},
[2]={232.19, -1789.37, 4.31},
[3]={251.73, -1870.66, 2.33}
}

local playerVehicle = {}

local randomBike = {
[1]={522},
[2]={468},
[3]={521},
[4]={581},
[5]={461}
}

function giveFreeVehicle (hitElement)
	if getElementType(hitElement) == "player" and not isPedInVehicle(hitElement) then
		if playerVehicle[hitElement] then destroyElement(playerVehicle[hitElement]) end
		local x, y, z = getElementPosition(source)
		local bike = randomBike[math.random(1,5)][1]
		playerVehicle[hitElement] = createVehicle(bike, x, y, z + 2)
		warpPedIntoVehicle(hitElement, playerVehicle[hitElement])
	end
end

for ID in pairs(freeVehicle) do 
		local x, y, z = freeVehicle[ID][1], freeVehicle[ID][2], freeVehicle[ID][3]
		local theMarker = createMarker ( x, y, z -1, "cylinder", 1.5, 255, 0, 0, 170 )
		addEventHandler("onMarkerHit", theMarker, giveFreeVehicle)
end