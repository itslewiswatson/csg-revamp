local allowed = {
	["ralph367"] = true,
	["fsaw97"] = true,
	["jockedabaws"] = true,
	["fcpranav"] = true,
	["paschi"] = true,
	--["pascal"] = true,
}
msg = function(a,b,c,d,e) exports.dendxmsg:createNewDxMessage(a,b,c,d,e) end
local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}
---getElementData(p,"Group") == "The Terrorists" and

function isLaw(e)
	local team = getTeamName(getPlayerTeam(e))
	for k,v in pairs(lawTeams) do if v == team then return true end end
	return false
end

addCommandHandler("settjob",function(ps,_,name)
	if allowed[exports.server:getPlayerAccountName(ps)] then
		if not name then
			msg(ps,"Usage: /settjob player'sNameHere",255,0,0)
		else
			local p = getPlayerFromParticalName(name)
			if not(p) then
				msg(ps,"There is no player with the name "..name.."",255,0,0)
			else
				if isElement(p) then
					if isLaw(p) == false and (not(getTeamName(getPlayerTeam(p))=="Staff") and getTeamName(getPlayerTeam(ps)) ~= "Staff") then
						triggerEvent("enterCriminalJob",p,p)
						setElementModel(p,136)

						msg(p,"You have been thrusted into The Terrorists job by "..getPlayerName(ps).."",0,255,0)
						msg(ps,"You have thrust "..getPlayerName(p).." into The Terrorists job",0,255,0)
						setPlayerNametagColor(p,0, 52, 52)
					else
						msg(ps,getPlayerName(p).." is in a police job or isn't in The Terrorists Group or is on Staff Duty",255,0,0)
					end
				end
			end
		end
	else
		msg(ps,"You are not authorized to use this command",255,0,0)
	end
end)

function removeHEX( message )
	return string.gsub(message,"#%x%x%x%x%x%x", "")
end

function getPlayerFromParticalName(thePlayerName)
	local thePlayer = getPlayerFromName(thePlayerName)
	if thePlayer then
		return thePlayer
	end
	for _,thePlayer in ipairs(getElementsByType("player")) do
		if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), thePlayerName:lower(), 1, true) then
			return thePlayer
		end
	end
	return false
end
---
addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
--addEvent("onPlayerLogin",true)
--addEventHandler("onPlayerLogin",root,function()
	if getElementData(source,"Group") == "The Terrorists" and getElementModel(source) == 136 then
		setPlayerNametagColor(source,0, 50, 50)
		--outputChatBox("Prime", source, 0, 255, 0)
	end
end)
--
addCommandHandler("terr",function(player)
if getElementData(player,"Group") == "The Terrorists" and getElementModel(player) == 136 then
setPlayerNametagColor(player,0, 0, 50)
end
end)

addCommandHandler("staff",function(ps)
	setPlayerNametagColor(ps,false)
end)

addCommandHandler("crim",function(ps,_,...)
	if not exports.server:isPlayerLoggedIn(ps) then return end
	local msg = table.concat({...}, " ")
	if getTeamName(getPlayerTeam(ps)) == "Criminals" then
		triggerEvent("onPlayerChat",ps,msg,2,ps,true)
	end
end)
