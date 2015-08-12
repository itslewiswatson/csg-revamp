-- Disable bombs
addEventHandler("onClientExplosion", localPlayer,
function( x, y, z, theType)
	if ( getElementDimension(localPlayer) == 1 and getElementInterior(localPlayer) == 5 ) then
		if ( theType == 0 ) or ( theType == 1 ) then
			cancelEvent()
		end
	end
end
)
kills=0
peds=0
saying = "Guards Alive"
	topKillerLaw = {}
	topKillerCrim = {}
	criminalCount = 0
	lawCount = 0

-- Set the mansionraid stats enabled or disabled
addEvent( "onTogglemansionraidStats", true )
addEventHandler( "onTogglemansionraidStats", localPlayer,
	function ( state )
		if ( state ) then
			local team = getTeamName(getPlayerTeam(localPlayer))
			if team == "Criminals" then
				saying = "Security Guards Alive"
			else
				saying = "Mafia Men Alive"
			end
			addEventHandler( "onClientRender", root, onDrawmansionraidStats )
		else
			removeEventHandler( "onClientRender", root, onDrawmansionraidStats )
		end
	end
)


addEventHandler("onClientPlayerWasted",localPlayer,function()
	triggerEvent("onTogglemansionraidStats",localPlayer,false)
end)

-- Reset the counters for everyone
addEvent( "onResetmansionraidStats", true )
addEventHandler( "onResetmansionraidStats", localPlayer,
	function ()
		kills=0
		topKillerLaw = {}
		topKillerCrim = {}
		criminalCount = 0
		lawCount = 0
		removeEventHandler( "onClientRender", root, onDrawmansionraidStats )
	end
)

-- On count change
addEvent( "onChangeMansionCount", true )
addEventHandler( "onChangeMansionCount", root,
	function ( lawCounts, crimCounts, pedc )
		if ( crimCounts ) then
			criminalCount = crimCounts
		end
		peds=pedc
		if ( lawCounts ) then
			lawCount = lawCounts
		end
	end
)

-- Get the top killers
function getTopKillersmansionraid ()
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
		if ( isElement( theKiller ) ) and getElementType(theKiller) == "player" and ( getPlayerTeam( theKiller ) ) then
			if ( getElementDimension(theKiller) == 1 and getElementInterior(theKiller) == 5 ) then
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

addEventHandler( "onClientPedWasted", root,
	function ( theKiller, weapon, bodypart )
		if ( isElement( theKiller ) ) and getElementType(theKiller) == "player" and ( getPlayerTeam( theKiller ) ) then
			if theKiller == localPlayer and getElementDimension(theKiller) == 1 and getElementInterior(theKiller) == 5 then
				triggerServerEvent("CSGmraid.payme",localPlayer,source)
				kills=kills+1
			end
			if ( getElementDimension(theKiller) == 1 and getElementInterior(theKiller) == 5 ) then
				if (getPlayerTeam( theKiller )) and ( getTeamName( getPlayerTeam( theKiller ) ) == "Criminals" ) then
					if ( topKillerCrim[theKiller] ) then
						topKillerCrim[theKiller] = topKillerCrim[theKiller] +1
					else
						topKillerCrim[theKiller] = 1
					end
				elseif (getPlayerTeam( theKiller )) and ( getTeamName( getPlayerTeam( theKiller ) ) == "Police" ) or ( getTeamName( getPlayerTeam( theKiller ) ) == "Government Agency" )  or ( getTeamName( getPlayerTeam( theKiller ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( theKiller ) ) == "Military Forces" ) then
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

timeLeft=0
tickTimer=false
addEvent("CSGmraid.started",true)
addEventHandler("CSGmraid.started",localPlayer,function(left)
	timeLeft=left
	tickTimer=setTimer(function()
		if timeLeft>0 then timeLeft=timeLeft-1 end
		if timeLeft==0 then
			killTimer(tickTimer)
		end
	end,1000,0)
end)

-- mansionraid stats
local sx, sy = guiGetScreenSize()

function onDrawmansionraidStats ()
	C1, C2, C3, C4, C5, L1, L2, L3, L4, L5 = getTopKillersmansionraid ()
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
	dxDrawText("Time Left: "..timeLeft.." Seconds",sx*(1125.0/1440),sy*(473.0/900),sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	dxDrawText(""..peds.." "..saying.."",sx*(1125.0/1440),sy*(533.0/900),sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)
	dxDrawText("My Kills: "..kills.."",sx*(1125.0/1440),sy*(503.0/900),sx*(1357.0/1440),sy*(431.0/900),tocolor(225,0,0,225),1.2,"default-bold","left","top",false,false,false)

end

addEvent("CSGmd.getKC",true)
addEventHandler("CSGmd.getKC",localPlayer,function()
	triggerServerEvent("CSGmd.recKC",localPlayer,kills)
	triggerEvent("onResetmansionraidStats",localPlayer)
end)

local bags = ""
local monitorBlipVisibilityTimer = ""
function rec(t,s)
	timeLeft=60
	bags=t
	addEventHandler("onClientRender",root,rotateBags)
	setTimer(function() removeEventHandler("onClientRender",root,rotateBags) triggerEvent("onResetmansionraidStats",localPlayer) end,s,1)
end
addEvent("CSGmansionRecBags",true)
addEventHandler("CSGmansionRecBags",localPlayer,rec)

function rotateBags()
	for k,v in pairs(bags) do
		if isElement(v) == false then return end
		local rx,ry,rz = getElementRotation(v)
		rz=rz+1
		if rz > 360 then rz = rz-360 end

		setElementRotation(v,rx,ry,rz)
	end
end

exports.customblips:createCustomBlip(1277.8, -789.11,20,20,"blip.png",99999)
