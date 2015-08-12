------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGfbiinterior/server (server-side)
--  FBI Interior (LVPD)
--  [CSG]Smith
------------------------------------------------------------------------------------
--[[ DISABLED. NEW TELEPORTERS IN [BASES]/CSGTELEPORTERS

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

local enterMarker = createMarker( 204.899,-1856.399,5.199, 'arrow', 1.5, 255, 255, 0, 150 )
local enterMarkerRoof = createMarker( 204.85, -1848.53, 5.63, 'arrow', 1.5, 255, 255, 0, 150 )
local exitMarkerDown = createMarker( 238.61, 138.90, 1003.59, 'arrow', 1.5, 255, 255, 0, 150  )
setElementInterior ( exitMarkerDown, 3)
setElementDimension( exitMarkerDown, 4)
local exitMarkerRoof = createMarker( 218.64, -1819.88, 10, 'arrow', 1.5, 255, 255, 0, 150  )
local enterMarkerBase = createMarker( 211.14, -1829.42, 10, 'arrow', 1.5, 255, 255, 0, 150 )
local exitMarkerBase = createMarker( 209.46, -1829.53, 10, 'arrow', 1.5, 255, 255, 0, 150 )
local enterMarkerBaseRoof = createMarker( 189.3, -1872.1, 4.2 , 'arrow', 1.5, 255, 255, 0, 150 )
local exitMarkerBaseRoof = createMarker( 206.77, -1869.45, 5.3, 'arrow', 1.5, 255, 255, 0, 150 )


function enterMarkerBase2( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
		if( (isPlayerInTeam(hitPlayer, "Staff")) or (isPlayerInTeam(hitPlayer, "Military Forces")) or (isPlayerInTeam(hitPlayer, "SWAT")) or (isPlayerInTeam(hitPlayer, "Government Agency")) or (getElementData(hitPlayer,"Group") == "FBI")) then
			setElementPosition ( hitPlayer,  207.02, -1866.48, 4.74)
		end
end
addEventHandler( "onMarkerHit", enterMarkerBaseRoof, enterMarkerBase2 )

function exitMarkerBase2( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
		setElementPosition ( hitPlayer, 189.29, -1874.36, 3.6)
end
addEventHandler( "onMarkerHit",exitMarkerBaseRoof, exitMarkerBase2 )




function enterMarkerBase1( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
		if( (isPlayerInTeam(hitPlayer, "Staff")) or (isPlayerInTeam(hitPlayer, "Military Forces")) or (isPlayerInTeam(hitPlayer, "SWAT")) or (isPlayerInTeam(hitPlayer, "Government Agency")) or (getElementData(hitPlayer,"Group") == "FBI")) then
			setElementPosition ( hitPlayer,  205.85, -1829.17,10)
		end
end
addEventHandler( "onMarkerHit", enterMarkerBase, enterMarkerBase1 )

function exitMarkerBase1( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
		setElementPosition ( hitPlayer, 214.1, -1828.73, 10)
end
addEventHandler( "onMarkerHit",exitMarkerBase, exitMarkerBase1 )


function exitPlayerDown( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
			if (getElementDimension(hitPlayer) == 4) then
				setElementPosition ( hitPlayer, 209.699,-1856.3,5.199)
				setElementInterior ( hitPlayer, 0)
				setElementDimension( hitPlayer, 0)
			end
end
addEventHandler( "onMarkerHit",exitMarkerDown, exitPlayerDown )

function exitPlayerRoof( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
		setElementPosition ( hitPlayer,   207.47, -1848.43, 5)
end
addEventHandler( "onMarkerHit",exitMarkerRoof, exitPlayerRoof )


function enterPlayerInt( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
			setElementPosition ( hitPlayer, 238.5, 141.4, 1003.6 )
			setElementInterior ( hitPlayer, 3)
			setElementDimension( hitPlayer, 4)
end
addEventHandler( "onMarkerHit", enterMarker, enterPlayerInt )

function enterPlayerRoof( hitPlayer, matchingDimension )
	if( getElementType( hitPlayer ) ~= "player" ) then return end
		if( (isPlayerInTeam(hitPlayer, "Staff")) or (isPlayerInTeam(hitPlayer, "Military Forces")) or (isPlayerInTeam(hitPlayer, "SWAT")) or (isPlayerInTeam(hitPlayer, "Government Agency")) or (getElementData(hitPlayer,"Group") == "FBI")) then
			setElementPosition ( hitPlayer,  218.34, -1824.64, 9.6 )
		end
end
addEventHandler( "onMarkerHit", enterMarkerRoof, enterPlayerRoof )
--]]
