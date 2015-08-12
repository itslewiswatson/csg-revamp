local ver = 2
text = {
{"some solid gold jewellery and got $"},
{"a band new plasma TV worth $"},
{"some good quality crack and sold it for $"},
{"some good quality heroin and sold it for $"},
{"some good quality LSD and sold it for $"},
{"a safe full of cash and found inside $"},
{"a hidden stash of cash and found $"}
}
addEvent("givePlayerHouseRobEarnings",true)
addEventHandler("givePlayerHouseRobEarnings",root,
function(earnings,wanted)
	if (earnings) then
		givePlayerMoney(source,earnings)
		--points = exports.DENstats:getPlayerAccountData(player,"robbingpoints")
		--exports.DENstats:setPlayerAccountData(player,"robbingpoints",points+1)
		--[[bonusCash = 0
		if bonusCash then
			randomText = math.random(1,#text)
			exports.dendxmsg:createNewDxMessage(source,"You found "..text[randomText][1]..""..exports.server:convertNumber(bonusCash),0,255,0)
			givePlayerMoney(source,bonusCash)
		end--]]
		if (wanted == true) then
			exports.server:givePlayerWantedPoints(source,10)
		end
	end
end)

function getBonusCash(points)
	if points == "In progress.." then return 0 end --debug line.
	if points < 250 then --no bonus
		return 0
	elseif points > 250 and points < 500 then --bonus 1
		return 250
	elseif points > 500 and points < 750 then --bonus 2
		return 500
	elseif points > 750 and points < 1000 then --more than 750 and less than 999
		return 750
	elseif points > 1000 then --more than 1000
		return 1000
	else
		return
	end
end

addCommandHandler("rob:points",
function(player,cmd)
	points = exports.DENstats:getPlayerAccountData(player,"robbingpoints")
	if points then
		outputChatBox("Robbing points: "..points,player,255,0,0)
	else
		outputChatBox("Error getting your points!",player,255,0,0)
	end
end)

addCommandHandler("rob:version",
function(player,cmd)
	outputChatBox("Version: "..ver,player,0,255,0)
end)
