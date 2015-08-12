function onDamage(attacker, wep, part, loss)
	if (isElement(source)) then
		if (getElementInterior(source) == 2 and getElementDimension(source) == 10) then
			cancelEvent(true, "No")
		end
	end
end
addEventHandler("onClientPlayerDamage", localPlayer, onDamage)