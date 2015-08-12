-- The bribe table
local bribeTable = {}

-- Cop teams
local copTeams = {
	["Military Forces"] = true,
	["SWAT"] = true,
	["Police"] = true,
	["Government Agency"] = true,
}

arrests={}
addEvent("onPlayerArrest",true)
addEventHandler("onPlayerArrest",root,function(cop)
	local p = source
	arrests[p]=cop
end)

addEvent("onPlayerArrest",true)
addEventHandler("onPlayerArrest",root,function(cop)
	local p = source
	arrests[p]=cop
end)

addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,function()
	arrests[source]=nil
end)

-- Command to bribe someone
addCommandHandler( "bribe",
	function ( thePlayer, cmd, copName, bribeAmount )
		-- Syntax check
		if not ( copName ) or not ( bribeAmount ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "The correct syntax for a bribe is: /bribe [copname] [amount]", 225, 0, 0 )
			return
		end

		-- Check if the player is not higher wanted then 3 stars
		if ( getPlayerWantedLevel( thePlayer ) > 3 ) or ( getPlayerWantedLevel( thePlayer ) == 0 ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You can only bribe if you have less than 3 stars or at least one!", 225, 0, 0 )
			return
		end

		-- Check if not already a bribe is open
		if ( bribeTable[thePlayer] ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You've already bribed a cop, please wait!", 225, 0, 0 )
			return false
		end

		-- Check if the offcier exist
		local theOfficer = exports.server:getPlayerFromNamePart( copName )
		if not ( theOfficer ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "We couldn't find a cop near you with that name! Try again.", 225, 0, 0 )
			return
		end

		-- Check if the offcier is a cop
		if not ( getPlayerTeam( theOfficer ) ) or not ( copTeams[getTeamName( getPlayerTeam( theOfficer ) )] ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You can only bribe cops, this ain't a cop!", 225, 0, 0 )
			return
		end

		-- Bribe yourself
		if ( thePlayer == theOfficer ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You want to bribe yourself!? That's weird.", 225, 0, 0 )
			return
		end

		-- Check if the officer is near
		local x1, x2, x3 = getElementPosition( thePlayer )
		local x4, x5, x6 = getElementPosition( theOfficer )
		if ( getDistanceBetweenPoints3D ( x1, x2, x3, x4, x5, x6 ) > 16 ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You can only bribe a cop near you!", 225, 0, 0 )
			return
		end

		-- Check the bribe amount
		if not ( string.match( bribeAmount, '^%d+$' ) ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "Please enter a valid amount of money!", 225, 0, 0 )
			return
		end
		if tonumber(bribeAmount) <= 0 then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You can't bribe $0 or less!", 225, 0, 0 )
			return
		end
		-- Money check
		if ( ( getPlayerMoney( thePlayer )-tonumber ( bribeAmount ) ) < 0 ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You don't have enough money to pay the bribe!", 225, 0, 0 )
			return
		end
		if getElementData(thePlayer,"isPlayerArrested") == true then
			if arrests[thePlayer] ~= nil then
				if arrests[thePlayer] ~= theOfficer then
					exports.DENdxmsg:createNewDxMessage( thePlayer, "You can only bribe the officer that arrested you!", 225, 0, 0 )
					return
				end
			end
		end
		exports.DENdxmsg:createNewDxMessage( thePlayer, "A bribe request has been sent to "..getPlayerName( theOfficer ), 0, 255, 0)
		exports.DENdxmsg:createNewDxMessage( theOfficer, getPlayerName( thePlayer ).." wants to bribe you for $" .. bribeAmount .. " do /accbribe [playername] to accept it!", 0, 255, 0)
		bribeTable[thePlayer] = { theOfficer, bribeAmount, setTimer( onCancelBribeRequest, 20000, 1, thePlayer, theOfficer ) }
	end
)

-- Function that cancels the bribe request
function onCancelBribeRequest ( thePlayer, theOfficer )
	bribeTable[thePlayer] = false
	exports.DENdxmsg:createNewDxMessage( thePlayer, getPlayerName( theOfficer ).." didn't respond to your bribe request!", 225, 0, 0)
end

-- Function to accept a bribe
addCommandHandler( "accbribe",
	function ( thePlayer, cmd, briberName )
		-- Syntax check
		if not ( briberName ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "The correct syntax to accept a bribe is: /accbribe [playername]", 225, 0, 0 )
			return
		end

		-- Check of the offcier exist
		local theBriber = exports.server:getPlayerFromNamePart( briberName )
		if not ( theBriber ) or not ( bribeTable[theBriber] ) or not ( bribeTable[theBriber][1] == thePlayer ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "There's no person with this name who bribed you!", 225, 0, 0 )
			return
		end

		-- Kill the timer
		if ( bribeTable[theBriber][3] ) and ( isTimer ( bribeTable[theBriber][3] ) ) then
			killTimer ( bribeTable[theBriber][3] )
		end
		if getElementData(theBriber,"isPlayerJailed") == true then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "You can't accept a bribe from someone who is jailed", 225, 0, 0 )
			return
		end
		if ( getPlayerWantedLevel( theBriber ) > 3 ) then
			exports.DENdxmsg:createNewDxMessage( thePlayer, "This player has more than 3 stars!", 225, 0, 0 )
			return	
		end
		exports.DENdxmsg:createNewDxMessage( theBriber, getPlayerName( thePlayer ).." accepted your bribe!", 0, 255, 0)
		exports.DENdxmsg:createNewDxMessage( thePlayer, "You accepted the bribe from "..getPlayerName( theBriber ), 0, 255, 0)

		givePlayerMoney( thePlayer, bribeTable[theBriber][2] )
		takePlayerMoney( theBriber, bribeTable[theBriber][2] )
		arrests[theBriber] = nil
		setElementData ( theBriber, "wantedPoints", 0 )
		setPlayerWantedLevel( theBriber, 0 )
		exports.DENlaw:updatedWantedLevel(theBriber,0)

		bribeTable[theBriber] = false
		triggerEvent("CSGbribe.accepted",thePlayer,thePlayer,"",briberName)
	end
)
