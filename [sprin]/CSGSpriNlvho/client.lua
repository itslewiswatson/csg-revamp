crash = {{{{{{{{ {}, {}, {} }}}}}}}}
col = createColRectangle( 1562.84, 1792.75, 88,83)
colz = createColRectangle( 344.24, 637.82,500,700)
function disablewep(thePlayer)
	if thePlayer == getLocalPlayer() then
	 local nWeapon = getPedWeapon( thePlayer )
	if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff") then return end
	if not ( (getPlayerTeam(thePlayer) == getTeamFromName("Police") or getTeamFromName("SWAT") or getTeamFromName("Military Forces") or getTeamFromName("Government Agency") ) and ( nWeapon == 3 ) ) then
	tmr = setTimer(function ()
		toggleControl("Fire",false )
		toggleControl("aim_weapon",false )
		toggleControl("next_weapon",false )
		toggleControl("previous_weapon",false )
		end, 50,0)
		exports.dendxmsg:createNewDxMessage("If you are cop then leave this area and enter again with nightstick to arrest", 255, 0,0)
		else
		tmr = setTimer(function ()
		toggleControl("next_weapon",false )
		toggleControl("previous_weapon",false )
		end, 50,0)
	end
		function stopDamage()
			if getPlayerWantedLevel(thePlayer) == 0 then
			cancelEvent()
			end
		end
		addEventHandler("onClientPlayerDamage", thePlayer, stopDamage)
		exports.dendxmsg:createNewDxMessage("You are in NON-DM zone! You can't shoot", 255, 0,0)
	end
end
addEventHandler ( "onClientColShapeHit", col, disablewep)
addEventHandler ( "onClientColShapeHit", colz, disablewep)

function ablewep(thePlayer)
	if thePlayer == getLocalPlayer() then
		if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Staff") then return end
		removeEventHandler("onClientPlayerDamage", thePlayer, stopDamage)
		if isTimer(tmr) then killTimer(tmr) end


		if getElementAlpha(localPlayer) == 255 then
			exports.dendxmsg:createNewDxMessage("You left the NON-DM zone! You can shoot now", 0,255,0)
			toggleControl("Fire",true )
			toggleControl("aim_weapon",true )
			toggleControl( "next_weapon",true )
			toggleControl( "previous_weapon",true )
		else
			exports.dendxmsg:createNewDxMessage("You left the NON-DM zone!", 0,255,0)
			exports.dendxmsg:createNewDxMessage("But you still cannot shoot because you are in ghost mode", 0,255,0)
		end
	end
end
addEventHandler ( "onClientColShapeLeave", col, ablewep)
addEventHandler ( "onClientColShapeLeave", colz, ablewep)

addEventHandler("onResourceStop",resourceRoot,
	function (s)
		if (s == getThisResource()) then
			removeEventHandler("onClientPlayerDamage", thePlayer, stopDamage)
			if isTimer(tmr) then killTimer(tmr) end
			toggleControl("Fire",true )
			toggleControl("aim_weapon",true )
			toggleControl( "next_weapon",true )
			toggleControl( "previous_weapon",true )
		end
	end
)

if fileExists("client.lua") == true then
	fileDelete("client.lua")
end
