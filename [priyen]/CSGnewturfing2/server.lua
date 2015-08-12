local turfRadarArea = {}
local turfColArea = {}
local turfingTimersStart = {}
local turfingTimersAttack = {}
local turfProvocationTimer = {}
local turfAttackGroup = {}
local turfGroups = {}
local turfData = {}


local turfSpawnTable = {
[1] = { 1678.14, 2331.15, 10.82, 273.35775756836 },
[2] = { 1880.89, 2339.45, 10.97, 269.00161743164 },
[3] = { 2245.16, 2005.47, 10.82, 0.21148681640625 },
[4] = { 2237.48, 2125.49, 10.82, 356.15197753906 },
[5] = { 2029.36, 1933.53, 12.23, 266.12313842773 },
[6] = { 1417.09, 2091.61, 11.01, 82.934326171875 },
[7] = { 1635.65, 1038.43, 10.82, 264.73333740234 },
[8] = { 1980.15, 1798.95, 12.34, 176.65460205078 },
[9] = { 2010.08, 1177.31, 10.82, 215.78851318359 },
[10] = { 1955.01, 1343.09, 15.37, 267.49645996094 },
[11] = { 1452.9, 2368.78, 10.82, 263.83795166016 },
[12] = { 1164.08, 1336.63, 10.81, 88.367126464844 },
[13] = { 943.93, 1733.04, 8.85, 265.27719116211 },
[14] = { 966.79, 2072.79, 10.82, 278.10940551758 },
[15] = { 1047.33, 2161.22, 10.82, 267.41955566406 },
[16] = { 1069.38, 1887.18, 10.82, 267.08993530273 },
[17] = { 1086.41, 1610.5, 5.82, 12.428466796875 },
[18] = { 1629.91, 994.05, 10.82, 268.82580566406 },
[19] = { 1947.96, 1625.71, 22.76, 274.81344604492 },
[20] = { 2609.26, 2392.2, 17.82, 17.487762451172 },
[21] = { 2341.51, 2805.07, 10.82, 181.4172668457 },
[22] = { 2496.23, 2320.42, 10.82, 92.833129882812 },
[23] = { 2855.62, 2418.89, 10.82, 228.46691894531 },
[24] = { 2368.26, 2311.21, 8.14, 349.74685668945 },
[25] = { 2456.51, 2020.87, 11.06, 109.5491027832 },
[26] = { 2470.94, 2127.92, 10.82, 356.69580078125 },
[27] = { 2580.6, 2185.06, 10.82, 351.66400146484 },
[28] = { 2600.43, 2085.82, 10.81, 268.26000976562 },
[29] = { 2629.76, 1716.96, 11.02, 90.789642333984 },
[30] = { 2443.15, 1655.06, 10.82, 232.93293762207 },
[31] = { 2440.58, 1750.76, 10.82, 357.9153137207 },
[32] = { 2408.78, 1866.87, 6.01, 357.9153137207 },
[33] = { 2220.33, 1839.7, 10.82, 89.756927490234 },
[34] = { 2161.98, 1643.88, 11.11, 12.340576171875 },
[35] = { 2484.99, 1529.75, 10.84, 321.74227905273 },
[36] = { 2565.13, 1442.24, 11.03, 87.570617675781 },
[37] = { 2576.65, 1221.56, 10.82, 87.345397949219 },
[38] = { 2542.75, 1279.4, 10.82, 81.357757568359 },
[39] = { 2588.68, 1324.5, 10.82, 177.04461669922 },
[40] = { 2483.38, 1363.89, 10.81, 1.6122741699219 },
[41] = { 2479.25, 1291.08, 10.81, 265.03549194336 },
[42] = { 2507.62, 1210.74, 10.82, 179.81323242188 },
[43] = { 2467.91, 1405.13, 10.82, 277.16458129883 },
[44] = { 2283.97, 1388.91, 10.82, 356.69030761719 },
[45] = { 2136.67, 1493.05, 10.82, 0.00274658203125 },
[46] = { 2096.24, 1284.98, 10.82, 179.21997070312 },
[47] = { 2257.51, 1286.12, 19.16, 88.119934082031 },
[48] = { 2551.48, 1169.08, 18.71, 181.14259338379 },
[49] = { 2552.76, 1054.41, 10.82, 266.17807006836 },
[50] = { 2393.09, 1003.33, 10.82, 91.262084960938 },
[51] = { 2491.58, 1149.32, 22.02, 182.23025512695 },
[52] = { 2466.65, 1065.37, 10.82, 0.00274658203125 },
[53] = { 2476.44, 992.23, 10.82, 269.96292114258 },
[54] = { 2883.68, 894.57, 10.75, 89.537200927734 },
[55] = { 2575.47, 724.07, 10.82, 359.99176025391 },
[56] = { 2361.69, 694.46, 11.44, 4.79833984375 },
[57] = { 2221.24, 694.27, 11.45, 355.48181152344 },
[58] = { 2056.33, 730.03, 11.46, 358.47561645508 },
[59] = { 1533.66, 751.34, 11.02, 262.45364379883 },
[60] = { 1634.18, 759.18, 10.82, 181.89517211914 },
[61] = { 1917.02, 703.28, 11.13, 86.691680908203 },
[62] = { 2269.87, 965.09, 10.81, 353.1471862793 },
[63] = { 1904.34, 974.14, 10.82, 177.90155029297 },
[64] = { 2177.31, 1117.87, 12.64, 60.390014648438 },
[65] = { 1148.5, 758.79, 10.82,357},
[66] = { 1010.55,942.94,11,328},
[67] = { 2496.79, 2772.79, 10.82,79},
[68] = { 1493.52, 2773.69, 10.82, 275},
[69] = {2856.35, 2612.98, 10.82,264},
[70] = { 3217.61, 1857.92,194},
[71]= {3341.33, 1313.76, 7.88,179},
[72]= {3437.79, 1221.1, 7.91,92},
[73] = {3277.08, 946.24, 7.77,293},
[74] = { 3414.06, 947.97, 7.77,175},
[75] = {3306.74, 1100.21, 7.77 ,330},
[76] = { 3347.37, 545.36, 52.47,357},
[77] = {3110.62, 2115.57, 1.39,90},
}

--id's don't nessarly correspond to turf ids
local radStations = {
[54] = "South East LV", -- turf id 54
[68] = "South West LV", -- turf id 65
[69] = "North East LV", -- turf id 69
[67] = "North West LV", -- turf id 68
[76] = "LV Sea"
}

local blipStats = {
[54] = "crim",
[68] = "crim",
[69] = "crim",
[67] = "crim",
[76] = "crim",
}

local turfStability = { -- 15 mins = 900000

}
for i=1,100 do turfStability[i] = getTickCount() end
-- Create the turfs when the resource gets started
addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
	local CSGTurfs = exports.DENmysql:query( "SELECT * FROM turfing" )
	if ( CSGTurfs ) and ( #CSGTurfs > 0 ) then
		for i=1,#CSGTurfs do
			turfStability[i] = getTickCount()
			turfRadarArea[i] = createRadarArea ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey, CSGTurfs[i].r, CSGTurfs[i].g, CSGTurfs[i].b, 180 )
			turfColArea[i] = createColRectangle ( CSGTurfs[i].leftx, CSGTurfs[i].bottomy, CSGTurfs[i].sizex, CSGTurfs[i].sizey )
			setElementData( turfColArea[i], "turfID", i )
			turfData[i] = {}
			if CSGTurfs[i].turfowner ~= "Unoccupied" then
				turfData[i].health=100
				turfData[i].mode="Owned"
			else
				turfData[i].health=15
				turfData[i].mode="Unoccupied"
			end
			turfData[i].owner=CSGTurfs[i].turfowner
			turfData[i].attackinggroup="None"
			turfData[i].col=turfColArea[i]
			turfData[i].influences = {}
			addEventHandler ( "onColShapeHit", turfColArea[i], onHitTurfZone )
			addEventHandler ( "onColShapeLeave", turfColArea[i], onLeaveTurfZone )
		end
	end
	CSGTurfingTable = CSGTurfs
end
)
local LVcol = createColRectangle(866,656,2100,2300)
local seaCol = createColRectangle(2983.9, 356.8,850,2700)
-- When a turfer dies spawn him at a turf owned by the group
addEventHandler( "onPlayerWasted", root,
function ()
	if isElementWithinColShape(source,LVcol) == true or isElementWithinColShape(source,seaCol) then
		if getTeamName( getPlayerTeam( source ) ) ~= "Criminals" then return end
		local spawnTable = {}
		local myGroup = getElementData(source,"Group")
		for k,v in pairs(turfData) do
			if v.owner == myGroup and v.health > 55 and (isElementWithinColShape(source,v.col)==false) then
				local x,y = getElementPosition(v.col)
				local z = 10
				local t = {x,y,z,k}
				table.insert(spawnTable,t)
				--outputDebugString("ff")
			end
		end
		triggerClientEvent( source, "onClientTurferDied", source, spawnTable )
	end
end
)

function onHitTurfZone ( hitElement, matchingDimension )
	local turfNumber = getElementData ( source, "turfID" )
	if getElementType ( hitElement ) == "player" then
		if canElementTurf(hitElement) == false then return end
		if radStations[turfNumber] == nil then
			local gangName = turfData[turfNumber].owner
			local message = "You entered the turf of " .. gangName .. "."
			if not gangName or gangName == "" then
				message = "You entered a unoccupied turf."
			elseif gangName == getActualG(hitElement) then
				if getElementData(hitElement,"Group") ~= getActualG(hitElement) then
					message = "You entered a turf owned by your alliance: " .. gangName .. "."
				else
					message = "You entered a turf owned by your group: " .. gangName .. "."
				end
			end
			exports.DENdxmsg:createNewDxMessage(hitElement, message, 0, 230, 0)
		else
			local gangName = turfData[turfNumber].owner
			if turfData[turfNumber].owner ~= "Unoccupied" then
				exports.DENdxmsg:createNewDxMessage(hitElement, "You entered a Radio Station turf, currently run by "..gangName.."", 0, 230, 0)
			else
				exports.DENdxmsg:createNewDxMessage(hitElement, "You entered a Radio Station turf currently run by No one", 0, 230, 0)
			end
		end
	end

end

function isPlayerInRegTurf(p)
	for k,v in pairs(turfData) do
		if radStations[k] == nil and isElementWithinColShape(p,v.col) then
			return true
		end
	end
	return false
end

--[[
function startTurfWar (turf, group, player)
	if getPlayersFromGroupInTurf ( group, turf ) >= 1 then
		setGroupAttacking ( turf, group )
		local gangName = CSGTurfingTable[turf].turfowner
		local message = "You started a attack on a turf from " .. gangName .. "."
		if not gangName or gangName == "" then
			message = "You started a attack on a unoccupied turf."
		end
		exports.DENdxmsg:createNewDxMessage(player, message, 0, 230, 0)
	end
end
--]]

function isLaw(p)
	if getElementType(p) == "player" then else return false end
	local tName = getTeamName(getPlayerTeam(p))
	if tName == "Police" or tName == "SWAT" or tName == "Military Forces" or tName == "Government Agency" then
		return true
	end
	return false
end

function isPlayerInRT(p)
	for k,v in pairs(turfData) do
		if radStations[k] ~= nil then
			if isElementWithinColShape(p,turfData[k].col) == true then
				return true
			end
		end
	end
	return false
end

local allianceDB = {}
function getActualG(v)
	local gr = getElementData(v,"Group")
	local a = getElementData(v,"alliance")
	if (a) then
		local t = exports.CSGgroups:alliances_getAllianceSettings(tonumber(a))
		if (t.turfAsAlliance) then
			gr=getElementData(v,"aName")
			allianceDB[gr] = true
		end
	end
	return gr
end

local zoneInfo = {}

addEvent("CSGwanted.wUpdate",true)
addEventHandler("CSGwanted.wUpdate",root,function(str)
	zoneInfo[source]=str
end)

addEventHandler("onPlayerQuit",root,function() zoneInfo[source] = nil end)

function getNearestRTType(p)
	return zoneInfo[p] or "noone"
end

function getGColor(group)
	if (allianceDB[group]) then
		local id = exports.CSGgroups:alliances_getAllianceIDByName(group)
		local colorT = fromJSON(exports.CSGgroups:getAllianceColor(id))
		if (colorT) and (colorT[1]) then
			r = colorT[1]
		else
			r = math.random(255)
		end
		if (colorT) and (colorT[2]) then
			g = colorT[2]
		else
			g = math.random(255)
		end
		if (colorT) and (colorT[3]) then
			b = colorT[3]
		else
			b = math.random(255)
		end

		return ""..r..","..g..","..b..""
	else
		return exports.server:getGroupColor(group)
	end
end

doTurf = function()

for i,data in pairs(turfData) do
	local col = data.col
	local t = getElementsWithinColShape(col,"player")
	local groups = {}
	local biggestInfluenceGroup=""
	local biggestInfluence=0
	local first = {}
	local counted = {}
	local oldHealth = data.health
	local lawRT = false
	for k,v in ipairs(t) do
		if getElementInterior(v) == 0 and getElementDimension(v) == 0 and canElementTurf(v) then
			local gr = getActualG(v)
			local teamName = getTeamName(getPlayerTeam(v))
			if teamName == "Police" then
				gr="Police"
			end

			if gr ~= false then
				if groups[gr] == nil then groups[gr]=0 end
				if (canElementTurf(v) == true and teamName == "Criminals") or (((isLaw(v) and radStations[i] ~= nil)) or (isLaw(v) and getNearestRTType(v) == "law")) then
					if getNearestRTType(v) == "law" then lawRT=true end
					if first[gr] == nil then
						if counted[v] == nil then
							groups[gr] = groups[gr]+2
							local rank = getElementData(v,"Rank")
							local rank2 = getElementData(v,"skill")
							if rank2 == false then rank2="" end
							if rank == "Don of LV" or rank2 == "Riot Squad" then
								groups[gr]=groups[gr]+0.6666
								if rank2 ~= false and rank2 == "Riot Squad" then
									groups[gr]=groups[gr]+0.6666
								end
							elseif rank == "Capo" or rank2 == "Task Force" then
								groups[gr]=groups[gr]+0.3333
							end
							counted[v]=true
							first[gr] = false
						end
					else
						if counted[v] == nil then
							local rank = getElementData(v,"Rank")
							groups[gr] = groups[gr]+1
							if rank == "Don of LV" then
								groups[gr]=groups[gr]+0.333
							elseif rank == "Capo" then
								groups[gr]=groups[gr]+0.115
							end
							counted[v]=true
						end
					end
				end
			end
		end
	end
	if radStations[i] ~= nil then
		local addLaw,addCrim = 0,0
		for k,v in pairs(groups) do

			if k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police" or k == "CSG Law" or k == "Criminals" then
				addLaw=addLaw+v
			else
				addCrim=addCrim+v
			end
		end
		groups["CSG Law"] = addLaw
		groups["Criminals"] = addCrim

	end
	if data.mode == "Unoccupied" or turfData[i].health <= 20 then
		if turfData[i].health <= 20 then
			for k,v in pairs(groups) do
				if v > biggestInfluence then
					if radStations[i] ~= nil then
						if k == "CSG Law" or k == "Criminals" then
							biggestInfluenceGroup=k
							biggestInfluence=v
						end

					else
						biggestInfluenceGroup=k
						biggestInfluence=v
					end
				end
			end
			data.attackinggroup=biggestInfluenceGroup
			turfData[i].attackinggroup=biggestInfluenceGroup
			--new attacking turf
			--[[if radStations[i] ~= nil then
			if turfData[i].attackinggroup == "Criminals" then
				turfData[i].attackinggroup = "CSG Law"
			else
				turfData[i].attackinggroup = "Criminals"
			end
			end--]]
		end
	end

	for k,v in pairs(groups) do
		if (k ~= data.owner and k ~= data.attackinggroup) or (radStations[i] ~= nil) then
			if radStations[i] ~= nil then
				if turfData[i].attackinggroup == "CSG Law" then
					if k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police" or k == "CSG Law" then
						--do nothing
					else
						groups[k] = groups[k]*-1
					end
				elseif turfData[i].attackinggroup == "Criminals" then
					if k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police" or k == "CSG Law" then
						groups[k] = groups[k]*-1
					else
						--do nothing
					end
				else
					if turfData[i].owner == "CSG Law" then
						if k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police" or k == "CSG Law" then
							--do nothing
						else
							groups[k] = groups[k]*-1
						end
					elseif turfData[i].owner == "Criminals" then
						if k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police" or k == "CSG Law" then
							groups[k] = groups[k]*-1
						end
					else
						groups[k] = groups[k]*-1
					end
				end

			else
				groups[k] = groups[k]*-1
			end
		end
	end
	if radStations[i] ~= nil then

	else
		if (lawRT) and (groups["FBI"] or groups["SWAT Team"] or groups["Military Forces"] or groups["Police"]) then
			--if (groups["FBI"] and groups["FBI"] > 0) or (groups["SWAT Team"] and groups["SWAT Team"] > 0) or (groups["Police"] and groups["Police"] > 0) or (groups["Military Forces"] and groups["Military Forces"] > 0) or
				for k,v in pairs(groups) do
					if not(k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police") then
						groups[k] = groups[k] * 0.5
					end
				end
			--end
		end
		for k,v in pairs(groups) do
			if k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police" then
				if v > 0 then
					groups[k] = groups[k] * -1
				end
			end
		end
	end

	local isDiff=false
	if #groups > 1 then
		for k,v in pairs(groups) do
			for k2,v2 in pairs(groups) do
				if v2 ~= v then isDiff=true end
			end
		end
	end


	for k,v in pairs(groups) do
		if radStations[i] == nil then
			turfData[i].health = turfData[i].health+v
		else
			turfData[i].health = turfData[i].health+((v/2)/2)
		end
	end
	if oldHealth == turfData[i].health or (#groups > 1 and isDiff==false) then
		data.attackinggroup="None"
		turfData[i].attackinggroup="None"
	end
	turfData[i].influences = groups
	if turfData[i].health > 100 then turfData[i].health=100 end
	if turfData[i].health < 0 then turfData[i].health=0 end

	if data.mode == "Owned" then
		if turfData[i].health <= 20 then
			turfData[i].mode="Unoccupied"
			turfData[i].oldRealGroup=turfData[i].owner
			turfData[i].owner="Unoccupied"
			turfData[i].attackinggroup="None"
			blipStats[i] = "noone"
			for k,v in pairs(getElementsByType("player")) do
				if getElementDimension(v) == 0 and getElementInterior(v) == 0 then
					if radStations[i] == nil then
						if isElementWithinColShape(v,turfData[i].col) then
							if isLaw(v) then
								givePlayerMoney(v,500)
								exports.CSGscore:givePlayerScore(v,0.5)
								exports.DENdxmsg:createNewDxMessage(v,"Earned $500 and +0.5 Score for Neutralizing a Criminal Turf",0,255,0)
							end
						end
						if getActualG(v) == turfData[i].oldRealGroup then
							local x,y = getElementPosition(turfData[i].col)
							local zoneName=getZoneName(x,y,10)
							exports.dendxmsg:createNewDxMessage(v,"Your turf at "..zoneName.." was under attack and has been lost!",255,0,0)
							destroyBag(i)
							turfStability[i] = getTickCount()
						end
					else
						if isLaw(v) then
							if turfData[i].oldRealGroup == "CSG Law" then
								exports.dendxmsg:createNewDxMessage(v,"Law Radio Station Turf "..radStations[i].." has been lost!",0,0,255)
								exports.dendxmsg:createNewDxMessage(v,"There is too much criminal influence! Respond!",0,0,255)
							end
						elseif getTeamName(getPlayerTeam(v)) == "Criminals" then
							if turfData[i].oldRealGroup == "Criminals" then
								exports.dendxmsg:createNewDxMessage(v,"Criminals Radio Station Turf "..radStations[i].." has been lost!",0,0,255)
								exports.dendxmsg:createNewDxMessage(v,"There is too much Law Enforcement influence! Respond!",0,0,255)
							end
						end
						triggerClientEvent(v,"CSGturfing.updateBlips",v,i,"noone")
					end
				end

			end
			--[[exports.DENmysql:exec( "UPDATE turfing SET turfowner=?, r=?, g=?, b=? WHERE turfid=?"
			,turfData[i].owner
			,255
			,255
			,255
			,i
			)--]]
			--turf lost
		elseif oldHealth > 55 and turfData[i].health <= 55 then
			for k,v in pairs(getElementsByType("player")) do
				if radStations[i] == nil then
					if getActualG(v) == turfData[i].owner then
						local x,y = getElementPosition(turfData[i].col)
						local zoneName=getZoneName(x,y,10)
						exports.dendxmsg:createNewDxMessage(v,"Your turf at "..zoneName.." is in danger of being lost, go defend it!",255,0,0)
					end
				elseif turfData[i].owner == "CSG Law" or turfData[i].owner == "Criminals" then
					if isLaw(v) then
						if turfData[i].owner == "CSG Law" then
							exports.dendxmsg:createNewDxMessage(v,"All units be advised there is heavy criminal presence at "..radStations[i].." Radio Station",0,0,255)
							exports.dendxmsg:createNewDxMessage(v,"Criminals are attacking the turf! Go defend it!",0,0,255)
						else
							exports.dendxmsg:createNewDxMessage(v,"Criminal Radio Station Turf "..radStations[i].." is being neutrailized by law!",0,0,255)
							exports.dendxmsg:createNewDxMessage(v,"Go help them!",0,0,255)
						end
					elseif getTeamName(getPlayerTeam(v)) == "Criminals" then
						if turfData[i].owner == "Criminals" then
							exports.dendxmsg:createNewDxMessage(v,"Criminals Radio Station Turf "..radStations[i].." is in danger of being lost!",255,0,0)
							exports.dendxmsg:createNewDxMessage(v,"Law Enforcement is trying to regrain control! Go defend it!",255,0,0)
						else
							exports.dendxmsg:createNewDxMessage(v,"Law Radio Station Turf "..radStations[i].." is being neutrailized by criminals!",255,0,0)
							exports.dendxmsg:createNewDxMessage(v,"Go help them!",255,0,0)
						end
					end
				end
			end
		end
	elseif data.mode == "Unoccupied" then
		if (groups["FBI"] or groups["SWAT Team"] or groups["Military Forces"] or groups["Police"]) then
			for k,v in pairs(groups) do
				if not(k == "FBI" or k == "SWAT Team" or k == "Military Forces" or k == "Police") then
					groups[k] = 0
				end
			end
		end
		destroyBag(i)
		if turfData[i].health > 20 then
			data.mode="Attack in Progress"
			turfData[i].mode="Attack in Progress"
			for k,v in pairs(getElementsByType("player")) do
				if (getActualG(v) == turfData[i].attackinggroup) or (radStations[i] ~= nil) then
					if radStations[i] ~= nil then
						if getTeamName(getPlayerTeam(v)) == "Criminals" then
							if turfData[i].attackinggroup == "Criminals" then
								exports.dendxmsg:createNewDxMessage(v,"The Criminals have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.dendxmsg:createNewDxMessage(v,"Go help them!",255,0,0)
							elseif turfData[i].attackinggroup == "CSG Law" then
								exports.dendxmsg:createNewDxMessage(v,"The Law Enforcement have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.dendxmsg:createNewDxMessage(v,"Go stop them and stop the Law advancement!",255,0,0)
							end
						elseif isLaw(v) then
							if turfData[i].attackinggroup == "Criminals" then
								exports.dendxmsg:createNewDxMessage(v,"The Criminals have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.dendxmsg:createNewDxMessage(v,"Go stop them and regain control!",255,0,0)
							elseif turfData[i].attackinggroup == "CSG Law" then
								--outputDebugString("2")
								exports.dendxmsg:createNewDxMessage(v,"The Law Enforcement have started an attack on Radio Station Turf "..radStations[i].."",255,0,0)
								exports.dendxmsg:createNewDxMessage(v,"Go help them and support the Law advancement!",255,0,0)
							end
						end
					else
						local x,y = getElementPosition(turfData[i].col)
						local zoneName=getZoneName(x,y,10)
						local typeg
						if getElementData(v,"ta") == true then
							typeg="Alliance"
						else
							typeg="Group"
						end
						exports.dendxmsg:createNewDxMessage(v,"Your "..typeg.." is attacking a turf at "..zoneName..", go help them!",255,0,0)
					end
				end
			end
		elseif turfData[i].health <= 20 then
			turfData[i].mode = "Unoccupied"
			data.mode = "Unoccupied"
		end
	elseif turfData[i].mode == "Attack in Progress" then
		if turfData[i].health >= 55 then
			turfData[i].mode="Owned"
			turfData[i].owner=data.attackinggroup
			turfData[i].attackinggroup="None"
			--new turf owner
			local r,g,b = 0,0,0
			if turfData[i].owner ~= "CSG Law" and turfData[i].owner ~= "Criminals" then
				local turfColorString = getGColor(turfData[i].owner)
				local turfColorTable = exports.server:stringExplode(turfColorString, ",")
				if turfColorTable == nil then
					turfColorTable={255,0,0}
				end
				r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
			else
				if data.owner == "CSG Law" then
					r,g,b = 57, 55, 57
				elseif data.owner == "Criminals" then
					r,g,b = 255,0,0
				end

			end
			setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
			--[[exports.DENmysql:exec( "UPDATE turfing SET turfowner=?, r=?, g=?, b=? WHERE turfid=?"
			,turfData[i].owner
			,r
			,g
			,b
			,i
			)--]]
			local grInTurf = 0
			for k,v in pairs(getElementsWithinColShape(turfColArea[i],"player")) do
				if (getActualG(v) == turfData[i].owner) or (isLaw(v)) then
					grInTurf=grInTurf+1
				end
			end
			local blipName="noone"
			if turfData[i].owner == "CSG Law" then
				blipName="law"
				blipStats[i]="law"
			elseif turfData[i].owner == "Criminals" then
				blipName="crim"
				blipStats[i]="crim"
			end
			destroyBag(i)
			for index, player in ipairs(getElementsByType("player")) do
				local oldGroup=turfData[i].oldRealGroup
				if oldGroup == nil then oldGroup = "No one" end
				local attackerMSG
				if getElementData(player,"ta") == true then
					attackerMSG = "Your alliance has captured a turf which was previously owned by " .. oldGroup .. "!"
				else
					attackerMSG = "Your group has captured a turf which was previously owned by " .. oldGroup .. "!"
				end
				turfStability[i] = getTickCount()
				local teamE = getPlayerTeam(player)
				if teamE ~= false then
					if oldGroup and ( getActualG(player) == oldGroup ) then
						--exports.DENdxmsg:createNewDxMessage (player, "Your turf has been captured by " .. newGroupName .. "!", 255, 0, 0 )
						--
					elseif (( getActualG(player) == turfData[i].owner ) and turfData[i].owner ~= oldGroup) or ((isLaw(player) or getTeamName(teamE) == "Criminals") and (turfData[i].owner == "CSG Law" or turfData[i].owner == "Criminals")) then
						if turfData[i].owner == "CSG Law" then
							local r,g,b = 0,255,0
							if isLaw(player) == false then r,g,b = 255,0,0 end
							exports.DENdxmsg:createNewDxMessage (player, "Law Enforcement have captured the Radio Station Turf "..radStations[i].."", r,g,b)
							exports.DENdxmsg:createNewDxMessage (player, "Station powered on, all crimes nearby being reported to CSG-PD HQ", r,g,b )
							for k,v in pairs(getElementsWithinColShape(turfData[i].col,"player")) do
								if isLaw(v) then
									exports.CSGachievements:check(v,12)
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTaken",exports.DENstats:getPlayerAccountData(v,"radioTurfsTaken")+1)
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTakenAsCop",exports.DENstats:getPlayerAccountData(v,"radioTurfsTakenAsCop")+1)
								end
							end
						elseif turfData[i].owner == "Criminals" then
							local r,g,b = 0,255,0
							if isLaw(player) then r,g,b = 0,0,255 end
							exports.DENdxmsg:createNewDxMessage (player, "Criminals have captured the Radio Station Turf "..radStations[i].."", r,g,b )
							exports.DENdxmsg:createNewDxMessage (player, "Station shutdown, too much criminal influence! nearby crimes not being reported!", r,g,b )
							for k,v in pairs(getElementsWithinColShape(turfData[i].col,"player")) do
								if isLaw(v) == false and getTeamName(getPlayerTeam(v)) == "Criminals" then
									exports.CSGachievements:check(v,12)
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTaken",exports.DENstats:getPlayerAccountData(v,"radioTurfsTaken")+1)
									exports.DENstats:setPlayerAccountData(v,"radioTurfsTakenAsCrim",exports.DENstats:getPlayerAccountData(v,"radioTurfsTakenAsCrim")+1)
								end
							end
						else
							exports.DENdxmsg:createNewDxMessage (player, attackerMSG, 0, 255, 0 )
						end
					end

					if ( turfColArea[i] ) and ( turfData[i].owner ) and ( isElementWithinColShape ( player, turfColArea[i] ) ) and ( (getActualG(player) == turfData[i].owner) or (turfData[i].owner=="CSG Law" and isLaw(player)) or (turfData[i].owner=="Criminals" and getTeamName(getPlayerTeam(player)) == "Criminals") ) then
						if grInTurf == 1 then
							givePlayerMoney(player, 3000)
							if isElementWithinColShape(player,seaCol) then

								givePlayerMoney(player,1000)
								exports.CSGscore:givePlayerScore(player,0.2)
							end
						elseif grInTurf == 2 then
							givePlayerMoney(player, 2500)
							if isElementWithinColShape(player,seaCol) then
								givePlayerMoney(player,750)
								exports.CSGscore:givePlayerScore(player,0.2)
							end
						elseif grInTurf > 2 then
							givePlayerMoney(player, 2000)
							if isElementWithinColShape(player,seaCol) then
								givePlayerMoney(player,500)
								exports.CSGscore:givePlayerScore(player,0.2)
							end
						end
							if isElementWithinColShape(player,seaCol) then
								if turfData[i].owner == "Criminals" then
									if getTeamName(getPlayerTeam(player)) == "Criminals" then
										givePlayerMoney(player,1000)
									end
								elseif turfData[i].owner == "CSG Law" then
									if isLaw(player) then
										givePlayerMoney(player,1000)
										exports.CSGscore:givePlayerScore(player,1)
									end
								end
							end
						exports.CSGscore:givePlayerScore(player,1)
						local taken = exports.DENstats:getPlayerAccountData(player,"turfsTaken")
						if taken==nil or taken==false then taken=0 end
						exports.DENstats:setPlayerAccountData(player,"turfsTaken",taken+1)
						exports.CSGachievements:check(v,12)

					end
					triggerClientEvent(player,"CSGturfing.updateBlips",player,i,blipName)
				end
			end

		end
	end

	local toSend = turfData[i]
	toSend.oldHealth=oldHealth
	toSend.text=toSend.mode
	toSend.barText = ""
	toSend.colors = {}
	toSend.turfID = i
	toSend.colors["Police"] = {0,191,255}

	for k,v in pairs(groups) do
		local turfColorString = getGColor(k)
		if k ~= "CSG Law" and k ~= "Criminals" then
			if type(turfColorString) ~= "boolean" then
				local turfColorTable = exports.server:stringExplode(turfColorString, ",")
				local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
				toSend.colors[k]={r,g,b}
			end
		else
			if k == "CSG Law" then
				local r, g, b = 57, 55, 57
				toSend.colors[k]= {r,g,b}
			elseif k == "Criminals" then
				local r, g, b = 57, 55, 57
				toSend.colors[k]= {r,g,b}
			end
		end
	end
	if turfData[i].owner ~= "Unoccupied" then
		local turfColorString = getGColor(turfData[i].owner)
		if type(turfColorString) ~= "boolean" then
			local turfColorTable = exports.server:stringExplode(turfColorString, ",")
			if type(turfColorTable) ~= "boolean" then
				local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
				toSend.colors[turfData[i].owner]= {r,g,b}
			end
		end
	end
	if turfData[i].attackinggroup ~= "None" then
		local k = turfData[i].attackinggroup
		if (radStations[i] == nil and (groups["FBI"] or groups["SWAT Team"] or groups["Military Forces"] or groups["Police"])) then
			toSend.barText="Law Presence Detected"

		else
			toSend.barText="Attack in Progress by "..turfData[i].attackinggroup

		end
		if turfData[i].health > 20 then
			setRadarAreaFlashing(turfRadarArea[i],true)
			--local r,g,b = toSend.colors[turfData[i].attackinggroup][1],toSend.colors[turfData[i].attackinggroup][2],toSend.colors[turfData[i].attackinggroup][3]
			setRadarAreaColor ( turfRadarArea[i], 255,255,255, 180 )
		end
	else
		toSend.barText=""..turfData[i].owner.." Turf"
		setRadarAreaFlashing(turfRadarArea[i],false)
		local r,g,b = 255,255,255
		if turfData[i].owner ~= "Unoccupied" then
			toSend.colors["Unoccupied"] = {255,255,255}
			toSend.colors["CSG Law"] = {57,55,57}
			toSend.colors["Criminals"] = {255,0,0}
			toSend.colors["Police"] = {0,191,255}
			if toSend.colors[turfData[i].owner] ~= nil then
				r,g,b = toSend.colors[turfData[i].owner][1],toSend.colors[turfData[i].owner][2],toSend.colors[turfData[i].owner][3]
			end
		end
		setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
	end
	if turfData[i].health > 20 and turfData[i].health < 55 and turfData[i].mode=="Owned" then
		toSend.barText=""..turfData[i].owner.." Turf (In Danger)"
		setRadarAreaFlashing(turfRadarArea[i],true)
	end
	toSend.colors["Unoccupied"] = {255,255,255}
	toSend.colors["CSG Law"] = {57,55,57}
	toSend.colors["Criminals"] = {255,0,0}
	for k,v in pairs(t) do
		local teamName = getTeamName(getPlayerTeam(v))
		if (canElementTurf(v)) and (teamName == "Criminals") or ((((isLaw(v))) and (radStations[i] ~= nil)) or (isLaw(v) and getNearestRTType(v) == "law")) then
			if getElementInterior(v) == 0 and getElementDimension(v) == 0 then
				triggerClientEvent(v,"recTurfData",v,toSend)
			end
		end
	end
	 if getTickCount() - turfStability[i] >= 900000 then
		if (turfData[i].owner) and (turfData[i].owner ~= "Unoccupied") and (turfData.owner ~= "CSG Law") and (turfData.owner ~= "Criminals") then
			makeBag(i)
		end
	end
end
end
setTimer(doTurf,15000,0)

local bags = {

}

function makeBag(i)
	if not (bags[i]) then
		bags[i] = {math.random(800,1200),turfData[i].owner}
		--outputChatBox("bag made for "..turfData[i].owner.."")
		sendBagInfo(i)
	end
end

function destroyBag(i)
	turfStability[i] = getTickCount()

	if bags[i] then
	else
		return
	end
	--outputChatBox("bag destroyed for "..bags[i][2].."")
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"tsKillBag",v,i)
	end
	bags[i] = nil
	turfStability[i] = getTickCount()
end

function sendBagInfo(i,p)

	if (p) then
		triggerClientEvent(p,"tsRecBagInfo",p,i,bags[i],true)
	else
		for k,e in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(e) then
				triggerClientEvent(e,"tsRecBagInfo",e,i,bags[i])
			end
		end
	end
end

addEvent("tsBagPick",true)
addEventHandler("tsBagPick",root,function(i,zoneName)
	if bags[i] then
		local stolen = false
		local gr = getElementData(source,"Group")
		if gr ~= bags[i][2] then
			stolen = true
		end
		local money = math.random(800,1000)
		if stolen then money = money + math.random(150,300) end
		givePlayerMoney(source,money)
		if stolen then
			exports.DENdxmsg:createNewDxMessage(source,"Got $"..money.." for stealing a turf money bag",0,255,0)
		else
			exports.DENdxmsg:createNewDxMessage(source,"Got $"..money.." for picking up a turf money bag",0,255,0)
		end
		local grMoney = bags[i][1]
		if stolen == true then grMoney = math.random(200,500) end
		local pName = getPlayerName(source)
		for k,v in pairs(getElementsByType("player")) do
			local gr2 = getElementData(v,"Group")
			if (gr2) and gr == gr2 then
				if stolen then
					exports.DENdxmsg:createNewDxMessage(v,pName.." has stolen a turf money bag at "..zoneName.." from "..bags[i][2].."",0,255,0)
				else
					exports.DENdxmsg:createNewDxMessage(v,pName.." has picked up a turf money bag at "..zoneName.."",0,255,0)
				end
				--exports.DENdxmsg:createNewDxMessage(v,"$"..grMoney.." has been added to the group bank",0,255,0)
			end
		end
		-- add code to add to group bank here
		triggerEvent("onServerGroupBankingDeposit",source,grMoney,true)
		destroyBag(i)
	end
end)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	for k,v in pairs(bags) do
		if (v) then
			sendBagInfo(k,source)
		end
	end
end)

addEvent("CSGturfing.reqDefendingMoney",true)
addEventHandler("CSGturfing.reqDefendingMoney",root,function()
givePlayerMoney(source,30)
exports.CSGscore:givePlayerScore(source,0.0208333)
	if isElementWithinColShape(source,seaCol) then
		givePlayerMoney(source,10)
		exports.CSGscore:givePlayerScore(source,0.0308333)
	end
end)

function turferDied ()
	for k,v in pairs(turfData) do
		if isElementWithinColShape(source,v.col) then
			triggerClientEvent(source,"recTurfData",source,nil)
			return
		end
	end
end
addEventHandler ( "onPlayerWasted", root, turferDied )

function onLeaveTurfZone ( leaveElement, matchingDimension )
	if getElementType(leaveElement) == "player" then
		triggerClientEvent(leaveElement,"recTurfData",leaveElement,nil)
	end
end

local badList = {
	[592]=true,
	[577]=true,
	[511]=true,
	[548]=true,
	[512]=true,
	[593]=true,
	[425]=true,
	[520]=true,
	[417]=true,
	[487]=true,
	[553]=true,
	[488]=true,
	[497]=true,
	[563]=true,
	[476]=true,
	[447]=true,
	[519]=true,
	[460]=true,
	[469]=true,
	[513]=true,
}

function canElementTurf ( theElement )
	if getElementType ( theElement ) == "player" then
		if getElementHealth ( theElement ) ~= 0 then
			if getPedOccupiedVehicle( theElement ) then
				local theVehicle = getPedOccupiedVehicle( theElement )
				if ( isElement(theVehicle) ) and (badList[getElementModel(theVehicle)]) then
					return false
				else
					return true
				end
			else
				return true
			end
		else
			return false
		end
	else
		return false
	end
end

addEvent( "onGroupChangeColor", true )
function setNewTurfColor (group, colorString)
	if type(colorString) == "boolean" then return end
	local turfColorTable = exports.server:stringExplode(colorString, ",")
	local r, g, b = turfColorTable[1], turfColorTable[2], turfColorTable[3]
	for i,v in pairs(turfData) do
		if v.owner == group then
			setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
		end
	end
end
addEventHandler ( "onGroupChangeColor", root, setNewTurfColor )

addEvent( "onAllianceChangeColor", true )
function setNewTurfColorA (alliance, r,g,b)
 	for i,v in pairs(turfData) do
		if v.owner == alliance then
			setRadarAreaColor ( turfRadarArea[i], tonumber(r), tonumber(g), tonumber(b), 180 )
		end
	end
end
addEventHandler ( "onAllianceChangeColor", root, setNewTurfColorA )

addEventHandler("onPlayerLogin",root,function()
local player=source
for i,blipName in pairs(blipStats) do
	triggerClientEvent(player,"CSGturfing.updateBlips",player,i,blipName)
end
end)

