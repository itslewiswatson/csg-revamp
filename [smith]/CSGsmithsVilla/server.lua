garageDoor = createObject ( 9823, 964.70, -1953.10, 3.90, 0, 180, 16 )
--garageMarker = createMarker( 964.70, -1953.10, 0, 'cylinder', 10, 255, 255, 0, 100 )
garageColCuboid = createColCuboid (938.70,-1960.10,3, 45,20, 4.7)

addEventHandler ("onColShapeHit", garageColCuboid,
function( hitElement, matchingDimension )
	if not matchingDimension then return end
	if "smith" == exports.server:getPlayerAccountName(hitElement) then	
		moveObject ( garageDoor, 9823, 964.70, -1953.10, 5.20, 0, -90, 0)			
		--if isTimer (auto_lift1) then killTimer (auto_lift1) end
		--auto_lift1 = setTimer ( moveObject, 10000, 1, garageDoor, 9823, 964.70, -1953.10, 3.90, 0, 0, 16)
	end
end)

addEventHandler ("onColShapeLeave", garageColCuboid, 
	function( hitElement, matchingDimension )
	if not matchingDimension then return end
	if "smith" == exports.server:getPlayerAccountName(hitElement) then
		moveObject ( garageDoor, 9823, 964.70, -1953.10, 3.90, 0, 90, 0)
	end	
end)

function SetPlayertoInterior( hitPlayer, matchingDimension )
	if "smith" == exports.server:getPlayerAccountName(hitPlayer) then
		moveObject ( garageDoor, 9823, 964.70, -1953.10, 5.20, 0, -90, 0)			
		--if isTimer (auto_lift1) then killTimer (auto_lift1) end
		--auto_lift1 = setTimer ( moveObject, 10000, 1, garageDoor, 9823, 964.70, -1953.10, 3.90, 0, 0, 16)
	end
end
addEventHandler( "onMarkerHit",garageMarker, SetPlayertoInterior )


function SetPlayertoExit( hitPlayer, matchingDimension )
	if "smith" == exports.server:getPlayerAccountName(hitPlayer) then
		moveObject ( garageDoor, 9823, 964.70, -1953.10, 3.90, 0, 90, 0)
	end
end
addEventHandler( "onMarkerLeave", garageMarker, SetPlayertoExit )
