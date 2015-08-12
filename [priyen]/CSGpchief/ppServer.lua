local chiefs = {
	["gusolina"] = 5,
	["priyen"] = 5,
	--["blackblood"] = 2,
	["abdogangs"] = 3,
	["maxil1"] = 4,
	["fatal"] = 3,
	["sensei"] = 5,
	["bunny"] = 2,
 	["chris2312"] = 5,
	["hashytk"] = 4,
	["maxcamelot"] = 4,
	["imaster"] = 5,
	["fiveseven"] = 5,
	["ranger"] = 2,
	["Micheal"] = 2,
	["furgons"] = 3,
	["mashcof"] = 1,
	["salman14"] = 1,
	["lior"] = 1,
	["valentim17"] = 1,
	["smith"] = 1,
	["TheHitman13"] = 1,
	["mada_killer"] = 1,
	["tr2012"]=1,
}

aeh=addEventHandler
ach = addCommandHandler

local logs = {}

aeh("onServerPlayerLogin",root,function()
	local nam = exports.server:getPlayerAccountName(source)
	if chiefs[nam] ~= nil then
		setElementData(source,"polc",chiefs[nam],true)
		triggerClientEvent(source,"pchiefRecRank",source,chiefs[nam])
	end
	sendLogs(source)
end)

function isLaw(p)
	local nam = getTeamName(getPlayerTeam(p))
	if nam == "Military Forces" or nam == "Police" or nam == "SWAT" or nam == "Government Agency" or nam == "Staff" then
		return true
	else
		return false
	end
end

function setLevel(ps,_,user,level)
	local pl = getElementData(ps,"polc")
	if (pl == false) or (pl ~= 5) then
		outputChatBox("You are not authorized to change the Police Chief Roster",ps,255,0,0)
		return
	end
	if not (user) then
		outputChatBox("You didn't specify a user name. Usage: /pchiefsetlevel username level  0=remove",ps,255,0,0)
		return
	end
	if not (level) or (type(tonumber(level)) ~= "number") then
		outputChatBox("You didn't specify a valid level. Usage: /pchiefsetlevel username level  0=remove",ps,255,0,0)
		return
	end
	level = tonumber(level)
	chiefs[user] = level
	for k,v in pairs(chiefs) do
		if v == 0 then
			chiefs[k] = nil
		end
	end
	local str = toJSON(chiefs)
	exports.DENmysql:exec('UPDATE serverstats SET value=? WHERE name=?',str,"policeChiefRoster")
	outputChatBox("You have set "..user.."'s Police Chief Rank to Level "..level.."",ps,0,255,0)
	logAction("set Username "..user.."'s Police Chief Rank to Level "..level..")",ps)
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:getPlayerAccountName(v) == user then
			outputChatBox(""..getPlayerName(ps).." has set your Police Chief Rank to Level "..level.."",v,0,255,0)
			setElementData(v,"polc",level,true)
			triggerClientEvent(v,"pchiefRecRank",v,level)
			return
		end
	end
end
ach("pchiefsetlevel",setLevel)

function printRoster(ps)
	for k,v in pairs(chiefs) do
		if v > 0 then
			outputChatBox("Username: "..k..". Level: "..v.."",ps,0,255,0)
		end
	end
end
ach("pchiefprintroster",printRoster)

function logAction(action,chief)
	local acc = exports.server:getPlayerAccountName(chief)
	local name = getPlayerName(chief)
	local namerow = name.."("..acc..") Level "..chiefs[acc]..""
	local datum = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
	table.insert(logs,{action,namerow,datum})
	sendLogs(nil,action,namerow,datum)
	local r,g,b = 0,0,0
	if string.find(action,"Unbanned") then r,g,b = 0,255,0 else r,g,b = 255,0,0 end
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then
			if isLaw(v) then
				outputChatBox(name.." (Police Chief Level "..chiefs[acc]..")  has "..action.."",v,r,g,b)
			end
		end
	end
	save()
end

function sendLogs(p,action,namerow,datum)
	if (p) then
		local tlogs = logs
		local size = #tlogs
		if size > 25 then
			for i=1,size-25 do
				table.remove(tlogs,1)
			end
		end
		triggerClientEvent(p,"pchiefLogT",p,tlogs)
	else
		for k,v in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(v) then
				triggerClientEvent(v,"pchiefLogAction",v,action,namerow,datum)
			end
		end
	end
end

addCommandHandler("plogtest",function(ps)
	logAction("test",ps)
end)

local recWarn = {}

addCommandHandler("pwarn",function(ps,cmd,name,...)
	local acc = exports.server:getPlayerAccountName(ps)
	if (chiefs[acc]) then
		if not(isLaw(ps)) then return end
		if chiefs[acc] >= 1 then
			local data = {...}
			local t = {}
			tim=data[#data]
			local reason = ""
			for k,v in pairs(data) do  table.insert(t,1,v)   end
			for k,v in pairs(t) do if reason ~= "" then reason=v.." "..reason else reason = v  end end
			if (reason) and (reason ~= "") and (name) then
				local e = exports.server:getPlayerFromNamePart(name)
				if (e) and isElement(e) then
					if isLaw(e) and getTeamName(getPlayerTeam(e)) ~= "Staff" then
						if (recWarn[exports.server:getPlayerAccountName(e)]) then
							recWarn[exports.server:getPlayerAccountName(e)]=nil

							logAction(""..getPlayerName(e).." (Kicked due to repeat warning) for ("..reason..")",ps)
							exports.DENdxmsg:createNewDxMessage(e,""..getPlayerName(ps).." (Police Chief) has kicked you from the job: "..reason.."",255,0,0)
							if isLaw(e) then
								triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))
							end
						else
							recWarn[exports.server:getPlayerAccountName(e)]=true
							logAction("Warned "..getPlayerName(e).." for ("..reason..")",ps)
							exports.DENdxmsg:createNewDxMessage(e,""..getPlayerName(ps).." (Police Chief) has warned you for: "..reason.."",255,0,0)
						end
					else
						exports.DENdxmsg:createNewDxMessage(ps,name.." is not in a law Enforcement job at the moment",255,0,0)
					end
				else
					exports.DENdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)
				end
			else
				if not(name) then
					exports.DENdxmsg:createNewDxMessage(ps,"You did not specify a player name!",255,0,0)
					return
				elseif not(reason) or reason=="" then
					exports.DENdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
				end
			end
		else
			exports.DENdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
		end
	end
end)

addCommandHandler("pkick",function(ps,cmd,name,...)
	local acc = exports.server:getPlayerAccountName(ps)
	if (chiefs[acc]) then
		if not(isLaw(ps)) then return end
		if chiefs[acc] >= 2 then
			local data = {...}
			local t = {}
			tim=data[#data]
			local reason = ""
			for k,v in pairs(data) do  table.insert(t,1,v)   end
			for k,v in pairs(t) do if v ~= tim then  reason=v.." "..reason else reason = v end   end
			if (reason) and (reason ~= "") and (name) then
				local e = exports.server:getPlayerFromNamePart(name)
				if (e) and isElement(e) then
					if isLaw(e) and getTeamName(getPlayerTeam(e)) ~= "Staff" then
						logAction("Kicked "..getPlayerName(e).." from Law Enforcement for ("..reason..")",ps)
						exports.DENdxmsg:createNewDxMessage(e,""..getPlayerName(ps).." (Police Chief) has kicked you from the job: "..reason.."",255,0,0)
						if isLaw(e) then
							triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))
						end
					else
						exports.DENdxmsg:createNewDxMessage(ps,name.." is not in a law Enforcement job at the moment",255,0,0)
					end
				else
					exports.DENdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)
				end
			else
				if not(name) then
					exports.DENdxmsg:createNewDxMessage(ps,"You did not specify a player name!",255,0,0)
					return
				elseif not(reason) or reason=="" then
					exports.DENdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
				end
			end
		else
			exports.DENdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
		end
	end
end)

addCommandHandler("pban",function(ps,cmd,name,...)
	local acc = exports.server:getPlayerAccountName(ps)
	if (chiefs[acc]) then
		if isLaw(ps) == false then return end
		if chiefs[acc] >= 3 then
			local data = {...}
			local t = {}
			tim=data[#data]
			local reason = ""
			for k,v in pairs(data) do if v ~= tim then table.insert(t,1,v) end end
			for k,v in pairs(t) do if v ~= tim then if reason ~= "" then reason=v.." "..reason else reason = v end end end
			if (tim) and (chiefs[acc] == 3) then
				exports.DENdxmsg:createNewDxMessage(ps,"You do not have permission to specify ban time!",255,0,0)
			else
				if not(reason) or reason=="" then
					exports.DENdxmsg:createNewDxMessage(ps,"You did not specify a reason!",255,0,0)
					return
				end

				if (name) then
					local e = exports.server:getPlayerFromNamePart(name)
					if (e) and isElement(e) then
						if (tim) then
							local timem = tonumber(tim)
							if type(timem) == "number" and math.floor(timem) > 0 then
								exports.DENjob:banFromJob(exports.server:getPlayerAccountName(e),"LawBan",math.floor(timem))
								logAction("Banned "..getPlayerName(e).." from Law Enforcement for ("..reason..") "..math.floor(timem).." Minutes",ps)
								if isLaw(e) then
									triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))
								end
							else
								exports.DENdxmsg:createNewDxMessage(ps,"Invalid time input",255,0,0)
							end
						else
							exports.DENjob:banFromJob(exports.server:getPlayerAccountName(e),"LawBan",60)
							logAction("Banned "..getPlayerName(e).." from Law Enforcement ("..reason..") for 60 Minutes",ps)
							if isLaw(e) then
								triggerEvent("onQuitJob",e,getElementData(e,"Occupation"))
							end
						end
					else
						exports.DENdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)
					end
				else
					exports.DENdxmsg:createNewDxMessage(ps,"You did not specify a player name",255,0,0)
				end
			end
		else
			exports.DENdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
		end
	end
end)

addCommandHandler("punban",function(ps,cmd,name)
	local acc = exports.server:getPlayerAccountName(ps)
	if (chiefs[acc]) then
		if chiefs[acc] >= 5 then
			if (name) then
				local e = exports.server:getPlayerFromNamePart(name)
				if (e) and isElement(e) then
					local acc = exports.server:getPlayerAccountName(e)
					if exports.DENjob:unbanFromJob(acc,"LawBan") == true then
						logAction("Unbanned "..getPlayerName(e).." from Law Enforcement",ps)
						exports.DENdxmsg:createNewDxMessage(e,"You have been unbanned from Law Enforcement",0,255,0)
					else
						exports.DENdxmsg:createNewDxMessage(ps,name.." was not banned",255,0,0)
					end
				else
					exports.DENdxmsg:createNewDxMessage(ps,name.." is not a valid player",255,0,0)
				end
			else
				exports.DENdxmsg:createNewDxMessage(ps,"You did not specify a player name",255,0,0)
			end
		else
			exports.DENdxmsg:createNewDxMessage(ps,"You do not have permission to use this command!",255,0,0)
		end
	end
end)

function save()
	xmlRootTree = xmlLoadFile ( "userSettings.xml" ) --Attempt to load the xml file
	if xmlRootTree then -- If the xml loaded then...
		xmlHudBranch = xmlFindChild(xmlRootTree,"data",0) -- Find the hud sub-node
	else -- If the xml does not exist then...
		xmlRootTree = xmlCreateFile ( "userSettings.xml", "root" ) -- Create the xml file
		xmlHudBranch = xmlCreateChild ( xmlRootTree, "data" ) -- Create the hud sub-node under the root node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "saved"), toJSON({}) ) --Create sub-node values under the hud sub-node

	end
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"saved",0),toJSON(logs))
	xmlSaveFile(xmlRootTree)
end

function loads()
	xmlRootTree = xmlLoadFile ( "userSettings.xml" ) --Attempt to load the xml file
	if xmlRootTree then -- If the xml loaded then...
		xmlHudBranch = xmlFindChild(xmlRootTree,"data",0) -- Find the hud sub-node
	else -- If the xml does not exist then...
		xmlRootTree = xmlCreateFile ( "userSettings.xml", "root" ) -- Create the xml file
		xmlHudBranch = xmlCreateChild ( xmlRootTree, "data" ) -- Create the hud sub-node under the root node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "saved"), toJSON({}) ) --Create sub-node values under the hud sub-node

	end

	saved = (xmlNodeGetValue (xmlFindChild(xmlHudBranch,"saved",0)))

	logs = fromJSON(saved)

	if logs == nil then logs = {} end
	setTimer(function() for k,v in pairs(getElementsByType("player")) do sendLogs(v) end end,5000,1)
	xmlSaveFile(xmlRootTree)
	local t=exports.DENmysql:query( "SELECT * FROM serverstats WHERE name=? LIMIT 1", "policeChiefRoster" )
	local res = false
	if t == nil then
		t = chiefs
	else
		local ts = nil
		for k,v in pairs(t) do
			ts = v.value
			ts = fromJSON(ts)
			break
		end
		chiefs = ts
	end
end
loads()
