
local sWidth,sHeight = guiGetScreenSize() -- The variables

-- add blips and convert to dxDrawImage


function showMap()

	if map_window and guiGetVisible ( map_window ) == false then
	
		guiSetVisible( map_window, true)
		centerWindow(map_window)
		addEventHandler ( "onClientGUIClick", root, onMapClick )
		addEventHandler ( "onClientRender", root, drawAllBlips )	
		showCursor(true)

	elseif not map_window then

		map_window = guiCreateWindow(365,71,705,735,"GPS: Pick a location on the map.",false)
		centerWindow(map_window)
		local windowX, windowY = guiGetPosition(map_window,false)
		local windowWidth, windowHeight = guiGetSize ( map_window, false )
		map_image = guiCreateStaticImage(5, 20,windowWidth-5, windowHeight-60,"map.png",false,map_window)
		map_button_close = guiCreateButton(301,695,112,36,"Close",false,map_window)
		showCursor(true)
		addEventHandler ( "onClientGUIClick", root, onMapClick )
		--addPlayerBlip()
		--drawAllBlips()
		addEventHandler ( "onClientRender", root, drawAllBlips )
		
	elseif map_window and guiGetVisible ( map_window ) then

		centerWindow(map_window)
	
	end

end

function drawPlayerBlip ()

	local px, py, pz = getElementPosition ( localPlayer )
	local prz = getPedRotation ( localPlayer )
	
	local imagePosX, imagePosY = guiGetPosition(map_image,false)
	local windowX, windowY = guiGetPosition(map_window,false)
	local windowWidth, windowHeight = guiGetSize ( map_window, false )
	local iWidth, iHeight = guiGetSize ( map_image, false )
	
	local worldPercX = ((px+3000) / 6000)-0.03
	local worldPercY = ((3000+py) / 6000)+0.03
	local imageX = worldPercX * iWidth
	local imageY = ( 1 -  worldPercY ) * iHeight
	local screenX = imageX+windowX+5
	local screenY = imageY+windowY+20
	
	if screenX and screenY then

		--map_playerBlip = guiCreateStaticImage(screenX, screenY,32, 32,"blips/player.png",false,map_image)
		--guiBringToFront(map_playerBlip)
		dxDrawImage ( screenX, screenY, 32, 32, "blips/player.png", prz-30, 0, 0, tocolor(255,255,255), true )
		
	end	


end

function drawAllBlips()

-- draw player blip

drawPlayerBlip ()

-- draw other blips

local players = getElementsByType ( "player" ) 
 
	for i, player in ipairs(players) do
	
		if player ~= localPlayer then
	
			local px, py, pz = getElementPosition ( player )
	
			local imagePosX, imagePosY = guiGetPosition(map_image,false)
			local windowX, windowY = guiGetPosition(map_window,false)
			local windowWidth, windowHeight = guiGetSize ( map_window, false )
			local iWidth, iHeight = guiGetSize ( map_image, false )
	
			local worldPercX = ((px+3000) / 6000)-0.03
			local worldPercY = ((3000+py) / 6000)+0.03
			local imageX = worldPercX * iWidth
			local imageY = ( 1 -  worldPercY ) * iHeight
			local screenX = imageX+windowX+5
			local screenY = imageY+windowY+20
	
				if screenX and screenY then
				
					local color = tocolor(getPlayerBlipColor(player))
				
					dxDrawImage ( screenX, screenY, 8, 8, "blips/playerBlip.png", 0, 0, 0, color, true )
		
				end	
			
		end	
			
	end		

end

local blipsForPlayers= {}
function getPlayerBlipColor(player)

	if not blipsForPlayers[player] then

		local r = math.random(100,255)
		local g = math.random(100,255)
		local b = math.random(100,255)
	
		blipsForPlayers[player] = { r, g, b }
		
	end	
	local playerTable = blipsForPlayers[player]
	local r, g, b = playerTable[1], playerTable[2], playerTable[3]
	return r, g, b

end

function closeMap()

	if isElement( map_window ) then 
		guiSetVisible( map_window, false )
		--destroyElement( map_playerBlip )
		removeEventHandler ( "onClientGUIClick", root, onMapClick )
		removeEventHandler ( "onClientRender", root, drawAllBlips )
	end
	showCursor(false)

end



addCommandHandler ( 'gpsmap', showMap )

onMarkerHitCheckZ = false

function onMapClick(btn, state, screenX, screenY)

	if source == map_image or source == map_playerBlip then

		local imagePosX, imagePosY = guiGetPosition(map_image,false)
		local windowX, windowY = guiGetPosition(map_window,false)
		local windowWidth, windowHeight = guiGetSize ( map_window, false )
		local iWidth, iHeight = guiGetSize ( map_image, false )
		
		local posX, posY = windowX+imagePosX, windowY+imagePosY	
		local worldX = ((((screenX-posX)/(iWidth)))*6000)-3000
		local worldY = (3000-(((screenY-posY)/(iHeight)))*6000)
		if worldX and worldY then
		
			local worldZ = getGroundPosition( worldX, worldY, 500 )
			
			if onMarkerHitCheckZ == true then 
			
				removeEventHandler( "onClientColShapeHit", checkForZCuboid, targetStreamedIn, false )

				if isElement(checkForZMarker) then destroyElement(checkForZMarker) end
				if isElement(checkForZCuboid) then destroyElement(checkForZCuboid) end					
				onMarkerHitCheckZ = false
				
			end
			
			checkForZMarker = createMarker ( worldX, worldY, worldZ, "cylinder", 100, 0, 0, 0, 0 )
			checkForZCuboid = createColCuboid ( worldX - 60, worldY - 60, worldZ, 120, 120, 80 )
			
				if worldZ == 0 and not isMarkerInWater(checkForZMarker) then
												
					addEventHandler( "onClientColShapeHit", checkForZCuboid, targetStreamedIn, false )
					onMarkerHitCheckZ = true
					
				elseif isMarkerInWater(checkForZMarker) then
								
					local waterLevel = getWaterLevel ( worldX, worldY, 5 )
					if waterLevel then
					worldZ = waterLevel
					end
				
				end
				
			if onMarkerHitCheckZ == false then

				if isElement(checkForZMarker) then destroyElement(checkForZMarker) end
				if isElement(checkForZCuboid) then destroyElement(checkForZCuboid) end			

			end			
				
			setDestination ( worldX, worldY, worldZ, "Map Destination" )
	
			closeMap()
			return
			
		else

			exports.DENhelp:createNewHelpMessage("Could not find location!", 255, 0, 0)
			
		end	
		
	elseif source == map_button_close then
	
		closeMap()
		
	end
	
end

function isMarkerInWater(marker)

	if isElement(marker) then
		local x,y,z = getElementPosition(marker)
		local waterHeight = getWaterLevel(x,y,5)
			if waterHeight and z < waterHeight then
	
				return true
		
			end
		
	end	
	
		return false
		
end

function targetStreamedIn (hitElement)

if hitElement == localPlayer then

local x,y,z,desc = getDestination ()

	local px, py, pz = getElementPosition ( localPlayer )
	local z = getGroundPosition( x, y, pz )
		if z and ( z ~= 0 or isMarkerInWater(destinationMarker) ) then
		
			if isMarkerInWater(destinationMarker) then
			
					local waterLevel = getWaterLevel ( x, y, 5 )
					if waterLevel then
					z = waterLevel
					end
			
			end
	
			removeEventHandler( "onClientColShapeHit", checkForZCuboid, targetStreamedIn, false )

			destroyElement(checkForZMarker)
			destroyElement(source)			
			onMarkerHitCheckZ = false
					
			setDestination ( x, y, z, "Map Destination", oldBlip )
						
		elseif z == 0 then
			
			local testZ = pz
			
				while z == 0 and testZ < 500 do
				
					z = getGroundPosition( x, y, testZ+20 )
					
				end

					if z ~= 0 or isMarkerInWater(destinationMarker) then
					
						if isMarkerInWater(destinationMarker) then
					
							local waterLevel = getWaterLevel ( x, y, 5 )
							if waterLevel then
							z = waterLevel
							end
						
						end
					
						removeEventHandler( "onClientColShapeHit", checkForZCuboid, targetStreamedIn, false )
						destroyElement(checkForZMarker)
						destroyElement(source)						
						onMarkerHitCheckZ = false
						
						setDestination ( x, y, z, "Map Destination", oldBlip )
						
					end	
					
					
	
		end
		
end		

end