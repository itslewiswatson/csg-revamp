------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppFish_s.lua (server-side)
--  Fisherman Job
--  Priyen Patel
------------------------------------------------------------------------------------


--[[
FishermanVehs = {
	[453] = {"Reefer",1,1,1,1},
	[484] = {"Marquis",1,1,1,1}
}
 --LS
 { "Fisherman", "Civilian Workers", 979.92, -2087.71, 4.8, 255, 255, 255, false, {35,36,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 2.1 }
 { 939.47, -2062.04, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 85}
 { 939.47, -2102.69, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 90}

 --SF
 { "Fisherman", "Civilian Workers", -2425.48, 2321, 4.99, 255, 255, 0, false, {35,36,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 2 }
 {   -2417.9, 2302.69, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 267}

 --LV
 { "Fisherman", "Civilian Workers", 1623.78, 606.04, 7.78 , 255, 255, 0, false, {35,36,37}, 3, false, "Work as a Fisherman to get fish and earn money!", 360 }
 {  1624.54, 571.48, -0.56, 255, 255, 0, FishermanVehs, "Civilian Workers", "Fisherman", 270}


 --]]
local limit = {}
local records = {}
records = fromJSON(tostring('[ { "Barracuda": [ "[CSG]Dredd|TSF", 11 ], "Tuna": [ "LCPL-Epicman[A-MF]", 11 ], "Squid": [ "Rig-16", 3792 ], "Red Snapper": [ "IL-0*GODFather|INV", 44 ], "Amberjack": [ "Rig-16", 110 ], "Mackeral": [ "~|T|~AlNhDe", 39 ], "Sea Bass": [ "Abdo|D", 11 ], "Lobster": [ "[CSG]Dredd|TSF", 36 ], "Sail Fish": [ "Smile^|D", 45 ], "Grouper": [ "SGT|USS|-OsKar\/*", 40 ], "Trout": [ "TA-Wolf#B[FIA]", 11 ], "Turtle": [ "Ankur|D", 105 ], "Eel": [ "[CSG]TheBenja^", 11 ], "Pike": [ "~|T|~AlNhDe", 43 ], "Shark": [ "Zod", 3854 ], "Catfish": [ "TA-Wolf#B[FIA]", 10 ], "Swordfish": [ "UA*L0-Luke[Sm]", 249 ], "Pirahna": [ "UA*[TSF]ViTo|>Re", 10 ], "Blue Marlin": [ "[CSG]The.V[Sm]", 3018 ] } ]'))
local billboardData = {5,4,1,0}

function reset()
	limit = {}
end
setTimer(reset,3600000,0)

function CSGfishGoodCatch(i)
	if i == 1 then -- money suitcase
		local m = math.random(500,1500)
		givePlayerMoney(source,m)
		 exports.DENdxmsg:createNewDxMessage(source,"Caught a money suitcase! Found $"..m.."",0,255,0)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from non-selling fish",m)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from fishing overall",m)
	elseif i == 2 then -- weapon suitcase
		 exports.DENdxmsg:createNewDxMessage(source,"Found a weapon suitcase!",255,255,0)
		 exports.DENdxmsg:createNewDxMessage(source,"But you dont want it so you threw it back!",255,255,0)
	elseif i == 3 then -- drug suitcase
		 exports.DENdxmsg:createNewDxMessage(source,"Found a drug suitcase!",255,255,0)
		 exports.DENdxmsg:createNewDxMessage(source,"But you dont want it so you threw it back!",255,255,0)
		-- exports.DENdxmsg:createNewDxMessage(source,"drug suit case TODO",255,255,0)
	elseif i == 6 then -- treasure chest
		local m = math.random(1500,10000)
		givePlayerMoney(source,m)
		 exports.DENdxmsg:createNewDxMessage(source,"Caught a treasure chest! Found $"..m.."",0,255,0)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from non-selling fish",m)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from fishing overall",m)
	end
end
addEvent("CSGfishGoodCatch",true)
addEventHandler("CSGfishGoodCatch",root,CSGfishGoodCatch)

sizes = {
	["Very Small"] = {0.1,9.9},
	["Small"] = {10,24.9},
	["Medium"] = {25,99.9},
	["Large"] = {100,249.9},
	["Huge"] = {250,749.9},
	["Massive"] = {750,999.9},
	["Colossal"] = {1000,9999}
}
common = {
	["Amberjack"] = {pricePerKg = 65.44,size={"Medium","Large"}},
	["Grouper"] = {pricePerKg = 101.97,size={"Small","Medium"}},
	["Red Snapper"] = {pricePerKg = 136.11,size={"Small","Medium"}},
	["Trout"] = {pricePerKg = 16.50,size={"Very Small","Small"}},
	["Sea Bass"] = {pricePerKg = 508.56,size={"Very Small","Small"}},
	["Pike"] = {pricePerKg = 118.46,size={"Small","Medium"}},
	["Sail Fish"] = {pricePerKg = 36.41,size={"Small","Medium"}},
	["Tuna"] = {pricePerKg = 372.60,size={"Very Small","Small"}},
	["Eel"] = {pricePerKg = 341.84,size={"Very Small","Small"}},
	["Barracuda"] = {pricePerKg = 494.51,size={"Very Small","Small"}},
}
rare = {
	["Mackeral"] = {pricePerKg = 164.11,size={"Small","Medium"}},
	["Dolphin"] = {pricePerKg = 131.24,size={"Large","Very Large"}},
	["Turtle"] = {pricePerKg = 169.59,size={"Medium","Large"}},
	["Catfish"] = {pricePerKg = 656.21,size={"Very Small","Small"}},
	["Swordfish"] = {pricePerKg = 16.22,size={"Large","Huge"}},
	["Squid"] = {pricePerKg = 29.10,size={"Small","Colossal"}},
	["Pirahna"] = {pricePerKg = 1026.20,size={"Very Small","Small"}}
}
veryrare = {
	["Blue Marlin"] = {pricePerKg = 23.62,size={"Large","Colossal"}},
	["Shark"] = {pricePerKg = 27.68,size={"Huge","Colossal"}},
	["Lobster"] = {pricePerKg = 771.51,size={"Very Small","Medium"}}
}
local bonusClaimed = false
local bonusName = false
local bonusWeight = false
local bonusValue = false

function newBonus()
	bonusClaimed = false
	local tableToUse=false
	local sizeToUse=false
	local num = math.random(1,100)
	if num <= 90 then	-- common catches
			tableToUse=common
			sizeToUse=10
		elseif num > 94 and num <= 97 then -- rare
			tableToUse=rare
			sizeToUse=7
		elseif num > 97 and num <= 100 then -- very rare
			tableToUse=veryrare sizeToUse=3
	end
	local t = tableToUse
	local size = sizeToUse
	local i = math.random(1,size)
	local count = 1
	local k = ""
	for k0,v in pairs(t) do
		if count == i then k=k0 break end
			count = count + 1
	end
		local weightMin = math.random(sizes[t[k]["size"][1]][1],sizes[t[k]["size"][1]][2])
		local weightMax = math.random(sizes[t[k]["size"][2]][1],sizes[t[k]["size"][2]][2])
		if weightMax == nil then WeightMax = weightMin+1 end
		local weight = math.random(weightMin,weightMax)
		weight=weight*0.453592
		weight=math.floor(weight+0.5)
		local value = weight*(t[k].pricePerKg)
		value=value/5
		value=value*0.7
		value=math.floor(value+0.5)
		bonusValue=value+(math.random(20000))
		bonusName=k
		bonusWeight=weight
		announceBonus()
end

function announceBonus()
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) then

			exports.DENdxmsg:createNewDxMessageBot(v,"Be the first to catch it!",0,255,0)
			exports.DENdxmsg:createNewDxMessageBot(v,"#33CCCCToday's Bonus Fish is a #00FF33"..bonusName.."#33CCCC, valued at #33FF00$"..bonusValue.."#33CCCC. (Minimum Weight "..bonusWeight.." Kg)",0,255,0)

		end
	end
end

addCommandHandler("fishbonustest",function()
	newBonus()
	announceBonus()
end)

function bonusFishCheck(nam,weight)
	if nam == bonusName and weight >= bonusWeight then
		return true
	else
		return false
	end
end

function sendData(p)
	local ele = ""
	if (p) then
		if isElement(p) == true then
			ele = p
		else
			if (source) then
				if isElement(source) then
					ele = source
				end
			end
		end
	end
	local t = fromJSON( exports.DENstats:getPlayerAccountData(ele,"fishstat"))
	if t == nil or t[1] == nil or t[2][18] == nil or t[3] == nil then
		t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0}}
		 exports.DENstats:setPlayerAccountData(ele,"fishstat",toJSON(t))
	end
	--exports.DENstats:setPlayerStats(ele,"fishstat",toJSON({{},{0,0,0,0,0,0,0,0,0,0,0,0,0}}))
	triggerClientEvent(ele,"CSGfishRecData",ele,t)
end

function recUpdate(t,permits)
	local t0 = fromJSON( exports.DENstats:getPlayerAccountData(source,"fishstat"))
	if t0 == nil or t0[1] == nil or t0[2][18] == nil or t0[3] == nil then t0 = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0}} end
	t0[1] = t
	t0[3][1] = permits
	exports.DENstats:setPlayerAccountData(source,"fishstat",toJSON(t0))
end
addEvent("CSGfishRecMyFishUpdate",true)
addEventHandler("CSGfishRecMyFishUpdate",root,recUpdate)

addEventHandler("onPlayerLogin",root, function()
	local p = source
	setTimer(function() sendData(p) sendRecordInfo(p) end,5000,1)
end)

setTimer(function()
for k,v in pairs(getElementsByType("player")) do
	if exports.server:isPlayerLoggedIn( v ) == true then
		sendData(v)
		sendRecordInfo(v)
	end
end
end,5000,1)

function newRecord(fish,weight)
	if records[fish] == nil then records[fish] = {"No One",0} end
	if records[fish][2] < weight then
		local prev = records[fish][2]
		if records[fish][1] ~= "No One" then
			triggerClientEvent(source,"CSGfishAddStat",source,"# of times record broken",1)
		end
		records[fish][2] = weight
		records[fish][1] = getPlayerName(source)
		 exports.DENdxmsg:createNewDxMessage(source,"Congratulations! You have beat the "..fish.." record!",0,255,0)
		 exports.DENdxmsg:createNewDxMessage(source,"Previous Record: "..prev.." Kg. New Record: "..weight.." Kg",0,255,0)
		sendRecordInfo()
	end
end
addEvent("CSGfishNewRecord",true)
addEventHandler("CSGfishNewRecord",root,newRecord)

function sendRecordInfo(p)
	if not(p) then
		triggerClientEvent(root,"CSGfishRecRecords",root,records)
	else
		triggerClientEvent(p,"CSGfishRecRecords",p,records)
	end
end


local nameToI = {
	["# of Fish Caught In Life Time"] = 1,
	["# of Common Fish Caught"] = 2,
	["# of Rare or Very Rare Fish Caught"] = 3,
	["# of Other Bad Caught"] = 4,
	["# of Other Good Caught"] = 5,
	["# of times nothing Caught"] = 6,
	["# of times record broken"] = 7,
	["$ Money earned from fishing overall"] = 8,
	["$ Money earned from selling fish"] = 9,
	["$ Money earned from non-selling fish"] = 10,
	["# of times eaten by jaws"] = 11,
	["# of times attacked by things you caught"] = 12,
	["# of times ganged on by sea monsters"] = 13,
	["# of times eaten a fish"] = 14,
	["# of times dropped a fish"] = 15,
	["# of times released a fish"] = 16,
	["$ Fish value caught"] = 17,
	["# of Kilograms of fish caught"] = 18
}


function CSGfishSetStat(stat,value,p,bool,st,rankPts)
	if (p) then
		if isElement(p) == false then
			if isElement(source) then p = source end
		end
	end
	if (bool) then
		if bool == true then
			if isElement(p) then
				if getElementType(p) == "player" then
					triggerClientEvent(p,"CSGfishAddStat",p,stat,value)
					return
				end
			end
		end
	end
	--local stats = fromJSON(exports.DENstats:getPlayerStats(source,"busdriverstat"))
	if (rankPts) then
		exports.DENstats:setPlayerAccountData(source, "fisherman", rankPts)
	end
	--if st == nil then st = {} end
	--st[nameToI[stat]] = value
	local t = fromJSON( exports.DENstats:getPlayerAccountData(source,"fishstat"))
	--local t = fromJSON(exports.DENstats:getPlayerStats(source,"fishstat"))
	if t == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0}} end
	t[2] = st
	 exports.DENstats:setPlayerAccountData(source,"fishstat",toJSON(t))
	--exports.DENstats:setPlayerStats( source, "fishstat", toJSON(t), true )
end
addEvent("CSGfishSetStat",true)
addEventHandler("CSGfishSetStat",root,CSGfishSetStat)

function caughtAFish(cat)
	local k = "fish"
	if cat == "common" then
		billboardData[2]=billboardData[2]+1
	elseif cat == "rare" then
		billboardData[3]=billboardData[3]+1
	elseif cat == "veryrare" then
		billboardData[4]=billboardData[4]+1
	end
	--exports.CSGbillboards:setBillboardData(k,billboardData)
	billboardData[1] = billboardData[1]+1

	--local t = fromJSON(exports.DENstats:getPlayerStats(source,"fishstat"))
	--[[if t[3][1] > 0 then
		t[3][1] = t[3][1]-1
		exports.DENstats:setPlayerStats(source,"fishstat",toJSON(t))
	elseif exports.server:getPlayerOccupation(source) ~= "Fisherman" then
			exports.server:givePlayerWantedPoints(source, 5)
	end--]]
end
addEvent("CSGfishCaughtAFish",true)
addEventHandler("CSGfishCaughtAFish",root,caughtAFish)

function CSGfishWanted()
	exports.server:givePlayerWantedPoints(source, 5)
end
addEvent("CSGfishWanted",true)
addEventHandler("CSGfishWanted",root,CSGfishWanted)

function CSGfishBuy(am,money)
	if getPlayerMoney(source) >= money then
		takePlayerMoney(source,money)
		local t = fromJSON( exports.DENstats:getPlayerAccountData(source,"fishstat"))
		--local t = fromJSON(exports.DENstats:getPlayerStats(source,"fishstat"))
		if t == nil or t[1] == nil or t[2][18] == nil or t[3][1] == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0}} end
		local new = tonumber(t[3][1])+am
		t[3][1] = new
		 exports.DENstats:setPlayerAccountData(source,"fishstat",toJSON(t))
		--exports.DENstats:setPlayerStats(source,"fishstat",toJSON(t),true)
		sendData(source)
		 exports.DENdxmsg:createNewDxMessage(source,"Bought a $"..money.." "..am.." fish permit.",0,255,0)
		 exports.DENdxmsg:createNewDxMessage(source,"New Total Fish Permit: "..new.."",0,255,0)
	else
		 exports.DENdxmsg:createNewDxMessage(source,"You can't afford $"..money.." "..am.." permit.",255,0,0)
	end
end
addEvent("CSGfishBuy",true)
addEventHandler("CSGfishBuy",root,CSGfishBuy)

local rankBonuses = {
	0,0,0,2,5,10,30,40
}

function CSGfishSoldFish(name,we,val,fisher,rankI)
local accName = exports.server:getPlayerAccountName(source)
	if limit[accName] == nil then limit[accName] = 60000 end
	if limit[accName] < 0 then
		 exports.DENdxmsg:createNewDxMessage(source,"You've sold us too much fish! You are damaging CSG's ocean life!",0,255,0)
		 exports.DENdxmsg:createNewDxMessage(source,"You will get wanted if you sell us anymore for this hour.",0,255,0)
		exports.server:givePlayerWantedPoints(source, 10)
	end

	local rankBonus = 0
	if (fisher) then
		if fisher == true then
			rankBonus=(val*((rankBonuses[rankI])/100))
		end
	end
	local tot = val+rankBonus
	tot=math.floor(tot+0.5)
	limit[accName] = limit[accName]-tot
	if limit[accName] < 0 then
		 exports.DENdxmsg:createNewDxMessage(source,"You've sold us too much fish! You are damaging CSG's ocean life!",0,255,0)
		 exports.DENdxmsg:createNewDxMessage(source,"You will get wanted if you fish anymore for this hour.",0,255,0)
	end
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from fishing overall",tot)
	triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from selling fish",tot)
	givePlayerMoney(source,tot)
	local scorePer3000=1
	local multi = tot/3000
	exports.CSGscore:givePlayerScore(source,scorePer3000*multi)
	 exports.DENdxmsg:createNewDxMessage(source,"Sold a "..we.." Kg "..name.." for $"..val.." + Rank Bonus $"..rankBonus.."",0,255,0)
end
addEvent("CSGfishSoldFish",true)
addEventHandler("CSGfishSoldFish",root,CSGfishSoldFish)

function newJob(p)
	triggerClientEvent(p,"CSGfishJob",p,true)
end

function quitJob(p)
	triggerClientEvent(p,"CSGfishJob",p,false)
end

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if nJob == "Fisherman" then
		newJob(source)
	else
		if oldJob == "Fisherman" then
		quitJob(source)
		else
			local team = getTeamName(getPlayerTeam(source))
			if team ~= "Civilian Workers" then
				quitJob(source)
			end
		end
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function addRankPts(ps,cmdName,arg1,amt)
	local p = getPlayerFromName(arg1)
	if not(amt) then
		outputChatBox("Please enter a valid number",ps,255,0,0)
		return
	end
	if tonumber(amt) ~= nil then else outputChatBox("Please enter a valid number",ps,255,0,0) return end
	if isElement(p) == true then
		triggerClientEvent(p,"CSGfishAddStat",p,"# of Fish Caught In Life Time",tonumber(amt))
		triggerClientEvent(p,"CSGfishAddStat",p,"# of Common Fish Caught",tonumber(amt))
		outputChatBox("Gave "..arg1.." "..amt.." Fisherman Rank Points",ps,0,255,0)
		 exports.DENdxmsg:createNewDxMessage(p,""..getPlayerName(ps).." has corrected your Fisherman Rank Points",0,255,0)
		 exports.DENdxmsg:createNewDxMessage(p,""..amt.." Rank Points Added",0,255,0)
	else
		outputChatBox("Please enter a valid player name",ps,255,0,0)
	end
end
addCommandHandler("addfishrankpts",addRankPts)

-----
