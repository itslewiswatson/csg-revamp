
--exports.DENmysql:query("UPDATE crimes SET crime=? WHERE userid=? AND timestamp=?",toJSON(accountToday[accName]),userid,theStamp)
--local t2 = exports.DENmysql:query( "SELECT timestamp FROM crimes WHERE userid=? AND timestamp=?",userid,11111111)

local currentRanks = {

}

addEventHandler("onPlayerLogin",root,function()
	local user = exports.server:getPlayerAccountName(source)
	local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",user)
	for k,v in pairs(t2) do
		--if v.Lawgroup == "SWAT Team" then
			if v.Rank ~= nil and v.Rank ~= false then
				for _,player in pairs(getElementsByType("player")) do
					triggerClientEvent(player,"recRank",player,user,v.Rank,v.Lawgroup)
				end
				table.insert(currentRanks,{user,v.Rank,v.Lawgroup})
			end
		--end
	end
	for k,v in pairs(currentRanks) do
		triggerClientEvent(source,"recRank",source,v[1],v[2],v[3])
	end
end)

addEventHandler("onPlayerQuit",root,function()
	local user = exports.server:getPlayerAccountName(source)
	for k,v in pairs(currentRanks) do
		if v[1] == user then
			table.remove(currentRanks,k)
			return
		end
	end
end)

addCommandHandler("setswatrank",function(ps,cmdName,user,r1,r2,r3)
	if exports.server:getPlayerAccountName(ps) == "gusolina" or exports.server:getPlayerAccountName(ps) == "abdogangs" or exports.server:getPlayerAccountName(ps) == "maxil1" then
		local rank = ""
		if (user) and (r1) and (r1 ~= nil and r1 ~= "") then
			rank = r1
			if (r2) then
				rank=rank.." "..r2..""
			end
			if (r3) then
				rank=rank.." "..r3..""
			end
		else
			exports.dendxmsg:createNewDxMessage(ps,"Set Swat rank usage: /setswatrank user rank",255,0,0)
			return
		end
		local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",user)
		if #t2 > 0 then
			local isSwat = false
			for k,v in pairs(t2) do
				if v.Lawgroup == "SWAT Team" then
					isSwat=true
				end
			end
			if isSwat == false then
				exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"SWAT Team",rank)
				--insert
			else
				exports.DENmysql:query("UPDATE officiallawranks SET Rank=? WHERE Username=? AND Lawgroup=?",rank,user,"SWAT Team")
				--update
			end
		else --insert
			exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"SWAT Team",rank)
		end
		exports.dendxmsg:createNewDxMessage(ps,"You have set Username "..user.."'s SWAT Team rank to "..rank..".",0,255,0)
		exports.dendxmsg:createNewDxMessage(ps,"Tell that person to relog for their rank to be updated on scoreboard",0,255,0)
	end
end)

addCommandHandler("setfbirank",function(ps,cmdName,user,r1,r2,r3)
	if exports.server:getPlayerAccountName(ps) == "gusolina" or exports.server:getPlayerAccountName(ps) == "priyen" or exports.server:getPlayerAccountName(ps) == "fiveseven"or exports.server:getPlayerAccountName(ps) == "sensei" then
		local rank = ""
		if (user) and (r1) and (r1 ~= nil and r1 ~= "") then
			rank = r1
			if (r2) then
				rank=rank.." "..r2..""
			end
			if (r3) then
				rank=rank.." "..r3..""
			end
		else
			exports.dendxmsg:createNewDxMessage(ps,"Set Swat rank usage: /setfbirank user rank",255,0,0)
			return
		end
		local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",user)
		if #t2 > 0 then
			local isSwat = false
			for k,v in pairs(t2) do
				if v.Lawgroup == "FBI" then
					isSwat=true
				end
			end
			if isSwat == false then
				exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"FBI",rank)
				--insert
			else
				exports.DENmysql:query("UPDATE officiallawranks SET Rank=? WHERE Username=? AND Lawgroup=?",rank,user,"FBI")
				--update
			end
		else --insert
			exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"FBI",rank)
		end
		exports.dendxmsg:createNewDxMessage(ps,"You have set Username "..user.."'s FBI rank to "..rank..".",0,255,0)
		exports.dendxmsg:createNewDxMessage(ps,"Tell that person to relog for their rank to be updated on scoreboard",0,255,0)
	end
end)

addCommandHandler("setmfrank",function(ps,cmdName,user,r1,r2,r3)
	if exports.server:getPlayerAccountName(ps) == "hashytk" or exports.server:getPlayerAccountName(ps) == "spirit" or exports.server:getPlayerAccountName(ps) == "vi-docks" then
		local rank = ""
		if (user) and (r1) and (r1 ~= nil and r1 ~= "") then
			rank = r1
			if (r2) then
				rank=rank.." "..r2..""
			end
			if (r3) then
				rank=rank.." "..r3..""
			end
		else
			exports.dendxmsg:createNewDxMessage(ps,"Set mf rank usage: /setmfrank user rank",255,0,0)
			return
		end
		local t2 = exports.DENmysql:query( "SELECT * FROM officiallawranks WHERE Username=?",user)
		if #t2 > 0 then
			local ismf = false
			for k,v in pairs(t2) do
				if v.Lawgroup == "Military Forces" then
					ismf=true
				end
			end
			if ismf == false then
				exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"Military Forces",rank)
				--insert
			else
				exports.DENmysql:query("UPDATE officiallawranks SET Rank=? WHERE Username=? AND Lawgroup=?",rank,user,"Military Forces")
				--update
			end
		else --insert
			exports.DENmysql:query( "INSERT INTO officiallawranks SET Username=?, Lawgroup=?, Rank=?",user,"Military Forces",rank)
		end
		exports.dendxmsg:createNewDxMessage(ps,"You have set Username "..user.."'s Military Forces rank to "..rank..".",0,255,0)
		exports.dendxmsg:createNewDxMessage(ps,"Tell that person to relog for their rank to be updated on scoreboard",0,255,0)
	end
end)

-------------
local pilotRanks = {
	{ "Pilot in Training", 0 },
	{ "Student Pilot", 30 },
	{ "Amature Pilot", 50 },
	{ "Private Pilot", 75 },
	{ "First Officer", 100 },
	{ "Senior First Officer", 125 },
	{ "Captain", 175 },
	{ "Flight Captain", 250 },
	{ "Senior Flight Captain", 350 },
	{ "Commercial Captain", 600 },
}

local policeRanks = {
	{"Officer in Training", 0},
	{"Recruit Officer", 40},
	{"Foot Patrol", 60},
	{"Constable", 80},
	{"Sergeant", 100},
	{"Sergeant II", 150},
	{"Chief Inspector", 200},
	{"Lieutenant", 250},
	{"Superintendent", 300},
	{"Lieutenant II", 350},
	{"Captain", 400},
	{"Commissioner", 450},
}

local busdriverRanks = {
	{ "Bus Driver In Training", 0 },
	{ "New Bus Driver", 15 },
	{ "Trained Bus Driver", 45 },
	{ "Experienced Bus Driver", 200 },
	{ "Senior Bus Driver", 300 },
	{ "Lead Bus Driver", 400 },
	{ "Chief Bus Driver", 500 },
	{ "Head Bus Driver", 1000 },
	{ "SA Busing CEO", 2000 },
}

local fisherRanks = {
	{ "New Fisherman", 0 },
	{ "Regular Fisherman", 15 },
	{ "Experienced Fisherman", 200 },
	{ "Seasonal Fisherman", 1000 },
	{"Lead Fisherman",1500},
	{ "Head Fisherman", 2000 },
	{ "SA Fising CEO", 6500 },
	{ "King of the Ocean", 11000 },

}

local newsRanks = {
				{"News Reporter in Training",0,0},
				{"Assistant of Photography", 30, 15},
				{"Photographer", 70, 20},
				{"Editor", 120, 25},
				{"Reporter", 170, 30},
				{"Photo Editor", 240, 35},
				{"Head Editor", 320, 40},
				{"Final Redator", 410, 50}
			}

local paramedicRanks = {
	{"Medical Student",0,0,"Base Salary"},
	{"Paramedic in Training",25,0,"Base Salary"},
	{"Recruit Paramedic",50,0,"Base Salary"},
	{"Experienced Paramedic",75,0,"Base Salary + 10%"},
	{"Recruit Doctor",100,0,"Base Salary + 20%"},
	{"Experienced Doctor",200,0,"Base Salary + 30%"},
	{"Head Doctor",300,0,"Base Salary + 40%"},
	{"Recruit Surgeon",400,0,"Base Salary + 45%"},
	{"Experienced Surgeon",500,0,"Base Salary + 50%"},
	{"Head Surgeon",600,0,"Base Salary + 55%"},
	{"CSG Medical Head",700,0,"Base Salary + 60%"},
	{"CSG Medical CEO",800,0,"Base Salary + 65%"},

}


local truckerRanks = {
	{"Trucker in Training", 0},
	{"Rookie Trucker",5},
	{"Highway Maggot", 10},
	{"Greenhorn Trucker",20},
	{"Regular Trucker",25},
	{"Seasoned Trucker",50},
	{"Enthusiast Trucker",75},
	{"Outback Ranger",100},
	{"Commander Trucker",125},
	{"Desert Captain",135},
	{"King of the Road",150},
}

local lumberRanks = {
	{"Wood Collector",0},
	{"Seasonal Woodcutter",50},
	{"Constant Lumberjack",450},
	{"Forest Woodcutter",1000},
	{"Head Lumberjack",2000},
	{"Lumberjack at Charge",2500},
	{"Senior Woodcutter",3600},
	{"Lead Lumberjack",5000},
	{"Wooden King",7000},
}

local occupationToStat = {
	["Pilot"] = "pilot",
	["Police Officer"] = "arrests",
	["Traffic Officer"] = "arrests",
	["Paramedic"] = "paramedic",
	["Firefighter"] = "firefighter",
	["Waste Collector"] = "wastecollector",
	["Bus Driver"] = "busdriver",
	["Mechanic"] = "mechanic",
	["Hooker"] = "hooker",
	["Trucker"] = "trucking",
	["Fisherman"] = "fisherman",
	["Paramedic"] = "paramedic2",
	["News Reporter"] = "newsreporter",
	["Lumberjack"] = "lj"
	--["Criminal"] = "criminal"
}

local criminalRanks = {
	{"Regular Criminal",0},
	{"Pick Pocket",10},
	{"Con Artist",20},
	{"Burgler",30},
	{"Capo",40},
	{"Don of LV",50}
}

local occupationToRank = {
	["Pilot"] = pilotRanks,
	["Police Officer"] = policeRanks,
	["Traffic Officer"] = policeRanks,
	["Paramedic"] = paramedicRanks,
	["Firefighter"] = firefighterRanks,
	["Waste Collector"] = wastecollectorRanks,
	["Bus Driver"] = busdriverRanks,
	["Mechanic"] = mechanicRanks,
	["Hooker"] = hookerRanks,
	["Trucker"] = truckerRanks,
	["Fisherman"] = fisherRanks,
	["Trucker"] = truckerRanks,
	["Paramedic"] = paramedicRanks,
	["News Reporter"] = newsRanks,
	["Lumberjack"] = lumberRanks,
	--["Criminal"] = criminalRanks,
}

function getRank(e,occ)
	local occupation = occ
		if ( occupationToRank[occupation] ) then
			local stat = exports.DENstats:getPlayerAccountData( e, occupationToStat[occupation] )
			if ( stat ) and occ ~= "Paramedic" then
				local number=0
				local theRank = false
				for i=1,#occupationToRank[occupation] do
					if not ( theRank ) then
						theRank = occupationToRank[occupation][i][1]
						number=i
					elseif ( occupationToRank[occupation][i][2] <= stat ) then
						theRank = occupationToRank[occupation][i][1]
						number=i
					end
				end
				return theRank,number,#occupationToRank[occupation]
			else
				return "Medical Student",1,#occupationToRank[occupation]
			end
		end
	return false
end
