------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGbarriers/server (server-side)
--  Barrier(s) Script
--  [CSG]Smith
------------------------------------------------------------------------------------
function outputChat(thePlayer,text,r,g,b)
	exports.CSGsmithsDx:addTextNotification(thePlayer,tostring(text),tonumber(r),tonumber(g),tonumber(b))
end

function isPlayerInTeam(src, TeamName)
	if src and isElement ( src ) and getElementType ( src ) == "player" then
		local team = getPlayerTeam(src)
		if team then
			if getTeamName(team) == TeamName then
				return true
			else
				return false
			end
		end
	end
end

barrier1 = {}
barrier2 = {}
barrier3 = {}
barrier4 = {}


function Law_Barrier1 ( thePlayer )
	if( (isPlayerInTeam(thePlayer, "Staff")) or (isPlayerInTeam(thePlayer, "Military Forces")) or (isPlayerInTeam(thePlayer, "SWAT")) or (isPlayerInTeam(thePlayer, "Government Agency"))) then
		if isPedInVehicle ( thePlayer ) then return false end
		if ( not isPedOnGround ( thePlayer ) ) then return false	end
		if barrier1[thePlayer] and isElement(barrier1[thePlayer]) then
			destroyElement(barrier1[thePlayer])
		end
		local x,y,z = getElementPosition(thePlayer)
		local rx,ry,rz = getElementRotation (thePlayer)
		barrier1[thePlayer] = createObject( 1459,x,y,z-0.6,rx,ry,rz + 90)
		setElementData(barrier1[thePlayer],"barrier",true)
		triggerClientEvent("prevent_break_able_",getRootElement(),barrier1[thePlayer])
		outputChat(thePlayer,"Successfuly added 'Barrier 1'",0,255,0)
		setElementFrozen ( barrier1[thePlayer], true )
	end
end
addCommandHandler( "barrier1", Law_Barrier1 )

function Law_Barrier2 ( thePlayer )
	if( (isPlayerInTeam(thePlayer, "Staff")) or (isPlayerInTeam(thePlayer, "Military Forces")) or (isPlayerInTeam(thePlayer, "SWAT")) or (isPlayerInTeam(thePlayer, "Government Agency"))) then
		if isPedInVehicle ( thePlayer ) then return false end
		if ( not isPedOnGround ( thePlayer ) ) then return false	end
		if barrier2[thePlayer] and isElement(barrier2[thePlayer]) then
			destroyElement(barrier2[thePlayer])
		end
		local x,y,z = getElementPosition(thePlayer)
		local rx,ry,rz = getElementRotation (thePlayer)
		barrier2[thePlayer] = createObject( 1459,x,y,z-0.6,rx,ry,rz + 90)
		setElementData(barrier2[thePlayer],"barrier",true)
		triggerClientEvent("prevent_break_able_",getRootElement(),barrier2[thePlayer])
		outputChat(thePlayer,"Successfuly added 'Barrier 2'",0,255,0)
		setElementFrozen ( barrier2[thePlayer], true )
	end
end
addCommandHandler( "barrier2", Law_Barrier2 )

function Law_Barrier3 ( thePlayer )
	if( (isPlayerInTeam(thePlayer, "Staff")) or (isPlayerInTeam(thePlayer, "Military Forces")) or (isPlayerInTeam(thePlayer, "SWAT")) or (isPlayerInTeam(thePlayer, "Government Agency"))) then
		if isPedInVehicle ( thePlayer ) then return false end
		if ( not isPedOnGround ( thePlayer ) ) then return false	end
		if barrier3[thePlayer] and isElement(barrier3[thePlayer]) then
			destroyElement(barrier3[thePlayer])
		end
		local x,y,z = getElementPosition(thePlayer)
		local rx,ry,rz = getElementRotation (thePlayer)
		barrier3[thePlayer] = createObject( 1423,x,y,z-0.2,rx,ry,rz + 90)
		setElementData(barrier3[thePlayer],"barrier",true)
		triggerClientEvent("prevent_break_able_",getRootElement(),barrier3[thePlayer])
		outputChat(thePlayer,"Successfuly added 'Barrier 3",0,255,0)
		setElementFrozen ( barrier3[thePlayer], true )
	end
end
addCommandHandler( "barrier3", Law_Barrier3 )

function Law_Barrier4 ( thePlayer )
	if( (isPlayerInTeam(thePlayer, "Staff")) or (isPlayerInTeam(thePlayer, "Military Forces")) or (isPlayerInTeam(thePlayer, "SWAT")) or (isPlayerInTeam(thePlayer, "Government Agency"))) then
		if isPedInVehicle ( thePlayer ) then return false end
		if ( not isPedOnGround ( thePlayer ) ) then return false	end
		if barrier4[thePlayer] and isElement(barrier4[thePlayer]) then
			destroyElement(barrier4[thePlayer])
		end
		local x,y,z = getElementPosition(thePlayer)
		local rx,ry,rz = getElementRotation (thePlayer)
		barrier4[thePlayer] = createObject( 1423,x,y,z-0.2,rx,ry,rz + 90)
		setElementData(barrier4[thePlayer],"barrier",true)
		triggerClientEvent("prevent_break_able_",getRootElement(),barrier4[thePlayer])
		outputChat(thePlayer,"Successfuly added 'Barrier 4",0,255,0)
		setElementFrozen ( barrier4[thePlayer], true )
	end
end
addCommandHandler( "barrier4", Law_Barrier4 )


function Destroy_All_Barriers( thePlayer )
	if( (isPlayerInTeam(thePlayer, "Staff")) or (isPlayerInTeam(thePlayer, "Military Forces")) or (isPlayerInTeam(thePlayer, "SWAT")) or (isPlayerInTeam(thePlayer, "Government Agency"))) then
		if barrier1[thePlayer] and isElement(barrier1[thePlayer]) then
			destroyElement(barrier1[thePlayer])
		end
		if barrier2[thePlayer] and isElement(barrier2[thePlayer]) then
			destroyElement(barrier2[thePlayer])
		end
		if barrier3[thePlayer] and isElement(barrier3[thePlayer]) then
			destroyElement(barrier3[thePlayer])
		end
		if barrier4[thePlayer] and isElement(barrier4[thePlayer]) then
			destroyElement(barrier4[thePlayer])
		end
		outputChat(thePlayer,"All your barriers has been removed",0,255,0)
	end
end
addCommandHandler( "removeall", Destroy_All_Barriers )
addCommandHandler( "destroyall", Destroy_All_Barriers )



function player_Wasted ()
	if( (isPlayerInTeam(source, "Staff")) or (isPlayerInTeam(source, "Military Forces")) or (isPlayerInTeam(source, "SWAT")) or (isPlayerInTeam(source, "Government Agency"))) then
		if barrier1[source] and isElement(barrier1[source]) then
			destroyElement(barrier1[source])
		end
		if barrier2[source] and isElement(barrier2[source]) then
			destroyElement(barrier2[source])
		end
		if barrier3[source] and isElement(barrier3[source]) then
			destroyElement(barrier3[source])
		end
		if barrier4[source] and isElement(barrier4[source]) then
			destroyElement(barrier4[source])
		end
	end
end
addEventHandler ( "onPlayerWasted", getRootElement(), player_Wasted )

addEventHandler( "onPlayerQuit", getRootElement(),
function()
	if( (isPlayerInTeam(source, "Staff")) or (isPlayerInTeam(source, "Military Forces")) or (isPlayerInTeam(source, "SWAT")) or (isPlayerInTeam(source, "Government Agency"))) then
		if barrier1[source] and isElement(barrier1[source]) then
			destroyElement(barrier1[source])
		end
		if barrier2[source] and isElement(barrier2[source]) then
			destroyElement(barrier2[source])
		end
		if barrier3[source] and isElement(barrier3[source]) then
			destroyElement(barrier3[source])
		end
		if barrier4[source] and isElement(barrier4[source]) then
			destroyElement(barrier4[source])
		end
	end
end
)

