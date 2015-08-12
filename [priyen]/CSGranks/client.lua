local rand = false

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

local limoRanks = {
 {"Limo Driver In Training",0},
 {"New Limo Driver",15},
 {"Trained Limo Driver",50},
 {"Experienced Limo Driver",150},
 {"Senior Limo Driver",250},
 {"Lead Limo Driver",350},
 {"Head Limo Driver",500},
}

local rescuerRanks = {
 {"Rescuer Man In Training",0},
 {"New rescuer Man",15},
 {"Trained rescuer Man",50},
 {"Experienced rescuer Man",150},
 {"Senior rescuer Man",250},
 {"Lead rescuer Man",350},
 {"Head rescuer Man",500},
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

local ironRanks = {
	{"Mine Worker",0,0,"Base Salary + 500 Kg Weight Limit"},
	{"Mineral Extractor in Training",25,0,"Base Salary + 500 Kg Weight Limit"},
	{"Recruit Mineral Extractor",50,0,"Base Salary + 500 Kg Weight Limit"},
	{"Professional Mineral Extractor",75,0,"Base Salary + 5% + 500 Kg Weight Limit"},
	{"Experienced Miner",100,0,"Base Salary + 5% + 600 Kg Weight Limit"},
	{"Head Miner",200,0,"Base Salary + 10% + 700 Kg Weight Limit"},
	{"Iron Expert",300,0,"Base Salary + 10% + 800 Kg Weight Limit"},
	{"Elite Miner",400,0,"Base Salary + 15% + 900 Kg Weight Limit"},
	{"Vice Chief of Mining",500,0,"Base Salary + 15% + 1200 Kg Weight Limit"},
	{"Head Chief of Mining",600,0,"Base Salary + 20% + 1300 Kg Weight Limit"},
	{"God of Iron",700,0,"Base Salary + 20% + 1400 Kg Weight Limit"},
	{"Iron Mining CEO",800,0,"Base Salary + 25% + 1500 Kg Weight Limit"},
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
	["Rescuer Man"] = "rescuerMan",
	["Limo Driver"] = "limoDriver",
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
	["Lumberjack"] = "lj",
	["Iron Miner"] = "ironminer",
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
	["Rescuer Man"] = rescuerRanks,
	["Limo Driver"] = limoRanks,
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
	["Iron Miner"] = ironRanks,
	--["Criminal"] = criminalRanks,
}

local swatUserToRank = {
	--["uau40"] = "Commander",
	["gusolina"] = "Commander",
	["ranger"] = "Captain",
	--["psydomin"] = "Lance Corporal",
	["blackhood"] = "Private",
	["mahmoud@salama"] = "Private",
	["dilerganzas"] = "SWAT Team",
	["bulletproof"] = "SWAT Team",
	--["shanduy"] = "Advanced Training Instructor",
	["faded"] = "Lance Corporal",
	["drammoth"] = "Sergeant Chief",
	["marga"] = "SWAT Team",
	["bunny"] = "SWAT Team",
	["blackgun"] = "SWAT Team",
	--["fcpranav"] = "Lance Corporal",
	["saracho"] = "Private 1st Class",
	["akb48"] = "SWAT Team",
	["bane"] = "Trial",
	["sprin"] = "Sergeant",
	["zizoubzz"] = "Private",
	["bibou"] = "Sergeant 1st Class",
	["blackblood"] = "Private 1st Class",
	["assassinobz"] = "Lance Corporal",
	["maxil1"] = "Sergeant 1st Class",
	["ramzi"] = "Private",
	["matrix95"] = "Private",
	["jocke"] = "Private",
	["dioxide"] = "Private",


}

local militaryUserToRank = {
	["rvp01"] = "Lance Corporal",
	["voltaire"] = "Private First Class",
	["mostafa"] = "Specialist",
	["tr2012"] = "Specialist",
	["skintoch"] = "Specialist",
	["hashytk"] = "General",
	["eratyra"] = "General",
	["csg.tn"] = "Master Sergeant",
	["drake"] = "Recruit",
	["chris2312"] = "Colonel",
	["dustin"] = "Captain",
	["swat10"] = "Colonel",
	--["striker"] = "General",
	["mert"] = "Sergeant",
	["Furgons"] = "1st Lieutenant",
	["klonoa7"] = "Private",
	["whitemoon"] = "Warrant Officer",
	["naser97."] = "Sergeant",
	["furgons"] = "Captain",
	["Aris"] = "Recruit",
	["aris"] = "Recruit",
	["cagatay67"] = "Recruit",
	["aris99"] = "Private",
	["metallpizza"] = "Recruit",
}

local fbiUserToRank = {
	["mostafa"] = "Director",
	["putq"] = "Agent in Training",
	["ruller"] = "Executive Agent",
	["drake"] = "Executive Agent",
	["imaster"] = "Overseer",
	["tatty"] = "Supervisory Special Agent",
	["sensei"] = "Overseer",
	["bossmanx1"] = "Special Agent",
	["stonepark"] = "Agent in Training",
	["kellyoo"] = "Agent in Training",
	["The joker"] = "Agent in Training",
	["the_neo123"] = "Agent in Training",
}




-- Timer that checks the ranks
warned=false
setTimer(
	function ()
		local occupation = getElementData( localPlayer, "Occupation" )
		local rank = getElementData( localPlayer, "Rank" )
		if ( occupationToRank[occupation] ) then
			local stat = exports.DENstats:getPlayerAccountData( localPlayer, occupationToStat[occupation] )
			if occupation == "Paramedic" then
				if stat == nil or stat == false then
					stat = 0
				else
					stat = fromJSON(stat)
					if type(stat) == "table" then
						if (stat["rankPTS"]) then
							stat = stat["rankPTS"]
						else
							stat = 0
						end
					else
						stat = 0
					end
				end
			end
			if ( stat ) then
				local theRank = false
				for i=1,#occupationToRank[occupation] do
					if not ( theRank ) then
						if occupation == "Police Officer" then
							theRank = "(PO)-"..occupationToRank[occupation][i][1]..""
						elseif occupation == "Traffic Officer" then
							theRank = "(TO)-"..occupationToRank[occupation][i][1]..""
						else
							theRank = occupationToRank[occupation][i][1]
						end
					elseif ( occupationToRank[occupation][i][2] <= stat ) then
						if occupation == "Police Officer" then
							theRank = "(PO)-"..occupationToRank[occupation][i][1]..""
						elseif occupation == "Traffic Officer" then
							theRank = "(TO)-"..occupationToRank[occupation][i][1]..""
						else
							theRank = occupationToRank[occupation][i][1]
						end
						--theRank = occupationToRank[occupation][i][1]
					end
				end
				if ( rank ~= theRank ) then setElementData( localPlayer, "Rank", theRank ) if ( rank ~= occupation ) then triggerEvent( "onPlayerRankChange", localPlayer, rank, theRank ) end end
			end
		else
				if occupation == "Criminal" then
					if rank == false or rank == "" then
						setElementData(localPlayer,"Rank","Petty Criminal")
					end
				elseif occupation == "SWAT Team" then
					local accName = exports.server:getPlayerAccountName(localPlayer)
					if swatUserToRank[accName] ~= nil then
						setElementData( localPlayer, "Rank", swatUserToRank[accName] )
					else
						setElementData( localPlayer, "Rank", occupation )
					end
				elseif occupation == "Military Forces" then
					local accName = exports.server:getPlayerAccountName(localPlayer)
					if militaryUserToRank[accName] ~= nil then
						setElementData( localPlayer, "Rank", militaryUserToRank[accName] )
					else
						--[[if warned == false then
							exports.DENdxmsg:createNewDxMessage(""..getPlayerName(localPlayer)..". Please PM Priyen on Forum The Following Details:",255,255,0)
							exports.DENdxmsg:createNewDxMessage("- Your username, Your MF Rank, Your Forum Name",255,255,0)
							warned=true
						end--]]
						setElementData( localPlayer, "Rank", occupation )
					end
				elseif occupation == "Federal Agent" then
					local accName = exports.server:getPlayerAccountName(localPlayer)
					if fbiUserToRank[accName] ~= nil then
						setElementData( localPlayer, "Rank", fbiUserToRank[accName] )
					else
						--[[if warned == false then
							exports.DENdxmsg:createNewDxMessage(""..getPlayerName(localPlayer)..". Please PM Priyen on Forum The Following Details:",255,255,0)
							exports.DENdxmsg:createNewDxMessage("- Your username, Your FBI Rank, Your Forum Name",255,255,0)
							warned=true
						end--]]
						setElementData( localPlayer, "Rank", occupation )
					end
				else
					if ( rank ~= occupation ) then setElementData( localPlayer, "Rank", occupation ) end
				end

		end
	end, 1000, 0
)

addEvent("recRank",true)
addEventHandler("recRank",localPlayer,function(user,rank,gr)
	if gr=="SWAT Team" then
		swatUserToRank[user]=rank
	elseif gr == "FBI" then
		fbiUserToRank[user]=rank
	elseif gr== "Military Forces" then
		militaryUserToRank[user]=rank
	end
end)

-- exports

function getPlayerRankInfo()
	local occupation = getElementData( localPlayer, "Occupation" )
	if occupation and occupationToStat[occupation] then
		local stat = exports.DENstats:getPlayerAccountData( localPlayer, occupationToStat[occupation] )
		if stat then
			local theRank = false
			local theRankN
			for i=1,#occupationToRank[occupation] do
				if not ( theRank ) then
					if occupation == "Police Officer" then
						theRank = "(PO)-"..occupationToRank[occupation][i][1]
					elseif occupation == "Traffic Officer" then
						theRank = "(TO)-"..occupationToRank[occupation][i][1]
					else
						theRank = occupationToRank[occupation][i][1]
					end
					theRankN = i
				elseif ( tonumber(occupationToRank[occupation][i][2]) <= tonumber(stat) ) then
					if occupation == "Police Officer" then
						theRank = "(PO)-"..occupationToRank[occupation][i][1]
					elseif occupation == "Traffic Officer" then
						theRank = "(TO)-"..occupationToRank[occupation][i][1]
					else
						theRank = occupationToRank[occupation][i][1]
					end
					theRankN = i
				end
			end
			local nextRank, nextRankPoints
			if occupationToRank[occupation][theRankN+1] then
				nextRank, nextRankPoints = occupationToRank[occupation][theRankN+1][1], occupationToRank[occupation][theRankN+1][2]
			end
			return theRank,stat,theRankN, nextRank, nextRankPoints
		end
	end
end

function getPlayerRankTable()
	local occupation = getElementData( localPlayer, "Occupation" )
	if occupation then
		return occupationToRank[occupation]
	end
	return false
end


