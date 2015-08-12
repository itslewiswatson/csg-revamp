-- Call service with phone
addEvent( "onPhoneCallService", true )
function onPhoneCallService ( theOccupation, theTeam )
	local players = getElementsByType("player")
	for i=1,#players do
		if ( getTeamName( getPlayerTeam( players[i] ) ) == theTeam ) and players[i] ~= source then
			if ( getElementData( players[i], "Occupation" ) == theOccupation ) or theTeam ~= "Civilian Workers" then
				triggerClientEvent(players[i], "onPlayerJobCall", source, theOccupation, theTeam )
			end
		end
	end
end
addEventHandler( "onPhoneCallService", root, onPhoneCallService )

-- Event for change email
addEvent( "onPlayerEmailChange", true )
function onPlayerEmailChange ( theEmail, thePassword )
	if ( theEmail ) and ( thePassword ) then
		exports.server:updatePlayerEmail( source, theEmail, thePassword )
	end
end
addEventHandler( "onPlayerEmailChange", root, onPlayerEmailChange )

-- Event for change password
addEvent( "onPlayerPasswordChange", true )
function onPlayerPasswordChange ( newPassword, newPassword2, oldPassword )
	if ( newPassword ) and ( newPassword2 ) and ( oldPassword ) then
		exports.server:updatePlayerPassword( source, newPassword, newPassword2, oldPassword )
	end
end
addEventHandler( "onPlayerPasswordChange", root, onPlayerPasswordChange )

-- Event send money
addEvent( "onTransferMoneyToPlayer", true )
function onTransferMoneyToPlayer ( toPlayer, theMoney )
	if ( isElement( toPlayer ) ) then
		if ( getPlayerMoney( source ) >= tonumber(theMoney) ) then
			givePlayerMoney( toPlayer, tonumber(theMoney) )
			takePlayerMoney( source, tonumber(theMoney) )

			exports.DENdxmsg:createNewDxMessage( toPlayer, getPlayerName( source ).." sent you $"..theMoney, 225, 0, 0 )
			exports.DENdxmsg:createNewDxMessage( source, "$ " .. theMoney .. " has been sent to "..getPlayerName( toPlayer), 225, 0, 0 )

			exports.CSGlogging:createLogRow ( source, "money", getPlayerName(source).." sent $".. theMoney .." to ".. getPlayerName(toPlayer) .." (IPHONE APP)" )
			exports.CSGlogging:createLogRow ( toPlayer, "money", getPlayerName(toPlayer).." recieved $".. theMoney .." from ".. getPlayerName(source) .." (IPHONE APP)" )
		else
			exports.DENdxmsg:createNewDxMessage( source, "You don't have enough money!", 225, 0, 0 )
		end
	end
end
addEventHandler( "onTransferMoneyToPlayer", root, onTransferMoneyToPlayer )

local youtubePendings = {}
local tempIDS = {}

-- Music stuff
addEvent("CSGyoutube.badLink",true)
addEventHandler("CSGyoutube.badLink",root,function(link)
	if youtubePendings[link] ~= nil then
		if isElement(youtubePendings[link]) then
			triggerClientEvent(youtubePendings[link],"CSGphone.badYoutube",youtubePendings[link],link)
		else
			youtubePendings[link]=nil
		end
	end
end)

addEvent("CSGyoutube.recSizeValidity",true)
addEventHandler("CSGyoutube.recSizeValidity",root,function(link,valid,length,name)
	if youtubePendings[link] ~= nil then
		if isElement(youtubePendings[link]) then
			if valid == true then
				--triggerClientEvent("CSGphone.validYoutube",youtubePendings[link],link,name)
			else
				exports.DENdxmsg:createNewDxMessage(youtubePendings[link],"Server :: YouTube link "..link.." is too long! The limit is 1200 seconds, or 20 minutes",255,255,0)
				return
			end
		else
			youtubePendings[link]=nil
		end
	end
end)

addEvent("CSGphone.youtubeReq",true)
addEventHandler("CSGphone.youtubeReq",root,function(link)
	local exists = exports.CSGyoutube:doesAlreadyExistLink(link)
	if type(exists) == "table" then
		if exists.name == "" then
			exists.name = ">>Being Processed<<"
		end
		triggerClientEvent(source,"CSGphone.validYoutube",source,exists.youtubelink,exists.name,exists.id)
	else
		youtubePendings[link]=source
		exports.CSGyoutube:attemptProcessLink(link)
	end
end)

addEvent("CSGphone.musicAdded",true)
addEventHandler("CSGphone.musicAdded",root,function(t)
	local name,link=t[1],t[2]
	local id = nil
	if t[3] ~= nil then
		id = t[3]
	end
	local username = exports.server:getPlayerAccountName(source)
	local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
	if #t > 0 then
		local data = t[1].data
		data=fromJSON(data)
		table.insert(data,{name,link,id})
		exports.DENmysql:query("UPDATE personalmusic SET data=? WHERE username=?",toJSON(data),username)
	else
		local data = {}
		table.insert(data,{name,link,id})
		exports.DENmysql:exec( "INSERT INTO personalmusic SET username=?, data=?",username,toJSON(data))
	end
	exports.DENdxmsg:createNewDxMessage(source,"Added Music :: Name - "..name..". Link - "..link.."",0,255,0)
end)

addEvent("CSGphone.removemusic",true)
addEventHandler("CSGphone.removemusic",root,function(link)
	local username = exports.server:getPlayerAccountName(source)
	local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
	local data = t[1].data
	data=fromJSON(data)
	for k,v in pairs(data) do
		if v[2] == link then
			exports.DENdxmsg:createNewDxMessage(source,"Music :: Removed "..v[1].."",0,255,0)
			table.remove(data,k)
			break
		end
	end
	exports.DENmysql:query("UPDATE personalmusic SET data=? WHERE username=?",toJSON(data),username)

end)

addEvent("CSGyoutube.idMade",true)
addEventHandler("CSGyoutube.idMade",root,function(link,id)
	tempIDS[id]=link
end)

addEvent("CSGyoutube.gotTitle",true)
addEventHandler("CSGyoutube.gotTitle",root,function(title,id)
	if isElement(youtubePendings[tempIDS[id]]) then
		triggerClientEvent(youtubePendings[tempIDS[id]],"CSGphone.validYoutube",youtubePendings[tempIDS[id]],tempIDS[id],title,id)
	end
end)

local vehmusic = {}
addEvent("CSGphone.addedToVeh",true)
addEventHandler("CSGphone.addedToVeh",root,function(url,pos,maxx,name)
	vehmusic[source]={url,pos,maxx*1000,name}
	playForVeh(source)
end)

addEvent("CSGphone.removedFromVeh",true)
addEventHandler("CSGphone.removedFromVeh",root,function()
	killSoundVeh(source)
	vehmusic[source] = nil
end)

function killSoundVeh(veh)
	local t=getVehicleOccupants(veh)
	for k,v in pairs(t) do
		if isElement(v) then
			exports.DENdxmsg:createNewDxMessage(v,"**Vehicle Sound System -- Music Off**",0,255,0)
			triggerClientEvent(v,"CSGphone.stopCarSound",v)
		end
	end
	vehmusic[veh]=nil
end

function playForVeh(veh)
	local t=getVehicleOccupants(veh)
	for k,v in pairs(t) do
		if isElement(v) then
			if getPedOccupiedVehicleSeat(v) ~= 0 then
				exports.DENdxmsg:createNewDxMessage(v,"Vehicle Sound System - Playing "..vehmusic[veh][4].." - "..math.floor(vehmusic[veh][2]/1000).."s/"..math.floor(vehmusic[veh][3]/1000).."s",0,255,0)
				triggerClientEvent(v,"CSGphone.playCarSound",v,vehmusic[veh][1],vehmusic[veh][2],vehmusic[veh][4])
			end
		end
	end
end

addEventHandler("onVehicleExit",root,function(p,seat)
	if seat == 0 then
		if vehmusic[source] ~= nil then
			killSoundVeh(source)
			triggerClientEvent(p,"CSGphone.stopCarSound",p)
		end
	else
		triggerClientEvent(p,"CSGphone.stopCarSound",p)
	end
end)

addEventHandler("onVehicleEnter",root,function(p)
	if vehmusic[source] ~= nil and isElement(getVehicleController(source)) and getVehicleController(source) ~= p then
		local v=p
		local veh=source
		exports.DENdxmsg:createNewDxMessage(v,"Vehicle Sound System - Playing "..vehmusic[veh][4].." - "..math.floor(vehmusic[veh][2]/1000).."s/"..math.floor(vehmusic[veh][3]/1000).."s",0,255,0)
		triggerClientEvent(v,"CSGphone.playCarSound",v,vehmusic[veh][1],vehmusic[veh][2],vehmusic[veh][4])
	end
end)

setTimer(function()
	for k,v in pairs(vehmusic) do
		if v ~= nil then
			local tim = v[2]
			tim=tim+1000
			if tim > v[3] then
				tim = 0
			end
			vehmusic[k][2]=tim
		end
	end
end,1000,0)

addEventHandler("onPlayerLogin",root,function()
	local username = exports.server:getPlayerAccountName(source)
	local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
	if #t > 0 then
		local data = fromJSON(t[1].data)
		for k,v in pairs(data) do
		local exists = exports.CSGyoutube:doesAlreadyExistLink(v[2])
			if type(exists) == "table" then
				if v[1] == "" then
					data[k][1] = exists.name
				end
			end
		end
		triggerClientEvent(source,"CSGphone.recMySongList",source,data)
	end
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		local username = exports.server:getPlayerAccountName(source)
		local t = exports.DENmysql:query("SELECT * FROM personalmusic WHERE username=?",username)
		if #t > 0 then
			local data = fromJSON(t[1].data)
			for k,v in pairs(data) do
				local exists = exports.CSGyoutube:doesAlreadyExistLink(v[2])
				if type(exists) == "table" then
					if v[1] == "" then
					data[k][1] = exists.name
					end
				end
			end
			triggerClientEvent(source,"CSGphone.recMySongList",source,data)
		end
	end
end,5000,1)

addEvent("resetAnim",true)
addEventHandler("resetAnim",root,function()
	setPedAnimation(source,false)
end)
