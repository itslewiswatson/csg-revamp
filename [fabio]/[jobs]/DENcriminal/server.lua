addEvent ( "enterCriminalJob", true )
function setPlayerCriminal ( thePlayer )
	local thePlayer = thePlayer or source
	local playerID = exports.server:getPlayerAccountID( thePlayer )
	local oldTeam = getPlayerTeam( thePlayer )
	local oldM = getElementModel(thePlayer)
	local playerData = exports.DENmysql:query( "SELECT skin,cjskin FROM accounts WHERE id=? LIMIT 1", playerID )
	if playerData and playerData[1] then
		setElementData( thePlayer, "Occupation", "Criminal", true )
		setPlayerTeam ( thePlayer, getTeamFromName ( "Criminals" ) )
		if oldM == 230 then
			setElementModel(thePlayer,230)
		else
			setElementModel ( thePlayer, tonumber( playerData[1].skin ) )
		end

		if ( tonumber( playerData[1].skin ) == 0 ) then
			local CJCLOTTable = fromJSON( tostring( playerData[1].cjskin ) )
			if CJCLOTTable then
				for theType, index in pairs( CJCLOTTable ) do
					local texture, model = getClothesByTypeIndex ( theType, index )
					addPedClothes ( thePlayer, texture, model, theType )
				end
			end
		end

		if ( getTeamName( oldTeam ) ~= "Criminals" ) then
			triggerEvent( "onPlayerTeamChange", thePlayer, oldTeam, getTeamFromName ( "Criminals" ) )
		end

		triggerEvent( "onPlayerJobChange", thePlayer, "Criminal", getTeamFromName ( "Criminals" ) )
		triggerEvent( "CSGcriminalskills.changed",thePlayer)
		exports.DENvehicles:reloadFreeVehicleMarkers( thePlayer, true )
		exports.DENdxmsg:createNewDxMessage( thePlayer, "You are now a criminal!", 200, 0, 0 )
		return true
	else
		return false
	end
end
addEventHandler ( "enterCriminalJob", root, setPlayerCriminal )

function givePlayerCJClothes ( thePlayer )
	local playerID = exports.server:getPlayerAccountID( thePlayer )
	local playerData = exports.DENmysql:query( "SELECT cjskin FROM accounts WHERE id=? LIMIT 1", playerID )
	if playerData and playerData[1] then
		setElementModel ( thePlayer, 0 )

		local CJCLOTTable = fromJSON( tostring( playerData[1].cjskin ) )
		if CJCLOTTable then
			for theType, index in pairs( CJCLOTTable ) do
				local texture, model = getClothesByTypeIndex ( theType, index )
				addPedClothes ( thePlayer, texture, model, theType )
			end
		end
		return true
	else
		return false
	end
end
