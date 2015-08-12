de=function(e,k,v) return exports.denstats:getPlayerAccountData(e,k,v) end
rank=function(e,occ) local name,num,maxx = exports.csgranks:getRank(e,occ) return ""..name.." ("..num.."/"..maxx..")" end

local rankings = {

}

local statsToRank = {
	"kills",
	"arrests",
	"deaths",
	"score",
	"moneyRobbed",
	"moneyGotRobbed",
	"turfsTaken",
	"radioTurfsTaken",
	"radioTurfsTakenAsCrim",
	"radioTurfsTakenAsCop",
}

top=function(e,stat)

	local id = exports.server:getPlayerAccountID(e)
	if stat == "score" then
		for k,v in pairs(rankings["score"]) do
			if v.id == id then
				return k
			end
		end
	else
		for k,v in pairs(rankings[stat]) do
			if v.userid == id then
				return k
			end
		end
	end
	return "Not Ranked Yet"
end

setTimer(function()
	for k,stat in pairs(statsToRank) do
		local t = {}
		if stat=="score" then
			t = exports.denmysql:query("SELECT * FROM accounts WHERE score != 0 ORDER BY score DESC")
		else
			t = exports.denmysql:query("SELECT * FROM playerstats ORDER BY "..stat.." DESC LIMIT 2500")
		end
		rankings[stat]=t
	end
end,1000,1)

setTimer(function()
	for k,stat in pairs(statsToRank) do
		local t = {}
		if stat=="score" then
			t = exports.denmysql:query("SELECT * FROM accounts WHERE score != 0 ORDER BY score DESC")
		else
			t = exports.denmysql:query("SELECT * FROM playerstats ORDER BY "..stat.." DESC LIMIT 2500")
		end
		rankings[stat]=t
	end
end,60000,1)

setTimer(function()
	for k,stat in pairs(statsToRank) do
		local t = {}
		if stat=="score" then
			t = exports.denmysql:query("SELECT * FROM accounts WHERE score != 0 ORDER BY score DESC")
		else
			t = exports.denmysql:query("SELECT * FROM playerstats ORDER BY "..stat.." DESC LIMIT 2500")
		end
		rankings[stat]=t
	end
end,3600000,1)

function getChiefStatus(e)
	local s = getElementData(e,"polc")
	if s == false then return "No" end
	return	"Chief Level "..s..""
end

function refresh(workingEle)
	local kills = de(workingEle,"kills")
	local deaths = de(workingEle,"deaths")
	local kdr = kills/deaths
	if kills == 0 and deaths==0 then kdr="Undefined" end
	kdr=string.format("%.2f",tostring(kdr))
	--remove KDR
	kdr = "Infinity"
	--remove deaths
	deaths = "Unavailable"
local data = {
	 {
		 "General",
			{"Play Time",getElementData(workingEle,"Play Time")},
			{"Score",getElementData(workingEle,"sbPS")},
			{"Cash",getElementData(workingEle,"Money")},
			{"Kills",kills},
			{"Deaths",deaths},
			{"Kill Death Ratio",kdr},
			{"Money Robbed","$ "..de(workingEle,"moneyRobbed")},
			{"Money got Robbed","$ "..de(workingEle,"moneyGotRobbed")},
			{"# of times Jailed","Unavailable"},
			--{"Wanted Points Earnt","Unavailable"},
			--{"Crimes Commited","Unavailable"},
			{"Radio Turfs Taken",de(workingEle,"radioTurfsTaken")},
	},
	 {
		"Civilian",
			{"Trucker Rank",rank(workingEle,"Trucker")},
			{"Pilot Rank",rank(workingEle,"Pilot")},
			{"Fisherman Rank",rank(workingEle,"Fisherman")},
			{"Bus Driver Rank",rank(workingEle,"Bus Driver")},
			{"News Reporter Rank",rank(workingEle,"News Reporter")},
			{"Lumberjack Rank",rank(workingEle,"Lumberjack")},
			{"Paramedic Rank",rank(workingEle,"Paramedic")},
			{"Mechanic Rank","Unavailable"},
			{"Street Cleaner","Unavailable"},
			{"Garbage Rank","Unavailable"},

	},
	 {
		"Law",
			{"Arrests",de(workingEle,"arrests")},
			{"Arrest Points",de(workingEle,"arrestpoints")},
			{"Assists",de(workingEle,"tazerassists")},
			{"Death on Job","Unavailable"},
			{"Police Rank",rank(workingEle,"Police Officer")},
			{"Police Chief",getChiefStatus(workingEle)},
			{"Radio Turfs Taken",de(workingEle,"radioTurfsTakenAsCop")},
			{"Armored Truck Escorts",de(workingEle,"armoredtrucks")},
			{"CR/BR Participation",de(workingEle,"brcrlaw")},
			{"DS Participation",de(workingEle,"drugshipmentlaw")},
			{"Stolen Cars Recovered",de(workingEle,"hijackcarslaw")},
			--{"SWAT Rank","Unavailable"},
			--{"MF Rank","Unavailable"},
			--{"FBI Rank","Unavailable"},
	},
	 {
		"Criminal",
			--{"Kills","Unavailable"},
			{"Turfs Taken",de(workingEle,"turfsTaken")},
			{"Turfs Defended","Unavailable"},
			{"Death in Turf","Unavailable"},
			{"Radio Turfs Taken",de(workingEle,"radioTurfsTakenAsCrim")},
			{"Pick Pocket $$$","$ "..de(workingEle,"moneyRobbedAsPick")},
			{"Con Artist $$$","$ "..de(workingEle,"moneyRobbedAsCon")},
			{"Hijack Cars Stolen",de(workingEle,"hijackcarscrim")},
			{"BR/CR Failed",de(workingEle,"brcrcrimfail")},
			{"BR/CR Success",de(workingEle,"brcrcrimsuccess")},
			{"DS Participation",de(workingEle,"drugshipmentcrim")},
			{"Houses Robbed","Unavailable"},
	},
	 {	"Ranking",
			{"Most Score","#"..top(workingEle,"score")},
			{"Most Arrests","#"..top(workingEle,"arrests")},
			{"Most Kills","#"..top(workingEle,"kills")},
			{"Most Deaths","#"..top(workingEle,"deaths")},
			{"Most Turfs Taken","#"..top(workingEle,"turfsTaken")},
			{"Most Radio Turfs","#"..top(workingEle,"radioTurfsTaken")},
			{"Most RT as Law","#"..top(workingEle,"radioTurfsTakenAsCop")},
			{"Most RT as Crim","#"..top(workingEle,"radioTurfsTakenAsCrim")},
			{"Most Money Robbed","#"..top(workingEle,"moneyRobbed")},
			{"Most Gotten Robbed","#"..top(workingEle,"moneyGotRobbed")},
			{"Most Houses Value","Unavailable"},
			{"Most Rich","Unavailable"},

	},
}
	triggerClientEvent(source,"CSGstats.rec",source,data)
end
addEvent("CSGstats.get",true)
addEventHandler("CSGstats.get",root,refresh)
