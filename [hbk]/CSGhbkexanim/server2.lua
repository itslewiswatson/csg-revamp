
local allowedTeams1 = {
        ["Criminals"] = true,

    }

	local allowedTeams2 = {
        ["Military Forces"] = true,
        ["Government Agency"] = true,
        ["SWAT"] = true,
        ["Police"] = true,
		["Staff"] = true,
    }
local warnsCD = {}
setTimer(function()
	local count = getTickCount()

	for k,v in pairs(warnsCD) do
		if count-v > 3000 then
			warnsCD[k]=nil
		end
	end
end,1000,0)
function copanim1 ( thePlayer )
 if isPedInVehicle(thePlayer) then return end
if (allowedTeams1[getTeamName(getPlayerTeam(thePlayer))]) then
	if warnsCD[thePlayer] then
		exports.DENdxmsg:createNewDxMessage(thePlayer,"Please wait before trying to surrender again",255,0,0)
		return
	end
	end
	warnsCD[thePlayer] = getTickCount()
	if getPlayerWantedLevel(thePlayer) > 0 and not(getElementData(thePlayer,"isPlayerArrested")) and not(getElementData(thePlayer,"isPlayerJailed")) then
		setPedAnimation ( thePlayer, "ped", "handsup", 5000, false,true,true)
		exports.DENdxmsg:createNewDxMessage(thePlayer,"You have given your self up and surrendered ",255,0,0)
	else
		exports.DENdxmsg:createNewDxMessage(thePlayer,"Your not wanted or are in jail or arrested, you can't surrender",255,0,0)
	end
--end
end
 addCommandHandler("surr", copanim1)

function copanim2 ( thePlayer )
 if isPedInVehicle(thePlayer) then return end
if (allowedTeams2[getTeamName(getPlayerTeam(thePlayer))]) then
 setPedAnimation ( thePlayer, "POLICE", "CopTraf_Stop", 5000, true,true,true )
end
end
addCommandHandler("costop", copanim2)



function copanim3 ( thePlayer )
 if isPedInVehicle(thePlayer) then return end
if (allowedTeams2[getTeamName(getPlayerTeam(thePlayer))]) then
setPedAnimation ( thePlayer, "POLICE", "CopTraf_Left", 5000, true,true,true )
end
end
addCommandHandler("comove", copanim3)


function copanim4 ( thePlayer )
 if isPedInVehicle(thePlayer) then return end
if (allowedTeams2[getTeamName(getPlayerTeam(thePlayer))]) then
setPedAnimation ( thePlayer, "POLICE", "CopTraf_Away", 5000, true,true,true )
end
end
addCommandHandler("cogo", copanim4)


function copanim5 ( thePlayer )
 if isPedInVehicle(thePlayer) then return end
if (allowedTeams2[getTeamName(getPlayerTeam(thePlayer))]) then
setPedAnimation ( thePlayer, "POLICE", "CopTraf_Come", 5000, true,true,true )
end
end
addCommandHandler("cocome", copanim5)



