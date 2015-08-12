
local nameToRankPt = {
	{"Petty Criminal", 0},
	{"Pick Pocket",10},
	{"Con Artist",20},
	{"Burgler",10},
	{"Drug Smuggler",10},
	{"Smooth Talker",10},
	{"Capo",10},
	{"Don of LV",10},
	{"Soldier",10},
	{"Car Jacker",10},
	{"Hood Rat",10},
	{"Assassin"},
	{""},
}


function changed(name)
	if name == nil then set(source) return end
	setElementData( source, "Rank", name, true )
	exports.dendxmsg:createNewDxMessage(source,"You are now a "..name.."!",255,0,0)
	triggerClientEvent(source,"CSGcriminalskills.updateGUI",source)
	exports.DENmysql:exec( "UPDATE playerstats SET `??`=? WHERE userid=?", "criminalRank", tostring(name), exports.server:getPlayerAccountID(source) )

end
addEvent("CSGcriminalskills.changed",true)
addEventHandler("CSGcriminalskills.changed",root,changed)

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if nJob == "Criminal" then
		set(source)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

function set(p)
		local userID = exports.server:getPlayerAccountID(p)
		local t = exports.DENmysql:querySingle( "SELECT * FROM playerstats WHERE userid=? LIMIT 1", userID )
		local name = tostring(t.criminalRank)
		local valid = false
		for k,v in pairs(nameToRankPt) do if string.lower(v[1]) == string.lower(name) then valid = true end end
		if valid == false then
			name = "Petty Criminal"
			exports.DENmysql:exec( "UPDATE playerstats SET `??`=? WHERE userid=?", "criminalRank", tostring(name), userID)
		end
		setElementData( p, "Rank", name, true )
		triggerClientEvent(p,"CSGcriminalskills.updateGUI",p)
end

addEventHandler("onPlayerLogin",root,function() set(source) end)
