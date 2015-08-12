--addEventHandler("onPlayerLogin",root,function() triggerClientEvent(source,"CSGupdates.loggedIn",source)  end)
version = "2.3" --default

local curr = {}
curr = exports.DENmysql:query( "SELECT * FROM updates ORDER BY id DESC LIMIT 30")
function checkForUpdates()
	local temp = exports.DENmysql:query( "SELECT * FROM updates ORDER BY id DESC LIMIT 30")
	if curr[1].text ~= temp[1].text then
		curr = temp
		for k,v in pairs(getElementsByType("player")) do
			exports.DENdxmsg:createNewDxMessage(v,"Another Update to CSG has occurred!",0,255,0)
			exports.DENdxmsg:createNewDxMessage(v,"Type /updates to see it!",0,255,0)
		end
		--sendUpdates() --Not needed, since when they do /updates, it'll then be sent.
	end
end
setTimer(checkForUpdates,1000*60,0)

function sendUpdates(p)
	if (p) then
		triggerClientEvent(p,"recUpdatedList",p,curr)
	else
		for k,v in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(v) then
				triggerClientEvent(v,"recUpdatedList",v,curr)
				triggerClientEvent(v,"recVersion",v,version)
			end
		end
	end
end
addCommandHandler("updates",sendUpdates)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,
function()
		sendUpdates(source)
		triggerClientEvent(source,"CSGupdates.loggedIn",source)
end)

function getServerVersion()
	local data = exports.DENmysql:querySingle("SELECT value FROM settings WHERE settingName=?","serverVersion")
	if (data) then
		local version = data.value
	end
end
setTimer(getServerVersion,(1000*60*10),0)
