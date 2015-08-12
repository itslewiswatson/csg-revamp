theMaxPeak = 0
players = 0

weapons = {28,29,30,31,32,33,34}

addEventHandler("onResourceStart",resourceRoot,
function()
	peakQ = exports.DENmysql:querySingle("SELECT value FROM settings WHERE settingName=?","totalPlayerPeak")
	if peakQ then
		theMaxPeak = tonumber(peakQ.value)
		outputDebugString("Peak loaded: "..theMaxPeak)
	else
		theMaxPeak = 100 --default
		outputDebugString("Default peak loaded: "..theMaxPeak)
	end

	for k,v in ipairs(getElementsByType("player")) do --quick loop
		players = players + 1
	end
	if (tonumber(players) >= tonumber(theMaxPeak)) then
		exports.DENdxmsg:createNewDxMessage(root,"A new peak has been reached! Peak is now: "..theMaxPeak,255,0,0)
		exports.DENdxmsg:createNewDxMessage(root,"Enjoy +5 Score",0,255,0)
		theMaxPeak = players
		local randomGive = math.random(1,2)
		for k,player in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(player) == true then
				exports.csgscore:givePlayerScore(player,2.5)
			end
			money = math.random(5000,15000)
			givePlayerMoney(player,money)
			exports.DENdxmsg:createNewDxMessage(player,"You have been given $"..money.."",0,255,0)
		end
	end
end)

addCommandHandler("peak",
function(player)
	if player then
		outputChatBox("Max Peak: "..theMaxPeak,player,255,0,0)
	end
end)

addEventHandler("onResourceStop",resourceRoot,
function()
	if theMaxPeak then --first get this..
		exports.DENmysql:exec("UPDATE settings SET value=? WHERE settingName='totalPlayerPeak'",theMaxPeak)
	end
end)

function onJoin()
	--player = source
	if isElement(player) then
		players = players + 1
		if players >= theMaxPeak then -- new peak
			theMaxPeak = players
			exports.DENdxmsg:createNewDxMessage(root,"A new peak has been reached! Peak is now: "..theMaxPeak,0,255,0)
			exports.DENdxmsg:createNewDxMessage(root,"Enjoy +5 Score",0,255,0)
			exports.DENmysql:exec("UPDATE settings SET value=? WHERE settingName=?",theMaxPeak,"totalPlayerPeak")
			for k,player in pairs(getElementsByType("player")) do
				if exports.server:isPlayerLoggedIn(player) == true then
					exports.csgscore:givePlayerScore(player,2.5)
				end
				money = math.random(5000,15000)
				givePlayerMoney(player,money)
				exports.DENdxmsg:createNewDxMessage(player,"You have been given $"..money.."",0,255,0)
			end
		end
	end
end
addEventHandler("onPlayerJoin",root,onJoin)

function onQuit()
	player = source
	if isElement(player) then
		players = players - 1
	end
end
addEventHandler("onPlayerQuit",root,onQuit)
