local x, y, z = 0, 0, 0
local int = 0
local dim = 0
local colshape = false
local speaker = false
local stream = false
local usingElement = false
local radius = 100

function wanttostream(plr)
 if (exports.CSGstaff:getPlayerAdminLevel(plr) >= 3) then
		triggerClientEvent(plr, "Guistr", plr)
	end
end
addCommandHandler("stream", wanttostream)

function sendSetting(typ, value)
	local event = false
	if (not typ) then return false end
	for a,b in pairs(getElementsByType("player")) do
		triggerClientEvent(b, event, b, value)
	end
	return true
end

function vehFix()
	if (not isElement(usingElement)) then return end
	local x2,y2,z2 = getElementPosition(usingElement)
	setElementPosition(colshape, x2, y2, z2)
	x = x2
	y = y2
	z = z2
end


function handleColSpeaker(element)
	if (not isElement(usingElement)) then return false end
	if (getElementType(element) ~= "player") then return end
	if (isElement(usingElement) and getElementType(usingElement) == "vehicle") then
		triggerClientEvent(element, "startClientStream", element, stream, radius, x, y, z, int, dim, usingElement)
	else
		triggerClientEvent(element, "startClientStream", element, stream, radius, x, y, z, int, dim)
	end
end

function startStream(url, dist)
	if (not isElement(client)) then return false end
	if (getTeamName(getPlayerTeam(client)) ~= "Staff") then return false end
	if (not stream) then
		stream = url
		if (not getPedOccupiedVehicle(client)) then
			x,y,z = getElementPosition(client)
			y = y + 0.5
			int = getElementInterior(client)
			dim = getElementDimension(client)
			usingElement = client
		else
			x,y,z = getElementPosition(getPedOccupiedVehicle(client))
			y = y + 0.5
			int = getElementInterior(client)
			dim = getElementDimension(client)
			usingElement = getPedOccupiedVehicle(client)
		end
		speaker = createObject(2229, x - 5, y - 5, z - 1)
		exports.CSGlogging:createAdminLogRow ( client, getPlayerName( client ).." spawned a speaker" )
		setElementInterior(speaker, int)
		setElementDimension(speaker, dim)
		colshape = createColSphere(x, y, z, radius / 2)
		addEventHandler("onColShapeHit", colshape, handleColSpeaker)
		if (getPedOccupiedVehicle(client)) then
			setTimer(vehFix, 100, 0)
			attachElements(speaker, getPedOccupiedVehicle(client), 0.3, -2.3, -0.5)
		end
		for a,b in pairs(getElementsByType("player")) do
			if (isElementWithinColShape(b, colshape)) then
				handleColSpeaker(b)
			end
		end
	end
	return true
end
addEvent("streamStart", true)
addEventHandler("streamStart", root, startStream)

function stopStream()
	if (not isElement(client)) then return false end
	if (getTeamName(getPlayerTeam(client)) ~= "Staff") then return false end
	if (stream) then
		destroyElement(colshape)
		destroyElement(speaker)
		exports.CSGlogging:createAdminLogRow ( client, getPlayerName( client ).." destroyed the speaker" )
		usingElement = false
		x,y,z = 0, 0, 0
		speaker = false
		colshape = false
		stream = false
		for a,b in pairs(getElementsByType("player")) do
			triggerClientEvent(b, "streamClientStop", b)
		end
		return true
	end
end
addEvent("streamStop", true)
addEventHandler("streamStop", root, stopStream)
