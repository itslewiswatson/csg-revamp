-----------------------------------
------------ Settings -------------
-----------------------------------

--Type command with which you want to oppen window/panel

CommandOfMenu = "navypanel"


--Type TEAM Name, who would be able to open it.
RestrictedToTeam = "Navy"

-----------------------------------
-----------------------------------
-----------------------------------


--function which it check if player is in correct team
function isPlayerInTeam( source, team)
	local playerTeam = getPlayerTeam ( source )
    if ( playerTeam ) then
        local TeamName = getTeamName ( playerTeam )
		if (TeamName == team) then
			return true
		end
    end
   return false
end	

--created doors of navy
CARRIER_LIFT2_SFSE_2 = createObject ( 3114, -1456.5080664063, 482.84861748047, 16.705319519043, 0, 0, 179.99450683594 )
CARRIER_LIFT2_SFSE_3 = createObject ( 3114, -1308.5531005859, 482.84861748047, 16.705319519043, 0, 0, 179.99450683594 )
Carrier_lift_1_qel = createObject ( 3115, -1456.49609375, 501.30001831055, 16.938274383545, 0, 0, 0 )
CARRIER_LIFT2_SFSE1 = createObject ( 3114, -1414.4638671875, 515.9921875, 16.674160003662, 0, 0, 0 )
CARRIER_DOOR_1 = createObject ( 3113, -1465.6452636719, 501.30853271484, 1.0700000524521, 0, 0, 0 )


--window of navy
function navy_windonw_open ( source, command )
	if((isPlayerInTeam(source, RestrictedToTeam)) or "smith" == exports.server:getPlayerAccountName(source) or "Navy" == getElementData(source,"Group")) then
		triggerClientEvent (source,"navy_open",source)
	end			
end
addCommandHandler( CommandOfMenu, navy_windonw_open )


--main door
function open_door ()
	moveObject ( CARRIER_DOOR_1, 3113, -1468.6633300781, 501.27752685547, 11.512248039246, 0, 0, 0)
	if isTimer (auto_close_door) then killTimer (auto_close_door) end
	auto_close_door = setTimer ( moveObject, 10000, 1, CARRIER_DOOR_1, 3113, -1465.6452636719, 501.30853271484, 1.0700000524521, 0, 0, 0)
end
addEvent ("open_door",true)
addEventHandler ("open_door",getRootElement(),open_door)



function close_door ()
		moveObject ( CARRIER_DOOR_1, 3113, -1465.6452636719, 501.30853271484, 1.0700000524521, 0, 0, 0)
end
addEvent ("close_door",true)

addEventHandler ("close_door",getRootElement(),close_door)


--lift 1
function down_1_lift ()
	moveObject ( Carrier_lift_1_qel, 3115, -1456.4488525391, 501.1985168457, 9.8966484069824, 0, 0, 0)			
	if isTimer (auto_lift1) then killTimer (auto_lift1) end
	auto_lift1 = setTimer ( moveObject, 10000, 1, Carrier_lift_1_qel, 3115, -1456.49609375, 501.30001831055, 16.938274383545, 0, 0, 0)
end
addEvent ("down_1_lift",true)

addEventHandler ("down_1_lift",getRootElement(),down_1_lift)



function up_1_lift()
		moveObject ( Carrier_lift_1_qel, 3115, -1456.49609375, 501.30001831055, 16.938274383545, 0, 0, 0)
end
addEvent ("up_1_lift",true)

addEventHandler ("up_1_lift",getRootElement(),up_1_lift)


--lift 2
function down_2_lift ()
	moveObject ( CARRIER_LIFT2_SFSE1, 3114, -1414.4796142578, 515.4140625, 9.6400451660156, 0, 0, 0)			
	if isTimer (auto_lift2) then killTimer (auto_lift2) end
	auto_lift2 = setTimer ( moveObject, 10000, 1, CARRIER_LIFT2_SFSE1, 3114, -1414.4638671875, 515.9921875, 16.674160003662, 0, 0, 0)
end
addEvent ("down_2_lift",true)

addEventHandler ("down_2_lift",getRootElement(),down_2_lift)



function up_2_lift()
		moveObject ( CARRIER_LIFT2_SFSE1, 3114, -1414.4638671875, 515.9921875, 16.674160003662, 0, 0, 0)
end
addEvent ("up_2_lift",true)
addEventHandler ("up_2_lift",getRootElement(),up_2_lift)


--lift 3
function down_3_lift ()
	moveObject ( CARRIER_LIFT2_SFSE_2, 3114, -1456.5680664063, 482.84861748047, 5.6403102874756, 0, 0, 0)			
	if isTimer (auto_lift3) then killTimer (auto_lift3) end
	auto_lift3 = setTimer ( moveObject, 10000, 1, CARRIER_LIFT2_SFSE_2, 3114, -1456.5680664063, 482.84861748047, 16.705319519043, 0, 0, 0)
end
addEvent ("down_3_lift",true)
addEventHandler ("down_3_lift",getRootElement(),down_3_lift)



function up_3_lift()
	moveObject ( CARRIER_LIFT2_SFSE_2 ,3114, -1456.5680664063, 482.84861748047, 16.705319519043, 0, 0, 0)
end
addEvent ("up_3_lift",true)
addEventHandler ("up_3_lift",getRootElement(),up_3_lift)



    


-----------------------------------------------------------------
------------- Air Force Telefort to interiot --------------------
-----------------------------------------------------------------
local SFPD = createMarker( -1294, 491, 10, 'cylinder', 3, 0, 0, 0, 0 )
local SF = createMarker( -1278, 507, 3.5, 'cylinder', 3, 0, 0, 0, 0  )

function MarkerHit( hitPlayer, matchingDimension )
setElementPosition ( hitPlayer, -1278, 503.5, 4 )
end
addEventHandler( "onMarkerHit", SFPD, MarkerHit )


function MarkerHit1( hitPlayer, matchingDimension )
setElementPosition ( hitPlayer, -1299, 491, 11)
end
addEventHandler( "onMarkerHit", SF, MarkerHit1 )


	
	
	