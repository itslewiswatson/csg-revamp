--giveScore
addEvent("giveLimoScore", true)
function score( ammount)
	exports.CSGscore:givePlayerScore(source, ammount)
end
addEventHandler("giveLimoScore", getRootElement(), score)

addEvent("giveLimoMoney", true)
function Money( ammount)
	givePlayerMoney(source, ammount)
end
addEventHandler("giveLimoMoney", getRootElement(), Money)

--get points
function getRank(thePlayer)
	local occc = exports.server:getPlayerOccupation(thePlayer)
	if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
	local pass = exports.denstats:getPlayerAccountData(thePlayer,"limoDriver")
		setElementData(thePlayer, "limo", tostring(pass), true)
	end
end
addEventHandler("onVehicleEnter", getRootElement(), getRank)

addEventHandler("onPlayerLogin", root,
  function()
    local pass = exports.denstats:getPlayerAccountData(source,"limoDriver")
		setElementData(source, "limo", tostring(pass), true)
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
		triggerClientEvent(v,"CSGLimoDriverSayVoiceClient",v,str2)
	end
end
addEvent("CSGLimoDriverSayVoice",true)
addEventHandler("CSGLimoDriverSayVoice",root,triggerVoice)


--set points for quit player
function setqRank()
	local pass = getElementData(source, "limo")
	if (pass == nil) or (pass == false) then
		exports.denstats:setPlayerAccountData(source,"limoDriver", tonumber(0))
	else
		exports.denstats:setPlayerAccountData(source,"limoDriver", tonumber(pass))
	end
end
addEventHandler ( "onPlayerQuit", getRootElement(), setqRank)


--set points when you leave the car
function setRank(thePlayer)
	local occc = exports.server:getPlayerOccupation(thePlayer)
	if ( occc == "Limo Driver") and ( getTeamName( getPlayerTeam( thePlayer ) ) == "Civilian Workers") then
		local playerID = exports.server:getPlayerAccountID( thePlayer )
		local pass = getElementData(thePlayer, "limo")
		exports.denstats:setPlayerAccountData(thePlayer,"limoDriver", tonumber(pass))
	end
end
addEventHandler ( "onVehicleExit", getRootElement(), setRank)