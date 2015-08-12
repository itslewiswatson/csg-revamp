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

local records = {}
local billboardData = {5,4,1,0}

function CSGfishGoodCatch(i)
	if i == 1 then -- money suitcase
		local m = math.random(500,1500)
		givePlayerMoney(source,m)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"Caught a money suitcase! Found $"..m.."",0,255,0)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from non-selling fish",m)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from fishing overall",m)
	elseif i == 2 then -- weapon suitcase
		exports.DENhelp:createNewHelpMessageForPlayer(source,"Found a weapon suitcase!",255,255,0)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"But you dont want it so you threw it back!",255,255,0)
	elseif i == 3 then -- drug suitcase
		exports.DENhelp:createNewHelpMessageForPlayer(source,"Found a drug suitcase!",255,255,0)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"But you dont want it so you threw it back!",255,255,0)
		--exports.DENhelp:createNewHelpMessageForPlayer(source,"drug suit case TODO",255,255,0)
	elseif i == 6 then -- treasure chest
		local m = math.random(1500,10000)
		givePlayerMoney(source,m)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"Caught a treasure chest! Found $"..m.."",0,255,0)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from non-selling fish",m)
		triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from fishing overall",m)
	end
end
addEvent("CSGfishGoodCatch",true)
addEventHandler("CSGfishGoodCatch",root,CSGfishGoodCatch)

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
	local t = fromJSON(exports.DENstats:getPlayerStats(ele,"fishstat"))
	if t == nil or t[1] == nil or t[2][18] == nil or t[3] == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0}} end
	--exports.DENstats:setPlayerStats(ele,"fishstat",toJSON({{},{0,0,0,0,0,0,0,0,0,0,0,0,0}}))
	triggerClientEvent(ele,"CSGfishRecData",ele,t)
end

function recUpdate(t)
	local t0 = fromJSON(exports.DENstats:getPlayerStats(source,"fishstat"))
	if t0 == nil or t0[1] == nil or t0[2][18] == nil or t0[3] == nil then t0 = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0}} end
	t0[1] = t
	exports.DENstats:setPlayerStats(source,"fishstat",toJSON(t0))
end
addEvent("CSGfishRecMyFishUpdate",true)
addEventHandler("CSGfishRecMyFishUpdate",root,recUpdate)

addEventHandler("onPlayerLogin",root, function()
	local p = source
	setTimer(function() sendData(p) sendRecordInfo(p) end,5000,1)
end)

setTimer(function()
for k,v in pairs(getElementsByType("player")) do
	if exports.server:isPlayerLoggedIn( v ) == false then
		sendData(v)
		sendRecordInfo(v)
	end
end
end,5000,1)

function newRecord(fish,weight)
	if records[fish] == nil then records[fish] = {"No One",0} end
	if records[fish][2] < weight then
		local prev = records[fish][2]
		triggerClientEvent(source,"CSGfishAddStat",source,"# of times record broken",1)
		records[fish][2] = weight
		records[fish][1] = getPlayerName(source)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"Congratulations! You have beat the "..fish.." record!",0,255,0)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"Previous Record: "..prev.." Kg. New Record: "..weight.." Kg",0,255,0)
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
		--exports.DENstats:setPlayerStats( source, "busdriver", rankPts, true )
	end
	if st == nil then st = {} end
	st[nameToI[stat]] = value
	local t = fromJSON(exports.DENstats:getPlayerStats(source,"fishstat"))
	if t == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0}} end
	t[2] = st
	exports.DENstats:setPlayerStats( source, "fishstat", toJSON(t), true )
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

	local t = fromJSON(exports.DENstats:getPlayerStats(source,"fishstat"))
	if t[3][1] > 0 then
		t[3][1] = t[3][1]-1
		exports.DENstats:setPlayerStats(source,"fishstat",toJSON(t))
	elseif exports.server:getPlayerOccupation(source) ~= "Fisherman" then
			exports.server:givePlayerWantedPoints(source, 5)
	end
end
addEvent("CSGfishCaughtAFish",true)
addEventHandler("CSGfishCaughtAFish",root,caughtAFish)

function CSGfishBuy(am,money)
	if getPlayerMoney(source) >= money then
		takePlayerMoney(source,money)
		local t = fromJSON(exports.DENstats:getPlayerStats(source,"fishstat"))
		if t == nil or t[1] == nil or t[2][18] == nil or t[3][1] == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0},{0}} end
		local new = tonumber(t[3][1])+am
		t[3][1] = new
		exports.DENstats:setPlayerStats(source,"fishstat",toJSON(t),true)
		sendData(source)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"Bought a $"..money.." "..am.." fish permit.",0,255,0)
		exports.DENhelp:createNewHelpMessageForPlayer(source,"New Total Fish Permit: "..new.."",0,255,0)
	else
		exports.DENhelp:createNewHelpMessageForPlayer(source,"You can't afford $"..money.." "..am.." permit.",255,0,0)
	end
end
addEvent("CSGfishBuy",true)
addEventHandler("CSGfishBuy",root,CSGfishBuy)

local rankBonuses = {
	0,0,0,2,5,10,15,20,30,40
}

function CSGfishSoldFish(name,we,val,fisher,rankI)
	local rankBonus = 0
	if (fisher) then
		if fisher == true then
			rankBonus=(val*((rankBonuses[rankI])/100))
		end
	end
	local tot = val+rankBonus
	tot=math.floor(tot+0.5)
	triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from fishing overall",tot)
	triggerClientEvent(source,"CSGfishAddStat",source,"$ Money earned from selling fish",tot)
	givePlayerMoney(source,tot)
	exports.DENhelp:createNewHelpMessageForPlayer(source,"Sold a "..we.." Kg "..name.." for $"..val.." + Rank Bonus $"..rankBonus.."",0,255,0)
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
