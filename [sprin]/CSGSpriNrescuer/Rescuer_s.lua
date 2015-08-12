--giveRescuerScore
addEvent("giveRescuerScore", true)
function score( ammount)
	exports.CSGscore:givePlayerScore(source, ammount)
end
addEventHandler("giveRescuerScore", getRootElement(), score)

addEvent("giveRescuerMoney", true)
function money( ammount)
	givePlayerMoney(source, ammount)
end
addEventHandler("giveRescuerMoney", getRootElement(), money)

--get points
function getRank(thePlayer)
	local occc = exports.server:getPlayerOccupation(thePlayer)
	if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
	local pass = exports.denstats:getPlayerAccountData(thePlayer,"rescuerMan")
		setElementData(thePlayer, "rescuer", tostring(pass), true)
	end
end
addEventHandler("onVehicleEnter", getRootElement(), getRank)

addEventHandler("onPlayerLogin", root,
  function()
    local pass = exports.denstats:getPlayerAccountData(source,"rescuerMan")
		setElementData(source, "rescuer", tostring(pass), true)
	end
)

function triggerVoice(str,diff)
	local str2 = ""
	if diff == true then
	str2 = "http://translate.google.com/translate_tts?tl=en&q="..str..""
	else
	str2 = "http://translate.google.com/translate_tts?tl=en&q=Nex Stop: "..str..""
	end
	local veh = getPedOccupiedVehicle(source)
	for k,v in pairs(getVehicleOccupants(veh)) do
		triggerClientEvent(v,"rescuerManVoiceClient",v,str2)
	end
end
addEvent("rescuerManVoice",true)
addEventHandler("rescuerManVoice",root,triggerVoice)


--set points for quit player
function setqRank()
	local playerID = exports.server:getPlayerAccountID( source )
	local pass = getElementData(source, "rescuer")
	if (pass == nil) or (pass == false) then
		exports.denstats:setPlayerAccountData(source,"rescuerMan", tonumber(0))
	else
		exports.denstats:setPlayerAccountData(source,"rescuerMan", tonumber(pass))
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), setqRank)


--set points when you leave the car
function setRank(thePlayer)
	local occc = exports.server:getPlayerOccupation(thePlayer)
	if ( occc == "Rescuer Man") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
		local playerID = exports.server:getPlayerAccountID( thePlayer )
		local pass = getElementData(thePlayer, "rescuer")
		exports.denstats:setPlayerAccountData(thePlayer,"rescuerMan", tonumber(pass))
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), setRank)