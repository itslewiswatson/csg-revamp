
nearCol = createColCircle(1,1,150)
attachElements(nearCol,localPlayer)

setTimer(function()
local int = getElementInterior(localPlayer)
	local dim = getElementDimension(localPlayer)
	setElementInterior(nearCol,int)
	setElementDimension(nearCol,dim)
end,1000,0)

addCommandHandler("pcopsound",function(_,arg1)
	--triggerServerEvent("CSGcops.play",localPlayer,getElementsWithinColShape(nearCol,"player"),arg1)
	local t = {}
	local x,y,z = getElementPosition(localPlayer)
	for k,v in pairs(getElementsByType("player")) do
		local x2,y2,z2 = getElementPosition(v)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 60 then
			table.insert(t,v)
		end
	end
	triggerServerEvent("CSGcops.play",localPlayer,t,arg1)
end)

addCommandHandler("pcopsound2",function(_,arg1)
	--triggerServerEvent("CSGcops.play",localPlayer,getElementsWithinColShape(nearCol,"player"),arg1)
	local t = {}
	local x,y,z = getElementPosition(localPlayer)
	for k,v in pairs(getElementsByType("player")) do
		local x2,y2,z2 = getElementPosition(v)
		if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) <= 60 then
			table.insert(t,v)
		end
	end
	triggerServerEvent("CSGcops.play2",localPlayer,t,arg1)
end)

addEvent("CSGcops.recSound",true)
addEventHandler("CSGcops.recSound",localPlayer,function(nam)
	--local x,y,z = getElementPosition(localPlayer)
	local sound = playSound("http://s1works.com/priyen/priyencopsounds/"..nam..".mp3")
	local int = getElementInterior(localPlayer)
	local dim = getElementDimension(localPlayer)
	setElementInterior(sound,int)
	setElementDimension(sound,dim)
end)

addEvent("CSGcops.recSoundCus",true)
addEventHandler("CSGcops.recSoundCus",localPlayer,function(nam)
	--local x,y,z = getElementPosition(localPlayer)
	local sound = playSound(nam)
	local int = getElementInterior(localPlayer)
	local dim = getElementDimension(localPlayer)
	setElementInterior(sound,int)
	setElementDimension(sound,dim)
end)
