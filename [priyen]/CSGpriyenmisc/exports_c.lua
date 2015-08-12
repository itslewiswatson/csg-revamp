function getTimeStampYYYYMMDD()
	local time = GetDateTime(GetTimestamp())
	if time.month < 10 then time.month = "0"..(time.month).."" end
	if time.monthday < 10 then time.monthday = "0"..(time.monthday).."" end
	local str = ""..(time.year)..""..(time.month)..""..(time.monthday)..""
	return str
end

function getTimeStampYYYYMMDDFromStamp(stamp)
	local time = GetDateTime(tonumber(stamp))
	if time.month < 10 then time.month = "0"..(time.month).."" end
	if time.monthday < 10 then time.monthday = "0"..(time.monthday).."" end
	local str = ""..(time.year)..""..(time.month)..""..(time.monthday)..""
	return str
end

function GetTimestamp(year, month, day, hour, minute, second)
    local i
    local timestamp = 0
    local time = getRealTime()
    local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    if (not year or year < 1970) then
        year = time.year + 1900
        month = time.month + 1
        day = time.monthday
        hour = time.hour
        minute = time.minute
        second = time.second
    else
        month = month or 1
        day = day or 1
        hour = hour or 0
        minute = minute or 0
        second = second or 0
    end

    for i=1970, year-1, 1 do
        timestamp = timestamp + 60*60*24*365
        if (IsYearALeapYear(i)) then
            timestamp = timestamp + 60*60*24
        end
    end

    if (IsYearALeapYear(year)) then
        monthDays[2] = monthDays[2] + 1
    end

    for i=1, month-1, 1 do
        timestamp = timestamp + 60*60*24*monthDays[i]
    end

    timestamp = timestamp + 60*60*24 * (day - 1) + 60*60 * hour + 60 * minute + second

    return timestamp
end

function GetDateTime(timestamp)
    local i
    local time = {}
    local monthDays = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 }

    time.year = 1970
    while (timestamp >= 60*60*24*365) do
        timestamp = timestamp - 60*60*24*365
        time.year = time.year + 1

        if (IsYearALeapYear(time.year - 1)) then
            if timestamp >= 60*60*24 then
                timestamp = timestamp - 60*60*24
            else
                timestamp = timestamp + 60*60*24*365
                time.year = time.year - 1
                break
            end
        end
    end

    if (IsYearALeapYear(time.year)) then
        monthDays[2] = monthDays[2] + 1
    end

    local month, daycount
    for month, daycount in ipairs(monthDays) do
        time.month = month
        if (timestamp >= 60*60*24*daycount) then
            timestamp = timestamp - 60*60*24*daycount
        else
            break
        end
    end

    time.monthday = math.floor(timestamp / (60*60*24)) + 1
    timestamp = timestamp - 60*60*24 * (time.monthday - 1)

    time.hour = math.floor(timestamp / (60*60))
    timestamp = timestamp - 60*60 * time.hour

    time.minute = math.floor(timestamp / 60)
    timestamp = timestamp - 60 * time.minute

    time.second = timestamp

    local monthcode = time.month - 2
    local year = time.year
    local yearcode

    if (monthcode < 1) then
        monthcode = monthcode + 12
        year = year - 1
    end
    monthcode = math.floor(2.6 * monthcode - 0.2)

    yearcode = year % 100
    time.weekday = time.monthday + monthcode + yearcode + math.floor(yearcode / 4)
    yearcode = math.floor(year / 100)
    time.weekday = time.weekday + math.floor(yearcode / 4) - 2 * yearcode
    time.weekday = time.weekday % 7

    return time
end

function IsYearALeapYear(year)
    if ((year % 4 == 0 and year % 100 ~= 0) or year % 400 == 0) then
        return true
    else
        return false
    end
end


function dxDrawColorText(str, ax, ay, bx, by, color, scale, font, alignX, alignY)
  bx, by, color, scale, font = bx or ax, by or ay, color or tocolor(255,255,255,255), scale or 1, font or "default"
  if alignX then
    if alignX == "center" then
      ax = ax + (bx - ax - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font))/2
    elseif alignX == "right" then
      ax = bx - dxGetTextWidth(str:gsub("#%x%x%x%x%x%x",""), scale, font)
    end
  end
  if alignY then
    if alignY == "center" then
      ay = ay + (by - ay - dxGetFontHeight(scale, font))/2
    elseif alignY == "bottom" then
      ay = by - dxGetFontHeight(scale, font)
    end
  end
  local alpha = string.format("%08X", color):sub(1,2)
  local pat = "(.-)#(%x%x%x%x%x%x)"
  local s, e, cap, col = str:find(pat, 1)
  local last = 1
  while s do
    if cap == "" and col then color = tocolor(getColorFromString("#"..col..alpha)) end
    if s ~= 1 or cap ~= "" then
      local w = dxGetTextWidth(cap, scale, font)
      dxDrawText(cap, ax, ay, ax + w, by, color, scale, font)
      ax = ax + w
      color = tocolor(getColorFromString("#"..col..alpha))
    end
    last = e + 1
    s, e, cap, col = str:find(pat, last)
  end
  if last <= #str then
    cap = str:sub(last)
    dxDrawText(cap, ax, ay, ax + dxGetTextWidth(cap, scale, font), by, color, scale, font)
  end
end

function output()
	local x,y,z = getElementPosition(localPlayer)
	outputChatBox("{"..x..","..y..","..z.."},")
end
addCommandHandler("bpos",output)

local cityBoundary = 1600
local cities = {
[1] = "LS",
[2] = "SF",
[3] = "LV"
}
local cityNames = {
[1] = "Los Santos",
[2] = "San Fierro",
[3] = "Las Venturas"
}
local cityCenters = {
[1] = {1622.94140625, -1548.486328125, 13.671937942505},
[2] = {-2259.66015625, 543.3671875, 35.11096572876},
[3] = {2181.0390625, 1773.41015625, 10.671875}
}

function isWithinCityBoundary(cityID,x1,y1,z1)
    if cityID ~= 0 then
    else
    cityID = city
    end
    local dist = getDistanceBetweenPoints2D(x1,y1,cityCenters[cityID][1],cityCenters[cityID][2])
    if dist <= cityBoundary then
    return true
    else
    return false
    end
end

function playCustomSound(name)
	playSound(name)
end

------------

local root = getRootElement()
local localPlayer = getLocalPlayer()
local PI = math.pi

local isEnabled = false
local wasInVehicle = isPedInVehicle(localPlayer)

local mouseSensitivity = 0.1
local rotX, rotY = 0,0
local mouseFrameDelay = 0
local idleTime = 999999999999999
local fadeBack = false
local fadeBackFrames = 50
local executeCounter = 0
local recentlyMoved = false
local Xdiff,Ydiff
local radar = true

local cam=2
function toggleCockpitView ()
	cam=cam+1
	if cam > 3 then cam=1 end
	local setmode=false
	if isPedInVehicle(localPlayer) == true then
		if getCameraViewMode() == 2 then
			if isEnabled == true then
				isEnabled=true
				setmode=true
			else
				isEnabled=false
			end
		else
			return
		end
	else
		if cam == 1 then
			isEnabled=false
		else
			isEnabled=true
		end
	end

	if (not isEnabled) then
		isEnabled = true
		addEventHandler ("onClientPreRender", root, updateCamera)
		addEventHandler ("onClientCursorMove",root, freecamMouse)
		--showPlayerHudComponent("radar", false)
		--radar = false
	else --reset view
		isEnabled = false
		setCameraTarget (localPlayer, localPlayer)
		removeEventHandler ("onClientPreRender", root, updateCamera)
		removeEventHandler ("onClientCursorMove", root, freecamMouse)
		--showPlayerHudComponent("radar", true)
		--radar = true
	end
	if setmode==true then setCameraViewMode(1) end
end

bindKey("v","down",toggleCockpitView)
addCommandHandler("fpv", toggleCockpitView)


function updateCamera ()
	if (isEnabled) then

		local nowTick = getTickCount()

		-- check if the last mouse movement was more than idleTime ms ago
		if wasInVehicle and recentlyMoved and not fadeBack and startTick and nowTick - startTick > idleTime then
			recentlyMoved = false
			fadeBack = true
			if rotX > 0 then
				Xdiff = rotX / fadeBackFrames
			elseif rotX < 0 then
				Xdiff = rotX / -fadeBackFrames
			end
			if rotY > 0 then
				Ydiff = rotY / fadeBackFrames
			elseif rotY < 0 then
				Ydiff = rotY / -fadeBackFrames
			end
		end

		if fadeBack then

			executeCounter = executeCounter + 1

			if rotX > 0 then
				rotX = rotX - Xdiff
			elseif rotX < 0 then
				rotX = rotX + Xdiff
			end

			if rotY > 0 then
				rotY = rotY - Ydiff
			elseif rotY < 0 then
				rotY = rotY + Ydiff
			end

			if executeCounter >= fadeBackFrames then
				fadeBack = false
				executeCounter = 0
			end

		end

		local camPosXr, camPosYr, camPosZr = getPedBonePosition (localPlayer, 6)
		local camPosXl, camPosYl, camPosZl = getPedBonePosition (localPlayer, 7)
		local camPosX, camPosY, camPosZ = (camPosXr + camPosXl) / 2, (camPosYr + camPosYl) / 2, (camPosZr + camPosZl) / 2
		local roll = 0

		inVehicle = isPedInVehicle(localPlayer)

		-- note the vehicle rotation
		if inVehicle then
			local rx,ry,rz = getElementRotation(getPedOccupiedVehicle(localPlayer))

			roll = -ry
			if rx > 90 and rx < 270 then
				roll = ry - 180
			end

			if not wasInVehicle then
				rotX = rotX + math.rad(rz) --prevent camera from rotation when entering a vehicle
				if rotY > -PI/15 then --force camera down if needed
					rotY = -PI/15
				end
			end

			cameraAngleX = rotX - math.rad(rz)
			cameraAngleY = rotY + math.rad(rx)

			if getControlState("vehicle_look_behind") or ( getControlState("vehicle_look_right") and getControlState("vehicle_look_left") ) then
				cameraAngleX = cameraAngleX + math.rad(180)
				--cameraAngleY = cameraAngleY + math.rad(180)
			elseif getControlState("vehicle_look_left") then
				cameraAngleX = cameraAngleX - math.rad(90)
				--roll = rx doesn't work out well
			elseif getControlState("vehicle_look_right") then
				cameraAngleX = cameraAngleX + math.rad(90)
				--roll = -rx
			end
		else
			local rx, ry, rz = getElementRotation(localPlayer)

			if wasInVehicle then
				rotX = rotX - math.rad(rz) --prevent camera from rotating when exiting a vehicle
			end
			cameraAngleX = rotX
			cameraAngleY = rotY
		end

		wasInVehicle = inVehicle

		--Taken from the freecam resource made by eAi

		-- work out an angle in radians based on the number of pixels the cursor has moved (ever)

		local freeModeAngleZ = math.sin(cameraAngleY)
		local freeModeAngleY = math.cos(cameraAngleY) * math.cos(cameraAngleX)
		local freeModeAngleX = math.cos(cameraAngleY) * math.sin(cameraAngleX)

		-- calculate a target based on the current position and an offset based on the angle
		local camTargetX = camPosX + freeModeAngleX * 100
		local camTargetY = camPosY + freeModeAngleY * 100
		local camTargetZ = camPosZ + freeModeAngleZ * 100

		-- Work out the distance between the target and the camera (should be 100 units)
		local camAngleX = camPosX - camTargetX
		local camAngleY = camPosY - camTargetY
		local camAngleZ = 0 -- we ignore this otherwise our vertical angle affects how fast you can strafe

		-- Calulcate the length of the vector
		local angleLength = math.sqrt(camAngleX*camAngleX+camAngleY*camAngleY+camAngleZ*camAngleZ)

		-- Normalize the vector, ignoring the Z axis, as the camera is stuck to the XY plane (it can't roll)
		local camNormalizedAngleX = camAngleX / angleLength
		local camNormalizedAngleY = camAngleY / angleLength
		local camNormalizedAngleZ = 0

		-- We use this as our rotation vector
		local normalAngleX = 0
		local normalAngleY = 0
		local normalAngleZ = 1

		-- Perform a cross product with the rotation vector and the normalzied angle
		local normalX = (camNormalizedAngleY * normalAngleZ - camNormalizedAngleZ * normalAngleY)
		local normalY = (camNormalizedAngleZ * normalAngleX - camNormalizedAngleX * normalAngleZ)
		local normalZ = (camNormalizedAngleX * normalAngleY - camNormalizedAngleY * normalAngleX)

		-- Update the target based on the new camera position (again, otherwise the camera kind of sways as the target is out by a frame)
		camTargetX = camPosX + freeModeAngleX * 100
		camTargetY = camPosY + freeModeAngleY * 100
		camTargetZ = camPosZ + freeModeAngleZ * 100

		-- Set the new camera position and target
		setCameraMatrix (camPosX, camPosY, camPosZ, camTargetX, camTargetY, camTargetZ, roll)
		--[[
		dxDrawText("fadeBack = "..tostring(fadeBack),400,200)
		dxDrawText("recentlyMoved = "..tostring(recentlyMoved),400,220)
		if executeCounter then dxDrawText("executeCounter = "..tostring(executeCounter),400,240) end
		dxDrawText("rotX = "..tostring(rotX),400,260)
		dxDrawText("rotY = "..tostring(rotY),400,280)
		if Xdiff then dxDrawText("Xdiff = "..tostring(Xdiff),400,300) end
		if Ydiff then dxDrawText("Ydiff = "..tostring(Ydiff),400,320) end
		if startTick then dxDrawText("startTick = "..tostring(startTick),400,340) end
		dxDrawText("nowTick = "..tostring(nowTick),400,360)
		]]
	end
end

function freecamMouse (cX,cY,aX,aY)

	--ignore mouse movement if the cursor or MTA window is on
	--and do not resume it until at least 5 frames after it is toggled off
	--(prevents cursor mousemove data from reaching this handler)
	if isCursorShowing() or isMTAWindowActive() then
		mouseFrameDelay = 5
		return
	elseif mouseFrameDelay > 0 then
		mouseFrameDelay = mouseFrameDelay - 1
		return
	end

	startTick = getTickCount()
	recentlyMoved = true

	-- check if the mouse is moved while fading back, if so abort the fading
	if fadeBack then
		fadeBack = false
		executeCounter = 0
	end

	-- how far have we moved the mouse from the screen center?
	local width, height = guiGetScreenSize()
	aX = aX - width / 2
	aY = aY - height / 2

	rotX = rotX + aX * mouseSensitivity * 0.01745
	rotY = rotY - aY * mouseSensitivity * 0.01745

	local pRotX, pRotY, pRotZ = getElementRotation (localPlayer)
	pRotZ = math.rad(pRotZ)

	if rotX > PI then
		rotX = rotX - 2 * PI
	elseif rotX < -PI then
		rotX = rotX + 2 * PI
	end

	if rotY > 2*PI then
		rotY = rotY - 2 * PI
	elseif rotY < -PI then
		rotY = rotY + 2 * PI
	end
	-- limit the camera to stop it going too far up or down
	if isPedInVehicle(localPlayer) then
		if rotY < -PI / 2 then
			rotY = -PI / 2
		elseif rotY > -PI/20+1 then
			rotY = -PI/20+1
		end
	else
		if rotY < -PI / 4 then
			rotY = -PI / 4
		elseif rotY > PI / 2.1 then
			rotY = PI / 2.1
		end
	end
end

--[[
local boneNumbers = {1,2,3,4,5,6,7,8,21,22,23,24,25,26,31,32,33,34,35,36,41,42,43,44,51,52,53,54}
local boneColors = {}
for _,i in ipairs(boneNumbers) do
 boneColors[i] = tocolor(math.random(0,255),math.random(0,255),math.random(0,255),255)
end
addEventHandler ("onClientRender", getRootElement(),
 function ()
  for _,i in ipairs(boneNumbers) do
   local x,y = getScreenFromWorldPosition(getPedBonePosition(getLocalPlayer(),i))
   if x then
	dxDrawText(tostring(i),x,y,"center","center",boneColors[i])
   end
  end
 end
)
]]

function toggleRadar()
	radar = not radar
	showPlayerHudComponent("radar", radar)
end
--addCommandHandler( "toggleradar", toggleRadar)

------

engineImportTXD(engineLoadTXD("cuff.txd", 1598), 1598)
engineReplaceModel(engineLoadDFF("cuff.dff", 1598), 1598)

function baseAddons()
minigun = createObject (2985, 88, 1909, 16.79, 0, 0, 180)
parachuteTarget = createObject (3108, 206, 1932, 22.4)
ramp = createObject (1634, 260, 2061, 17.89)
setObjectBreakable (minigun, false)
setObjectBreakable (parachuteTarget, false)
setObjectBreakable (ramp, false)
end
baseAddons()


