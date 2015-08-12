function PlayerWeaponFire(weapon, ammo, ammoInClip, hitX, hitY, hitZ, hitElement)
	local health = 0
	if (isElement(hitElement)) then
		if (getElementType(hitElement) == "vehicle") then
			if (getVehicleID(hitElement) == 432) then
				health = getElementHealth(hitElement)
				if (health - 3 > 0) then
					local a = health - 3
					triggerServerEvent("healthchange", hitElement, a)
				end
			end
		end
	end
end
addEventHandler("onClientPlayerWeaponFire", getLocalPlayer(), PlayerWeaponFire, false)