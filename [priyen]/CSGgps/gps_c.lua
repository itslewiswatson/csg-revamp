------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  gps_c.luac (client-side)
--  GPS / Pathfinding System
--  Priyen Patel, arc_
------------------------------------------------------------------------------------


local root = getRootElement()
local floor = math.floor
local arrows = {}
local gpsPath = {}
local markers = {}
local gpsOn = false
local uTurnCount = 0

function drawGps(path)
	if path == gpsPath then return end
	local veh = getPedOccupiedVehicle(localPlayer)
    gpsOn = true
    gpsPath = path
    local count = 1
	for i,node in ipairs(path) do
        local arrow = createObject(1318, node.x, node.y, node.z + 1)
        local x,y = 0,0
        if path[i+1] ~= nil then
			local nextnodex = path[i+1].x
			local nextnodey = path[i+1].y
			rot = findRotationArrows(tonumber(node.x), tonumber(node.y), tonumber(nextnodex), tonumber(nextnodey))
			setElementRotation(arrow, 0, 90, rot)
        end
        table.insert(arrows,arrow)
		if i == 1 then

		end
		if i ~= 1 then
			local rot0 = findRotationArrows(tonumber(path[i-1].x), tonumber(path[i-1].y),tonumber(node.x), tonumber(node.y))
			local dir1 = getDir(rot0)
			local dir2 = getDir(rot)
			if rot0 > rot then
				local temp = rot
				rot=rot0
				rot0=temp
			end

			if dir1 ~= dir2 then
				if rot-rot0 > 75 then
					local turn = getTurnDir(dir1,dir2)
					local marker = createMarker( node.x, node.y, node.z,"cylinder",30,255,255,0,0)
					markers[marker] = turn
					addEventHandler("onClientMarkerHit",marker, sayTurn)
				end
			end
		end
		if count >= 25 then
			local m = createMarker(path[i-5].x,path[i-5].y,path[i-5].z,"cylinder",20,1,1,1,0)
			markers[m] = "continueMarker"
			addEventHandler("onClientMarkerHit",m,hitMakeRestOfRouteMarker)
			return
		end
        if count == #path then
			local lastNode = createColCircle(node.x,node.y,20)
			table.insert(arrows,lastNode)
			addEventHandler("onClientColShapeHit",lastNode,hitLastNode)
        end
        count = count + 1
	end
end

function hitMakeRestOfRouteMarker(p)
	if p ~= localPlayer then return end
	if gpsOn == false then endGps() return end
	sendGpsReq("",dx,dy,dz)
end

function sayTurn()
	if toSayVoice == true then
		playSound("turn"..markers[source]..".mp3")
		exports.DENdxmsg:createNewDxMessage("Turn "..markers[source].."",0,255,0)
	end
end

local turns = {
	["North"] = {["East"] = "right",["West"] = "left"},
	["South"] = {["East"] = "left",["West"] = "right"},
	["East"] = {["North"] = "left",["South"] = "right"},
	["West"] = {["North"] = "right",["South"] = "left"}
}

function getTurnDir(d1,d2)
	if  turns[d1][d2] == nil then return "Now" else
	return turns[d1][d2]
	end
end

function getDir(rot)
	if rot == nil then return "none" end
	if rot > 360 then rot = rot-360 end
	if rot >= 0 and rot <= 90 then
		if 90-rot < 45 then return "South" end
		if 90-rot >= 45 then return "West" end
	end
	if rot > 90 and rot <= 180 then
		if 180-rot < 45 then return "East" end
		if 180-rot >= 45 then return "South" end
	end
	if rot > 180 and rot <= 270 then
		if 270-rot < 45 then return "North" end
		if 270-rot >= 45 then return "East" end
	end
	if rot > 270 and rot <= 360 then
		if 360-rot < 45 then return "West" end
		if 360-rot >= 45 then return "North" end
	end
end

function hitLastNode(p)
    if p == localPlayer then
		--endGps()
		-- exports.DENdxmsg:createNewDxMessage("GPS: Reached Destination "..globalDest.."",255,255,0)
		--if guiCheckBoxGetSelected(cbVoice) == true then playSound("arriving.mp3") end
    end
end

function isClientInPathRange()
	local isInPathRange = false
	if gpsPath == false then sendGpsReq("",dx,dy,dz) return end
	local px,py,pz = getElementPosition(localPlayer)
		local dist = getDistanceBetweenPoints3D(dx,dy,dz,px,py,pz)
		if dist < 50 then isInPathRange = true return end
        for i,node in pairs(gpsPath) do
           if isInPathRange == false then
            local x,y,z = node.x, node.y, node.z

            local dist = getDistanceBetweenPoints3D(x,y,z,px,py,pz)
            if dist <= 20 then
            isInPathRange = true
            end
           end
        end
	return isInPathRange
end

function monitor()
    if gpsOn == true then

        local isInPathRange = isClientInPathRange()


        if isInPathRange == false then
            local x,y,z = gpsPath[#gpsPath].x,gpsPath[#gpsPath].y,gpsPath[#gpsPath].z
            destName = getZoneName(x,y,z)
             exports.DENdxmsg:createNewDxMessage("GPS: Rerouting / Finding Alternative Route",255,255,0)
			endGps()
            sendGpsReq("",x,y,z)
        end
    end
end
setTimer(monitor,3000,0)

function endGps()
    for k,arrow in pairs(arrows) do
     if arrow ~= nil then
        if isElement(arrow) then
        destroyElement(arrow)
        end
      end
    end
	for k,v in pairs(markers) do
		if isElement(k) then
			removeEventHandler("onClientMarkerHit",k, sayTurn)
			if v == "continueMarker" then
			removeEventHandler("onClientMarkerHit",k, hitMakeRestOfRouteMarker)
			end
			destroyElement(k)
		end
	end
    gpsPath = nil
    gpsOn = false
end

function sendGpsReq(cmdName,x,y,z)
    local x1,y1,z1 = getElementPosition(localPlayer)
   -- if isPedInVehicle(localPlayer) == true then
	local pth = calculatePathByCoords(x1,y1,z1,x,y,z)
	endGps()
	drawGps(pth)
   -- end
end
addCommandHandler("setgps",sendGpsReq)

function setGpsC(x,y,z)
    local x1,y1,z1 = getElementPosition(localPlayer)
    local pth = calculatePathByCoords(x1,y1,z1,x,y,z)
	drawGps(pth)
	 exports.DENdxmsg:createNewDxMessage("GPS: Finding Path to "..globalDest.."",255,255,0)
end

function clearGpsC()
    endGps()
end

findRotationArrows = function(a, b, c, d)
  local X = math.abs(c - a)
  local Y = math.abs(d - b)
  Rotm = math.deg(math.atan2(Y, X))
  if a <= c and b < d then
    Rotm = 90 - Rotm
  elseif c <= a and b < d then
    Rotm = 270 + Rotm
  elseif a <= c and d <= b then
    Rotm = 90 + Rotm
  elseif c < a and d <= b then
    Rotm = 270 - Rotm
  end
  return 630 - Rotm
end




local function getAreaID(x, y)
	return floor((y + 3000)/750)*8 + floor((x + 3000)/750)
end

local function getNodeByID(db, nodeID)
	local areaID = floor(nodeID / 65536)
	return db[areaID][nodeID]
end

local function findNodeClosestToPoint(db, x, y, z)
	local areaID = getAreaID(x, y)
	local minDist, minNode
	local nodeX, nodeY, dist
	for id,node in pairs(db[areaID]) do
		nodeX, nodeY = node.x, node.y
		dist = (x - nodeX)*(x - nodeX) + (y - nodeY)*(y - nodeY)
		if not minDist or dist < minDist then
			minDist = dist
			minNode = node
		end
	end
	return minNode
end

local function calculatePath(db, nodeFrom, nodeTo)
	local next = next

	local g = { [nodeFrom] = 0 }
	local hcache = {}
	local parent = {}
	local openheap = MinHeap.new()

	local function h(node)
		if hcache[node] then
			return hcache[node]
		end
		local x, y, z = node.x - nodeTo.x, node.y - nodeTo.y, node.z - nodeTo.z
		hcache[node] = x*x + y*y + z*z
		return hcache[node]
	end
	local nodeMT = {
		__lt = function(a, b)
			return g[a] + h(a) <  g[b] + h(b)
		end,
		__le = function(a, b)
			if not g[a] or not g[b] then
				outputConsole(debug.traceback())
			end
			return g[a] + h(a) <= g[b] + h(b)
		end
	}
	setmetatable(nodeFrom, nodeMT)
	openheap:insertvalue(nodeFrom)

	local current
	while not openheap:empty() do
		current = openheap:deleteindex(0)
		if current == nodeTo then
			break
		end

		local successors = {}
		for id,distance in pairs(current.neighbours) do
			local successor = getNodeByID(db, id)
			local successor_g = g[current] + distance*distance
			if not g[successor] or g[successor] > successor_g then
				setmetatable(successor, nodeMT)

				g[successor] = successor_g
				openheap:insertvalue(successor)
				parent[successor] = current
			end
		end
	end

	if current == nodeTo then
		local path = {}
		repeat
			table.insert(path, 1, current)
			current = parent[current]
		until not current
		return path
	else
		return false
	end
end

function calculatePathByCoords(x1, y1, z1, x2, y2, z2)
    local path = calculatePath(vehicleNodes, findNodeClosestToPoint(vehicleNodes, x1, y1, z1), findNodeClosestToPoint(vehicleNodes, x2, y2, z2))
 	return path
end

function calculatePathByNodeIDs(node1, node2)
	node1 = getNodeByID(vehicleNodes, node1)
	node2 = getNodeByID(vehicleNodes, node2)
	if node1 and node2 then
		return calculatePath(vehicleNodes, node1, node2)
	else
		return false
	end
end

if fileExists("gps_c.lua") == true then
	fileDelete("gps_c.lua")
end
