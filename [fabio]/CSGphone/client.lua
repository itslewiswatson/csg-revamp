theFont = "Tahoma bold"
theFontSize = 1.2

exports.DENsettings:addPlayerSetting('phoneBackground', '1')
sW, sH = guiGetScreenSize()

relativeCaseWidth, relativeCaseHeight = 0.275, 0.6
if sW == 800 then
	sW,sH = 1024, 768 -- fix a too small phone for crappy resolutions
end
caseWidth, caseHeight = relativeCaseWidth*sW, relativeCaseWidth*sW*2
sW, sH = guiGetScreenSize()
caseX, caseY = math.floor(sW-caseWidth-10), math.floor(sH-caseHeight-10)

BGnumber = exports.DENsettings:getPlayerSetting('phoneBackground')
BGWidth, BGHeight = 0.666015625*caseWidth, 0.5732421875*caseHeight
BGX = (0.26953125*caseWidth)+caseX
BGY = (0.30859375*caseHeight)+caseY

homeX = caseX+(0.53125*caseWidth)
homeY =caseY+(0.900390625*caseHeight)
homeWidth = 0.150390625*caseWidth
homeHeight = 0.076171875*caseHeight

local appSize = 0.2*BGWidth
local appOffsetX, appOffsetY = 0.035*BGWidth, 0.05*BGWidth
apps = {
-- dock
{ nil, nil, (0.85*BGHeight)+BGY, nil,nil, "Phone Alt", false, false, false, false, "Phone" },
{ nil, nil, (0.85*BGHeight)+BGY, nil,nil, "Messages", false, false, false, false, "Messages" },
{ nil, nil, (0.85*BGHeight)+BGY, nil,nil, "iPod Alt", false, false, false, false, "Radio" },
{ nil, nil, (0.85*BGHeight)+BGY, nil,nil, "Settings", false, false, false, false, "Settings" },
-- First row
{ nil,nil,nil,nil,nil, "Contacts Alt", false, false, false, false, "Contacts" },
{ nil,nil,nil,nil,nil, "Clock", false, false, false, false, "Clock" },
{ nil,nil,nil,nil,nil, "Notes", false, false, false, false, "Notes" },
{ nil,nil,nil,nil,nil, "Weapons", false, false, false, false, "Weapons" },
-- Second row
{ nil,nil,nil,nil,nil, "PocketMoney", false, false, false, false, "Money" },
{ nil,nil,nil,nil,nil, "Maps", false, false, false, false, "Maps" },
{ nil,nil,nil,nil,nil, "Minesweep", false, false, false, false, "Minesweeper" },
{ nil,nil,nil,nil,nil, "Puzzle", false, false, false, false, "Slide Puzzle" },
-- Third Row
{ nil,nil,nil,nil,nil, "Houses", false, false, false, false, "Houses" },
{ nil,nil,nil,nil,nil, "Calculator", false, false, false, false, "Calculator" },
{ nil,nil,nil,nil,nil, "Music", false, false, false, false, "Music" },
{ nil,nil,nil,nil,nil, "backwep", false, false, false, false, "Back Weapon" },
-- Fourth row
{ nil,nil,nil,nil,nil, "alarm", false, false, false, false, "Alarm" }, -- < WIP


} -- row difference Y = 0.2, X values listed above

phoneImages = {}
appImages = {}
phoneVisible = false
fading = false
local phoneObject

function createApps()

	local row = 0
	local column = 1

	for i=1, #apps do

		local app = apps[i]
		local x,y = app[2], app[3]

		if not app[2] or not app[3] then

			x = BGX+(appOffsetX*column)+(appSize*(column-1))
			column = column + 1
			if x+appSize >= BGX+BGWidth then
				column = 2
				if not app[3] then
					row = row + 1
					x = BGX+appOffsetX
				end
			end
			y = BGY+(appOffsetY*row)+(appSize*(row-1))
			app[2] = app[2] or x
			app[3] = app[3] or y

		end
		if not app[4] or app[5] then
			app[4] = appSize
			app[5] = appSize
		end
		app[1] = guiCreateStaticImage(app[2], sH+(app[3]-caseY), appSize, appSize, "icons\\" .. app[6] .. ".png", false )
		table.insert ( phoneImages, app[1] )
		guiSetProperty ( app[1], "AlwaysOnTop", "True" )
		guiBringToFront(app[1])

	end

end

function createCase()

	local caseImage = guiCreateStaticImage(caseX, sH, caseWidth, caseHeight, "csgiphone.png", false )
	table.insert ( phoneImages, caseImage )
	local bgPNG = "background" .. BGnumber .. ".png"
	local BGImage = guiCreateStaticImage(BGX, sH+(BGY-caseY), BGWidth, BGHeight, "backgrounds\\" .. tostring(bgPNG), false )
	table.insert ( phoneImages, BGImage )

	local homeLabel = guiCreateLabel ( homeX, sH+(homeY-caseY), homeWidth, homeHeight, "", false )
	guiSetProperty ( homeLabel, "AlwaysOnTop", "True" )
	guiBringToFront(homeLabel)
	table.insert ( phoneImages, homeLabel )

end

function snapImages()

	guiSetPosition ( phoneImages[1], caseX, caseY, false )
	guiSetPosition ( phoneImages[2], BGX, BGY, false )
	guiSetPosition ( phoneImages[3], homeX, homeY, false )

	for i=1, #apps do

		local app = apps[i]

		if isElement(app[1])then

			guiSetPosition ( app[1], app[2], app[3], false )

		end

	end
	showCursor(true)
	setPedAnimation(localPlayer,false)
	setElementPosition(localPlayer,getElementPosition(localPlayer))
	setPedAnimation(localPlayer,"ped","phone_talk",nil,nil,false)
	addEventHandler("onClientRender",root,drawNotificationBar)
	guiSetInputMode("no_binds_when_editing")

end

function togglePhone()

	if ( not phoneVisible ) and exports.server:isPlayerLoggedIn( localPlayer ) and not fading then

		createCase()
		createApps()
		if not isElement(phoneObject) then
			phoneObject = createObject(330,0,0,0)
			setElementDimension(phoneObject,getElementDimension(localPlayer))
		end
		slide('up')
		triggerServerEvent("resetAnim",localPlayer)
		setPedAnimation(localPlayer,"ped","phone_in",nil,false,false)
		exports.bone_attach:attachElementToBone(phoneObject,localPlayer,12,0,0,0,0,-90)

	elseif isElement(phoneImages[1]) then

		if not fading then

			slide('down')
			showCursor(false)
			for i=1, #apps do

				local app = apps[i]

				if app[7] == true then

					app[9]()

				end

			end
			closeApps()
			setPedAnimation(localPlayer,"ped","phone_out", 500, false, nil, nil ,false)
			setTimer(function() triggerServerEvent("resetAnim",localPlayer) end,500,1)
			setTimer( function () if isElement(phoneObject) and not phoneVisible and not fading then destroyElement(phoneObject) end end, 800,1)
			removeEventHandler("onClientRender",root,drawNotificationBar)
			toggleControl("accelerate",true)
			toggleControl("forwards",true)

		end

	end

end

function disablePhoneOutAnim()

	setPedAnimation(localPlayer)
	removeEventHandler("onClientKey",root, disablePhoneOutAnim )

end

function hidePhone()

	for i=1, #phoneImages do
		destroyElement(phoneImages[i])
	end
	for i=1, #apps do

		local app = apps[i]

		if app[7] == true then

			app[9]()

		end

	end
	phoneImages = {}
	appImages = {}
	fading = false
	phoneVisible = false


end

bindKey ( "n", "down", togglePhone )
local slideEndTicks
local slideStartTicks
local slideTicks = 400

function increaseHeight ()

	if isElement(phoneImages[1]) then

		local ticks = getTickCount()

		local _,y = guiGetPosition(phoneImages[1],false)
		local rel = (slideEndTicks - ticks)/slideTicks
		if slideEndTicks > ticks then

			local posY = interpolateBetween( sH, 0, 0, caseY, 0, 0, 1-rel, 'Linear' )
			local change = y - posY

			for i=1, #phoneImages do

				local image = phoneImages[i]
				local x,y = guiGetPosition(image,false)
				guiSetPosition ( image, x, y-change, false )
			end

		else

			snapImages()
			removeEventHandler('onClientRender',root,increaseHeight)
			fading = false
			phoneVisible = true
			addEventHandler ( "onClientMouseEnter", root, onMouseEnter )
			addEventHandler ( "onClientMouseLeave", root, onMouseLeave )
			addEventHandler ( "onClientGUIClick", root, onMouseClick )

		end

	end

end

function decreaseHeight ()

	if isElement(phoneImages[1]) then

		local ticks = getTickCount()
		local _,y = guiGetPosition(phoneImages[1],false)
		local rel = (ticks-slideStartTicks)/slideTicks
		if ticks < slideEndTicks then

			local posY = interpolateBetween( caseY, 0, 0, sH, 0, 0, rel, 'Linear' )
			local change = posY - y

			for i=1, #phoneImages do

				local image = phoneImages[i]
				local x,y = guiGetPosition(image,false)
				guiSetPosition ( image, x, y+change, false )
			end

		else

			removeEventHandler('onClientRender',root,decreaseHeight)
			hidePhone()

		end
	end

end


function slide(direction)
	fading = true

	local currentTicks = getTickCount()
	slideStartTicks = currentTicks
	slideEndTicks = currentTicks + slideTicks

	if direction == 'up' then

		addEventHandler('onClientRender',root,increaseHeight)

	else

		for i=1, #apps do

			local v = apps[i]
			if isElement(v[1]) then

				guiSetPosition ( v[1], v[2], v[3], false )
				guiSetSize ( v[1], appSize, appSize, false )

			end

		end

		removeEventHandler ( "onClientMouseEnter", root, onMouseEnter )
		removeEventHandler ( "onClientMouseLeave", root, onMouseLeave )
		for i=1, #apps do

			local app = apps[i]
			if app[10] then
				removeEventHandler ( 'onClientRender', root, drawPopups )
				app[10] = false
			end
		end

		removeEventHandler ( "onClientGUIClick", root, onMouseClick )

		addEventHandler('onClientRender',root,decreaseHeight)

	end

end

function onMouseEnter ()

	for i=1, #apps do

		local v = apps[i]
		if v[1] == source then

			local image, X, Y, width, height = v[1], v[2], v[3], appSize, appSize
			guiSetSize ( image, width+10, height+10, false )
			guiSetPosition ( image, X-5, Y-5, false )
			if not v[10] then
				addEventHandler ( 'onClientRender', root, drawPopups )
				v[10] = true
			end

		end

	end

end

function drawNotificationBar()

	local barX,barY = BGX,caseY+(0.2890625*caseHeight)
	local barWidth,barHeight = BGWidth,0.0185546875*caseHeight
	local timeX,timeY,timeWidth,timeHeight = barX+(barWidth*0.25),barY,0.5*barWidth,barHeight
	local theTime = getRealTime()
	if theTime.hour < 10 then theTime.hour = "0"..theTime.hour end
	if theTime.second < 10 then theTime.second = "0"..theTime.second end
	if theTime.minute < 10 then theTime.minute = "0"..theTime.minute end
	dxDrawText ( theTime.hour..":"..theTime.minute..":"..theTime.second, timeX,timeY, timeWidth+timeX, timeY+timeHeight, tocolor ( 255, 255, 255, 255 ), barWidth/263.7421875, theFont, "center", "center", false, false, true )


end

function drawPopups ()

	for i=1, #apps do

		if apps[i][10] == true then

			local image, X, Y, width, height = apps[i][1], apps[i][2], apps[i][3], apps[i][4], apps[i][5]
			local nWidth = dxGetTextWidth(apps[i][11],theFontSize, theFont)+10
			local txtHeight = dxGetFontHeight(theFontSize, theFont)+5
			local x,y = X+(width-(nWidth))/2, Y-txtHeight-10
			dxDrawRectangle ( x,y, nWidth, txtHeight, tocolor ( 0, 0, 0, 220 ), true )
			dxDrawText ( apps[i][11], x,y, x+nWidth, y+txtHeight, tocolor ( 255, 255, 255, 255 ), theFontSize, theFont, "center", "center", false, false, true )

		end

	end

end

function onMouseLeave ()

	for i=1, #apps do

		local v = apps[i]
		if v[1] == source then
			local image, X, Y, width, height = v[1], v[2], v[3], appSize, appSize

			guiSetSize ( image, width, height, false )
			guiSetPosition ( image, X, Y, false )
			if v[10] then
				removeEventHandler ( 'onClientRender', root, drawPopups )
				v[10] = false
			end

		end

	end

end

function onMouseClick ()

	local appOpen
	for i=1, #apps do

		if apps[i][1] == source then

			if apps[i][8] then openApp(apps[i][11]) end

		end

		if apps[i][7] == true then appOpen = true end
		guiBringToFront(apps[i][1])

	end

	if source == phoneImages[3] then

		closeApps()
		if not appOpen then

			togglePhone()

		end

	end
end

function openApp(name)

	guiStaticImageLoadImage ( phoneImages[2], "backgrounds\\appbackground.png" )
	for i=1, #apps do

		local app = apps[i]
		if isElement(app[1]) then

			guiSetVisible ( app[1], false )

		end

		if app[11] == name then

			app[8]()

		end

	end
end

function closeApps()

	local bgPNG = "background" .. BGnumber .. ".png"
	guiStaticImageLoadImage ( phoneImages[2], "backgrounds\\" .. tostring(bgPNG) )
	for i=1, #apps do

		local app = apps[i]
		if isElement(app[1]) then

			guiSetVisible ( app[1],true )

		end
		if apps[i][7] then

			apps[i][9]()

		end

	end

end
