
tse=triggerServerEvent
aeh=addEventHandler
ae=addEvent

vehBlip,destBlip=false,false

ae("hijackBlip",true)
aeh("hijackBlip",localPlayer,function(veh,x,y,z)
	if isElement(vehBlip) == true then
		destroyElement(vehBlip)
	end
	if isElement(destBlip) == true then
		destroyElement(destBlip)
	end
	vehBlip=createBlipAttachedTo(veh,12,2,255,0,0,255,0,99999)
	destBlip=createBlip(x,y,z,53,2,255,0,0,255,0,99999)
end)

ae("hijackBlipd",true)
aeh("hijackBlipd",localPlayer,function()
	if isElement(vehBlip) == true then
		destroyElement(vehBlip)
	end
	if isElement(destBlip) == true then
		destroyElement(destBlip)
	end
end)
