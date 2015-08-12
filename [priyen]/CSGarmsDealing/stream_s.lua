local data = {}
local radius = 100

function CSGplayStream(link,dist,private)
	dist = radius
	local drivVeh = ""
	local speaker = ""
	local ms = 0
	local marker = ""
	local x,y,z = 0,0,0
	local int,dim = 0,0
    local p = source
	if isElement(p) == false then return false end
	if getTeamName(getPlayerTeam(p)) ~= "Staff" then return false end
        drivVeh = getPedOccupiedVehicle(p)
		if isElement(drivVeh) == false then
            outputChatBox("You can only stream in a vehicle!",source,255,0,0)
            return
		else
            if data[source] ~= nil then stopStream(source) end
            if getPedOccupiedVehicleSeat(source) ~= 0 then
                outputChatBox("You can only stream when your in the driver seat!",source,255,0,0)
                return
            end
			x,y,z = getElementPosition(drivVeh)
			y = y + 2
			int = getElementInterior(p)
			dim = getElementDimension(p)
		end
		speaker = createObject(2229, x - 4, y - 4, z - 1)
		--outputChatBox("here")
		setElementDimension(speaker, dim)
		setElementInterior(speaker, int)
		marker = createMarker(x, y, z,"cylinder", 200 / 2,0,0,0,0)
		addEventHandler("onMarkerHit", marker, onColHit)
		attachElements(marker, speaker,0.305,-2.33,-0.51)
		attachElements(speaker, drivVeh, 0.305, -2.33, -0.51)
	ms=0
	data[tostring(p)] = {link,dist,private,speaker,"nothing",marker,ms,drivVeh}
	for k,v in pairs(getElementsByType("player")) do
		if isElementWithinMarker(v, marker) == true then
			startTheStream(marker,v)
		end
	end
end
addEvent("CSGplayStream",true)
addEventHandler("CSGplayStream",root,CSGplayStream)

function serversideUpdate()
    for k,v in pairs(data) do
        if isElement(v[8]) then
        local x,y,z = getElementPosition(v[8])
        setElementPosition(v[6],x,y,z)
        else
            data[k] = nil
        end
    end
end
setTimer(serversideUpdate,200,0)

function up()
    for k,v in pairs(data) do
        data[k][7] = data[k][7]+1
    end
end
setTimer(up,1000,0)

function onColHit(e)
	if getElementType(e) ~= "player" then return end
    local m = source
    startTheStream(m,e)
end


function startTheStream(m,ele)
		local s = ""
		local veh = ""
        local link = ""
        local starter = ""

        for k,v in pairs(data) do
            if v[6] == m then s = v[7] starter=tostring(k) veh = v[8] link = v[1] break end
        end
		local x,y,z = getElementPosition(veh)
		local int = getElementInterior(veh)
		local dim = getElementDimension(veh)
		triggerClientEvent(ele, "CSGstreamStart", ele, link, radius, x, y, z, int, dim, veh, s,starter)
end

function stopStream(p)
	p=tostring(p)
    if isElement(data[p][4]) then
    destroyElement(data[p][4])
    end
    if isElement(data[p][6]) then
    destroyElement(data[p][6])
    end
    if data[p] ~= nil then data[p] = nil end
    for k,v in pairs(getElementsByType("player")) do
        triggerClientEvent(v,"CSGstreamStop",root,p)
    end
    return true
end
addEvent("CSGstreamStop2",true)
addEventHandler("CSGstreamStop2",root,stopStream)

function CSGstreamGetList()
    local str = {}
    triggerClientEvent(source,"CSGstreamRecList",root,str)
end
addEvent("CSGstreamGetList",true)
addEventHandler("CSGstreamGetList",root,CSGstreamGetList)

function CSGstreamListUpdated(t)
    --updated list export
end
addEvent("CSGstreamListUpdated",true)
addEventHandler("CSGstreamListUpdated",root,CSGstreamListUpdated)

function vehExplode()
    for k,v in pairs(data) do
        if v[8] == source then
            stopStream(k)
        break
        end
    end
end
addEventHandler("onVehicleExplode",root,vehExplode)

function playerQuit()
    for k,v in pairs(data) do
        if k == source then stopStream(k) break end
    end
end
addEventHandler("onPlayerQuit",root,playerQuit)
