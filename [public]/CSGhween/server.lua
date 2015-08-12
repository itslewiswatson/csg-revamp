local skin1Marker = createMarker(225, -1845.55, 2.41, 'cylinder', 2.0, 218, 24, 24, 150 )
local skin2Marker = createMarker(230, -1845.55, 2.41, 'cylinder', 2.0, 218, 24, 24, 150 )
local skin3Marker = createMarker(235, -1845.55, 2.41, 'cylinder', 2.0, 218, 24, 24, 150 )
 
function skin1MarkerHit( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement) then
		setPlayerSkin( hitElement, 7)		
  end
end
addEventHandler( "onMarkerHit", skin1Marker , skin1MarkerHit ) 

function skin2MarkerHit( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement) then
		setPlayerSkin( hitElement, 10)		
  end
end
addEventHandler( "onMarkerHit", skin2Marker , skin2MarkerHit ) 

function skin3MarkerHit( hitElement, matchingDimension )
    if getElementType( hitElement ) == "player" and not isPedInVehicle(hitElement) then
		setPlayerSkin( hitElement, 11)		
  end
end
addEventHandler( "onMarkerHit", skin3Marker , skin3MarkerHit ) 