local bot = {
[1]={687, -1273.0278320313, 14},
[2]={662, -1867.6429443359, 5.5},
[3]={1569, -1892.7559814453, 14},
[4]={1886, -1956.5288085938, 14},
[5]={2788, -2449.4914550781, 14},
[6]={2654, -1909.8798828125, 14},
[7]={2500, -1685.7183837891, 14},
[8]={2813, -1573.8166503906, 11},
[9]={2630, -1068.5139160156, 69},

}

local elements = {}

local reqs = {
	{1178,-1328.4331054688,12.5},
}
mar=false
ped=false
pedblips=false


addEventHandler("onClientMarkerHit",root,
function (player)
	if player ~= localPlayer then return end
	if getElementType(player) == "player" then
		local valid = false
		for k,v in pairs(elements) do if v==source then valid=true break end end
		if valid==true and source~=mar then
			if getTeamName(getPlayerTeam(player)) == "Paramedics" and getElementData(player,"Occupation") == "Paramedic" then
				if isElement(ped) then exports.DENdxmsg:createNewDxMessage("You already have a job! Go to the '+' Blip on your map",255,0,0) return end
				area = math.random ( 1, #bot )
				x,y,z = unpack ( bot[area] )
				exports.DENdxmsg:createNewDxMessage("Hurry, a person is in need of serious medicial assistance, go to the '+' blip on the map!",255,255,0)
				mar = createMarker (bot[area][1],bot[area][2],bot[area][3],"arrow",1,255,0,0,255)
				local id = math.random( 10, 60 )
				ped = createPed ( tonumber( id ), x, y, z, 0 )
				setElementHealth ( ped, getElementHealth(ped) - 80 )
				pedblips = createBlipAttachedTo(ped,22,2,255,0,0,255,0,99999.0,player)
				setPedAnimation(ped,"CRACK","crckidle4",10000,true,true)
			end
		end

	end
end )

addEventHandler("onClientPedDamage",root,function()
	if source == ped then cancelEvent() end
end)

addEventHandler("onClientMarkerHit", root,
function (player)
	if getElementType(player) == "player" and getPlayerTeam(player) and getTeamName(getPlayerTeam(player)) == "Paramedics" and getElementData(player,"Occupation") == "Paramedic" then
		if (source == mar) and (player == localPlayer) then
			setPedAnimation(player,"medic","CPR",10000,true,true)
			setElementHealth ( ped, getElementHealth(ped) + 10 )
			local health = getElementHealth(ped)
			if (health > 70) then
				setPedAnimation(player,false)
				destroyElement(ped)
				destroyElement(mar)
				destroyElement(pedblips)

				exports.CSGpriyenmisc:playCustomSound("complete.mp3")
				triggerServerEvent("CSGdoc",localPlayer)
				setTimer ( spawndrug, 5000, 1 )
			end
		end
	end
end )

function makeReqs()
	for k,v in pairs(reqs) do
		local x,y,z = unpack(v)
		local marker = createMarker(x,y,z,"cylinder",2, 0, 100, 100, 255 )
		table.insert(elements,marker)
	end
end

function spawndrug (player)
	area = math.random ( 1, #bot )
	x,y,z = unpack ( bot[area] )
	mar = createMarker (bot[area][1],bot[area][2],bot[area][3],"arrow",1,0,255,0,0)
	local id = math.random( 10, 60 )
	ped = createPed ( tonumber( id ), x, y, z, 0 )
	setElementHealth ( ped, getElementHealth(ped) - 80 )
	pedblips = createBlipAttachedTo(ped,22,2,255,0,0,255,0,99999.0,player)
	setPedAnimation(ped,"CRACK","crckidle4",10000,true,true)
end



function TimerOfSpawn ()
	setTimer ( spawndrug, 5000, 1 )
end

function kill(m)
	if isElement(m) then destroyElement(m) end
end

function quitJob()
	for k,v in pairs(elements) do
		kill(v)
	end
	kill(mar)
	kill(ped)
	kill(pedblips)
 end

addEventHandler("onClientPlayerWasted",localPlayer,function()
	if isElement(mar) then
		exports.CSGpriyenmisc:playCustomSound("fail.mp3")
	end
	kill(mar)
	kill(ped)
	kill(pedblips)
end)

function newJob()
	makeReqs()
end

addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
	if oldJob == "Paramedic" then
		quitJob(source)
	elseif nJob == "Paramedic" then
		newJob(source)
	end
end
addEventHandler("onPlayerJobChange",root,jobChange)

