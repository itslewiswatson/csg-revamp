local chat_range=100
local showtime = tonumber(get("chatbubbles.DefaultTime"))
local characteraddition = tonumber(get("chatbubbles.PerCharacterAddition"))
local maxbubbles = get("chatbubbles.MaxBubbles")
if maxbubbles == "false" then maxbubbles = false else maxbubbles = tonumber(maxbubbles) end
local hideown = get("chatbubbles.HideOwn")
if hideown == "true" then hideown = true else hideown = false end

local localChatSpam = {}
 
addEventHandler("onPlayerJoin",root,
function ()
	bindKey(source,"u","down","chatbox","Localchat")
end)
 
addEventHandler("onResourceStart",getResourceRootElement(getThisResource()),
function ()
	for index, player in pairs(getElementsByType("player")) do
		bindKey(player,"u","down","chatbox","Localchat")
	end
end)
 
function isPlayerInRangeOfPoint(player,x,y,z,range)
   local px,py,pz=getElementPosition(player)
   return ((x-px)^2+(y-py)^2+(z-pz)^2)^0.5<=range
end
 
function onPlayerMessagelocalChat(player,_,...)
	if ( exports.server:getPlayerAccountName ( player ) ) then
		local px,py,pz = getElementPosition(player)
		local message = table.concat({...}, " ")
		if ( exports.server:getPlayerAccountName ( player ) ) then
			if message:match("^%s*$") then
				exports.DENdxmsg:createNewDxMessage(player, "You didn't enter a message", 200, 0, 0)
			elseif ( localChatSpam[player] ) and ( getTickCount()-localChatSpam[player] < 1000 ) then
				exports.DENdxmsg:createNewDxMessage(player, "You are typing to fast! The limit is one message each second.", 200, 0, 0)
			elseif ( exports.CSGadmin:getPlayerMute ( player ) == "Global" ) then
				exports.DENdxmsg:createNewDxMessage(player, "You are muted!", 236, 201, 0)
			else
				localChatSpam[player] = getTickCount()
				local nick = getPlayerName(player)
				local r,g,b = getTeamColor(getPlayerTeam(player))
				local playertable = getElementsByType("player")
				local newplayertable = {}
				
				for i,v in ipairs(playertable ) do
					if getElementDimension (v) == getElementDimension (player) then
						if isPlayerInRangeOfPoint(v,px,py,pz,chat_range) then
							table.insert(newplayertable , v)
						end
					end
				end
			
				local thecount = #newplayertable -1
				for _,v in ipairs(newplayertable ) do
					if getElementAlpha( v ) == 0 then thecount = thecount -1 end
					if ( getElementData( v, "chatOutputLocalchat" ) ) then
						outputChatBox("(LOCAL) ["..thecount.."]"..nick..": #ffffff"..message,v,r,g,b,true)
					end
					triggerClientEvent( v, "onChatSystemMessageToClient", v, player, message, "Localchat" )
				end
				triggerClientEvent("onChatbubblesMessageIncome", player, message, 1)
				exports.CSGlogging:createLogRow ( player, "localchat", message )
			end
		end
	end
end
addCommandHandler( "Localchat", onPlayerMessagelocalChat, false,false )
addCommandHandler( "local", onPlayerMessagelocalChat,false,false )

addEvent("onAskForBubbleSettings",true)
function returnSettings()
	local settings =
	{
		showtime,
		characteraddition,
		maxbubbles,
		hideown
	}
	triggerClientEvent(source,"onBubbleSettingsReturn",root,settings)
end
addEventHandler("onAskForBubbleSettings",root,returnSettings)