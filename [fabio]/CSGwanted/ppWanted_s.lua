------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppWanted_s.lua (server-side)
--  Wanted / Crime Detection System + Jail GUI's
--  Priyen Patel
------------------------------------------------------------------------------------
-- The connection element

local data = {
	[1] = {"Bodily Harm",0.1},
	[2] = {"Assault with a Deadly Weapon",0.15},
	[3] = {"Assault with a Melee Weapon",0.1},
	[4] = {"Bodily Harm to a Law Enforcement Officer",0.1225},
	[5] = {"Aggravated Assault to a Law Enforcement Officer",0.125},
	[6] = {"Attempted Murder",4},
	[7] = {"1st Degree Murder",25},
	[8] = {"2nd Degree Murder",20},
	[9] = {"Impaired driving",5}, --not yet implemented
	[10] = {"Public Drug Usage",5}, --not yet implemented
	[11] = {"Uttering Threats",3}, --not yet implemented
	[12] = {"Theft of motor vehicle",5}, --not yet implemented
	[13] = {"Arson",5}, --not yet implemented
	[14] = {"Disorderly conduct",1}, --not yet implemented
	[15] = {"Harm to a vehicle",1}, --not yet implemented / refer to ID 20
	[16] = {"Assault with a Weapon of Mass Destruction",1},
	[17] = {"Voluntary Bodily Harm using a Vehicle",0.1},
	[18] = {"1st Degree Murder using a Vehicle",15},
	[19] = {"Unvoluntary Bodily Harm using a Vehicle",0.075},
	[20] = {"Vandalism to a vehicle",0.1},
	[21] = {"Aggravated Assault - Vehicle Jacking",10},
	[22] = {"Attempted Armored Truck Robbery",30},
	[23] = {"Vandalism to a vehicle - Attempted Murder",4},
	[24] = {"Attempted Store Robbery",10},
	[25] = {"Successfull Store Robbery",10},
	[26] = {"Successfull House Break-in",22},
	[27] = {"Attempted House Break-in",15},
	[28] = {"Attempted Bank Robbery",60},
	[29] = {"Successfull Bank Robbery",60},
	[30] = {"Aggravated Robbery",22},
	[31] = {"Attempted Robbery",12},
	[32] = {"Drug Shipment / Robbery",50},
	[33] = {"Illegal Entry - Federal Prison Premesis",10},
	[34] = {"Selling Drugs in Public",3},
	[35] = {"Buying Drugs in Public",3},
	[36] = {"Driving Stolen Vehicle",15},
	[37] = {"Delivering Stolen Vehicle",20},
	[38] = {"Illegally driving law vehicle",35},
}

local shortFormNames = {
	[1] = {"Bodily Harm",0.1},
	[2] = {"Deadly Weapon Usage",0.15},
	[3] = {"Melee Weapon Assault",0.1},
	[4] = {"Bodily Harm to LAW",0.1225},
	[5] = {"Aggravated Assault to a Law",0.125},
	[6] = {"Attempted Murder",4},
	[7] = {"1st Degree Murder",25},
	[8] = {"2nd Degree Murder",20},
	[9] = {"Impaired driving",5}, --not yet implemented
	[10] = {"Public Drug Usage",5}, --not yet implemented
	[11] = {"Uttering Threats",3}, --not yet implemented
	[12] = {"Theft of motor vehicle",5}, --not yet implemented
	[13] = {"Arson",5}, --not yet implemented
	[14] = {"Disorderly conduct",1}, --not yet implemented
	[15] = {"Harm to a vehicle",1}, --not yet implemented / refer to ID 20
	[16] = {"Mass Destruction Usage",1},
	[17] = {"Harm using a Vehicle",0.1},
	[18] = {"1st Degree Murder",15},
	[19] = {"Harm using a Vehicle",0.075},
	[20] = {"Vandalism to a vehicle",0.1},
	[21] = {"Vehicle Jacking",10},
	[22] = {"Attempted Armored Truck Robbery",30},
	[23] = {"Attempted Murder",4},
	[24] = {"Attempted Store Robbery",10},
	[25] = {"Successfull Store Robbery",10},
	[26] = {"Successfull House Break-In",22},
	[27] = {"Attempted House Break-in",15},
	[28] = {"Attempted Bank Robbery",60},
	[29] = {"Successfull Bank Robbery",60},
	[30] = {"Aggravated Robbery",22},
	[31] = {"Attempted Robbery",12},
	[32] = {"Drug Shipment",50},
	[33] = {"Illegal Entry - Federal Prison Premesis",10},
	[34] = {"Selling Drugs in Public",3},
	[35] = {"Buying Drugs in Public",3},
	[36] = {"Driving Stolen Vehicle",15},
	[37] = {"Delivering Stolen Vehicle",20},
	[38] = {"Illegally driving law vehicle",35},
}
-- Create Col in LV
--local LVcol = createColRectangle(866,656,2100,2300)
LVcol = createColRectangle(866,556,2100,2400)
local seaCol = createColRectangle(2983.9, 356.8,850,2700)

local zoneInfo = {}
local cd = {}
local accountCurrentJailPeriod = {}
local accountToday = {}
local needsUpdatedData = {}
local currentCrimesCount = {}
local currentChargesCount = {}
local accountPast7Raw = {}
local currTimeStamp = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()

addEvent("CSGwanted.wUpdate",true)
addEventHandler("CSGwanted.wUpdate",root,function(str)
	zoneInfo[source]=str
end)

function resetMonitor()
	local theStamp = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
	if theStamp ~= currTimeStamp then
		for k,v in pairs(getElementsByType("player")) do
			if exports.server:isPlayerLoggedIn(v) == true then
				triggerClientEvent(v,"CSGwanted.newTimeStamp",v,theStamp)
				local accName = exports.server:getPlayerAccountName(v)
				local userid = exports.server:getPlayerAccountID(v)
				exports.DENmysql:query("UPDATE crimes SET crime=? WHERE userid=? AND timestamp=?",toJSON(accountToday[accName]),userid,theStamp)
				accountToday[accName] = {} for count=1,#data do accountToday[accName][count] = 0 end
				save(v)
				setData(v)
				sendData(v,false)
			end
		end
		currTimeStamp = theStamp
	end
end
setTimer(resetMonitor,1000,0)
--[[
function fakedays(p,cmdName,stamp)
	local userid = exports.server:getPlayerAccountID( p )
	exports.DENmysql:query( "INSERT INTO crimes SET userid=?, crime=?, timestamp=?", userid,toJSON(accountToday[exports.server:getPlayerAccountName(p)]), stamp)
	outputDebugString("Inserted fakeday "..stamp.."")
end
addCommandHandler("fakeday",fakedays)
--]]

addEvent("CSGspawn.alpha",true)
addEventHandler("CSGspawn.alpha",root,function(al)
	setElementAlpha(source,al)
end)

addEvent("CSGwanted.assasinate",true)
addEventHandler("CSGwanted.assasinate",root,function(atker,wep,bodypart)
	if getElementHealth(source) <= 0 then return end
	if getTeamName(getPlayerTeam(source)) ~= "Staff" then
		if getElementInterior(source) ~= 1 and getElementDimension(source) ~= 1 then
			if getPedArmor(source) > 0 then setPedArmor(source,0) return end
			if getElementHealth(source) > 20 then
				setElementHealth(source,math.random(10,20))
			else
				if getElementAlpha(source) == 255 and getElementAlpha(atker) == 255 then
					killPed(source,atker,wep,bodypart)
				end
			end
		end
	end
end)

function save(p)
	dbQuery(s1,{p},exports.DENmysql:getConnection(),"SELECT timestamp FROM crimes WHERE userid=? AND timestamp=?",exports.server:getPlayerAccountID( p ),exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
end

function s1(qh,p)
	--outputDebugString("s1")
	if isElement(p) == false then return end
	--outputDebugString("s1x")
 	local t = dbPoll(qh,-1)
	if t == nil then t = {} end
	if #t == 0 then
		exports.DENmysql:exec("INSERT INTO crimes SET userid=?, crime=?, timestamp=?", exports.server:getPlayerAccountID( p ),toJSON(accountToday[exports.server:getPlayerAccountName( p )]), exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
		--dbQuery(s2,{p},exports.DENmysql:getConnection(),"INSERT INTO crimes SET userid=?, crime=?, timestamp=?", exports.server:getPlayerAccountID( p ),toJSON(accountToday[exports.server:getPlayerAccountName( p )]), exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
	else
		exports.DENmysql:exec("UPDATE crimes SET crime=? WHERE userid=? AND timestamp=?",toJSON(accountToday[exports.server:getPlayerAccountName( p )]),exports.server:getPlayerAccountID( p ), exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
	end
	dbQuery(s2,{p},exports.DENmysql:getConnection(),"SELECT timestamp FROM crimes WHERE userid=? AND timestamp=?",exports.server:getPlayerAccountID(p),11111111)
end

function s2(qh,p)
	if isElement(p) == false then return end
	local t = dbPoll(qh,-1)
	if t == nil then t = {} end
	if #t == 0 then
		exports.DENmysql:exec("INSERT INTO crimes SET userid=?, crime=?, timestamp=?", exports.server:getPlayerAccountID(p),toJSON(accountCurrentJailPeriod[exports.server:getPlayerAccountName( p )]),11111111)
	else
		exports.DENmysql:exec("UPDATE crimes SET crime=? WHERE userid=? AND timestamp=?",toJSON(accountCurrentJailPeriod[exports.server:getPlayerAccountName( p )]),exports.server:getPlayerAccountID(p),"11111111")
	end
end
--[[
function save(p)
	local strExists = false
	local userid = exports.server:getPlayerAccountID( p )
	local accName = exports.server:getPlayerAccountName(p)
	local str = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
	local t = exports.DENmysql:query( "SELECT timestamp FROM crimes WHERE userid=? AND timestamp=?",userid,str)
	if t == nil then t = {} end
	if #t ~= 0 then strExists=true end
	--local t = exports.DENmysql:query( "SELECT * FROM crimes WHERE userid=? ORDER BY timestamp ASC LIMIT 7", userid )
	if strExists == false then
		exports.DENmysql:query( "INSERT INTO crimes SET userid=?, crime=?, timestamp=?", userid,toJSON(accountToday[accName]), str)
		strExists = true
	else
		exports.DENmysql:query("UPDATE crimes SET crime=? WHERE userid=? AND timestamp=?",toJSON(accountToday[accName]),userid,str)
	end
	local t2 = exports.DENmysql:query( "SELECT timestamp FROM crimes WHERE userid=? AND timestamp=?",userid,11111111)
	if t2 == nil then t2 = {} end
	if #t2 == 0 then
		exports.DENmysql:query( "INSERT INTO crimes SET userid=?, crime=?, timestamp=?", userid,toJSON(accountCurrentJailPeriod[accName]),11111111)
	else
		exports.DENmysql:query("UPDATE crimes SET crime=? WHERE userid=? AND timestamp=?",toJSON(accountCurrentJailPeriod[accName]),userid,"11111111")
	end

end
--]]
addEventHandler("onPlayerWasted",root,function(_,killer) save(source) if isElement(killer) then  if getElementType(killer) == "player" then exports.CSGscore:givePlayerScore(killer,0.5) end end exports.CSGscore:takePlayerScore(source,1) end)
addEventHandler("onPlayerQuit",root,function() save(source) local acc = exports.server:getPlayerAccountName(source) accountToday[acc] = nil accountPast7Raw[acc] = nil accountCurrentJailPeriod[acc] = nil end)
--[[
addCommandHandler("savewanted",save)
addCommandHandler("givewanted",function(p) detected(p,math.random(1,#data),p) end)
--]]

function setData(p)
	dbQuery(sd1,{p},exports.DENmysql:getConnection(),"SELECT * FROM crimes WHERE userid=? ORDER BY timestamp DESC LIMIT 7",exports.server:getPlayerAccountID(p))
end

local timers = {}

function sd1(qh,p)
	--outputDebugString("sd1")
	if isElement(p) == false then return end
	local t = dbPoll(qh,-1)
	local accName = exports.server:getPlayerAccountName(p)
	local userid = exports.server:getPlayerAccountID( p )
	local str = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
	--outputDebugString("sd1x")
	if t == nil then t = {} end
	if #t ~= 0 then
		for k,v in pairs(t) do
			t[k].crime = fromJSON(t[k].crime)
		end
		accountPast7Raw[accName] = t
		accountToday[accName] = t[1].crime
	else
		accountToday[accName] = {} for count=1,#data do accountToday[accName][count] = 0 end
		save(p)
		setData(p)
	end
	if not(timers[p]) then
		timers[p]=true
		setTimer(function() timers[p] = nil end,5000,1)
		dbQuery(sd2,{p},exports.DENmysql:getConnection(),"SELECT * FROM crimes WHERE userid=? AND timestamp=?",userid,11111111)
	end
end

function sd2(qh,p)
	if isElement(p) == false then return end
	local t2 = dbPoll(qh,-1)
	local accName = exports.server:getPlayerAccountName(p)
	local userid = exports.server:getPlayerAccountID( p )
	local str = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
	if t2 == nil then t2 = {} end
	if #t2 ~= 0 then
		accountCurrentJailPeriod[accName] = fromJSON(t2[1].crime)
		if accountCurrentJailPeriod[accName] == nil then
			accountCurrentJailPeriod[accName] = {} for i=1,#data do accountCurrentJailPeriod[accName][i] = 0 end
			save(p)
			setData(p)
		end
	else
		accountCurrentJailPeriod[accName] = {} for i=1,#data do accountCurrentJailPeriod[accName][i] = 0 end
		save(p)
		setData(p)
	end

end

--[[
function setData(p)
	local accName = exports.server:getPlayerAccountName(p)
	local userid = exports.server:getPlayerAccountID( p )
	local str = exports.CSGpriyenmisc:getTimeStampYYYYMMDD()
	local t = exports.DENmysql:query( "SELECT * FROM crimes WHERE userid=? ORDER BY timestamp DESC LIMIT 7",userid)
	if #t ~= 0 then
		for k,v in pairs(t) do
			t[k].crime = fromJSON(t[k].crime)
		end
		accountPast7Raw[accName] = t
		accountToday[accName] = t[1].crime
	else
		accountToday[accName] = {} for count=1,#data do accountToday[accName][count] = 0 end
		save(p)
		setData(p)
	end
	local t2 = exports.DENmysql:query("SELECT * FROM crimes WHERE userid=? AND timestamp=?",userid,11111111)
	if #t2 ~= 0 then
		accountCurrentJailPeriod[accName] = fromJSON(t2[1].crime)
		if accountCurrentJailPeriod[accName] == nil then
			accountCurrentJailPeriod[accName] = {} for i=1,#data do accountCurrentJailPeriod[accName][i] = 0 end
			save(p)
			setData(p)
		end
	else
		accountCurrentJailPeriod[accName] = {} for i=1,#data do accountCurrentJailPeriod[accName][i] = 0 end
		save(p)
		setData(p)
	end
end
--]]
function onLogin()
	local p = source
	setTimer(function() triggerClientEvent(p,"CSGwanted.newTimeStamp",p,currTimeStamp) setData(p) sendData(p) end,5000,1)
end
addEventHandler("onPlayerLogin",root,onLogin)

function enterVeh(p,i,jackedP)
	if getElementModel(source) == 447 then return end
	if isElement(jackedP) then
		if getTeamName(getPlayerTeam(p)) ~= "Staff" then
			if getPlayerWantedLevel(jackedP) >= 1 and isLaw(p)==true then
				return
			else

				detected(p,21,jackedP)
			end
		end
	end
end
addEventHandler("onVehicleEnter",root,enterVeh)

function released()
	accountCurrentJailPeriod[exports.server:getPlayerAccountName(source)] = {}
	--save(source)
	sendData(source)
	triggerClientEvent(source,"CSGwanted.playerJailReleased",source)
end
addEvent("onPlayerJailReleased",true)
addEventHandler("onPlayerJailReleased",root,released)

--local stimers = {}
function sendData(p,bool)
	--if (stimers[p]) then return end
	if bool == nil then bool = false end
	if needsUpdatedData[p] == nil then needsUpdatedData[p] = true end
	if needsUpdatedData[p] == false then return end
	local acc = exports.server:getPlayerAccountName(p)
	if accountCurrentJailPeriod[acc] == nil then setData(p) setTimer(function() sendData(p,bool) end,6000,1) return end
	if accountToday[acc] == nil or accountCurrentJailPeriod[acc] == nil then setData(p) end
	local period = {} --current period
	local today = {} --today
	currentCrimesCount[p] = 0
	currentChargesCount[p] = 0
	local mainT = {}
	for k,v in pairs(accountCurrentJailPeriod[acc]) do
		if v ~= 0 then
			table.insert(period,{v,k})
			currentCrimesCount[p]=currentCrimesCount[p]+1
			currentChargesCount[p]=currentChargesCount[p]+v
		end
	end
	if accountPast7Raw[acc] == nil then setData(p) end
	for k,v in pairs(accountPast7Raw[acc]) do
		if tostring(v.timestamp) ~= "11111111" then
			local crimes = {}
			local thisDayT = {tostring(v.timestamp),{}}
			if k == 1  then
				crimes = accountToday[acc]
			else
				crimes = v.crime
			end
			local testS = ""
			if crimes ~= nil then
				for crimeID,amount in pairs(crimes) do
					testS = testS.." "..amount.." "
					if tonumber(amount) > 0 then
						table.insert(thisDayT[2],{amount,crimeID})
					end
				end
				table.insert(mainT,thisDayT)
			end
		end
	end
	triggerClientEvent(p,"CSGwanted.recData",p,mainT,period)
end
addEvent("CSGlaw.playerJailed",true)
addEventHandler("CSGlaw.playerJailed",root,function() sendData(source,true) end)
local descriptions = {}
local responds = {}
for i=1,20 do responds[i] = true end
local locs = {}
local respondingTo = {}
local resToID = {}
local resTimers = {}
local callLocations = {}
function respond(ps,cmdName,i)
	i=tonumber(i)
	if type(i) ~= "number" then
		exports.DENdxmsg:createNewDxMessage(ps,"Responding Syntax: /respond crimeReportID",255,255,0)
		return
	end
	if locs[i] ~= nil then
		if isLaw(ps) == false then
			exports.DENdxmsg:createNewDxMessage(ps,"You are not a LAW enforcement officer!",255,0,0)
		return
		end
		if locs[i][1] ~= nil then
			if resToID[ps] ~= nil then
				exports.DENdxmsg:createNewDxMessage(ps,"Your already responding to a Crime Report, type /rescancel to cancel it!",255,255,0)
			return
			end
			local x,y,z = locs[i][1],locs[i][2],locs[i][3]
			exports.DENdxmsg:createNewDxMessage(ps,descriptions[i],0,255,0)
			exports.CSGgps:setDestination ( ps, x, y, z,"Crime Report",false,{false,true,false,false})
			warnLaw("CR: Officer "..getPlayerName(ps).." is responding to Report #"..i.."",255,0,0)
			resTimers[ps] = setTimer(function() resToID[ps] = nil end,15000,1)
			resToID[ps] = i
			return
		end
	end
	exports.DENdxmsg:createNewDxMessage(ps,"This Crime Report ID does not exist!",255,255,0)
end
addCommandHandler("respond",respond)
addCommandHandler("res",respond)

function cancelRespond(ps)
	if resToID[ps] ~= nil then
		if isTimer(resTimers[ps]) then killTimer(resTimers[ps]) end
		exports.DENdxmsg:createNewDxMessage(ps,"You are no longer responding to Crime Report #"..resToID[ps].."",255,255,0)
		resToID[ps] = nil
		exports.CSGgps:resetDestination(ps)
		return
	end
	exports.DENdxmsg:createNewDxMessage(ps,"You are no longer responding to any Crime Report",255,255,0)
	resToID[ps] = nil
	exports.CSGgps:resetDestination(ps)
	--exports.DENdxmsg:createNewDxMessage(ps,"You already aren't responding to a Crime Report",255,255,0)
end
addCommandHandler("rescancel",cancelRespond)

local timeLeft = {}
for i=1,20 do timeLeft[i] = 0 end

function requestRespondID(x,y,z)
	local zonename = getZoneName(x,y,z)
	for k,v in pairs(callLocations) do
		if v == zonename then
			if timeLeft[k] <= 0 then
			--do nothing
			else
				return 999
			end
		end
	end
	local i = getSmallestSlot()
	responds[i] = false
	timeLeft[i] = 20
	locs[i] = {x,y,z}
	return i
end

function manageTimeLeft()
	for k,v in pairs(timeLeft) do
		if v > 1 then
			timeLeft[k]=timeLeft[k]-1
		end
	end
end
setTimer(manageTimeLeft,1000,0)

function getSmallestSlot()
	local smallestTime = 999999
	local smallestID = 1
	for k,v in pairs(timeLeft) do
		if v < smallestTime then smallestTime = v smallestID = k end
	end
	return smallestID
end

local fireCD = {}
local VandalismCD = {}

function detected(p,i,victim,cx,cy,cz)
        local addMore=false
        if ready == false then return end
        if getElementType(p) ~= "player" then return end
        if getTeamName(getPlayerTeam(p)) == "Staff" then return end
        if getElementInterior(p) == 0 and getElementDimension(p) ~= 0 then return end
        if (isElementWithinColShape(p,LVcol) == true or isElementWithinColShape(p,seaCol)) and i ~= 38 then
                if isLaw(p) then
                        if isElement(victim) then
                                if getPlayerWantedLevel(victim) <= 0 then
                                        addMore=true
                                end
                        end
                end
                if zoneInfo[p] == nil then
                        return
                elseif zoneInfo[p] == "crim" then
                        return
                elseif zoneInfo[p] == "law" then
					if isLaw(victim) and exports.CSGnewturfing2:isPlayerInRegTurf(victim) == true then
						return
					end
                elseif zoneInfo[p] == "noone" then
                        local num = math.random(1,2)
                        if num == 2 then -- take effect only when number is 2 else doing nothing
                                --50% chance of being wanted when noone
                                return
                        end
                end
        end

        if i == 20 then
                if VandalismCD[p] == nil then VandalismCD[p] = false end
                if VandalismCD[p] == true then return end
                VandalismCD[p] = true
                local p2=p
                setTimer(function() VandalismCD[p2] = false end,1000,1)
        end
        local wantedPTS=getElementData(p,"wantedPoints")
        local toAdd = data[i][2]
        if tonumber(wantedPTS) < 10 then
                local needed = 10 - wantedPTS
                local pts = math.random(0.1,needed)
                toAdd=toAdd+pts
        end
        if (isElementWithinColShape(p,LVcol) == true or isElementWithinColShape(p,seaCol))and i~=38 then
                toAdd=toAdd/5
        end
        if addMore==true then toAdd=toAdd*3 end
        if getElementData(p,"Rank") == "Smooth Talker" then toAdd=toAdd*0.8 end
        exports.server:givePlayerWantedPoints(p,toAdd)
	if wantedPTS < 30 and wantedPTS+toAdd > 30 then
		triggerEvent("enterCriminalJob",p,p)
		--setElementData(p,"Occupation","Criminal")
		--setPlayerTeam(p,getTeamFromName("Criminals"))
	end
	setElementData(p,"wantedPoints",wantedPTS+toAdd,true)
	exports.CSGnewsreporter:recRequest(p,data[i][1],toAdd)
	if victim == nil or victim == false or (isElement(victim) == false) then
		victim = getRandomPlayer()
	end
	if cd[p] == nil then cd[p] = {} end
	if cd[p][victim] == nil then cd[p][victim] = {} end
	if cd[p][victim][i] == nil then cd[p][victim][i]=false end
	if cd[p][victim][i] == false then
		if getElementInterior(p) == 0 and getElementDimension(p) == 0 and not(cx) then
			local x,y,z = getElementPosition(p)
			local zonename = getZoneName(x,y,z)
			local resID = requestRespondID(x,y,z)
			if resID ~= 999 then
				callLocations[resID]=zonename
				warnLaw("CR: "..shortFormNames[i][1].." at "..zonename..". Suspect: "..getPlayerName(p).." /respond "..resID.."",255,0,0)
				descriptions[resID] = "Responding to Crime Report: "..data[i][1].." at "..zonename..". Suspect: "..getPlayerName(p)..""
			end
		else
			if	cx ~= nil then
			local zonename = getZoneName(cx,cy,cz)
			local resID = requestRespondID(cx,cy,cz)
				if resID ~= 999 then
					callLocations[resID]=zonename
					warnLaw("CR: "..shortFormNames[i][1].." at "..zonename..". Suspect: "..getPlayerName(p).." /respond "..resID.."",255,0,0)
					descriptions[resID] = "Responding to Crime Report: "..data[i][1].." at "..zonename..". Suspect: "..getPlayerName(p)..""
				end
			end
		end
		local acc = exports.server:getPlayerAccountName(p)
		if accountCurrentJailPeriod[acc] == nil then accountCurrentJailPeriod[acc] = {} for count=1,#data do accountCurrentJailPeriod[acc][count] = 0 end end
		if accountToday[acc] == nil then accountToday[acc] = {} for count=1,#data do accountToday[acc][count] = 0 end end
		if accountCurrentJailPeriod[acc][i] == nil then
			accountCurrentJailPeriod[acc] = {} for count=1,#data do accountCurrentJailPeriod[acc][count] = 0 end
			save(p)
		end
		if accountCurrentJailPeriod[acc][i] == nil then
			accountCurrentJailPeriod[acc][i] = 0
		end
		accountCurrentJailPeriod[acc][i] = accountCurrentJailPeriod[acc][i] + 1
		if accountToday[acc][i] == nil then
			accountToday[acc][i] = 0
		end
		accountToday[acc][i] = accountToday[acc][i] + 1
		cd[p][victim][i] = true
		local p2,victim2,i2 = p,victim,i
		setTimer(function() cd[p2][victim2][i2] = false end,10000,1)
		sendData(p)
	end
end
addEvent("CSGwantedDetect.detected",true)
addEventHandler("CSGwantedDetect.detected",root,detected)

local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}

function getLawTable()
	local law = {}
	for k,v in pairs (lawTeams) do
		local list = getPlayersInTeam(getTeamFromName(v))
		for k,v in pairs(list) do
			table.insert(law,v)
		end
	end
	return law
end

function isLaw(e)
	local team = getTeamName(getPlayerTeam(e))
	for k,v in pairs(lawTeams) do if v == team then return true end end
	return false
end

function warnLaw(msg,r,g,b)
	local law = getLawTable()
	for k,v in pairs(law) do
		-- exports.DENdxmsg:createNewDxMessage(v,"---Notice---",0,255,0)
		exports.killmessages:outputMessage(msg,v,r,g,b)
	end
end

function addWanted(p,id,vic,cx,cy,cz)
	detected(p,id,vic,cx,cy,cz)
end

function recNewWanteds(t)
	for k,v in pairs(t) do
		for k2,v2 in pairs(v) do
			detected(k,v2,source)
		end
	end
end
addEvent("CSGwanted.recNewWanteds",true)
addEventHandler("CSGwanted.recNewWanteds",root,recNewWanteds)

arrests={}
addEvent("onPlayerArrest",true)
addEventHandler("onPlayerArrest",root,function(cop)
	local p = source
	arrests[p]=cop
end)

addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,function(tim)
	local p = source
	if arrests[p] == nil then arrests[p]="The Law" end
	local arrestor = arrests[p]
	local arrestorName = ""
	local pts = math.floor((exports.server:getPlayerWantedPoints(p))+0.5)
	if isElement(arrestor) then
		arrestorName=getPlayerName(arrestor)
		local wantedPoints = tonumber(getElementData(p,"wantedPoints"))
		local scoreToGive=0.1
		if wantedPoints > 30 then scoreToGive=0.25 end
		if wantedPoints > 40 then scoreToGive=0.5 end
		if wantedPoints > 50 then scoreToGive=1 end
		if wantedPoints > 70 then scoreToGive=1.5 end
		if wantedPoints > 100 then scoreToGive=2 end
		exports.CSGscore:givePlayerScore(arrestor,scoreToGive)
		exports.CSGscore:takePlayerScore(p,1)
	else
		arrestorName=arrestor
	end
	if currentCrimesCount[p] == nil then sendData(p,true) end
	triggerClientEvent(p,"CSGwanted.jailed",p,arrestorName,tim,pts,currentCrimesCount[p],currentChargesCount[p])
end)

ready = false
onStartTimer = setTimer(function()
	for k,v in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(v) == true then
			triggerClientEvent(v,"CSGwanted.newTimeStamp",v,currTimeStamp)
			setData(v)
			sendData(v)
		end
	end
	ready = true
end,5000,1)
------------------



-- Check if player is in LV
addEventHandler( "onColShapeHit", LVcol, -- Root is alle cols he
function (hitElement)
	setElementData ( hitElement, "isPlayerInLvCol", true )
end
) -- Denk dat dit het al oplost

addEventHandler( "onColShapeLeave", LVcol,
function (hitElement)
	setElementData ( hitElement, "isPlayerInLvCol", true )
end
)

addEvent ("isPlayerInLvCol", true)
function isPlayerInLvCol ()
	setElementData ( source, "isPlayerInLvCol", false )
	if isElementWithinColShape ( source, LVcol ) then
		setElementData ( source, "isPlayerInLvCol", true )
	end
end
addEventHandler ("onPlayerConnect", root, isPlayerInLvCol)
addEventHandler ("onPlayerLogin", root, isPlayerInLvCol)
addEventHandler ("isPlayerInLvCol", root, isPlayerInLvCol)

