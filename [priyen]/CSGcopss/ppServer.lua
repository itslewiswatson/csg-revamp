addEvent("CSGcops.play",true)
addEventHandler("CSGcops.play",root,function(t,nam)
	for k,v in pairs(t) do
		triggerClientEvent(v,"CSGcops.recSound",v,nam)
	end
end)
addEvent("CSGcops.play2",true)
addEventHandler("CSGcops.play2",root,function(t,nam)
	for k,v in pairs(t) do
		triggerClientEvent(v,"CSGcops.recSoundCus",v,nam)
	end
end)
