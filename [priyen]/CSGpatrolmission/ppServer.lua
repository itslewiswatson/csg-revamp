peds = {}
pissData = {}
pissMarkers = {}
limit = {}
function clear(pp)
	if peds[pp] ~= nil then
		for k,v in pairs(peds[pp]) do
			if isElement(v) then
				if pissData[v] ~= nil then
					removeEventHandler("onMarkerHit",pissData[v][2],hitMarker)
					destroyElement(pissData[v][2])
					destroyElement(pissData[v][1])
					pissData[v]=nil
				end
				if getElementType(v) == "marker" then
					removeEventHandler("onMarkerHit",v,hitStreamMarker)
					local p = getElementData(v,"p")
					triggerClientEvent(root,"CSGpatrolMission.stream",root,p,"",false)
				end
				destroyElement(v)
			end
		end
	end
end

setTimer(function() limit = {} end, 3600000,0)

function circle(r,s,cx,cy)
	local xVals = {}
	local yVals = {}
	for i=1,s-1 do
		xVals[i] = (cx+r*math.cos(math.pi*i/s*2-math.pi/2))
		yVals[i] = (cy+r*math.sin(math.pi*i/s*2-math.pi/2))
	end
	return xVals,yVals
end
circle(10,200,10,10)

function hitStreamMarker(e,bool)
	if bool == false then return end
	if getElementType(e) ~= "player" then return end
	local i = getElementData(source,"songI")
	local p = getElementData(source,"p")
	local x,y,z = getElementPosition(source)
	triggerClientEvent(e,"CSGpatrolMission.stream",e,p,i,true,x,y,z)
end

local possibleSkins = {
	1,105,106,107,102,103,104,108,109,110,114,115,116,111,112,113
}

function doEffect(i,dx,dy,dz,songI)
	local p = source
	clear(source)
	if i == 2 or i == 3 or i == 5 then
		local am = 2
		if i == 3 or i == 5 then
			am = math.random(3,6)
		end
		local t = {}
		for var=1,am do
			local xVals,yVals = circle(7,200,dx,dy,dz)
			local i2 = math.random(1,#xVals)
			local ped1= exports.slothbot:spawnBot(xVals[i2],yVals[i2],dz,0,possibleSkins[math.random(1,#possibleSkins)])
			table.insert(t,ped1)
			if i ~= 5 then
				exports.slothbot:setBotAttackEnabled(ped1,true)
			else
				exports.slothbot:setBotAttackEnabled(ped1,false)
				local dances = {
				"dnce_M_a",
				"dnce_M_b",
				"dnce_M_c",
				"dnce_M_d",
				"dnce_M_e",
				}
				setTimer(function() setPedAnimation(ped1,"DANCING",dances[math.random(1,#dances)],9999999,true,true,false) end,2000,1)

			end
		end
		if i == 2 then
			exports.slothbot:setBotChase(t[1],t[2])
			exports.slothbot:setBotChase(t[2],t[1])
		end
		if i == 5 then
			local xVals,yVals = circle(7,200,dx,dy,dz)
			local i = math.random(1,#xVals)
			local speaker = createObject(2229,xVals[i],yVals[i],dz-1)
			table.insert(t,speaker)
			local m = createMarker(xVals[i],yVals[i],dz-1,"cylinder",50,255,255,0,0)
			table.insert(t,m)
			addEventHandler("onMarkerHit",m,hitStreamMarker)
			setElementData(m,"songI",songI)
			setElementData(m,"p",source)
		end
		peds[source]=t
		triggerClientEvent(source,"CSGpatrolMission.recPeds",source,t)

		return
	end
	if i == 1 then
		local t = {}
		local xVals,yVals = circle(7,200,dx,dy,dz)
		local i = math.random(1,#xVals)
		local veh = createVehicle(602,xVals[i],yVals[i],dz)
		local ped1= exports.slothbot:spawnBot(xVals[i],yVals[i],dz+2,0,possibleSkins[math.random(1,#possibleSkins)])
		table.insert(t,veh)
		table.insert(t,ped1)
		setVehicleDamageProof(veh,true)
		peds[source]=t
		triggerClientEvent(source,"CSGpatrolMission.recPeds",source,t)
		setTimer(function() setElementFrozen(veh,true) end,2000,1)
		return
	end
	if i == 6 then
		local t = {}
		local am = math.random(1,4)
		for i=1,am do
			local xVals,yVals = circle(7,200,dx,dy,dz)
			local i = math.random(1,#xVals)
			local ped1 = exports.slothbot:spawnBot(xVals[i],yVals[i],dz,0,possibleSkins[math.random(1,#possibleSkins)])
			table.insert(t,ped1)
			exports.slothbot:setBotAttackEnabled(ped1,false)
			if i == 1 or i == 2 then
				setTimer(function() setPedAnimation(ped1,"DEALER","DEALER_DEAL",9999999,true,true,false) end,2000,1)
			else
				if math.random(1,100) > 50 then
					setTimer(function() setPedAnimation(ped1,"DEALER","DRUGS_BUY",9999999,true,true,false) end,2000,1)
				else
					setTimer(function() setPedAnimation(ped1,"DEALER","DEALER_IDLE",9999999,true,true,false) end,2000,1)
				end
			end
		end
		for k,v in pairs(t) do
			if k ~= #peds then
				exports.slothbot:setBotChase(v,peds[k+1])
			else
				exports.slothbot:setBotChase(v,peds[1])
			end
		end
		peds[source]=t
		setTimer(function() triggerClientEvent(p,"CSGpatrolMission.recPeds",p,t)end, 2000,1)
	end
	if i == 7 then
		local am = math.random(1,5)
		local t = {}
		for i=1,am do
			local xVals,yVals = circle(7,200,dx,dy,dz)
			local i = math.random(1,#xVals)
			local ped1 = exports.slothbot:spawnBot(xVals[i],yVals[i],dz,0,possibleSkins[math.random(1,#possibleSkins)])
			local skin1 = math.random(1,100)
			if skin1 > 50 then
				setPedAnimation(ped1,"PAULNMAC","Piss_loop",99999999,true,false,false)
			else
				setPedAnimation(ped1,"STRIP","strip_B",99999999,true,false,false)
			end
			table.insert(t,ped1)
			local x,y,z = getElementPosition(ped1)
			local piss = createObject(2052,x,y,z)
			local m = createMarker(x,y,z,"cylinder",1.5,255,255,0,0)
			if skin1 > 50 then
				attachElements(piss,ped1,0,0.5)
			else
				attachElements(piss,ped1,0,0.215)
			end
			attachElements(m,ped1,0,0.5,-0.75)
			pissData[ped1] = {piss,m}
			addEventHandler("onMarkerHit",m,hitMarker)
		end
			peds[source]=t
			setTimer(function() triggerClientEvent(p,"CSGpatrolMission.recPeds",p,t) end, 2000,1)
	end
end
addEvent("CSGpatrolMission.doEffect",true)
addEventHandler("CSGpatrolMission.doEffect",root,doEffect)

local cd = {}
function hitMarker(e,bool)
	if bool == false then return end
	if getElementType(e) ~= "player" then return end
	if cd[e] == nil or cd[e] == 0 then
		setPedAnimation(e,"FOOD","EAT_Vomit_P",3000,true,true,true)
		setTimer(function() setPedAnimation(e,false) end, 3000,1)
		setTimer(function() cd[e] = 0 end, 6000,1)
		cd[e] = 6
	end
end

function CSGpatrolMissiondetainedPeds(i,bool,pay,calls)
	clear(source)
	if bool == true then
		givePlayerMoney(source,pay)
		exports.CSGscore:givePlayerScore(source,calls*0.4)
	end
end
addEvent("CSGpatrolMission.success",true)
addEventHandler("CSGpatrolMission.success",root,CSGpatrolMissiondetainedPeds)

function canStart()
	triggerClientEvent(source,"CSGpatrolMission.recCanStart",source,true)
	--[[
	local accName = exports.server:getPlayerAccountName(source)
	if limit[accName] == nil then limit[accName] = 3 end
	if limit[accName] > 0 then
		limit[accName] = limit[accName]-1
		triggerClientEvent(source,"CSGpatrolMission.recCanStart",source,true)
	else
		triggerClientEvent(source,"CSGpatrolMission.recCanStart",source,false)
	end
	--]]
end
addEvent("CSGpatrolMission.canClientStart",true)
addEventHandler("CSGpatrolMission.canClientStart",root,canStart)

function neutrailizedPed(ped)
	if pissData[ped] ~= nil then
		removeEventHandler("onMarkerHit",pissData[ped][2],hitMarker)
		setPedAnimation(ped,false)
		destroyElement(pissData[ped][2])
		destroyElement(pissData[ped][1])
		pissData[ped]=nil
	end
	local num = math.random(1,100)
	setPedAnimation(ped,false)
	setElementData(ped,"slothbot",false)
	setElementFrozen(ped,true)
	setPedAnimation(ped,"ped","handsup",3000,false,false,false)
end
addEvent("CSGpatrolMission.neutrailizedPed",true)
addEventHandler("CSGpatrolMission.neutrailizedPed",root,neutrailizedPed)

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	triggerClientEvent(source,"CSGpatrolMission.servFailed",source)
end
addEventHandler("onPlayerJobChange",root,jobChange)

function attackedDealingPed(ped)
	setPedAnimation(ped,false)
	exports.slothbot:setBotAttackEnabled(ped,true)
	exports.slothbot:setBotChase(ped,source)
end
addEvent("CSGpatrolMission.attackedDealingPed",true)
addEventHandler("CSGpatrolMission.attackedDealingPed",root,attackedDealingPed)

addEvent("CSGpatrolMission.endAll",true)
addEventHandler("CSGpatrolMission.endAll",root,function() clear(source) end)

addEventHandler("onPlayerQuit",root,function() clear(source) end)

addEventHandler("onPlayerWasted",root,function() clear(source) end)

addEvent("onBotFindEnemy",true)
addEventHandler("onBotFindEnemy",root, function() if isElementFrozen(source) == true then cancelEvent() end end)

addEvent("onBotFollow",true)
addEventHandler("onBotFollow",root, function() if isElementFrozen(source) == true then cancelEvent() end end)
