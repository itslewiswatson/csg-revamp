--NOTE: Doesn't need compiling, the script doesn't save to the players HDD
local enabled = true --default

local max = 5000
local high = 4000
local medium = 3000
local low = 2000
local off = 1000

addEventHandler("onClientResourceStart",resourceRoot,
function()
	setFarClipDistance(medium)
end)

function distance(cmd,_type)
	if (_type == nil) then
		outputChatBox("Syntax: /viewdistance max/high/medium/low/lowest - on",255,0,0)
		return false
	end
	
	
	if (tostring(_type) == "max") then
		outputChatBox("Distance set to max.",0,255,0)
		setFarClipDistance(max)
	elseif (tostring(_type) == "high") then
		outputChatBox("Distance set to high.",0,255,0)
		setFarClipDistance(high)
	elseif (tostring(_type) == "medium") then
		outputChatBox("Distance set to medium.",0,255,0)
		setFarClipDistance(medium)
	elseif (tostring(_type) == "low") then
		outputChatBox("Distance set to low.",0,255,0)
		setFarClipDistance(low)
	elseif (tostring(_type) == "lowest") then
		outputChatBox("Distance set to lowest.",0,255,0)
		setFarClipDistance(off)
	else
		return false
	end
end
addCommandHandler("viewdistance",distance)

function _debug()
	if (debug == false) then
		debug = true
	else
		debug = false
	end
end
addCommandHandler("distance_debug",_debug)