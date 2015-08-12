local groupChatSpam = {}

function onGroupChat(player,commName,...)
	if ( exports.server:getPlayerAccountName ( player ) ) then

		local sourceGroup = getElementData( player, "Group" )
		if commName=="gcw" then
			if exports.server:getPlayerAccountName ( player ) == "priyen" then
				sourceGroup = "Wolfensteins"
			end
		end
		local message = table.concat({...}, " ")
		if not ( sourceGroup ) then
			exports.DENdxmsg:createNewDxMessage( player, "You are not in a group!",200,0,0,true)
		elseif message:match("^%s*$") then
			exports.DENdxmsg:createNewDxMessage( player, "You didn't enter a message!", 200, 0, 0)
		elseif ( groupChatSpam[player] ) and ( getTickCount()-groupChatSpam[player] < 1000 ) then
			exports.DENdxmsg:createNewDxMessage( player, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then
			exports.DENdxmsg:createNewDxMessage( player, "You are muted!", 236, 201, 0)
		else
			groupChatSpam[player] = getTickCount()
			local nick = getPlayerName( player )
			local playertable = getElementsByType("player")
			local groupPlayerTable = {}
			local thePlayerGroup = getElementData( player, "Group" )
			local thePlayer = player

			for i,v in ipairs(playertable ) do
				local playersGroup = getElementData( v, "Group" )
				if sourceGroup == playersGroup then
					if ( getElementData( v, "chatOutputGroupchat" ) ) then
						outputChatBox("(GROUP) "..nick..": #ffffff"..message,v,200,0,0,true)
					end
					triggerClientEvent( v, "onChatSystemMessageToClient", v, thePlayer, message, "Groupchat" )
				end
			end
			exports.CSGlogging:createLogRow ( player, "groupchat", message, thePlayerGroup )
		end
	end
end
addCommandHandler( "group", onGroupChat )
addCommandHandler( "gc", onGroupChat )
addCommandHandler( "gcw", onGroupChat )
addCommandHandler( "groupchat", onGroupChat )

-- Output a message to all group members, such as notes etc
function outPutGroupMessage (groupname, message,r,g,b)
	local playertable = getElementsByType("player")
	local groupPlayerTable = {}

	for i,v in ipairs(playertable ) do
		local playersGroup = getElementData( v, "Group" )
		if groupname == playersGroup then
			outputChatBox(message,v,r or 200,g or 0,b or 0,true)
		end
	end
end

-- Output message thats send by a player
function outPutGroupMessageByPlayer (thePlayer, message)
	local sourceGroup = getElementData( thePlayer, "Group" )
	if message:match("^%s*$") then
		exports.DENdxmsg:createNewDxMessage(thePlayer, "You didnt enter a message!", 200, 0, 0)
	else
		local nick = getPlayerName(thePlayer)
		local playertable = getElementsByType("player")
		local groupPlayerTable = {}

		for i,v in ipairs(playertable ) do
			local playersGroup = getElementData( v, "Group" )
			if sourceGroup == playersGroup then
				outputChatBox(message,v,200,0,0,true)
			end
		end
	end
end
-- alliance chat


local allianceChatSpam = {}

function onAllianceChat(player,commName,...)
	if ( exports.server:getPlayerAccountName ( player ) ) then

		local sourceGroup = exports.server:getPlayerGroupID(player)
		local sourceAlliance = getElementData(player,"alliance")
		local sourceAllianceName = exports.csggroups:alliances_getAllianceName(sourceAlliance)
		local message = table.concat({...}, " ")
		if not ( sourceAlliance ) then
			exports.DENdxmsg:createNewDxMessage( player, "Your group is not in an alliance!",200,0,0,true)
		elseif message:match("^%s*$") then
			exports.DENdxmsg:createNewDxMessage( player, "You didn't enter a message!", 200, 0, 0)
		elseif ( allianceChatSpam[player] ) and ( getTickCount()-allianceChatSpam[player] < 1000 ) then
			exports.DENdxmsg:createNewDxMessage( player, "You are typing too fast! The limit is one message each second.", 200, 0, 0)
		elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then
			exports.DENdxmsg:createNewDxMessage( player, "You are muted!", 236, 201, 0)
		else
			allianceChatSpam[player] = getTickCount()
			local nick = getPlayerName( player )
			local playertable = getElementsByType("player")
			local groupPlayerTable = {}
			local thePlayerGroup = exports.server:getPlayerGroupName(player)

			for i,v in ipairs(playertable ) do
				local playersAlliance = getElementData(v,"alliance")
				if (playersAlliance) and (sourceAlliance) and sourceAlliance == playersAlliance then
					if ( getElementData( v, "chatOutputAlliancechat" ) ) then
						outputChatBox("(ALLIANCE) ["..thePlayerGroup.."] "..nick..": #ffffff"..message,v,0,255,0,true)
					end
					triggerClientEvent( v, "onChatSystemMessageToClient", v, player, message, "Alliancechat" ) -- sends to DENchatsystem
				end
			end
			exports.CSGlogging:createLogRow ( player, "alliancechat", message, thePlayerGroup )
		end
	end
end
addCommandHandler( "alliance", onAllianceChat, false, false )
addCommandHandler( "ac", onAllianceChat, false, false )
addCommandHandler( "alliancechat", onAllianceChat, false, false )
