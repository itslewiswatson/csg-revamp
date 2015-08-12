de=function(e,k,v) return exports.denstats:getPlayerAccountData(e,k,v) end
rank=function(e,occ) local name,num,maxx = exports.csgranks:getRank(e,occ) return ""..name.." ("..num.."/"..maxx..")" end
function refresh(workingEle)
local data = {
	 {
		 "General",
			{"Play Time",getElementData(workingEle,"Play Time")},
			{"Score",getElementData(workingEle,"sbPS")},
			{"Cash",getElementData(workingEle,"Money")},
			{"Kills",de(workingEle,"kills")},
			{"Deaths",de(workingEle,"deaths")},
			{"Money Robbed","Unavailable"},
			{"Money got Robbed","Unavailable"},
	},
	 {
		"Civilian",
			{"Trucker Rank",rank(workingEle,"Trucker")},
			{"Pilot Rank",rank(workingEle,"Pilot")},
			{"Fisherman Rank",rank(workingEle,"Fisherman")},
			{"Bus Driver Rank",rank(workingEle,"Bus Driver")},
			{"News Reporter Rank","Unavailable"},
			{"Electrician Rank","Unavailable"},
			{"Mechanic Rank","Unavailable"},
			{"Street Cleaner","Unavailable"},
			{"Garbage Rank","Unavailable"},

	},
	 {
		"Law",
			{"Arrests",de(workingEle,"arrests")},
			{"Arrest Points",de(workingEle,"arrestpoints")},
			{"Assists","Unavailable"},
			{"Death on Job","Unavailable"},
			{"Police Rank",rank(workingEle,"Police Officer")},
			--{"SWAT Rank","Unavailable"},
			--{"MF Rank","Unavailable"},
			--{"FBI Rank","Unavailable"},
	},
	 {
		"Criminal",
			--{"Kills","Unavailable"},
			{"Turfs Taken","Unavailable"},
			{"Turfs Defended","Unavailable"},
			{"Death in Turf","Unavailable"},
			{"Pick Pocket $$$","Unavailable"},
			{"Con Artist $$$","Unavailable"},
			{"Houses Robbed","Unavailable"},
	},
	 {	"Ranking",
			{"Most Score","Unavailable"},
			{"Most Rich","Unavailable"},
			{"Most Kills","Unavailable"},
			{"Most Deaths","Unavailable"},
			{"Most Turfs Taken","Unavailable"},
			{"Most Money Robbed","Unavailable"},
			{"Most Robbed","Unavailable"},
			{"Most Houses Value","Unavailable"},

	},
}
	triggerClientEvent(source,"CSGstats.rec",source,data)
end
addEvent("CSGstats.get",true)
addEventHandler("CSGstats.get",root,refresh)
