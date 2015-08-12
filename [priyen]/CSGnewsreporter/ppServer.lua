local CD = {}
local players = {

}
--[1] = player, [2] = reason, [3] = pay, [4] = oldWL

function recRequest(p,reason,wl,skip)
	if not p or not reason then return end
	local do1=true
	if do1 == true then
    local cont = true
	if CD[p]==nil then CD[p]=false end
	if CD[p]==true then return end
	if not skip then
		if getElementData(p,"Occupation") == "News Reporter" then return end
	end
    local name = getPlayerName(p)
    local upgradedStory = false

    for k,v in pairs(players) do
        if v[1] == p then
			return--[[
            if v[4] < wl then
                players[k][2] = reason
                players[k][3] = players[k][3] + math.random(500,1000)
                story = true
                players[k][4] = wl
            else
            cont = false
            end--]]
        end
    end

    if cont == false then return end
    local msg = "News HQ: New story incoming ("..reason.."): Get a photo of "..name.." for the CSG media!"
    if upgradedStory == false then
	if #players > 10 then return end

    table.insert(players,{p,reason,math.random(1000,2000),wl})

    else

    end
    sayToAllNewsReporters(msg,0,255,0)
    updateData()
	end
end

setTimer(function()
	if #players == 0 then
		local p = getRandomPlayer()

		recRequest(p,"Suspicious Activity",0,true)
	end
end,10000,0)

local pRanks = {
				{"News Reporter in Training",0,0},
				{"Assistant of Photography", 30, 15},
				{"Photographer", 70, 20},
				{"Editor", 120, 25},
				{"Reporter", 170, 30},
				{"Photo Editor", 240, 35},
				{"Head Editor", 320, 40},
				{"Final Redator", 410, 50}
			}

function RReporterTookPic(person)
    local salary = 0
    local reason = ""
    for k,v in pairs(players) do
        if v[1] == person then
            salary = v[3]
            reason = v[2]
            table.remove(players,k)
            break
        end
    end
	local rank = getElementData(source,"Rank")
	local new
	local bonus = 0
	local rankmoney = 0
	local mypts = exports.DENstats:getPlayerAccountData(source,"newsreporter")
	for k,v in pairs(pRanks) do
		if mypts >= v[2] then bonus=bonus+5000 rankmoney=(salary*(v[3]/100)) new = v[1] end
	end
	rankmoney=math.floor(rankmoney)
	if new ~= rank then
		givePlayerMoney(source,bonus)
		exports.dendxmsg:createNewDxMessage(source,"Congratulations! You have been promoted to "..new..". Promo Bonus: $"..bonus.."",0,255,0)
	end
	guiSetText(lblRank,rank)
    local personName = getPlayerName(person)
 	givePlayerMoney(source,salary)
    exports.dendxmsg:createNewDxMessage(source,"Taken a picture of "..getPlayerName(person).." successfully! Received $"..salary.." + 0.5 Score",0,255,0)

	sayToAllNewsReporters("The story on "..personName.." is now over. "..getElementData(source,"Rank").." "..getPlayerName(source).." has taken a photo and submitted it!",0,255,0)
	--setElementData(source, "PicturesTaken", getElementData(source, "PicturesTaken")+1)
    updateData()
	if rankmoney > 0 then
		givePlayerMoney(source,rankmoney)
		exports.dendxmsg:createNewDxMessage(source,"Rank Bonus: $"..rankmoney.."",0,255,0)
	end
	exports.DENstats:setPlayerAccountData(source,"newsreporter",mypts+1)
	exports.CSGscore:givePlayerScore(source,0.5)
	exports.CSGscore:takePlayerScore(person,0.1)
    setElementData(person,"wantedPoints",getElementData(person,"wantedPoints")+3)
	exports.dendxmsg:createNewDxMessage(person,""..getPlayerName(source).." has taken a photo of you for the media! You were caught for "..reason.."",255,255,0)
    exports.dendxmsg:createNewDxMessage(person,"CSG News! Lies and exaggeration with false info caused your wanted level to go up!",255,0,0)
	if CD[person]==nil then CD[person]=false end
	CD[person]=true
	setTimer(function() CD[person]=false end,60000,1)

 --[[  for k,v in pairs(getElementsByType("player")) do
        exports.dendxmsg(""..personName.." got caught by the media for "..reason.."",255,255,255,255,v)
    end--]]
end
addEvent("RReporterTookPic",true)
addEventHandler("RReporterTookPic",root,RReporterTookPic)

function sayToAllNewsReporters(msg,r,g,b)
   for k,v in pairs(getElementsByType("player")) do
        if getElementData(v,"Occupation") == "News Reporter" then
            exports.dendxmsg:createNewDxMessage(v,msg,r,g,b)
        end
   end
end

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	if getElementData(source,"Occupation") == "News Reporter" and getTeamName(getPlayerTeam(source)) == "Civilian Workers" then
		 local temp = {}
		for k,v in pairs(players) do
			temp[v[1]] = v[2]
		end
		triggerClientEvent(source,"RReporterReport",source,"pu",temp)
	end
end)

function updateData()
    for k,v in pairs(getElementsByType("player")) do
        if getElementData(v,"Occupation") == "News Reporter" then
            local temp = {}
            for k,v in pairs(players) do
				temp[v[1]] = v[2]
            end
            triggerClientEvent(v,"RReporterReport",v,"pu",temp)
        end
    end
end

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	local player=source
	if oldJob == "News Reporter" then
		 triggerClientEvent(player,"RReporterJobChange",player,"quit")
	elseif nJob == "News Reporter" then
		 local temp = {}
		for k,v in pairs(players) do
			temp[v[1]] = v[2]
		end
		triggerClientEvent(player,"RReporterReport",player,"pu",temp)
		--Take photos of criminals, anyone who commits crimes. Check your map for yellow blips to assist you!
		--exports.dendxmsg:createNewDxMessage(player,"This job is in development! Will be added ~Jan 22-23-24",0,255,0)
		triggerClientEvent(player,"RReporterJobChange",player,"became")
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)
