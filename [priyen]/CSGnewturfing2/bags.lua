local bags = {}
local bagsE = {}

addEvent("tsRecBagInfo",true)
addEventHandler("tsRecBagInfo",localPlayer,function(x,t,hideMsg)
	outputDebugString("this")
	bags[x] = t
	local gr = getElementData(localPlayer,"Group")

	if (gr) then
		for i,v in pairs(bags) do

			if not(bagsE[i]) then
				local x,y,z = turfSpawnTable[i][1],turfSpawnTable[i][2],turfSpawnTable[i][3]
				bagsE[i] = {}
				bagsE[i][1] = createObject(1550,x,y,z)
				bagsE[i][2] = createMarker(x,y,z,"cylinder",2,255,0,0,0)
				setElementData(bagsE[i][2],"i",i)
				if gr == v[2] and not(hideMsg) and getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
					exports.DENdxmsg:createNewDxMessage("A turf money bag is available for pickup in "..getZoneName(x,y,z).."",0,255,0)
				else

					--setElementAlpha(bagsE[i][1],50)
				end
				addEventHandler("onClientMarkerHit",bagsE[i][2],hitMarker)
				if getTeamName(getPlayerTeam(localPlayer)) ~= "Criminals" then
						setElementAlpha(bagsE[i][1],0)
					else
						setElementAlpha(bagsE[i][1],255)
					end
			end
		end
	end
end)

addEventHandler("onClientPlayerTeamChange",localPlayer,function(k)
	if k == "Occupation" then
		local crim = false
		if getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then crim = true end
		for k,v in pairs(bagsE) do
			if crim then
				setElementAlpha(v[1],255)
			else
				setElementAlpha(v[1],0)
			end
		end
	end
end)

addEvent("tsKillBag",true)
addEventHandler("tsKillBag",localPlayer,function(i)
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
	if dim and p == localPlayer then
		if not isPedInVehicle(p) then
			local gr = getElementData(localPlayer,"Group")
			local i = getElementData(source,"i")
			if getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
				if (gr) then
					local x,y,z = getElementPosition(source)
					triggerServerEvent("tsBagPick",localPlayer,i,getZoneName(x,y,z))
					triggerEvent("tsKillBag",localPlayer,i)
				else
					exports.DENdxmsg:createNewDxMessage("You must be in a group to steal this turf money bag",255,0,0)
				end
			else
				--triggerEvent("tsKillBag",localPlayer,i)
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
			--if v[2] == gr then
				local x,y,z = turfSpawnTable[i][1],turfSpawnTable[i][2],turfSpawnTable[i][3]
				bagsE[i] = {}
				bagsE[i][1] = createObject(1550,x,y,z)
				bagsE[i][2] = createMarker(x,y,z,"cylinder",2,255,0,0,0)
				setElementData(bagsE[i][2],"i",i)
				if gr == v[2] and getTeamName(getPlayerTeam(localPlayer)) == "Criminals" then
					exports.DENdxmsg:createNewDxMessage("A turf money bag is available for pickup in "..getZoneName(x,y,z).."",0,255,0)
				else
					--setElementAlpha(bagsE[i][1],50)
				end
 				addEventHandler("onClientMarkerHit",bagsE[i][2],hitMarker)
				if getTeamName(getPlayerTeam(localPlayer)) ~= "Criminals" then
						setElementAlpha(bagsE[i][1],0)
					else
						setElementAlpha(bagsE[i][1],255)
					end
			--end
		end
	end
end,5000,0)
