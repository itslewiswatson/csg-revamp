-- Spam table
local spamTable = {}
local helpSpamTable = {}
local helpTable = {}
local warpPosition = {}
local supporters = {}

function loadSupporters()
	local data = exports.DENmysql:query("SELECT userid FROM supporters")
	if data then
		for k, v in ipairs(data) do
			supporters[v] = true
		end
	end
end
addEventHandler("onResourceStart",resourceRoot,loadSupporters)

-- Open the supporters GUI
addCommandHandler( "supporters",function(thePlayer)
	if getElementData(thePlayer,"isPlayerSupporter") then
		triggerClientEvent(thePlayer,"openSupportersWindow",thePlayer)
	end
end)

-- Available for help
addCommandHandler( "supporter",
	function ( thePlayer )
		if ( getElementData(thePlayer,"isPlayerSupporter") == true ) then
			if ( spamTable[ thePlayer ] ) and ( getTickCount()-spamTable[ thePlayer ] < 120000 ) then
				outputChatBox( "Please refuse from spamming this command!", thePlayer, 225, 0, 0 )
			else
				spamTable [ thePlayer ] = getTickCount()
				outputChatBox( "Supporter "..getPlayerName( thePlayer ).." is now available to help you!", root, 255, 128, 0 )
			end
		end
	end
)

-- Mute the player
addEvent( "onSupportMutePlayer", true )
addEventHandler( "onSupportMutePlayer", root,
	function ( thePlayer, theReason, theTime )
		if not ( exports.CSGadmin:getPlayerMute( source ) ) then
			exports.CSGadmin:adminMutePlayer ( source, thePlayer, theReason, theTime, "Support" )
		else
			outputChatBox( "This player is already muted!", source, 225, 0, 0 )
		end
	end
)

-- On player login
addEventHandler( "onServerPlayerLogin", root,
	function ()
		if supporters[exports.server:getPlayerAccountID(source)] then
			setElementData( source, "isPlayerSupporter", true )
			outputChatBox( "Welcome supporter, have a nice day! :)", source, 255, 128, 0 )
			return
		end

		if ( getElementData( source, "playTime" ) ) and ( getElementData( source, "playTime" ) < 60 ) then
			outputChatBox( "Welcome new player! Use /helpme if you recuire a supporter!", source, 255, 128, 0 )
		end
	end
)

-- isPlayerSupporter
function isPlayerSupporter ( thePlayer )
	if not ( isElement( thePlayer ) ) then
		return false
	else
		return getElementData( thePlayer, "isPlayerSupporter" )
	end
end

-- supporter message
function onMessageToSupporters ( theMessage )
	for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
		if ( isPlayerSupporter ( thePlayer ) ) or ( exports.CSGstaff:isPlayerStaff( thePlayer ) ) then
			outputChatBox( theMessage, thePlayer, 0, 225, 0 )
		end
	end
end

-- helpme command
addCommandHandler( "helpme",
	function ( thePlayer )
		if ( exports.server:getPlayerAccountName( thePlayer ) ) then
			if ( helpSpamTable[ getPlayerSerial( thePlayer ) ] ) and ( getTickCount()-helpSpamTable[ getPlayerSerial( thePlayer ) ] < 120000 ) then
				outputChatBox( "Please refuse from spamming this command! (Once every 2 minutes)", thePlayer, 225, 0, 0 )
			elseif ( getElementData( thePlayer, "playTime" ) ) and ( getElementData( thePlayer, "playTime" ) < 900 ) then
				onMessageToSupporters ( getPlayerName( thePlayer ).." requested a supporter! Use /warp [thePlayer] to warp to him/her!" )
				helpSpamTable[ getPlayerSerial( thePlayer ) ] = getTickCount()
				helpTable[ thePlayer ] = true
				outputChatBox( "Your help request has been sent!", thePlayer, 0, 225, 0 )
			else
				outputChatBox( "You can only request a supporter when you're playtime is lower than 15 hours!", thePlayer, 225, 0, 0 )
			end
		end
	end
)

-- warp to
addCommandHandler( "warp",
	function ( thePlayer, cmd, aPlayer )
		if ( isPlayerSupporter ( thePlayer ) ) then
			if ( aPlayer ) and not ( aPlayer == "" ) or ( aPlayer == " " ) and ( exports.server:getPlayerFromNamePart( aPlayer ) ) then
				local aPlayerElement = exports.server:getPlayerFromNamePart( aPlayer )
				if ( aPlayerElement ) and ( helpTable[ aPlayerElement ] ) then
					if (getElementData(player,"isPlayerJailed") == true) then
						exports.DENdxmsg:createNewDxMessage(thePlayer,"You cannot warp to players while you're in jail!",255,0,0)
						return false --prevent them from warping to them.
					end
					if (exports.CSGadmin:isPlayerJailed(aPlayer)) then
						exports.DENdxmsg:createNewDxMessage(thePlayer,"You cannot warp to players while they're in jail!",255,0,0)
						return false --prevent them from warping to them.									
					end
					
					local x1, y1, z1 = getElementPosition( thePlayer )
					warpPosition[ thePlayer ] = x1..",".. y1 ..","..z1
					local x, y, z = getElementPosition( aPlayerElement )
					local int, dim = getElementInterior( aPlayerElement ), getElementDimension( aPlayerElement )
					if ( isPedInVehicle( thePlayer ) ) then removePedFromVehicle( thePlayer, getPedOccupiedVehicle( thePlayer ) ) end
					
					setElementPosition( thePlayer, x, y, z )
					setElementDimension ( thePlayer, dim )
					setElementInterior( thePlayer, int )
					if ( isPedInVehicle( aPlayerElement ) ) then 
						local veh = getPedOccupiedVehicle( aPlayerElement )
						local tSeat = false
						for seat=0, 3 do
							if not getVehicleOccupant(veh,seat) then
								tSeat = seat
								break
							end
						end
						if tSeat then
							warpPedIntoVehicle( thePlayer, tSeat ) 
						else	
							outputChatBox( "This player was in a filled vehicle, you have been warped near it.", thePlayer, 255, 225, 0 )
						end
					end
					
					helpTable[ aPlayerElement ] = false
					outputChatBox( "You can use /warpback to get back to your old position!", thePlayer, 0, 225, 0 )
				else
					outputChatBox( "This player didn't ask for help, got already help or is not a valid player!", thePlayer, 225, 0, 0 )
				end
			else
				outputChatBox( "You didn't enter a valid playername!", thePlayer, 225, 0, 0 )
			end
		end
	end
)

-- warp back
addCommandHandler( "warpback",
	function ( thePlayer )
		if ( isPlayerSupporter ( thePlayer ) ) then
			if ( warpPosition[ thePlayer ] ) then
				local tbl = split( warpPosition[ thePlayer ], "," )
				setElementPosition( thePlayer, tbl[1], tbl[2], tbl[3] )
				warpPosition[ thePlayer ] = false
			end
		end
	end
)
