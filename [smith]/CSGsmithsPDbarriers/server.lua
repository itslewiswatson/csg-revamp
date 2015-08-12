
function isPlayerInTeam(player, team)
	local playerTeam = getPlayerTeam ( player )
    if ( playerTeam ) then
        local TeamName = getTeamName ( playerTeam )
		if (TeamName == team) then
			return true
		end
    end
  return false
end


--LS_Gate_Object = createObject (968, 1544.6877441406, -1630.8345947266, 13.029567718506, 180, 90, 90)
--LS_Gate_Marker = createMarker ( 1544.6877441406, -1628.0345947266, 10.029567718506, "cylinder" , 8 ,255,255,0,0)
LV_Gate_Object = createObject ( 968, 2238.2143554688, 2450.3972167969, 10.629767417908, 0, 90, 90 )
LV_Gate_Marker = createMarker ( 2238.2143554688, 2453.3972167969, 7.629767417908, "cylinder", 5,0,0,0,0)

function LV_MarkerHit( thePlayer, matchingDimension )
	if( getElementType( thePlayer ) ~= "player" ) then return end
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
		if theVehicle then
			if getPedOccupiedVehicleSeat ( thePlayer ) == 0 then
				local rx,ry,rz = getElementRotation(LV_Gate_Object)
				if ry ~= 90 then
					setElementRotation(LV_Gate_Object,0,90,90)
					ry = -90
				else
					setElementRotation(LV_Gate_Object,0,90,90)
					ry = -90
				end
				moveObject ( LV_Gate_Object, 900, 2238.2143554688, 2450.3972167969, 10.629767417908, 0, ry, 0, "OutBounce",0.6,1,2)
			end
		end
end
addEventHandler( "onMarkerHit", LV_Gate_Marker, LV_MarkerHit )

function LV_MarkerLeave( thePlayer, matchingDimension )
	if( getElementType( thePlayer ) ~= "player" ) then return end
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
		if theVehicle then	
			if getPedOccupiedVehicleSeat ( thePlayer ) == 0 then
				local rx,ry,rz = getElementRotation(LV_Gate_Object)
				if ry ~= 0 then
					setElementRotation(LV_Gate_Object,0,0,90)
					ry = 90
				else
					setElementRotation(LV_Gate_Object,0,0,90)
					ry = 90
				end
				moveObject ( LV_Gate_Object, 900, 2238.2143554688, 2450.3972167969, 10.629767417908, 0, ry, 0,"OutBounce",0.3,0.6,2)
			end
		end
end
addEventHandler( "onMarkerLeave",LV_Gate_Marker, LV_MarkerLeave )


--[[function LS_MarkerHit( thePlayer, matchingDimension )
		local rx,ry,rz = getElementRotation(LS_Gate_Object)
		local ry = 180 - ry
		if ry > 180 then
			ry = ry - 180
		end
		moveObject ( LS_Gate_Object, 900, 1544.6877441406, -1630.8345947266, 13.029567718506, 0, ry, 0, "OutBounce",0.6,1,2)
		
end
addEventHandler( "onMarkerHit", LS_Gate_Marker, LS_MarkerHit )

function LS_MarkerLeave( thePlayer, matchingDimension )
		local rx,ry,rz = getElementRotation(LS_Gate_Object)
		local ry = 90 - ry
		if ry > 90 then
			ry = 90 - ry
		end
		moveObject ( LS_Gate_Object, 900, 1544.6877441406, -1630.8345947266, 13.029567718506, 0, ry, 0,"OutBounce",0.3,0.6,2)
end
addEventHandler( "onMarkerLeave",LS_Gate_Marker, LS_MarkerLeave )]]


--[[function LV_MarkerHit( thePlayer, matchingDimension )
	if( getElementType( thePlayer ) ~= "player" ) then return end
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
		if theVehicle then
			if getPedOccupiedVehicleSeat ( thePlayer ) == 0 then
				local rx,ry,rz = getElementRotation(LV_Gate_Object)
				if ry ~= 90 then
				else
					local ry = 0 - ry
					if ry > 90 or ry < 0 then
						setElementRotation(LV_Gate_Object,0,90,90)
						ry = -90
					end
					moveObject ( LV_Gate_Object, 900, 2238.2143554688, 2450.3972167969, 10.629767417908, 0, ry, 0, "OutBounce",0.6,1,2)
				end
			end
		end
end
addEventHandler( "onMarkerHit", LV_Gate_Marker, LV_MarkerHit )

function LV_MarkerLeave( thePlayer, matchingDimension )
	if( getElementType( thePlayer ) ~= "player" ) then return end
	local theVehicle = getPedOccupiedVehicle ( thePlayer )
		if theVehicle then	
			if getPedOccupiedVehicleSeat ( thePlayer ) == 0 then
				local rx,ry,rz = getElementRotation(LV_Gate_Object)
				if ry == 90 then
				else
					local ry = 180 - ry
					if ry < 90 or ry > 180 then
						setElementRotation(LV_Gate_Object,0,0,90)
						ry = 90
					end
					moveObject ( LV_Gate_Object, 900, 2238.2143554688, 2450.3972167969, 10.629767417908, 0, ry, 0,"OutBounce",0.3,0.6,2)
				end
			end
		end
end
addEventHandler( "onMarkerLeave",LV_Gate_Marker, LV_MarkerLeave )]]


