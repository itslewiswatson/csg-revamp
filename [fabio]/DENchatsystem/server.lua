local chatRooms = {
"Support", "Mainchat", "Localchat", "Teamchat", "Groupchat","Alliancechat", "Cafe", "NL", "TN", "TR", "RU", "AR","PT-BR"
}

local seeAllPlayers = {}

local chatRoomSpam = {}
local mainChatSpam = {}
local teamChatSpam = {}
local carChatSpam = {}
local lawChatSpam = {}
local actionMessageSpam = {}
local logData = true


-- Remove hex
function removeHEX( message )
	return string.gsub(message,"#%x%x%x%x%x%x", "")
end

-- Players near
function isElementNearEnough( player, x, y, z )
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=400
end

addEventHandler( "onPlayerChat", root,
function( message, messageType )
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if ( messageType == 1 ) then
			cancelEvent()
			local x, y, z = getElementPosition( source )
			if ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
				exports.DENdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)
			elseif ( actionMessageSpam[source] ) and ( getTickCount()-actionMessageSpam[source] < 2000 ) then
				exports.DENdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message per 2 seconds.", 200, 0, 0)
			else
				actionMessageSpam[source] = getTickCount()
				for i, thePlayer in ipairs ( getElementsByType ( "player" ) ) do
					if ( isElementNearEnough( thePlayer, x, y, z ) ) then
						outputChatBox( "* " .. getPlayerName(source) .. ": "..removeHEX( message ), thePlayer, 204, 051, 153 )
					end
				end
				if logData == true then
					exports.CSGlogging:createLogRow ( source, "mechat", message )
			 	end
			end
		end
	end
end
)

function onPlayerMessageCarChat(player,_,...)
	if ( exports.server:getPlayerAccountName ( player ) ) then
		if not ( isPedInVehicle (player)) then
			exports.DENdxmsg:createNewDxMessage(player, "You're not inside a vehicle!", 255, 0, 0)
		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then
			exports.DENdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)
		elseif ( carChatSpam[player] ) and ( getTickCount()-carChatSpam[player] < 1000 ) then
			exports.DENdxmsg:createNewDxMessage(player, "You type as fast as an Infernus! Please slow down.", 200, 0, 0)
		else
			carChatSpam[player] = getTickCount()
			local message = table.concat({...}, " ")
			if #message < 1 then
				exports.DENdxmsg:createNewDxMessage(player, "Enter a message.", 200, 0, 0)
			else
				local nick = getPlayerName(player)
				local vehicle = getPedOccupiedVehicle(player)
				local occupants = getVehicleOccupants(vehicle)
				local seats = getVehicleMaxPassengers(vehicle)

				for seat = 0, seats do
					local occupant = occupants[seat]
					if (isElement(occupant) and getElementType(occupant) == "player") then
						outputChatBox("#FF4500(CAR) "..(nick)..": #FFFFFF"..(message).." ", occupant, 255,69,0, true)
					end
				end
				if logData == true then
					exports.CSGlogging:createLogRow ( player, "carchat", message )
				end
			end
		end
    end
end
addCommandHandler( "cc", onPlayerMessageCarChat )
addCommandHandler( "carchat", onPlayerMessageCarChat )

function onLawChat(player,_,...)
	if ( exports.server:getPlayerAccountName ( player ) ) then
		if ( getTeamName( getPlayerTeam( player ) ) == "Police" ) or ( getTeamName( getPlayerTeam( player ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( player ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( player ) ) == "Government Agency" ) then
			local message = table.concat({...}, " ")
			if message:match("^%s*$") then
				exports.DENdxmsg:createNewDxMessage(player, "You didnt enter a message!", 200, 0, 0)
			elseif ( lawChatSpam[player] ) and ( getTickCount()-lawChatSpam[player] < 1000 ) then
				exports.DENdxmsg:createNewDxMessage(player, "You are typing to fast! The limit is one message each second.", 200, 0, 0)
			elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then
				exports.DENdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)
			else
				lawChatSpam[player] = getTickCount()

				for i,thePlayer in ipairs( getElementsByType("player") ) do
					if ( getPlayerTeam( thePlayer ) ) then
						if ( getTeamName( getPlayerTeam( thePlayer ) ) == "Police" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "SWAT" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Military Forces" ) or ( getTeamName( getPlayerTeam( thePlayer ) ) == "Government Agency" ) then
							outputChatBox("(LAW) " .. getPlayerName(player) .. ": #ffffff"..message, thePlayer, 67, 156, 252, true)
						end
					end
				end
				if logData == true then
					exports.CSGlogging:createLogRow ( player, "lawchat", message )
				end
			end
		end
	end
end
addCommandHandler( "law", onLawChat )
addCommandHandler( "lawchat", onLawChat )

function onPlayerMessageTeamChat( message, messageType, thePlayer,fromCrimCommand )
	local source = source or thePlayer
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if ( messageType == 2 ) and message:match("^%s*$") then
			exports.DENdxmsg:createNewDxMessage(source, "You didnt enter a message!", 200, 0, 0)
			cancelEvent()
		elseif ( messageType == 2 ) and ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
			exports.DENdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)
			cancelEvent()
		elseif ( messageType == 2 ) and ( teamChatSpam[source] ) and ( getTickCount()-teamChatSpam[source] < 1000 ) then
			exports.DENdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
			cancelEvent()
		elseif messageType == 2 then
			cancelEvent()
			teamChatSpam[source] = getTickCount()
			if exports.server:isPlayerLoggedIn( source ) then
				local teamPlayers = {}
				local sourceTeam = getPlayerTeam ( source )
				local teamName = getTeamName ( sourceTeam )
				local r,g,b = getTeamColor(getPlayerTeam(source))
				local allplayers = getElementsByType ( "player" )
				for theKey,thePlayer in ipairs(allplayers) do
					local playersTeam = getPlayerTeam ( thePlayer )
					if sourceTeam == playersTeam then
						table.insert(teamPlayers,thePlayer)
					end
				end
				if not(fromCrimCommand) then
					if getElementData(source,"Group") == "The Smurfs" then
						if getTeamName(getPlayerTeam(source)) == "Criminals" then
							local m = getElementModel(source)
							if m == 261 or m == 57 then
								r,g,b = 142,56,142
								teamPlayers = {}
								for k,v in pairs(getElementsByType("player")) do
									if getTeamName(getPlayerTeam(v)) == "Criminals" and (getElementModel(v) == 261 or getElementModel(v) == 57) and getElementData(v,"Group") == "The Smurfs" then
										table.insert(teamPlayers,v)
									end
								end
							end
						end
					end
				end
				for index, sameTeamPlayers in ipairs( teamPlayers ) do
					if ( getElementData( sameTeamPlayers, "chatOutputTeamchat" ) ) then
						outputChatBox( "(TEAM) ".. getPlayerName(source) ..": #FFFFFF".. removeHEX(message), sameTeamPlayers, r,g,b, true )
					end
					triggerClientEvent ( sameTeamPlayers, "onChatSystemMessageToClient", sameTeamPlayers, source, removeHEX(message), "Teamchat" )
				end
				if logData == true then
					exports.CSGlogging:createLogRow ( source, "teamchat", message, teamName )
				end
			end
		end
	else
		cancelEvent()
    end
end
addEventHandler( "onPlayerChat", root, onPlayerMessageTeamChat )

function onPlayerMessageMainChat( message, messageType, thePlayers )
	local source = source or thePlayers
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if ( messageType == 0 ) and message:match("^%s*$") then
			exports.DENdxmsg:createNewDxMessage(source, "You didnt enter a message!", 200, 0, 0)
			cancelEvent()
		elseif ( messageType == 0 ) and ( exports.CSGadmin:getPlayerMute ( source ) == "Main" ) or ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
			exports.DENdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)
			cancelEvent()
		elseif ( messageType == 0 ) and ( mainChatSpam[source] ) and ( getTickCount()-mainChatSpam[source] < 3000 ) and not ( exports.CSGstaff:isPlayerStaff( source ) ) then
			exports.DENdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message in 3 seconds.", 200, 0, 0)
			cancelEvent()
		elseif messageType == 0 then
			cancelEvent()
			mainChatSpam[source] = getTickCount()
			local nearbyPlayers = {}

			local playerChatZone = exports.server:getPlayChatZone( source )
			local r, g, b = getTeamColor(getPlayerTeam(source))

			local getAllPlayers = getElementsByType ( "player" )
			for theKey, thePlayer in ipairs(getAllPlayers) do
				local thePlayerChatZone = exports.server:getPlayChatZone( thePlayer )
				if ( getElementData( thePlayer, "chatOutputMainchat" ) ) then
					outputChatBox( "(".. playerChatZone ..") ".. getPlayerName(source) ..": #FFFFFF".. removeHEX(message), thePlayer, r,g,b, true )				
				end
			end
			for k,v in pairs(getElementsByType("player")) do
				triggerClientEvent (v, "onChatSystemMessageToClient", v, source, playerChatZone.." "..removeHEX(message), "Mainchat" )
			end
			if logData==true then
				exports.CSGlogging:createLogRow ( source, "mainchat", message )
			end
			triggerEvent( "onPlayerMainChat", source, playerChatZone, removeHEX(message) )
		end
	else
		cancelEvent()
    end
end
addEventHandler( "onPlayerChat", root, onPlayerMessageMainChat )

addEvent( "onChatSystemSendMessage", true )
function onChatSystemSendMessage ( theMessage, theRoom, thePlayer )
	if (source) and isElement(source) then thePlayer=source end
	local source = source or thePlayer
	if theRoom=="Support" and getElementData(thePlayer,"chatOutputSupport") == false then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "You have disabled support chat, go to Phone > Settings to enable it!", 200, 0, 0)
		return
	end

	if theRoom=="PT" or theRoom=="BR" then theRoom="PT-BR" end
	if ( theRoom == "Support" ) and ( exports.CSGadmin:getPlayerMute ( source ) == "Support" ) then exports.DENdxmsg:createNewDxMessage(source, "You are muted from the support channel!", 236, 201, 0) return end
	if ( exports.server:getPlayerAccountName ( source ) ) then
		if ( theMessage ) and ( theRoom ) then
			if ( theRoom == "Localchat" ) then
				executeCommandHandler ( "localchat", source, theMessage  )
			elseif ( theRoom == "Groupchat" ) then
				executeCommandHandler ( "groupchat", source, theMessage  )
			elseif ( theRoom == "Alliancechat" ) then
				executeCommandHandler ( "ac", source, theMessage  )
			elseif ( theRoom == "Mainchat" ) then
				onPlayerMessageMainChat( theMessage, 0, source )
			elseif ( theRoom == "Teamchat" ) then
				onPlayerMessageTeamChat( theMessage, 2, source )
			else
				if theMessage:match("^%s*$") then
					exports.DENdxmsg:createNewDxMessage(source, "You didnt enter a message!", 200, 0, 0)
				elseif ( exports.CSGadmin:getPlayerMute ( source ) == "Global" ) then
					exports.DENdxmsg:createNewDxMessage(source, "You are muted!", 236, 201, 0)
				elseif ( chatRoomSpam[source] ) and ( getTickCount()-chatRoomSpam[source] < 1000 ) then
					exports.DENdxmsg:createNewDxMessage(source, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
				else
					for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
						if ( getElementData( thePlayer, "chatOutput"..theRoom ) ) then
							if ( theRoom == "Support" ) then
								outputChatBox("(" .. string.upper(theRoom) .. ") " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( theMessage ).." ", thePlayer, 137, 104, 205, true)
							else
								outputChatBox("(" .. string.upper(theRoom) .. ") " .. ( getPlayerName( source ) ) .. ": #FFFFFF"..( theMessage ).." ", thePlayer, 255, 128, 0, true)
							end
						end
						triggerClientEvent(thePlayer,"onChatSystemMessageToClient",thePlayer, source, removeHEX(theMessage), theRoom )
					end
					chatRoomSpam[source] = getTickCount()

					if logData==true then
						exports.CSGlogging:createLogRow ( source, theroom, theMessage )
					end
					if ( theRoom == "Support" ) then
						triggerEvent( "onPlayerSupportChat", source, removeHEX(theMessage) )
					end
				end
			end
		end
	end
end
addEventHandler("onChatSystemSendMessage", root, onChatSystemSendMessage )

addEvent( "OnEchoSupportChat" )
addEventHandler( "OnEchoSupportChat",root,
function ( theNick, theMessage )
	if ( theNick ) and ( theMessage ) then
		for k, thePlayer in ipairs ( getElementsByType( "player" ) ) do
			if ( getElementData( thePlayer, "chatOutputSupport" ) ) then
				outputChatBox("(SUPPORT) [IRC] " .. ( theNick ) .. ": #FFFFFF"..( removeHEX( theMessage ) ).." ", thePlayer, 137, 104, 205, true)
			end
		end
		for k,v in pairs(getElementsByType("player")) do
			triggerClientEvent(v,"onChatSystemMessageToClient", v, false, removeHEX( theMessage ), "Support", "[IRC] "..theNick )
		end
	end
end
)

function onChatSystemCommandChat( thePlayer,commandName,... )
	if ( commandName == "nl" ) or ( commandName == "tn" ) or ( commandName == "tr" ) or ( commandName == "ru" ) or ( commandName == "ar" ) or ( commandName == "pt" )  or ( commandName == "br" ) then
		commandName = string.upper(commandName)
	else
		commandName = commandName:gsub("^%l", string.upper)
	end

	local theMessage = table.concat({...}, " ")
	if theMessage:match("^%s*$") then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "You didnt enter a message!", 200, 0, 0)
	elseif ( exports.CSGadmin:getPlayerMute ( thePlayer ) == "Global" ) then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "You are muted!", 236, 201, 0)
	else
		onChatSystemSendMessage ( theMessage, commandName, thePlayer )
	end
end

for i=1,#chatRooms do
	if ( chatRooms[i] == "NL" ) or ( chatRooms[i] == "TN" ) or ( chatRooms[i] == "TR" ) or ( chatRooms[i] == "RU" ) or ( chatRooms[i] == "PT-BR" ) or ( chatRooms[i] == "AR" ) or ( chatRooms[i] == "Support" ) or ( chatRooms[i] == "Cafe" ) then
		if ( chatRooms[i] == "PT-BR") then
			addCommandHandler( "pt", onChatSystemCommandChat )
			addCommandHandler( "br", onChatSystemCommandChat )
		else
			addCommandHandler( string.lower(chatRooms[i]), onChatSystemCommandChat )
		end
	end
end


function seeAll(ps)
    if exports.CSGstaff:isPlayerStaff(ps) then
        seeAllPlayers[ps] = not seeAllPlayers[ps]
        if seeAllPlayers[ps] then
            exports.dendxmsg:createNewDxMessage(ps,"You can now see all chatzone chat",0,255,0)
        else
            exports.dendxmsg:createNewDxMessage(ps,"You can no longer see all chatzone chat",0,255,0)
        end
    end
end
addCommandHandler("seeall",seeAll)


