toSayVoice = true
toDrawVehArrow = true
targetPlayer = ""
function getPointFromDistanceRotation(x, y, dist, angle)

    local a = math.rad(90 - angle);

    local dx = math.cos(a) * dist;
    local dy = math.sin(a) * dist;

    return x+dx, y+dy;

end

hasDestination = false
addEvent ( "gps_setDestination", true )

function setDestinationToPlayer(pl,desc,blip,specificSettings)
	if not(pl) then  exports.DENdxmsg:createNewDxMessage("GPS: No Player Specified!", 255,0, 0) return end
	if isElement(pl) then
		local name = getPlayerName(pl)
		if getElementData(pl,"isPlayerJailed") == true then
		 exports.DENdxmsg:createNewDxMessage("GPS: "..name.." is jailed!", 255,0, 0)
		return
		end
		targetPlayer = pl
		local x,y,z = getElementPosition(pl)

		setDestination(x,y,z,name,"",specificSettings, targetPlayer)
		 exports.DENdxmsg:createNewDxMessage("GPS: Target "..name.." in "..getZoneName(x,y,z).."", 0, 255, 0)
		--destinationBlip = createBlipAttachedTo(player,58)
	end
end
addEvent("GPSrecDestToPlayer",true)
addEventHandler("GPSrecDestToPlayer",localPlayer,setDestinationToPlayer)

function updateGPSPlayerDest()
	local x,y,z = getElementPosition(destinationMarker)
	dx,dy,dz = x,y,z
	endGps()
	sendGpsReq("",dx,dy,dz)
end

function setDestination ( ox, oy, oz, desc, blip, specificSettings,ptt,eventName)
		locationDesc = desc

		local makeEventHitDes = true
		if not locationDesc then
			locationDesc = "Unspecified!!"
		end
		globalDest = locationDesc
		local x,y,z = tonumber(ox),tonumber(oy),tonumber(oz)
		endGps()
		resetDestination()
		if (ptt) then
			if isElement(ptt) then
				targetPlayer=ptt
			end
		end

		hasDestination = true

		if z < 10 then z = z - 1 end

		dx,dy,dz = ox,oy,z

		if (specificSettings) then
			if i == 2 then if specificSettings[2] == nil then specificSettings[2] = true end end
			for i=1,3 do
				if specificSettings[i] == nil then specificSettings[i] = false end

			end

			if specificSettings[1] == true then	--veh arrow
				--guiCheckBoxSetSelected(cbVehArrow,true)
				toDrawVehArrow = true
			else
				--guiCheckBoxSetSelected(cbVehArrow,false)
				toDrawVehArrow = false
			end
			if specificSettings[2] == true then	--road arrow
				toShowRoadArrows = true
				sendGpsReq("",ox,oy,oz)
			else
				toShowRoadArrows = false
			end
			if specificSettings[3] == true then	--turn by turn and voice guidance
				toSayVoice = true
			else
				toSayVoice = false
			end
			if specificSettings[4] == true then --sender of GPS request will manual reset, make marker invisible and small
				makeEventHitDes = false
				destinationMarker = createMarker ( x, y, z, "cylinder", 5, 1,1,1,0 )
			else
				destinationMarker = createMarker ( x, y, z, "cylinder", 10, 215, 0, 0, 100 )
			end
		else
			destinationMarker = createMarker ( x, y, z, "cylinder", 10, 215, 0, 0, 100 )
		end

		if makeEventHitDes == true then
			addEventHandler ( "onClientMarkerHit", destinationMarker, destinationMarkerReached, false )
			if (eventName) then
				eventToTrigger=eventName
			end
		end
		createDisplayHelpers(blip)

		addEventHandler ( "onPlayerWasted", localPlayer, resetDestination, false )

		if isElementWithinMarker ( localPlayer, destinationMarker ) then

			destinationReached ()

		end
		if isElement(targetPlayer) then
			updatePlayerPos = setTimer(updateGPSPlayerDest,3000,0)
		end

end

function setDestinationcmd ( cmd, x, y, z, locationDesc, blip )

setDestination ( x, y, z, locationDesc, blip )

end

addEventHandler ( "gps_setDestination", localPlayer, setDestination )

function resetDestination ()

	if hasDestination == true then
		if madeBlip == true then
			exports.customblips:destroyCustomBlip ( targetBlip )
			madeBlip = false
		end
		eventToTrigger = ""
		targetPlayer = ""
		--if isElement(destinationBlip) then destroyElement(destinationBlip) end
		if isTimer(updatePlayerPos) then killTimer(updatePlayerPos) end
		endGps()
		hasDestination = false

		removeEventHandler ( "onClientMarkerHit", destinationMarker, destinationMarkerReached, false )
		removeEventHandler ( "onPlayerWasted", localPlayer, resetDestination, false )

		if isElement ( destinationMarker ) then destroyElement ( destinationMarker ) end

		if lineHandler then removeEventHandler ( "onClientRender", root, drawGPSLine ) lineHandler = false end


		if isElement(arrowObject) then destroyElement(arrowObject) end
		endGps()
		vehicleDrawing = false
		if onMarkerHitCheckZ == true then
			removeEventHandler( "onClientColShapeHit", checkForZCuboid, targetStreamedIn, false )
			onMarkerHitCheckZ = false
		end
		if isElement(checkForZMarker) then destroyElement(checkForZMarker) end
		if isElement(checkForZCuboid) then destroyElement(checkForZCuboid) end

	end

end
addEventHandler ( "gps_resetDestination", localPlayer, resetDestination )
addEventHandler("onClientPlayerWasted",localPlayer,resetDestination)
addEvent ( "gps_getDestination", true )

function getDestination ( )

	if hasDestination == true then

		local desc = getElementData(localPlayer, "GPS_description" )

		return dx, dy, dz, desc

	end

end
addEventHandler ( "gps_getDestination", localPlayer, getDestination )


function destinationMarkerReached ( hitElement )
local px, py, pz = getElementPosition ( localPlayer )
local mx, my, mz = getElementPosition ( source )
	if eventToTrigger ~= "" then
		triggerEvent(eventToTrigger,localPlayer)
	end
	if hitElement == localPlayer then

		if ( ( mz + 5 ) > pz and ( mz - 5 ) < pz ) or ( isElementOnScreen ( source ) ) then

			destinationReached ()

		end

	end


end


function destinationReached ()

	if hasDestination == true then

		local message = "You have reached "..locationDesc..""

		 exports.DENdxmsg:createNewDxMessage(message, 0, 255, 0)

		resetDestination()

	end

end




customGPSBlips =
{
[1]="blips/customblip_orange.png",
[2]="blips/customblip_green.png",
[3]="blips/customblip_green_light.png",
[4]="blips/customblip_blue.png",
[5]="blips/customblip_pink.png",
[6]="blips/customblip_purple.png"
}

function isBlipPathSpecifiedValid( filePath )

	for i, fPath in ipairs(customGPSBlips) do

		if fPath == filePath then

			return true

		end

	end

	return false

end

function createDisplayHelpers (blip)
--:CSGgps/
	if lineHandler then removeEventHandler ( "onClientRender", root, drawGPSLine ) lineHandler = false end

	lineHandler = true

	local x,y,z = getElementPosition ( destinationMarker )
	local randomBlip = nil
		if blip and blip ~= "" then
			--if blip ~= "None" then
				randomBlip = "blips/customblip_" .. tostring(blip) .. ".png"
				if not isBlipPathSpecifiedValid( randomBlip ) then
					local randomNumber = math.random(1,6)
					randomBlip = customGPSBlips[randomNumber]
				end
			--end
		else
			local randomNumber = math.random(1,6)
			randomBlip = customGPSBlips[randomNumber]
		end
	-- formatting to oldBlip
	local oldBlip1 = string.gsub ( randomBlip, "blips/customblip_", "" )
	local oldBlip2 = string.gsub ( oldBlip1, ".png", "" )
	oldBlip = oldBlip2
	madeBlip = false
	if blip ~= "None" then
		madeBlip = true
		targetBlip = exports.customblips:createCustomBlip ( x, y, 14, 14, tostring(randomBlip), 10000 )
	end
	addEventHandler ( "onClientRender", root, drawGPSLine )

end

vehicleDrawing = false


function isVehicleValid(vehicle)

local vehType = getVehicleType( vehicle )

	if vehType == "Plane" or vehType == "Helicopter" or vehType == "Boat" or vehType == "Train" then

		return false

	else

		return true

	end

end


function drawGPSLine ()

local px, py, pz = getElementPosition ( localPlayer )
local pz = pz +1

				if isElement(targetPlayer) and getElementType(targetPlayer) == "player" then
					targetName = getPlayerName(targetPlayer)
					tx, ty, tz = getElementPosition (targetPlayer)

					if getElementInterior(targetPlayer) ~= 0 then

						resetDestination()

						 exports.DENdxmsg:createNewDxMessage("GPS: Reset, "..targetName.." is in interior.", 255, 100, 0)

						return

					end

					if isPlayerDead ( targetPlayer ) then

						resetDestination()

						 exports.DENdxmsg:createNewDxMessage("GPS: Reset, "..targetName.." is dead.", 255, 100, 0)

						return

					end

						if isElement( destinationMarker ) then

							setElementPosition ( destinationMarker, tx, ty, tz-1 )
							if madeBlip == true then
								exports.customblips:setCustomBlipPosition ( targetBlip, tx, ty )
							end

						end
				else
					if targetPlayer ~= "" then
						 exports.DENdxmsg:createNewDxMessage("GPS: Reset - Target disconnected or is missing!", 255, 0, 0)
						resetDestination()
					end
				end
			if toDrawVehArrow == false then if isElement(arrowObject) then destroyElement(arrowObject) end vehicleDrawing = false end

			if getPedOccupiedVehicle(localPlayer) then

				if vehicleDrawing == true then

					local angle = ( 360 - math.deg ( math.atan2 ( ( tx - px ), ( ty - py ) ) ) ) % 360
						if angle - 90 < 0 then
							angle = 360 + (angle - 90 )
						else
							angle = angle - 90
						end

					local prx,pry,prz = getElementRotation ( getPedOccupiedVehicle(localPlayer) )

					local aX, aY = getPointFromDistanceRotation	( px, py, 1.3, prz )

					detachElements ( arrowObject )
					local newAngle = angle - prz
					local zOffset = 0.5 --getArrowOffset(px, py, pz)
					attachElements ( arrowObject, getPedOccupiedVehicle ( localPlayer ), 0, 1.2, zOffset, 0, 90, newAngle )

				else
					if toDrawVehArrow == true then
					arrowObject = createObject ( 1318, px, py, pz+0.7, 0, 90, 0, true )
					if isVehicleValid(getPedOccupiedVehicle(localPlayer)) then
						local ox, oy, oz = getElementPosition ( destinationMarker )
						--executeCommandHandler ( "gpsSystemStart", tostring(ox) .. " " .. tostring(oy) .. " " .. tostring(oz) )
					end
					vehicleDrawing = true
					end

				end

			else

				if vehicleDrawing == true then

					if isElement(arrowObject) then destroyElement(arrowObject) end

					--removeLinePoints ( )
					--cleanUpMarkers()
					vehicleDrawing = false

				end

			end

			--dxDrawLine3D ( px, py, pz, tx, ty, tz, tocolor(255, 50, 50 ), 3, false )
			--drawGPSArrow()



			--if lineHandler then removeEventHandler ( "onClientRender", root, drawGPSLine ) lineHandler = false end

end

function findRotation(x1,y1,x2,y2)

  local t = -math.deg(math.atan2(x2-x1,y2-y1))
  if t < 0 then t = t + 360 end;
  return t;

end

if fileExists("client.lua") == true then
	fileDelete("client.lua")
end
