ae=addEvent
aeh=addEventHandler
tse=triggerServerEvent
lp=localPlayer
sendtick = getTickCount()

local trees = {}
local peds = {}
local blips = {}


ae("recTree",true)
aeh("recTree",lp,function(tree)
	table.insert(trees,tree)
	if getElementData(localPlayer,"Occupation") == "Lumberjack" then
		local x,y,z = getElementPosition(tree)
		blips[tree] = createBlip(x,y,z,0)
	end
	--tse("desTree",lp,tree)
end)

ae("remTree",true)
aeh("remTree",lp,function(tree)
	for k,v in pairs(trees) do if v == tree then table.remove(trees,k) destroyElement(blips[tree]) end end
end)

ae("treeFall",true)
aeh("treeFall",lp,function( ... )
	local tree = createObject( ... )
	local x,y,z = getElementPosition(tree)
	--[[setTimer(function()
		local rx = getElementRotation(tree)
		local x,y,z = getElementPosition(tree)

		setElementPosition(tree,x,y,z-0.3)
		setElementRotation(tree,rx-1,0,0)
	end,50,111)--]]
	setElementCollisionsEnabled(tree,false)
	moveObject(tree,6000,x,y,z-10,0,90,90)
	setTimer(function()
		local x,y,z = getElementPosition(tree)
		moveObject(tree,5000,x,y,z-5)
		setTimer(destroyElement,5000,1,tree)
		--if blips[tree] then destroyElement(blips[tree]) end
	end,6000,1)
end)

aeh("onClientPedDamage",root,function(atk,wep)
	if getElementData(source,"l") and wep ~= 9 then cancelEvent() end
end)

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if oldJob == "Lumberjack" then
		for k,v in pairs(blips) do
			destroyElement(v)
			blips[k]=nil
		end
	elseif nJob == "Lumberjack" then
		exports.DENdxmsg:createNewDxMessage("Lumberjack :: Cut down trees (the red blips on your map) for money!",0,255,0)
		for k,v in pairs(trees) do
			if not blips[v] then
				local x,y,z = getElementPosition(v)
				blips[v] = createBlip(x,y,z,0)
			end
		end
	end
end
addEventHandler("onPlayerJobChange",localPlayer,jobChange)
