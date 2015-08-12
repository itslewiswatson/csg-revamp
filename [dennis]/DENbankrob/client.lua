local topKillerLaw = {}
local topKillerCrim = {}

local criminalCount = 0
local lawCount = 0

-- Disable teamkill
addEventHandler( "onClientPlayerDamage", root,
function ( theAttacker )
	if ( isElement( source ) ) and ( isElement( theAttacker ) ) then -- moeten ook nog player zijn he
		if ( getElementType(theAttacker) == "player" ) then
			if ( getPlayerTeam( source ) ) and ( getPlayerTeam( theAttacker ) ) then
				if ( getElementData ( source, "isPlayerRobbing" ) ) then
					if ( getTeamName( getPlayerTeam( theAttacker ) ) == "Criminals" ) and ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) or ( getTeamName( getPlayerTeam( source ) ) == "Paramedics" ) then
						cancelEvent()
					elseif ( getTeamName( getPlayerTeam( theAttacker ) ) == "Paramedics" ) then
						if ( getTeamName( getPlayerTeam( source ) ) == "Criminals" ) or ( getTeamName( getPlayerTeam( source ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( source ) ) == "Police" ) or ( getTeamName( getPlayerTeam( source ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( source ) ) == "Government Agency" ) or ( getTeamName( getPlayerTeam( source ) ) == "Paramedics" ) then
							cancelEvent()
						end
					else
						if ( getTeamName( getPlayerTeam( theAttacker ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( theAttacker ) ) == "Police" ) or ( getTeamName( getPlayerTeam( theAttacker ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( theAttacker ) ) == "Government Agency" ) then
							if ( getTeamName( getPlayerTeam( source ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( source ) ) == "Police" ) or ( getTeamName( getPlayerTeam( source ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( source ) ) == "Government Agency" ) or ( getTeamName( getPlayerTeam( source ) ) == "Paramedics" ) then
								cancelEvent()
							end
						end
					end
				end
			end
		end
	end
end
)

-- Disable projectiles in bank
addEventHandler( "onClientProjectileCreation", localPlayer,
function ( creator )
	if ( getElementData ( localPlayer, "isPlayerRobbing" ) ) then
		if ( getProjectileType( source ) == 16 ) or ( getProjectileType( source ) == 17 ) or ( getProjectileType( source ) == 18 ) or ( getProjectileType( source ) == 39 ) then

			if ( creator == localPlayer ) then
				exports.DENdxmsg:createNewDxMessage( "Its not allowed to use projectiles inside the bankrob!", 225, 0, 0 )
			end

			destroyElement( source )
		end
	end
end
)

-- Disable bombs
addEventHandler("onClientExplosion", localPlayer,
function( x, y, z, theType)
	if ( getElementData ( localPlayer, "isPlayerRobbing" ) ) then
		if ( theType == 0 ) or ( theType == 1 ) then
			cancelEvent()
		end
	end
end
)

-- Set the bankrob stats enabled or disabled
addEvent( "onToggleBankrobStats", true )
addEventHandler( "onToggleBankrobStats", localPlayer,
	function ( state )
		if ( state ) then
			addEventHandler( "onClientRender", root, onDrawBankrobStats )
		else
			removeEventHandler( "onClientRender", root, onDrawBankrobStats )
		end
	end
)

-- Reset the counters for everyone
addEvent( "onResetBankrobStats", true )
addEventHandler( "onResetBankrobStats", localPlayer,
	function ()
		topKillerLaw = {}
		topKillerCrim = {}
		criminalCount = 0
		lawCount = 0
		removeEventHandler( "onClientRender", root, onDrawBankrobStats )
	end
)

-- On count change
addEvent( "onChangeCount", true )
addEventHandler( "onChangeCount", root,
	function ( lawCounts, crimCounts )
		if ( crimCounts ) then
			criminalCount = crimCounts
		end

		if ( lawCounts ) then
			lawCount = lawCounts
		end
	end
)

-- Get the top killers
function getTopKillersBankrob ()
	local C1, C2, C3, C4, C5, L1, L2, L3, L4, L5 = "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet", "Noone yet",

	table.sort( topKillerLaw )
	table.sort( topKillerCrim )

	local i1 = 1

	for thePlayer, theKills in pairs ( topKillerLaw ) do
		if ( isElement( thePlayer ) ) then
			if ( i1 >= 5 ) then
				break;
			else
				if ( i1 == 1 ) then
					L1 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 2 ) then
					L2 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 3 ) then
					L3 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 4 ) then
					L4 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				elseif ( i1 == 5 ) then
					L5 = getPlayerName( thePlayer ).." ("..theKills..")"
					i1 = i1 + 1
				end
			end
		else
			topKillerLaw[thePlayer] = {}
		end
	end

	local i2 = 1

	for thePlayer, theKills in pairs ( topKillerCrim ) do
		if ( isElement( thePlayer ) ) then
			if ( i2 >= 5 ) then
				break;
			else
				if ( i2 == 1 ) then
					C1 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 2 ) then
					C2 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 3 ) then
					C3 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 4 ) then
					C4 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				elseif ( i2 == 5 ) then
					C5 = getPlayerName( thePlayer ).." ("..theKills..")"
					i2 = i2 + 1
				end
			end
		else
			topKillerCrim[thePlayer] = {}
		end
	end

	return C1, C2, C3, C4, C5, L1, L2, L3, L4, L5
end

-- Insert into top list when player kills a player
addEventHandler( "onClientPlayerWasted", root,
	function ( theKiller, weapon, bodypart )
		if ( isElement( theKiller ) ) and ( getPlayerTeam( theKiller ) ) then
			if ( getElementData( theKiller, "isPlayerRobbing" ) ) then
				if ( getTeamName( getPlayerTeam( theKiller ) ) == "Criminals" ) then
					if ( topKillerCrim[theKiller] ) then
						topKillerCrim[theKiller] = topKillerCrim[theKiller] +1
					else
						topKillerCrim[theKiller] = 1
					end
				elseif ( getTeamName( getPlayerTeam( theKiller ) ) == "Police" ) or ( getTeamName( getPlayerTeam( theKiller ) ) == "Government Agency" )  or ( getTeamName( getPlayerTeam( theKiller ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( theKiller ) ) == "Military Forces" ) then
					if ( topKillerLaw[theKiller] ) then
						topKillerLaw[theKiller] = topKillerLaw[theKiller] +1
					else
						topKillerLaw[theKiller] = 1
					end
				end
			end
		end
	end
)

-- Bankrob stats
local sx, sy = guiGetScreenSize()

function onDrawBankrobStats ()
	C1, C2, C3, C4, C5, L1, L2, L3, L4, L5 = getTopKillersBankrob ()
	-- Rectangle
	dxDrawRectangle(sx*(1121.0/1440),sy*(205.0/900),sx*(248.0/1440),sy*(257.0/900),tocolor(0,0,0,100),false)
	-- Top killers Law
	dxDrawText("5. "..L5,sx*(1125.0/1440),sy*(393.0/900),sx*(1359.0/1440),sy*(407.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("4. "..L4,sx*(1125.0/1440),sy*(380.0/900),sx*(1359.0/1440),sy*(394.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("3. "..L3,sx*(1125.0/1440),sy*(368.0/900),sx*(1359.0/1440),sy*(382.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("2. "..L2,sx*(1125.0/1440),sy*(354.0/900),sx*(1359.0/1440),sy*(368.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("1. "..L1,sx*(1125.0/1440),sy*(341.0/900),sx*(1359.0/1440),sy*(355.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
    dxDrawText("Top killers: (Law)",sx*(1125.0/1440),sy*(318.0/900),sx*(1357.0/1440),sy*(336.0/900),tocolor(0,0,225,225),1.2,"default-bold","left","top",false,false,false)
	-- Top killer Crim
	dxDrawText("5. "..C5,sx*(1125.0/1440),sy*(293.0/900),sx*(1359.0/1440),sy*(307.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("4. "..C4,sx*(1125.0/1440),sy*(279.0/900),sx*(1359.0/1440),sy*(293.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("3. "..C3,sx*(1125.0/1440),sy*(265.0/900),sx*(1359.0/1440),sy*(279.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("2. "..C2,sx*(1125.0/1440),sy*(251.0/900),sx*(1359.0/1440),sy*(265.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
	dxDrawText("1. "..C1,sx*(1125.0/1440),sy*(235.0/900),sx*(1359.0/1440),sy*(249.0/900),tocolor(255,255,255,255),0.9,"clear","left","top",false,false,false)
    dxDrawText("Top killers: (Criminals)",sx*(1125.0/1440),sy*(209.0/900),sx*(1357.0/1440),sy*(227.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	-- Totals
	dxDrawText("Cops: "..lawCount,sx*(1125.0/1440),sy*(433.0/900),sx*(1357.0/1440),sy*(451.0/900),tocolor(0,0,225,225),1.2,"default-bold","left","top",false,false,false)
    dxDrawText("Criminals: "..criminalCount,sx*(1125.0/1440),sy*(413.0/900),sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
end
