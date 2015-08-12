local styles = {
{"Normal",0},
{"Fat Man",55},
{"Fat Man 2",124},
{"Old and Fat Man",123},
{"Old Man",120},
{"Cool Man ",56,true},
{"Ugly Man",63},
{"Fat Boss",64},
{"Boss",65},
--{"Sneak Move",69,true},
--{"Player with Jetpack",70,true},
{"Funny Man Walk",118},
{"Shuffling Player",119},
{"Gang Walk 1",121},
{"Gang Walk 2",122},
{"Jogger",125},
{"Drunk Man",126},
{"Blid Man",127,true},
{"CSG Law Walk",128},
{"Woman Walk",129},
{"Girl Walk",130},
{"Busy Woman",131},
{"Sexy Woman",132},



{"MOVE_PRO",133},
{"MOVE_OLDWOMAN",134},
{"MOVE_FATWOMAN",135},
{"MOVE_JOGWOMAN",136},
{"MOVE_OLDFATWOMAN",137},
--{"MOVE_SKATE",138 },
}


local mystyle=0
window = guiCreateWindow(287, 137, 216, 350, "CSG ~ Walk Style", false)
guiWindowSetSizable(window, false)

list = guiCreateGridList(9, 26, 198, 283, false, window)
guiGridListAddColumn(list, "Style", 0.9)
btnBuy = guiCreateButton(10, 315, 90, 26, "Buy ($500)", false, window)
btnExit = guiCreateButton(116, 315, 90, 26, "Exit", false, window)
guiSetVisible(window,false)
addEventHandler("onClientGUIClick",root,function()
	if source == btnBuy then
		local row = guiGridListGetSelectedItem(list)
		if row ~= nil and row ~= false and row ~= -1 then
			if getPlayerMoney() < 500 then
				exports.dendxmsg:createNewDxMessage("You can't afford to change your walking style!",255,255,0)
			else
				local id = guiGridListGetItemData(list,row,1)
				if id == 128 and isLaw(localPlayer) == false then
					exports.dendxmsg:createNewDxMessage("Only CSG's Official Law Enforcement can use this style!",255,255,0)
					return
				end
				for k,v in pairs(styles) do
					if v[2] == id then
						if (v[3]) then
							--exports.dendxmsg:createNewDxMessage("Note: This walking style has weapons disabled (only melee and colt pistol work)",255,255,0)
						end
						break
					end
				end
				triggerServerEvent("CSGwalk.buy",localPlayer,id)
			end
		else
			exports.dendxmsg:createNewDxMessage("You didn't select a walking style!",255,255,0)
		end
	elseif source == btnExit then
		hide()
	end

end)


local pos = {
	{773.87, -0.27, 1000.72,int=5,dim=0},
	{ 762.1, -60.44, 1000.65,int=7,dim=0},
}
--[[
local styles = {
{"MOVE_DEFAULT",0},
{"MOVE_PLAYER",54},
{"MOVE_PLAYER_F",55},
{"MOVE_PLAYER_M",56},
{"MOVE_ROCKET",57},
{"MOVE_ROCKET_F",58},
{"MOVE_ROCKET_M",59},
{"MOVE_ARMED",60},
{"MOVE_ARMED_F",61},
{"MOVE_ARMED_M",62},
{"MOVE_BBBAT",63},
{"MOVE_BBBAT_F",64},
{"MOVE_BBBAT_M",65},
{"MOVE_CSAW",66},
{"MOVE_CSAW_F",67},
{"MOVE_CSAW_M",68},
{"MOVE_SNEAK",69},
{"MOVE_JETPACK",70},
{"MOVE_MAN",118},
{"MOVE_SHUFFLE",119},
{"MOVE_OLDMAN",120},
{"MOVE_GANG1",121},
{"MOVE_GANG2",122},
{"MOVE_OLDFATMAN",123},
{"MOVE_FATMAN",124},
{"MOVE_JOGGER",125},
{"MOVE_DRUNKMAN",126},
{"MOVE_BLINDMAN",127},
{"MOVE_SWAT",128},
{"MOVE_WOMAN",129},
{"MOVE_SHOPPING",130},
{"MOVE_BUSYWOMAN",131},
{"MOVE_SEXYWOMAN",132},
{"MOVE_PRO",133},
{"MOVE_OLDWOMAN",134},
{"MOVE_FATWOMAN",135},
{"MOVE_JOGWOMAN",136},
{"MOVE_OLDFATWOMAN",137},
{"MOVE_SKATE",138 },
}
--]]


function isLaw(p)
	local t = getTeamName(getPlayerTeam(p))
	if t == "Military Forces" or t == "SWAT" or t == "Government Agency" then return true else return false end
end

function hit(p,di)
	if di == false then return end
	if p ~= localPlayer then return end
	show()
end

for k,v in pairs(pos) do
	local m = createMarker(v[1],v[2],v[3]-1,"cylinder",2,0,255,0,100)
	setElementDimension(m,v.dim)
	setElementInterior(m,v.int)
	addEventHandler("onClientMarkerHit",m,hit)
end

function refresh()
guiGridListClear(list)

for k,v in pairs(styles) do
	local row = guiGridListAddRow(list)
	guiGridListSetItemText(list,row,1,v[1],false,false)
	guiGridListSetItemData(list,row,1,v[2])
	if mystyle == v[2] then
		guiGridListSetItemColor(list,row,1,0,255,0)
	end
end
end
refresh()
addEvent("CSGwalk.rec",true)
addEventHandler("CSGwalk.rec",localPlayer,function(e,style)
	setPedWalkingStyle(e,style)
end)

function badStyle()
	for k,v in pairs(styles) do
		if v[2] == mystyle then
			if (v[3]) then return true else return false end
		end
	end
end
--[[
addEventHandler("onClientPlayerWeaponSwitch",localPlayer,function(prev,curr)
	if badStyle() == false then return end
	if curr ~= 0 and curr ~= 1 and curr ~= 2 then
		exports.dendxmsg:createNewDxMessage("This weapon is disabled in your walk style. Only melee and pistol allowed",255,0,0)
		setPedWeaponSlot(localPlayer,0)
	else
		if curr == 2 then
			if getPedWeapon(localPlayer,curr) ~= 22 then
				exports.dendxmsg:createNewDxMessage("This weapon is disabled in your walk style. Only melee and pistol allowed",255,0,0)
				setPedWeaponSlot(localPlayer,0)
			end
		end
	end
end)--]]

addEvent("CSGwalk.recTable",true)
addEventHandler("CSGwalk.recTable",localPlayer,function(t)
	for k,v in pairs(t) do
		setPedWalkingStyle(k,v)
	end
end)


addEvent("CSGwalk.bought",true)
addEventHandler("CSGwalk.bought",localPlayer,function(id)
	mystyle=id
	refresh()
	for k,v in pairs(styles) do
		if v[2] == id then
			exports.dendxmsg:createNewDxMessage("Bought walking style "..v[1].." for $500",0,255,0)
			return
		end
	end
end)

function show()
	guiSetVisible(window,true)
	showCursor(true)
end

function hide()
	guiSetVisible(window,false)
	showCursor(false)
end
addEventHandler("onClientPlayerWasted",localPlayer,hide)


function setElementSpeed(element, unit, speed) -- only work if element is moving!
    if (unit == nil) then unit = 0 end
    if (speed == nil) then speed = 0 end
    speed = tonumber(speed)
    local acSpeed = getElementSpeed(element, unit)
    if (acSpeed~=false) then -- if true - element is valid, no need to check again
        local diff = speed/acSpeed
        local x,y,z = getElementVelocity(element)
        setElementVelocity(element,x*diff,y*diff,z*diff)
        return true
    end

    return false
end

function getElementSpeed(element,unit)
    if (unit == nil) then unit = 0 end
    if (isElement(element)) then
        local x,y,z = getElementVelocity(element)
        if (unit=="mph" or unit==1 or unit =='1') then
            return (x^2 + y^2 + z^2) ^ 0.5 * 100
        else
            return (x^2 + y^2 + z^2) ^ 0.5 * 1.61 * 100
        end
    else
        outputDebugString("Not an element. Can't get speed")
        return false
    end
end

local tick = getTickCount()
addEventHandler("onClientRender",root,function()
	local team = getPlayerTeam(localPlayer)
	if not team then return end
	if getTeamName(team) == "Staff" then return end

	if isPedInVehicle(localPlayer) then return end

   --[[ local speed = getElementSpeed(localPlayer,"mph")
	--outputDebugString(speed)
    if speed and speed > 40 then
        setElementSpeed(localPlayer,"mph",27)
		exports.dendxmsg:createNewDxMessage("You are running too fast! Anti-cheat, you have been slowed!",255,0,0)
		toggleControl("sprint",false)
		tick=getTickCount()
		--outputDebugString("set to 30")
	else
		if getTickCount()-tick > 4000 then
			toggleControl("sprint",true)
		end
    end
end )
--]]
--[[
local count = 0

addEventHandler("onClientClick",root,function()
	count=count+1
end)

setTimer(function()
	if count > 30 then
		exports.dendxmsg:createNewDxMessage("Stop Autoclicking! You are frozen until it is no longer detected",255,0,0)
		setElementFrozen(localPlayer,true)
		setTimer(function() setElementFrozen(localPlayer,false) end,900,1)
	end
	count = 0
end,1000,0)
--]]
