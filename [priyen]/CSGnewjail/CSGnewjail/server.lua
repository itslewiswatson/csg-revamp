local gateWalkers = {
	{934.76, -2367.17, 13.24}
}

local gateWalkPeds = {

}

local patrols1 = {
	{ 829.482421875,-2461.6259765625,12.9296875,
	  {
		{"walkToPos", 830.41015625,-2463.1142578125,12.9296875,1},
		{"walkToPos", 831.4140625,-2537.0361328125,12.9296875,1},
		{"walkToPos", 880.1484375,-2538.9248046875,12.9296875,1},
		{"walkToPos", 880.59375,-2559.1494140625,12.970000267029,1},
		{"walkToPos", 861.0419921875,-2557.2314453125,12.970000267029,1},
		{"walkToPos", 860.4658203125,-2550.203125,12.970000267029,1},
		{"walkToPos", 848.892578125,-2549.5517578125,12.970000267029,1},
		{"walkToPos", 848.078125,-2558.326171875,12.970000267029,1},
		{"walkToPos", 848.12890625,-2551.4326171875,12.970000267029,1},
		{"walkToPos", 860.9140625,-2552.421875,12.970000267029,1},
		{"walkToPos", 875.0751953125,-2560.19140625,12.970000267029,1},
		{"walkToPos", 880.8759765625,-2555.453125,12.970000267029,1},
		{"walkToPos", 881.2939453125,-2543.439453125,12.970000267029,1},
		{"walkToPos", 876.32421875,-2535.669921875,12.9296875,1},
		{"walkToPos", 832.837890625,-2535.4033203125,12.9296875,1},
		{"walkToPos", 828.3896484375,-2463.181640625,12.9296875,1},
	  }
	}
}

local snipers = {
	--{ 827.87731933594,-2454.5473632813,28.046634674072},
	--{846.65234375,-2454.4331054688,28.046634674072},
	--{ 814.4697265625,-2563.2568359375,22.127107620239},
	--{ 813.2919921875,-2483.537109375,22.21968460083},
}

local sniperPeds = {

}

local sniperHunting = {}
addEvent("onBotFindEnemy",true)
setTimer(function()
for k,v in pairs(snipers) do
	local ped =createPed(287,v[1],v[2],v[3])
	setElementFrozen(ped,true)
	local col = createColTube(1,1,60)
	attachElements(col,ped)
	addEventHandler("onColShapeHit",col,function(e)
		if getElementType(e) == "player" then
			giveWeapon(ped,31,99999)
			setPedWeaponSlot(ped,5)
		end
	end)
	setTimer(function()
		giveWeapon(ped,31,99999)
		setPedWeaponSlot(ped,5)
	end,1000,5)
	table.insert(sniperPeds,ped)
	exports.npc_hlc:enableHLCForNPC(ped,"walk",1)
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"CSGjail.recSniperPed",v,ped)
	end
end
end,5000,1)
addEvent("CSGjail.iHurtArmyPed",true)
addEventHandler("CSGjail.iHurtArmyPed",root,function(ped)
	for k,v in pairs(sniperPeds) do
		--setElementData(v,"slothbot",true,true)
		--exports.slothbot:setBotAttackEnabled(v,true)
		--exports.slothbot:setBotChase(v,source)
		exports.npc_hlc:setNPCTask(v,{"shootElement", source})
	end
	addEventHandler("onPlayerWasted",source,function()
		for k,v in pairs(sniperPeds) do
			exports.slothbot:setBotAttackEnabled(v,false)
			--removeElementData(v,"slothbot")
			exports.npc_hlc:clearNPCTasks(v)
		end
		for k,v in pairs(getElementsByType("player")) do
			triggerClientEvent(v,"CSGjail.alarmStop",v)
		end
	end)
	local x,y,z = getElementPosition(source)
	for k,v in pairs(getElementsByType("player")) do
		triggerClientEvent(v,"CSGjail.alarm",v,x,y,z)
	end

end)
--[[
local drivePatrols1 = {
	{ 775.9580078125,-2462.021484375,12.9296875,
		{
			{"driveToPos", 775.9580078125,-2462.021484375,12.9296875,1},
			{"driveToPos", 914.7275390625,-2461.9365234375,12.9296875,1},
			{"driveToPos", 912.1953125,-2535.12109375,12.9296875,1},
			{"driveToPos", 833.111328125,-2534.154296875,12.9296875,1},
			{"driveToPos", 833.380859375,-2477.6494140625,12.9296875,1},
			{"driveToPos", 783.7099609375,-2475.884765625,12.937484741211,1},
		}
	}
}
--]]

addEvent("npc_hlc:onNPCTaskDone",true)
for k,v in pairs(gateWalkers) do
	local ped = createPed(287,v[1],v[2],v[3])
	setTimer(function()
		giveWeapon(ped,31,99)
		setPedWeaponSlot(ped,5)
	end,1000,10)
	exports.npc_hlc:enableHLCForNPC(ped,"walk")
	exports.npc_hlc:addNPCTask(ped,{"walkToPos", 934.76, -2367.17, 13.24,1})
	exports.npc_hlc:addNPCTask(ped,{"walkToPos", 941.7, -2379.03, 13.25,1})
	table.insert(gateWalkPeds,ped)
	setElementData(ped,"ShowModelPed",true,true)
	addEventHandler("npc_hlc:onNPCTaskDone",ped,function()
		exports.npc_hlc:addNPCTask(ped,{"walkToPos", 934.76, -2367.17, 13.24,1})
		exports.npc_hlc:addNPCTask(ped,{"walkToPos", 941.7, -2379.03, 13.25,1})
	end)
end

for k,v in pairs(patrols1) do
	local ped = createPed(287,v[1],v[2],v[3])
	setTimer(function()
		giveWeapon(ped,31,99)
		setPedWeaponSlot(ped,5)
	end,1000,10)
	exports.npc_hlc:enableHLCForNPC(ped,"walk")
	for _,task in pairs(v[4]) do
		exports.npc_hlc:addNPCTask(ped,task)
	end

	table.insert(gateWalkPeds,ped)
	setElementData(ped,"ShowModelPed",true,true)
	addEventHandler("npc_hlc:onNPCTaskDone",ped,function()
		local i=k
		for _,task in pairs(patrols1[i][4]) do
			exports.npc_hlc:addNPCTask(ped,task)
		end
	end)
end


--[[
for k,v in pairs(drivePatrols1) do
	local ped = createPed(287,v[1],v[2],v[3])
	local veh = createVehicle(490,v[1],v[2],v[3])

	setTimer(function()
		giveWeapon(ped,31,99)
		warpPedIntoVehicle(ped,veh)
		setPedWeaponSlot(ped,5)
	end,1000,10)

	exports.npc_hlc:enableHLCForNPC(ped,"walk",1,2)
	for _,task in pairs(v[4]) do
		exports.npc_hlc:addNPCTask(ped,task)
	end

	table.insert(gateWalkPeds,ped)
	setElementData(ped,"ShowModelPed",true,true)
	addEventHandler("npc_hlc:onNPCTaskDone",ped,function()
		local i=k
		for _,task in pairs(drivePatrols1[i][4]) do
			exports.npc_hlc:addNPCTask(ped,task)
		end
	end)
end
--]]
addCommandHandler("savepos",function(ps)
	local x,y,z = getElementPosition(ps)
	outputConsole('{"driveToPos", '..x..','..y..','..z..',1}')
end)









--restricted area
local resCol = createColRectangle(759,-2572,200,400)
local timers = {}

addEventHandler("onColShapeHit",resCol,function(e)
	if getElementType(e) ~= "player" then return end
	local teamName=getTeamName(getPlayerTeam(e))
	if teamName == "Staff" or teamName=="Government Agency" or teamName=="SWAT" or teamName=="Police" or teamName=="Military Forces" then return end
	if getElementData(e,"isPlayerArrested") == true then return end
	exports.dendxmsg:createNewDxMessage(e,"You have entered CSG Federal Prison premesis",255,0,0)
	exports.dendxmsg:createNewDxMessage(e,"You have 10 seconds to leave before you are classified as an intruder",255,0,0)
	if timers[e] ~= nil then if isTimer(timers[e]) then killTimer(timers[e]) end end
	timers[e] = setTimer(function() if isElementWithinColShape(e,resCol) == true then exports.CSGwanted:addWanted(e,33,false) else
		if timers[e] ~= nil then if isTimer(timers[e]) then killTimer(timers[e]) end end
		end
	end,10000,0)
end)

addEventHandler("onPlayerQuit",root,function()
	local e = source
	if timers[e] ~= nil then if isTimer(timers[e]) then killTimer(timers[e]) end end
end)

