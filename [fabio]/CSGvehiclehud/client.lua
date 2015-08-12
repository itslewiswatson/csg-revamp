local sx,sy = guiGetScreenSize()

if exports.densettings:addPlayerSetting('damagemeter') == false then
	exports.densettings:setPlayerSetting('damagemeter',true)
	exports.densettings:setPlayerSetting('fuelmeter',true)
	exports.densettings:setPlayerSetting('speedmeter',true)
	exports.densettings:setPlayerSetting('gpsonhud',true)
  enableVehicleHealth = exports.densettings:getPlayerSetting('damagemeter')
  enableFuel = exports.densettings:getPlayerSetting('fuelmeter')
  enableSpeedMeter = exports.densettings:getPlayerSetting('speedmeter')
  enableGPS = exports.densettings:getPlayerSetting('gpsonhud')
else
	exports.densettings:addPlayerSetting('damagemeter',true)
	exports.densettings:addPlayerSetting('fuelmeter',true)
	exports.densettings:addPlayerSetting('speedmeter',true)
	exports.densettings:addPlayerSetting('gpsonhud',true)
	exports.densettings:setPlayerSetting('damagemeter',true)
	exports.densettings:setPlayerSetting('fuelmeter',true)
	exports.densettings:setPlayerSetting('speedmeter',true)
	exports.densettings:setPlayerSetting('gpsonhud',true)
end

addEvent( "onPlayerSettingChange" )
addEventHandler( "onPlayerSettingChange", localPlayer,
	function ( setting, state )
		if setting == 'speedmeter' then
			enableSpeedMeter = state
		elseif setting == 'damagemeter' then
			enableVehicleHealth = state
		elseif setting == "fuelmeter" then
			enableFuel = state
		elseif setting == 'gpsonhud' then
			enableGPS = state
		end
	end, false
)

addEventHandler( "onClientRender", root,
    function()
		local theVehicle = getPedOccupiedVehicle ( localPlayer )
		local playerHealth = getElementHealth(localPlayer)
		if theVehicle and playerHealth >= 1 then
			local spx, spy, spz = getElementVelocity( theVehicle )
			local px,py,pz = getElementPosition(theVehicle)
			local mphSpeed = ( spx^2 + spy^2 + spz^2 ) ^ 0.5 * 100
			local kphSpeed = ( spx^2 + spy^2 + spz^2 ) ^ 0.5 * 1.61 * 100

			local vehicleHealth = ( getElementHealth( theVehicle ) )
			local vehicleFuel = getElementData( theVehicle, "vehicleFuel" )
			local location = getZoneName( px,py,pz )
			if location == 'Unknown' then location = getZoneName( px,py,pz, true ) end

			local vehHealthColor = math.max(vehicleHealth - 250, 0)/750
			local vehHealthColorMath = -510*(vehHealthColor^2)
			local rh, gh = math.max(math.min(vehHealthColorMath + 255*vehHealthColor + 255, 255), 0), math.max(math.min(vehHealthColorMath + 765*vehHealthColor, 180), 0)
			local vehFuelColor = math.max((vehicleFuel * 10) - 250, 0)/750
			local vehFuelthColorMath = -510*(vehFuelColor^2)
			local rf, gf = math.max(math.min(vehFuelthColorMath + 255*vehFuelColor + 255, 255), 0), math.max(math.min(vehFuelthColorMath + 765*vehFuelColor, 180), 0)
			local lockToDraw = 'lock'
			if isVehicleLocked(theVehicle) then lockToDraw = 'lock2' end
			if enableFuel then
				dxDrawRectangle((1019/1268)*sx,(673/768)*sy, (104/1268)*sx, (23/768)*sy, tocolor(0, 0, 0, 196), false)
				dxDrawRectangle((1022/1268)*sx, (676/768)*sy, (vehicleFuel*(98/1268)*sx)/100, (17/768)*sy, tocolor(rf, gf, 0, 196), false)
				dxDrawText("Fuel", (1021/1268)*sx, (677/768)*sy, (1118/1268)*sx, (690/768)*sy, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, false, false, false)
				dxDrawImage((1025/1268)*sx, (679/768)*sy, (17/1920)*sx, (17/1080)*sy, "images/fuel.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			end
			if enableVehicleHealth then
				dxDrawRectangle((1136/1268)*sx, (673/768)*sy, (104/1268)*sx, (23/768)*sy, tocolor(0, 0, 0, 196), false)
				dxDrawRectangle((1139/1268)*sx, (676/768)*sy, (vehicleHealth/10*(98/1268)*sx)/100, (17/768)*sy, tocolor(rh, gh, 0, 196), false)
				dxDrawText("Health", (1139/1268)*sx, (676/768)*sy, (1237/1268)*sx, (693/768)*sy, tocolor(255,255,255, 255), 1, "default", "center", "center", false, false, false, false, false)
				dxDrawImage((1140/1268)*sx, (679/768)*sy, (17/1920)*sx, (17/1080)*sy, "images/health.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			end
			-- speed & lock
			if enableSpeedMeter then
				dxDrawRectangle((1057/1268)*sx, (646/768)*sy, (183/1268)*sx, (23/768)*sy, tocolor(0, 0, 0, 196), false)
				dxDrawText(tostring(math.floor(kphSpeed)).." kph / "..tostring(math.floor(mphSpeed)).." mph", (1057/1268)*sx, (646/768)*sy, (1240/1268)*sx, (669/768)*sy, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, false, false, false)
			end
				dxDrawImage((1022/1268)*sx, (646/768)*sy, (22/1920)*sx, (23/1080)*sy, 'images\\'..lockToDraw..'.png', 0, 0, 0, tocolor(255, 255, 255, 255), false)

			-- gps
			if enableGPS then
				dxDrawRectangle((1019/1268)*sx, (701/768)*sy, (221/1268)*sx, (23/768)*sy, tocolor(0, 0, 0, 196), false)
				dxDrawText("GPS: "..tostring(location), (1019/1268)*sx, (701/768)*sy, (1240/1268)*sx, (724/768)*sy, tocolor(255, 255, 255, 255), 1, "default", "center", "center", false, false, false, false, false)
			end
		end
   end
)
