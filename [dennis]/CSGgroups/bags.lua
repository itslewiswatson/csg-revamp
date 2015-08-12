local bags = {}
local bagsE = {}

addEvent("tsRecBagInfo",true)
addEvent("tsRecBagInfo",localPlayer,function(i,t)
	bags[i] = t
	local gr = getElementData(localPlayer,"Group")
	if (gr) then
		for i,v in pairs(bags) do
			if v[1] == gr and not(bagsE[i]) then
				local x,y,z = turfSpawnTable[i][1],turfSpawnTable[i][2],turfSpawnTable[i][3]
				bagsE[i] = {}
				bagsE[i][1] = createObject(1550,x,y,z)
				bagsE[i][2] = createMarker(x,y,z,"cylinder",2,255,0,0,0)
				setElementData(bagsE[i][2],"i",i)
				exports.DENdxmsg:createNewDxMessage("A turf money bag is available for pickup in "..getZoneName(x,y,z).."",0,255,0)
				addEventHandler("onClientMarkerHit",bagsE[i][2],hitMarker)
			end
		end
	end
end)

addEvent("tsKillBag",true)
addEvent("tsKillBag",localPlayer,function(i)
	if bagsE[i] then
		removeEventHandler("onClientMarkerHit",bagsE[i][2],hitMarker)
		destroyElement(bagsE[i][1])
		destroyElement(bagsE[i][2])
	end
	bagsE[i] = nil
	bags[i] = nil
end)

addEventHandler("onClientRender",root,function()
	for k,v in pairs(bagsE) do
		if v[1] then
			local _,_,rz = getElementRotation(v[1])
			local newrz = rz+1
			if newrz > 360 then newrz = 1 end
			setElementRotation(v[1],0,0,newrz)
		end
	end
end)

function hitMarker(p,dim)
	if dim then
		if not isPedInVehicle(p) then
			local gr = getElementData(localPlayer,"Group")
			local i = getElementData(source,"i")
			if (gr) and bags[i][1] == gr then
				local x,y,z = getElementPosition(source)
				triggerServerEvent("tsBagPick",localPlayer,i,getZoneName(x,y,z))
				triggerEvent("tsKillBag",localPlayer,i)
			else
				triggerEvent("tsKillBag",localPlayer,i)
			end
		end
	end
end

currGroup = ""
setTimer(function()
	local gr = getElementData(localPlayer,"Group")
	if gr ~= currGroup then
		currGroup = gr
		for i,v in pairs(bagsE) do
			if bagsE[i] then destroyElement(bagsE[i][1])  destroyElement(bagsE[i][2])  end
			bagsE[i] = nil
		end
		for i,v in pairs(bags) do
			if v[1] == gr then
				local x,y,z = turfSpawnTable[i][1],turfSpawnTable[i][2],turfSpawnTable[i][3]
				bagsE[i] = {}
				bagsE[i][1] = createObject(1550,x,y,z)
				bagsE[i][2] = createMarker(x,y,z,"cylinder",2,255,0,0,0)
				setElementData(bagsE[i][2],"i",i)
				exports.DENdxmsg:createNewDxMessage("A turf money bag is available for pickup in "..getZoneName(x,y,z).."",0,255,0)
				addEventHandler("onClientMarkerHit",bagsE[i][2],hitMarker)
			end
		end
	end
end,5000,0)
