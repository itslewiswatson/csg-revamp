-- Get a JSON string of the player his weapons
canSaveWeps=false
weapons = {}
monTimer = setTimer(function()
	local hasWep=true
	for slot = 0, 12 do
		local weapon = getPedWeapon( localPlayer, slot )
		if ( weapon > 0 ) then
			local ammo = getPedTotalAmmo( localPlayer, slot )
			if ( ammo > 0 ) then
				weapons[weapon] = ammo
				hasWep=true
			end
		end
	end
	if hasWep == true then canSaveWeps=true killTimer(monTimer) end
end,1000,0)

oldstr=""

function getPlayerWeaponsJSON(allow)
	if canSaveWeps == false then return end
	--if getElementHealth(localPlayer) <= 0 and allow == nil then return end
	local weaponsT={}

	for slot = 0, 12 do
		local weapon = getPedWeapon( localPlayer, slot )
		if ( weapon > 0 ) then
			local ammo = getPedTotalAmmo( localPlayer, slot )
			if ( ammo > 0 ) then
				weaponsT[weapon] = ammo
			end
		end
	end
	str=toJSON(weaponsT)
	if str ~= oldstr then
		oldstr=str
		triggerServerEvent ( "syncPlayerWeaponString",localPlayer,str,allow)
	end
end

-- Sync the player weapons with the server because MTA fails with that
setTimer (
	function ()
		getPlayerWeaponsJSON()
	end, 5000, 0
)

addEventHandler("onClientPlayerWasted",root,function() if source==localPlayer then getPlayerWeaponsJSON(true) end end)

addEvent("startSaveWep",true)
addEventHandler("startSaveWep",localPlayer,function()
	setTimer(function() canSaveWeps=true end,10000,1)
end)

addEvent("forceWepSync",true)
addEventHandler("forceWepSync",localPlayer,function() getPlayerWeaponsJSON(true) end)
