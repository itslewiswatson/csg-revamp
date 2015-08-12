function cancelDeath(killer)
	cancelEvent()
	local h = getElementHealth(localPlayer)
	if h-5 > 0 then
		setElementHealth(localPlayer,h-5)
	else
		triggerServerEvent("killHeliBlade",localPlayer,getVehicleController(killer))
	end
end
addEventHandler("onClientPlayerHeliKilled", localPlayer, cancelDeath)
