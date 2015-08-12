-- Premium car
local premiumVehicleLoaded = false
local ferrariVehicleLoaded = true
local lamboVehicleLoaded = true

function loadModifiedVehicles()
	if (premiumVehicleLoaded == false) then
		if (fileExists("premiumSkins/supergt.txd")) and (fileExists("premiumSkins/supergt.dff")) then
			elgtx = engineLoadTXD ( "premiumSkins/supergt.txd" )
			engineImportTXD ( elgtx, 526 )
			elgdf = engineLoadDFF ( "premiumSkins/supergt.dff", 526 )
			engineReplaceModel ( elgdf, 526 )
			premiumVehicleLoaded = true --define this, so its not reloaded.
		else
			exports.CSGsecrettrans:downloadFile(":DENpremium/premiumSkins/supergt.txd", "supergt.txd", 150)
			exports.CSGsecrettrans:downloadFile(":DENpremium/premiumSkins/supergt.dff", "supergt.dff", 150)
			premiumVehicleLoaded = false --define this, so we can then reload it.
		end
	end --nothing else to do.
	--[[
	if (ferrariVehicleLoaded == false) then
		if (fileExists("turismo.txd")) and (fileExists("turismo.dff")) then
			elgtx = engineLoadTXD ( "turismo.txd" )
			engineImportTXD ( elgtx, 401 )
			elgdf = engineLoadDFF ( "turismo.dff", 401 )
			engineReplaceModel ( elgdf, 401 )
			ferrariVehicleLoaded = true
		else
			exports.CSGsecrettrans:downloadFile(":DENpremium/turismo.txd", "turismo.txd", 150)
			exports.CSGsecrettrans:downloadFile(":DENpremium/turismo.dff", "turismo.dff", 150)
			ferrariVehicleLoaded = false --define this, so we can then reload it.
		end
	end --nothing else to do.
	
	if (lamboVehicleLoaded == false) then
		if (fileExists("lamb.txd")) and (fileExists("lamb.dff")) then
			lambTXD = engineLoadTXD("lamb.txd",503)
			lambDFF = engineLoadDFF("lamb.dff",503)
			engineImportTXD(lambTXD,503)
			engineReplaceModel(lambDFF,503)
		else
			exports.CSGsecrettrans:downloadFile(":DENpremium/lamb.txd", "lamb.txd", 150)
			exports.CSGsecrettrans:downloadFile(":DENpremium/lamb.dff", "lamb.dff", 150)
		end
	end
	--]]
	if (premiumVehicleLoaded == false) then -- or (ferrariVehicleLoaded == false) or (lamboVehicleLoaded == false) then
		--The vehicles wasn't loaded properly, so we give it 30 seconds to download.
		setTimer(loadModifiedVehicles,30000,1)
	end
end
addEventHandler("onClientResourceStart",resourceRoot,loadModifiedVehicles)

local skin1 = false
local skin2 = false
local skin3 = false
local skin4 = false
local skin5 = false

function loadSkinMods()
	if (skin1 == false) then
		if (fileExists("premiumSkins/premiumSkin1.txd")) and (fileExists("premiumSkins/premiumSkin1.dff")) then
			txd = engineLoadTXD ( "premiumSkins/premiumSkin1.txd" )
			engineImportTXD ( txd,41)
			dff = engineLoadDFF ( "premiumSkins/premiumSkin1.dff",41)
			engineReplaceModel ( dff,41)
			skin1 = true
		else
			skin1 = false --reload
		end
	end
	
	if (skin2 == false) then
		if (fileExists("premiumSkins/premiumSkin2.txd")) and (fileExists("premiumSkins/premiumSkin2.dff")) then
			txd = engineLoadTXD ( "premiumSkins/premiumSkin2.txd" )
			engineImportTXD ( txd,52)
			dff = engineLoadDFF ( "premiumSkins/premiumSkin2.dff",52)
			engineReplaceModel ( dff,52)
			skin2 = true
		else
			skin2 = false --reload
		end
	end
	
	if (skin3 == false) then	
		if (fileExists("premiumSkins/premiumSkin3.txd")) and (fileExists("premiumSkins/premiumSkin3.dff")) then
			txd = engineLoadTXD ( "premiumSkins/premiumSkin3.txd" )
			engineImportTXD ( txd,94)
			dff = engineLoadDFF ( "premiumSkins/premiumSkin3.dff",94)
			engineReplaceModel ( dff,94)
			skin3 = true
		else
			skin3 = false --reload
		end
	end
	if (skin4 == false) then	
		if (fileExists("premiumSkins/lapd1.txd")) and (fileExists("premiumSkins/lapd1.dff")) then
			txd = engineLoadTXD ( "premiumSkins/lapd1.txd" )
			engineImportTXD ( txd,183)
			dff = engineLoadDFF ( "premiumSkins/lapd1.dff",183)
			engineReplaceModel ( dff,183)
			skin4 = true
		else
			skin4 = false --reload
		end
	end
	
	if (skin5 == false) then	
		if (fileExists("premiumSkins/rabbit.txd")) and (fileExists("premiumSkins/rabbit.dff")) then
			txd = engineLoadTXD ( "premiumSkins/rabbit.txd" )
			engineImportTXD ( txd,229)
			dff = engineLoadDFF ( "premiumSkins/rabbit.dff",229)
			engineReplaceModel ( dff,229)
			skin5 = true
		else
			skin5 = false
		end
	end
	
	if (skin1 == false) or (skin2 == false) or (skin3 == false) or (skin4 == false) or (skin5 == false) then
		--reload the function in 30 seconds to give chance for CSGsecrettrans--
		setTimer(loadSkinMods,30000,1)
	end
end
addEventHandler("onClientResourceStart",resourceRoot,loadSkinMods)

-- OnPlayerZoneChange
local x1, y1, z1 = getElementPosition( localPlayer )
local oldZone = getZoneName ( x1, y1, z1, true )

addEventHandler( "onClientRender", root,
	function ()
		local x2, y2, z2 = getElementPosition( localPlayer )
		local newZone = getZoneName ( x2, y2, z2, true )
		if ( oldZone ~= newZone ) and ( getPlayerTeam( localPlayer ) ) then
			triggerServerEvent( "playerZoneChange", localPlayer, oldZone, newZone )
			triggerEvent( "onClientPlayerZoneChange", localPlayer, oldZone, newZone )
			x1, y1, z1 = getElementPosition( localPlayer )
			oldZone = getZoneName ( x1, y1, z1, true )
		end
	end
)