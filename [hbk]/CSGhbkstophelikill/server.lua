addEvent("killHeliBlade",true)
addEventHandler("killHeliBlade",root,function(killer)
	killPed(source,killer)
end)
