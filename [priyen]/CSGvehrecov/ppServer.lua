theVeh = false
vehs={
445,507,585,587,466,492,546,551,516,411,559,561,560,506,451,480,565,415,541,494
}
local starts = {
 {1837.57,-2031.76, 13.54,117},
 {2229.74, -1003.81, 59.78, 151},
 {2804.14, -1109.22, 30.49, 185},
 {2444.96, -1762.54, 13.3, 10},
 {2047.06, -2151.55, 13.38, 343},
 {1245.74, -2036.43, 59.6, 89},
 {490.49, -1528.51, 19.46, 15},
 {685.5, -1026.25, 51.04, 154},
 {-1969.59, -743.58, 31.98, 268},
 {-2416.36, 331.39, 34.73, 148},
 {-2688.18, 330.44, 4.04, 264},
 {-2515.2, 1003.9, 78.11, 91},
 {-2077, 1430.31, 6.86, 353},
 {-2274.4, 787.73, 49.13, 173},
 {-2049, 144.64, 28.6, 38},
 {-1855.58, -134.51, 11.67, 77},
 { 1083.6, 1449.13, 5.58, 93},
{ 1435.67, 2378.86, 10.68, 89},
{ 2511.57, 2492.17, 10.57, 72},
{ 1894.42, 1138.37, 10.57, 1.5},
{2843.2,1644.35, 10.24, 0.13},
 --{2852.14, 1232.82, 10.24, 92.08},
 {2647.71, 738.66, 10.24, 87.60},
 {2383.53, 552.71, 7.2, 1.01},
}

local destsCrim = {
	{1643.59, -1522.9, 13.55},
	{1087.25, 1890.7, 10.82},
	{-142.43, 1125.44, 19.74},
}

local destsLaw = {
	{1566.8, -1693.15, 5.89},
	{ 2292.51, 2467.35, 9.82},
	{ -1590.08, 716.58, -4.25},
}

local wanted = {}
current="law"
resetTimer = false
firstEnter=false
resetTimer=false
started=false
local dx,dy,dz = 0,0,0
theVeh=false
function start()
	firstEnter=true
	if isTimer(resetTimer) then killTimer(resetTimer) end
	if isTimer(startTimer) then killTimer(startTimer) end
	if current=="crim" then t = destsCrim else t = destsLaw end
	local i2 = math.random(1,#t)
	local i = math.random(1,#starts)
	local x,y,z = starts[i][1], starts[i][2], starts[i][3]
	dx,dy,dz = t[i2][1],t[i2][2],t[i2][3]
	theVeh=createVehicle(vehs[math.random(1,#vehs)],x,y,z)
	setElementRotation(theVeh,0,0,starts[i][4])
	resetTimer=setTimer(reset,600000,1)
	destMarker=createMarker(dx,dy,dz-1,"cylinder",3)
	addEventHandler("onMarkerHit",destMarker,hitMarker)
	started=true
	vehName=getVehicleName(theVeh)
	wanted={}
	if current == "crim" then
		warnCriminals("The Mafia has left a precious vehicle on the streets!")
		warnCriminals("A "..vehName.." needs to be hijacked! Steal it and bring it in for some money!")
	elseif current=="law" then
		warnLaw("CSG's Police Head Quarters have tracked down a stolen vehicle to a location nearby")
		warnLaw("Recover the stolen "..vehName.." and bring it to the desired destination for a satisfying payment!")
	end
	if current=="crim" then
		for k,v in pairs(getPlayersInTeam(getTeamFromName("Criminals"))) do
			local source=v
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	else
		for k,v in pairs(getLawTable()) do
			local source=v
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	end
end

addEvent("onPlayerLogin",true)
addEventHandler("onPlayerLogin",root,function()
	if started==true then
		if current=="law" then
			if isLaw(source) == true then
				if isElement(theVeh) then
					triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
				end
			end
		elseif current=="crim" then
			if getTeamName(getPlayerTeam(source)) == "Criminals" then
				if isElement(theVeh) then
					triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
				end
			end
		end
	end
end)

function hitMarker(e)
	if source == destMarker then
		if getElementType(e) == "vehicle" then
			if e ~= theVeh then return end
			if isElement(getVehicleController(e)) then
				local p = getVehicleController(e)
				if current=="crim" then
					if getTeamName(getPlayerTeam(p)) == "Criminals" then
						local pay,score = getPay()
						exports.CSGwanted:addWanted(p,37,getRandomPlayer())
						exports.CSGscore:givePlayerScore(p,score)
						local per = getElementHealth(theVeh)/10
						per=math.floor(per)
						pay=(per/100)*pay
						pay=math.floor(pay)
						givePlayerMoney(p,pay)
						warnCriminals(""..getElementData(p,"Rank").." "..getPlayerName(p).." has returned the hijacker vehicle ("..per.."% health) for $"..pay.."!")
						exports.DENdxmsg:createNewDxMessage(p,"+"..score.." Score for delievering the hijacker vehicle!",0,255,0)
						setElementData(p,"wantedPoints",getElementData(p,"wantedPoints")+10)
						local am = exports.DENstats:getPlayerAccountData(p,"hijackcarscrim")
						if am == nil or am == false then am=0 end
						exports.DENstats:setPlayerAccountData(p,"hijackcarscrim",am+1)
						reset()
					else
						exports.DENdxmsg:createNewDxMessage("Only criminals can deliever this vehicle right now!",255,255,0)
						return
					end
				elseif current=="law" then
					if isLaw(p) then
						local pay,score = getPay()

						exports.CSGscore:givePlayerScore(p,score)
						local per = getElementHealth(theVeh)/10
						per=math.floor(per)
						pay=(per/100)*pay
						pay=math.floor(pay)
						givePlayerMoney(p,pay)
						warnLaw(""..getElementData(p,"Rank").." "..getPlayerName(p).." has returned the stolen vehicle ("..per.."% health) for $"..pay.."!")
						exports.DENdxmsg:createNewDxMessage(p,"+"..score.." Score for returning the stolen vehicle!",0,255,0)
						local am = exports.DENstats:getPlayerAccountData(p,"hijackcarslaw")
						if am == nil or am == false then am=0 end
						exports.DENstats:setPlayerAccountData(p,"hijackcarslaw",am+1)
						reset()
					else
						exports.DENdxmsg:createNewDxMessage("Only a law enforcement officer can deliever this vehicle right now!",255,255,0)
						return
					end
				end
			end
		end
	end
end

function getPay()
	if current=="law" then
		local law = getLawTable()
		local laws = #law
		local money=laws*550
		local score=laws*0.18
		return money,score
	elseif current=="crim" then
		local crim = getPlayersInTeam(getTeamFromName("Criminals"))
		local crims = #crim
		local money=crims*400
		local score=crims*0.18
		return money,score
	end
end

addEventHandler("onVehicleEnter",root,function(p)
	if source ~= theVeh then return end
	if getPedOccupiedVehicleSeat(p) ~= 0 then return end
	if current=="crim" and getTeamName(getPlayerTeam(p)) == "Criminals" then
		warnCriminals(""..getElementData(p,"Rank").." "..getPlayerName(p).." has entered the hijacker vehicle "..vehName.."!")
		if wanted[p] == nil then wanted[p]=false end
		if wanted[p] == false then
			exports.CSGwanted:addWanted(p,36,getRandomPlayer())
			wanted[p]=true
		end
	elseif current=="law" then
		if isLaw(p) then
			warnLaw(""..getElementData(p,"Rank").." "..getPlayerName(p).."  has entered the stolen vehicle "..vehName.."!")
		else
			warnLaw("A unknown stranger has entered the stolen vehicle, recover it!")
		end
	end
	if firstEnter==true then
		firstEnter=false
		killTimer(resetTimer)
		resetTimer=setTimer(reset,500000,1)
	end
end)

addEventHandler("onVehicleExplode",root,function()
	if source == theVeh then
		if current=="crim" then
			warnCriminals("The "..vehName.." has blown up! It can no longer be recovered!")
		elseif current=="law" then
			warnLaw("The "..vehName.." has blown up! No law officer is able to return it now!")
		end
	end
end)

local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency"
}

function reset()
	firstEnter=true
	started=false
	if isTimer(resetTimer) then killTimer(resetTimer) end
	if isTimer(startTimer) then killTimer(startTimer) end
	startTimer=setTimer(start,120000,1)
	if current=="law" then
		for k,v in pairs(getLawTable()) do
			local source=v
			triggerClientEvent(source,"hijackBlipd",source)
		end
		current="crim"
	else
		for k,v in pairs(getPlayersInTeam(getTeamFromName("Criminals"))) do
			local source=v
			triggerClientEvent(source,"hijackBlipd",source)
		end
		current="law"
	end
	if isElement(theVeh) then
		destroyElement(theVeh)
	end
	if isElement(destMarker) then
		destroyElement(destMarker)
	end
end

function warnCriminals(msg)
	local list = getPlayersInTeam(getTeamFromName("Criminals"))
	for k,v in pairs(list) do
		 exports.DENdxmsg:createNewDxMessage(v,msg,255,0,0)
	end
end

function warnLaw(msg)
	local law = getLawTable()
	for k,v in pairs(law) do
		 exports.DENdxmsg:createNewDxMessage(v,msg,0,255,0)
	end
end

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

addEvent("onPlayerTeamChange",true)
addEventHandler("onPlayerTeamChange",root,function()
	if current=="law" then
		if isLaw(source) == false then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	else
		if getTeamName(getPlayerTeam(source)) ~= "Criminals" then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	end
end)

 addEventHandler("onElementDataChange",root,function(name)

	if name ~= "Occupation" then return end
	if getElementType(source) ~= "player" then return end
	if current=="law" then
		if isLaw(source) == false or started==false then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			if started==false then return end
			if isElement(theVeh) == false then return end
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	else
		if getTeamName(getPlayerTeam(source)) ~= "Criminals" or started==false then
			triggerClientEvent(source,"hijackBlipd",source)
		else
			if isElement(theVeh) == false then return end
			triggerClientEvent(source,"hijackBlip",source,theVeh,dx,dy,dz)
		end
	end
end)

setTimer(start,10000,1)
