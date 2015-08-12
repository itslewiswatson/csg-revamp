local backupSpam = {}

addEvent ("onSendRequestMessage", true)
function onSendRequestMessage ( theTeam, theMessage )
	if ( backupSpam[source] ) and ( getTickCount()-backupSpam[source] < 30000 ) then
		exports.DENdxmsg:createNewDxMessage(source, "Wait 30 seconds before sending a new request!", 225, 0, 0)
	else
		local setting = nil
		if ( theTeam == "SWAT" ) then setting = "swatRequest" elseif ( theTeam == "Military Forces" ) then setting = "mfRequest" elseif ( theTeam == "Police" ) then setting = "policeRequest" elseif ( theTeam == "Government Agency" ) then setting = "dodRequest" end

		backupSpam[source] = getTickCount()
		exports.DENdxmsg:createNewDxMessage(source, "Request was sent!", 0, 225, 0)

		for i, player in ipairs ( getElementsByType("player") ) do
			if ( getPlayerTeam( player ) ) then
				if (getTeamName(getPlayerTeam(player)) == "SWAT") or (getTeamName(getPlayerTeam(player)) == "Military Forces") or (getTeamName(getPlayerTeam(player)) == "Police") or (getTeamName(getPlayerTeam(player)) == "Government Agency") then
					if ( source ~= player ) and ( setting ) and ( getElementData( player, setting ) ) then
						outputChatBox(theMessage, player, 225, 0, 0)
					end
				end
			end
		end
	end
end
addEventHandler ("onSendRequestMessage", root, onSendRequestMessage)

local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}

function isLaw(e)
	local t = getPlayerTeam(e)
	if t==false then return false end
	local team = getTeamName(t)
	for k,v in pairs(lawTeams) do if v == team then return true end end
	return false
end

addEventHandler("onPlayerQuit",root,function()
	for k,v in pairs(getElementsByType("player")) do
		if isLaw(v) == true then
			triggerClientEvent(v,"policeUnblip",v,source)
		end
	end
end)

addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,function()
	for k,v in pairs(getElementsByType("player")) do
		if isLaw(v) == true then
			triggerClientEvent(v,"policeUnblip",v,source)
		end
	end
end)
