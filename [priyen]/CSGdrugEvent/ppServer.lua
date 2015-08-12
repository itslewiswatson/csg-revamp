hull = false
data = {}
data.depTime = "5 Minutes"
data.remainingCrates=6
data.loadedCrates=0
data.lawtoppts1 = {"No one",-999}
data.lawtoppts2 = {"No one",-999}
data.lawtoppts3 = {"No one",-999}
data.lawtoppts4 = {"No one",-999}
data.lawtoppts5 = {"No one",-999}
data.lawtopkills1 = {"No one",-999}
data.lawtopkills2 = {"No one",-999}
data.lawtopkills3 = {"No one",-999}
data.lawtopkills4 = {"No one",-999}
data.lawtopkills5 = {"No one",-999}

data.crimtoppts1 = {"No one",-999}
data.crimtoppts2 = {"No one",-999}
data.crimtoppts3 = {"No one",-999}
data.crimtoppts4 = {"No one",-999}
data.crimtoppts5 = {"No one",-999}
data.crimtopkills1 = {"No one",-999}
data.crimtopkills2 = {"No one",-999}
data.crimtopkills3 = {"No one",-999}
data.crimtopkills4 = {"No one",-999}
data.crimtopkills5 = {"No one",-999}


crateTable = {}

objects = { }
kills = {}
points = {}
gaveStars = {}

timeTillActuallyReady=3600

--billboards
createObject ( 1259, -2422.5, 2227.8999023438, 12, 0, 0, 150 )
createObject ( 7900, -2421.6999511719, 2228.5, 18.200000762939, 0, 0, 60 )
createObject ( 1259, -1826.4000244141, 40.700000762939, 15, 0, 0, 180 )
createObject ( 7900, -1826.5, 41.599998474121, 21.299999237061, 0, 0, 90 )
--
function stopCargoFunc()
	stopObject(hull)
end
addEvent("stopCargo", true)
addEventHandler("stopCargo", root, stopCargoFunc)

function cargoMove(xD, yD, zD,tim)
	--[[
	local x,y,z = getElementPosition(hull)
	moveObject(hull, 3000, x + xD, y + yD, z + zD) --]]
	for k,v in pairs(objects) do
		local x,y,z = getElementPosition(v)
		moveObject(v,tim*1000,x + xD, y + yD, z + zD)
	end
end
addEvent("cargoMoveEvent", true)
addEventHandler("cargoMoveEvent", root, cargoMove)

function cargoMoveTo(xD, yD, zD,tim)
	local x,y,z = getElementPosition(hull)
	moveObject(hull, tim*1000, xD,yD, z + zD)
end

-- Rotational Movement Controls
function cargoRotateFunc(rX, rY, rZ)

	local x,y,z = getElementPosition(hull)
	moveObject(hull, 20000, x, y, z, rX, rY, rZ)

end
addEvent("cargoRotate", true)
addEventHandler("cargoRotate", root, cargoRotateFunc)


NW = function() cargoMove(-160, 160, 0) end
N = function() cargoMove(0, 160, 0) end
NE = function() cargoMove(160, 160, 0) end
E = function() cargoMove(160, 0, 0) end
SE = function() cargoMove(160, -160, 0) end
S = function() cargoMove(0, -160, 0) end
SW = function() cargoMove(-160, -160, 0) end
W = function () cargoMove(-160, 0, 0) end
NWr = function() cargoRotateFunc(0, 0, 45) end
NEr = function() cargoRotateFunc(0, 0, -45) end
Er = function() cargoRotateFunc(0, 0, -90) end
Wr = function() cargoRotateFunc(0, 0, 90) end
stop = function() stopCargoFunc() end

E()

local pos = {
	{
		[1] = {2548.84, -2850.56,0,18},
		--[12] = { 2724.08, -2624.85,0,3},
		[55] = {2548.42, -2682.04,0,3},
	}
}

local count = 0
local readyToLeaveLS = false
local leftLS = false
local started = false
local readyToLeaveLS = false
local allDied = false

local vehPos = {
	{ -2400.52, 2213.74, 4.98, 84 },
	{ -2399.67, 2219.28, 4.98, 90 },
	{ -2413.4, 2223.94, 4.98, 69 },
	{ -2415.8, 2212.78, 4.98,90},
	{ -2389.49, 2217.05, 4.98, 86},
	{ -2431.53, 2234.37, 4.98 , 358},
}
local vehs = {}

local vehModels = {440,482}

function arrivedSF()
	if started == false then return end
	if loadedCrates > 0 then
		for i=1,loadedCrates do
			local veh = createVehicle(vehModels[math.random(1,#vehModels)],vehPos[i][1],vehPos[i][2],vehPos[i][3],0,0,vehPos[i][4])
			table.insert(vehs,veh)
		end
		DFmarker = createMarker( -1826.34, 28.5, 15.12,"checkpoint",3,255,255,0,100)
		addEventHandler("onMarkerHit",DFmarker,hitDFmarker)
	end
end

local got25pts = {}

function hitDFmarker(e,bool)
	if bool == true then
		if getElementType(e) == "vehicle" then
			local valid=false
			for k,p in pairs(getVehicleOccupants(e)) do
				if isElement(p) then
					local accName = exports.server:getPlayerAccountName(p)
					if got25pts[accName]==nil or got25pts[accName]==false then
						for k,v in pairs(vehs) do if e == v then valid=true end end
						if valid==false then return end
							exports.DENdxmsg:createNewDxMessage(p,"You got +25 extra drug points for delivering a drug van!",0,255,0)
							points[accName]=points[accName]+25
							got25pts[accName] = true
					else
						exports.DENdxmsg:createNewDxMessage(p,"You already got +25 extra drug points for delivering a drug van!",255,0,0)
						exports.DENdxmsg:createNewDxMessage(p,"You can only deliver one drug van!",255,0,0)
					end
				end
			end
			if valid == true then
				sendUpdatedData()
				destroyElement(e)
			end
		end
	end
end

function doShip()
	if timeTillActuallyReady > 0 then timeTillActuallyReady=timeTillActuallyReady-1 return end

	count = count+1
	if count == 1 then
	createBlipAttachedTo(hull,24)
setTimer(function()
for k,v in pairs(getElementsByType("player")) do
	triggerClientEvent(v,"CSGdrugEvent.playHorn",v)
end
warnCriminals("The Drug Ship is heading for LS!")
warnCriminals("Look for D on your map!")
warnCriminals("Drup Ship arriving at LS Docks in 30 seconds!")
end,5000,1)
	end
	if count == 20 then
		Er()
	end
	if pos[1][count] ~= nil then
		cargoMoveTo(pos[1][count][1],pos[1][count][2],0,pos[1][count][4])
	end
	--if count == 30 then readyToLeaveLS=true end
	if readyToLeaveLS == true and leftLS == false then
		for k,v in pairs(crateTable) do
			if isElement(v) then
				detachElements(v)
				destroyElement(v)
			end
		end
		setTimer(arrivedSF,380000,1)
		timeTillArriveSF=400
		setTimer(function() timeTillArriveSF = timeTillArriveSF - 1 end,1000,400)
		leftLS=true
		cargoMoveTo(2548.42, -2986.83,0,20)
		setTimer(function()
			Er()
			setTimer(function() cargoMoveTo(-2923.68, -3095.16 ,0,100)
				setTimer(function()
					Er()
					setTimer(function() cargoMoveTo( -3142.75, 1714.4 ,0,100)
						setTimer(function()
							Er()
							setTimer(function() cargoMoveTo(-2321.57, 2032.92,0,40)
								setTimer(function()
									Wr()
									setTimer(function() cargoMoveTo( -2350.85, 2165.43,0,10)
									end,20000,1)
								end,56000,1)
							end,23000,1)
						end,106000,1)
					end,23000,1)
				end,106000,1)
			end,23000,1)
		end,21000,1)
	end
end


function createObject2(m,x,y,z,rx,ry,rz)
	x=x+804
	y=y-608
	if (rx) then else rx,ry,rz=0,0,0 end
	table.insert(objects,createObject(m,x,y,z,rx,ry,rz))
end

createObject2 ( 10794, 379.69921875, -2296.19921875, 3.9000000953674 )
createObject2 ( 10795, 377.69921875, -2296.19921875, 13.800000190735 )
createObject2 ( 3406, 369.39999390, -2277.50000000, -2.00000000 )
createObject2 ( 3406, 369.39999390, -2276.50000000, -2.00000000 )
createObject2 ( 5158, 285.60000610352, -2296.5, 13.699999809265, 0, 0, 90 )
createObject2 ( 5155, 309.60000610352, -2296.1000976563, 23.10000038147 )
createObject2 ( 8661, 306.10000610352, -2300.6000976563, 13 )
createObject2 ( 8661, 306.10000610352, -2291.6999511719, 13.010000228882 )
createObject2 ( 8077, 342.10000610352, -2305.1000976563, 17.10000038147, 0, 0, 90 )
createObject2 ( 8077, 342.099609375, -2288, 17.10000038147, 0, 0, 90 )
createObject2 ( 8886, 337.39999389648, -2296.3999023438, 16.5 )
createObject2 ( 944, 343.20001220703, -2298.3999023438, 14, 0, 0, 90 )
createObject2 ( 944, 343.10000610352, -2297.6000976563, 15.39999961853, 0, 0, 90 )
createObject2 ( 944, 343.20001220703, -2295.3999023438, 14, 0, 0, 90 )
createObject2 ( 3798, 345.60000610352, -2298.8000488281, 13.10000038147 )
createObject2 ( 3799, 354.10000610352, -2301.1000976563, 13.10000038147 )
createObject2 ( 1685, 343.10000610352, -2295, 15.300000190735, 0, 0, 90 )--
createObject2 ( 3565, 457.5, -2306.1000976563, 14.39999961853 )
createObject2 ( 3565, 457.5, -2303.5, 14.39999961853 )
createObject2 ( 3565, 457.5, -2300.8999023438, 14.39999961853 )
createObject2 ( 3565, 457.5, -2304.8999023438, 17.10000038147 )
createObject2 ( 3565, 457.39999389648, -2298.3000488281, 14.39999961853 )
createObject2 ( 3565, 457.5, -2295.6999511719, 14.39999961853 )
createObject2 ( 3565, 457.39999389648, -2293.1999511719, 14.39999961853 )
createObject2 ( 3565, 457.39999389648, -2302.3999023438, 17.10000038147 )
createObject2 ( 3565, 457.39999389648, -2290.6000976563, 14.39999961853 )
createObject2 ( 3565, 457.39999389648, -2288, 14.39999961853 )
createObject2 ( 3565, 457.39999389648, -2285.3999023438, 14.39999961853 )
createObject2 ( 3565, 457.39999389648, -2299.8000488281, 17.10000038147 )
createObject2 ( 3565, 457.39999389648, -2297.3000488281, 17.10000038147 )
createObject2 ( 3565, 457.39999389648, -2294.6999511719, 17.10000038147 )
createObject2 ( 3565, 457.39999389648, -2292.1999511719, 17.10000038147 )
createObject2 ( 3565, 457.39999389648, -2289.6000976563, 17.10000038147 )
createObject2 ( 3565, 457.39999389648, -2287, 17.10000038147 )
createObject2 ( 3633, 376.5, -2296.1999511719, 13.60000038147 )
createObject2 ( 3576, 401, -2305.8000488281, 14.60000038147 )
createObject2 ( 3576, 401, -2302.6999511719, 14.60000038147 )
createObject2 ( 3577, 401.39999389648, -2299.1999511719, 13.89999961853 )
createObject2 ( 7040, 369.79998779297, -2292.5, 16.5, 0, 0, 90 )
createObject2 ( 7025, 356.79998779297, -2287.8999023438, 16.5, 0, 0, 90 )

--ramp 1
local horizontalPlate = createObject( 2395, 2528, -2667.48, 14, -90)
local shipRamp = createObject( 2395, 0,0,0)
local docksRamp = createObject( 2395, 0,0,0)
attachElements(shipRamp, horizontalPlate,3.5, 0.2,0,0,0,20)
attachElements(docksRamp, horizontalPlate,-3.3, 1.1,0,0,0,-20)
--ramp 2
  horizontalPlate = createObject( 2395, 2528, -2671.48, 14, -90)
  shipRamp = createObject( 2395, 0,0,0)
  docksRamp = createObject( 2395, 0,0,0)
attachElements(shipRamp, horizontalPlate,3.5, 0.2,0,0,0,20)
attachElements(docksRamp, horizontalPlate,-3.3, 1.1,0,0,0,-20)

local mx,my,mz = getElementPosition(objects[1])
local mrx,mry,mrz = getElementRotation(objects[1])
hull = objects[1]
--make the blip


--col
local x,y = getElementPosition(hull)
local lawparticipation={}
local freegiven = {}
--[[
blip = exports.customblips:createCustomBlip(x,y,50,50,"blip.jpg",99999)
setTimer(function()
	local x,y = getElementPosition(hull)
	exports.customblips:setCustomBlipPosition(blip,x,y)
end,500,0) --]]
shipCol = createColCircle(x,y,200)
attachElements(shipCol,hull)
shipCol2 = createColRectangle(x,y,35,225)
addEventHandler("onColShapeHit",root,function(thePlayer,bool)
	if source ~= shipCol then return end
	if getElementType(thePlayer) ~= "player" then return end
	if bool == true then
		if (doesPedHaveJetPack(thePlayer)) == true then
			removePedJetPack(thePlayer)
			exports.DENdxmsg:createNewDxMessage(thePlayer,"Jetpack Removed - Not allowed in Drug Shipment Zone",255,0,0)
		end
		if started==true then
			if gaveStars[thePlayer] == nil or gaveStars[thePlayer] == false then
				if getTeamName(getPlayerTeam(thePlayer)) == "Criminals" then
					exports.CSGwanted:addWanted(thePlayer,32,false)
					if points[exports.server:getPlayerAccountName(thePlayer)] == nil then points[exports.server:getPlayerAccountName(thePlayer)] = 0 end
					if getPedArmor(thePlayer) < 50 then
						setPedArmor(thePlayer,50)
					end
					--points[thePlayer] = points[thePlayer]+10
					--sendUpdatedData()
					gaveStars[thePlayer] = true
				end
				exports.DENstats:setPlayerAccountData(thePlayer,"drugshipmentcrim",exports.denstats:getPlayerAccountData(thePlayer,"drugshipmentcrim")+1)
			end
			if isLaw(thePlayer) then
				if lawparticipation[exports.server:getPlayerAccountName(thePlayer)]==nil then
					exports.DENstats:setPlayerAccountData(thePlayer,"drugshipmentlaw",exports.denstats:getPlayerAccountData(thePlayer,"drugshipmentlaw")+1)
					lawparticipation[exports.server:getPlayerAccountName(thePlayer)]=true
				return
				end
				exports.DENdxmsg:createNewDxMessage(thePlayer,"The Drug Shipment is occuring!",255,0,0)
				exports.DENdxmsg:createNewDxMessage(thePlayer,"Unload the crates and Kill all criminals!",255,0,0)
				if not (freegiven[exports.server:getPlayerAccountName(thePlayer)]) then
					freegiven[exports.server:getPlayerAccountName(thePlayer)]=true
					if points[exports.server:getPlayerAccountName(thePlayer)] == nil then points[exports.server:getPlayerAccountName(thePlayer)] = 0 end
					points[exports.server:getPlayerAccountName(thePlayer)]=points[exports.server:getPlayerAccountName(thePlayer)]+50
					exports.DENdxmsg:createNewDxMessage(thePlayer,"+ 50 Drug Points for participating in Drug Shipment",255,0,0)

				end

			else

				exports.DENdxmsg:createNewDxMessage(thePlayer,"The Drug Shipment is in progress!",255,0,0)
				exports.DENdxmsg:createNewDxMessage(thePlayer,"Load the drug crates and protect the boat!",255,0,0)
				exports.DENdxmsg:createNewDxMessage(thePlayer,"/drugtime for information",255,0,0)
				if getTeamName(getPlayerTeam(thePlayer)) == "Criminals" and not (freegiven[exports.server:getPlayerAccountName(thePlayer)]) then
					freegiven[exports.server:getPlayerAccountName(thePlayer)]=true
					if points[exports.server:getPlayerAccountName(thePlayer)] == nil then points[exports.server:getPlayerAccountName(thePlayer)] = 0 end
					points[exports.server:getPlayerAccountName(thePlayer)]=points[exports.server:getPlayerAccountName(thePlayer)]+50
					exports.DENdxmsg:createNewDxMessage(thePlayer,"+ 50 Drug Points for participating in Drug Shipment",255,0,0)
				end

			end
		else
				if isLaw(thePlayer) == false then
					exports.DENdxmsg:createNewDxMessage(thePlayer,"This is the Drug Shipment Area",255,0,0)
					exports.DENdxmsg:createNewDxMessage(thePlayer,"5 Criminals must be on the ship to start the shipment!",255,0,0)
				else
					exports.DENdxmsg:createNewDxMessage(thePlayer,"This is the Drug Shipment Area",255,0,0)
					exports.DENdxmsg:createNewDxMessage(thePlayer,"Leave this area, the shipment has not started yet!",255,0,0)
				end

		end
	end
end)
attachElements(shipCol2,hull,110,-23)
remainingCrates = 6
loadedCrates = 0
timeLeft=30
started=false
setTimer(function()
	if started == true then
		timeTillLeaveLS = timeTillLeaveLS-1
		data.depTime=data.depTime-1
		if timeTillLeaveLS == 60 then
			warnCriminals("The Drug Ship is leaving LS in 1 minute!")
			warnLaw("1 Minute until the Drug Ship heads for SF!")
		end
		if timeTillLeaveLS <= 0 then
			for k,v in pairs(getElementsWithinColShape(shipCol2,"vehicle")) do
				for k2,v2 in pairs(getVehicleOccupants(v)) do
					removePedFromVehicle(v2,v)
				end
			end
		readyToLeaveLS = true end
	end
	if started==false and timeLeft <= 0 and timeTillActuallyReady<=0 and leftLS == false then
		local t = getElementsWithinColShape(shipCol2)
		local crimsC=0
		local crims={}
		for k,v in pairs(t) do
			if getElementType(v) == "player" then
			if getTeamName(getPlayerTeam(v)) == "Criminals" then
				crimsC=crimsC+1
				table.insert(crims,v)
			end
			end
		end
		if crimsC >= 5 then

			for k,v in pairs(getElementsWithinColShape(shipCol,"player")) do
				if (doesPedHaveJetPack(v)) == true then
					if isElementWithinColShape(shipCol) == true then
						removePedJetPack(v)
						exports.DENdxmsg:createNewDxMessage(v,"Jetpack Removed - Not allowed in Drug Shipment Zone",255,0,0)
					end
				end
			end
			timeTillReset=1800
			setTimer(function()
				timeTillReset=timeTillReset-1
				if timeTillReset <= 0 then restart() end
			end,1000,0)
			for k,v in pairs(getElementsByType("player")) do
				triggerClientEvent(v,"CSGdrugEvent.playHorn",v)
				triggerClientEvent(v,"CSGdrugEvent.recBoatCol",v,shipCol)
			end
			started=true
			timeTillLeaveLS=300
			data.depTime=300
			warnCriminals("The Drug Shipment has started!")
			warnCriminals("Protect the drug boat and load the crates within 5 minutes!")
			warnLaw("The Criminals have started a Drug Shipment!")
			warnLaw("Kill the Criminals and prevent the drug smuggling!")

			for k,v in pairs(getElementsWithinColShape(shipCol)) do
				if getElementType(v) == "vehicle" then
					local p = getVehicleController(v)
					if isElement(p) and getElementType(p) == "player" then
						if getTeamName(getPlayerTeam(p)) == "Criminals" then
							if points[exports.server:getPlayerAccountName(p)] == nil then points[exports.server:getPlayerAccountName(p)] = 0 end
							points[exports.server:getPlayerAccountName(p)] = points[exports.server:getPlayerAccountName(p)]+10
							exports.CSGwanted:addWanted(p,32,false)
							if getPedArmor(p) < 50 then
								setPedArmor(p,50)
							end
							local thePlayer=p
							if not (freegiven[exports.server:getPlayerAccountName(thePlayer)]) then
								freegiven[exports.server:getPlayerAccountName(thePlayer)]=true
								if points[exports.server:getPlayerAccountName(thePlayer)] == nil then points[exports.server:getPlayerAccountName(thePlayer)] = 0 end
									points[exports.server:getPlayerAccountName(thePlayer)]=points[exports.server:getPlayerAccountName(thePlayer)]+50
									exports.DENdxmsg:createNewDxMessage(thePlayer,"+ 50 Drug Points for participating in Drug Shipment",255,0,0)

							end
							sendUpdatedData()
							gaveStars[p] = true
						end
					end
				else
					if getElementType(v) == "player" then
						if getTeamName(getPlayerTeam(v)) == "Criminals" then
							exports.CSGwanted:addWanted(v,32,false)
							if getPedArmor(v) < 50 then
								setPedArmor(v,50)
							end
							local thePlayer=v
							if not (freegiven[exports.server:getPlayerAccountName(thePlayer)]) then
								freegiven[exports.server:getPlayerAccountName(thePlayer)]=true
								if points[exports.server:getPlayerAccountName(thePlayer)] == nil then points[exports.server:getPlayerAccountName(thePlayer)] = 0 end
									points[exports.server:getPlayerAccountName(thePlayer)]=points[exports.server:getPlayerAccountName(thePlayer)]+50
									exports.DENdxmsg:createNewDxMessage(thePlayer,"+ 50 Drug Points for participating in Drug Shipment",255,0,0)

							end
							gaveStars[v] = true
							sendUpdatedData()
						end
					end
				end
			end
			sendUpdatedData()
		else
			for k,v in pairs(getElementsWithinColShape(shipCol2)) do
				if getElementType(v) == "player" then
					exports.dendxmsg:createNewDxMessage(v,"Not enough Criminals to start Drug Shipment! 5 Needed.",255,0,0)
				end
			end
			timeLeft=30
		end
	end
end,1000,0)

local lawTeams = {
	"Military Forces",
	"SWAT",
	"Police",
	"Government Agency",
}

function isLaw(e)
	local team = getTeamName(getPlayerTeam(e))
	for k,v in pairs(lawTeams) do if v == team then return true end end
	return false
end

addCommandHandler("jetpack",function(v)
	if isElement(shipCol) and isElement(shipCol2) then else return end
	if isElementWithinColShape(v,shipCol2) == true or isElementWithinColShape(v,shipCol) == true then
		if doesPedHaveJetPack(v) == true then
			removePedJetPack(v)
			exports.DENdxmsg:createNewDxMessage(v,"Jetpack Removed - Not allowed in Drug Shipment Zone",255,0,0)
		end
	end
end)

function recalcTops()


	data.lawtoppts1 = {"No one",0}
data.lawtoppts2 = {"No one",0}
data.lawtoppts3 = {"No one",0}
data.lawtoppts4 = {"No one",0}
data.lawtoppts5 = {"No one",0}
data.lawtopkills1 = {"No one",0}
data.lawtopkills2 = {"No one",0}
data.lawtopkills3 = {"No one",0}
data.lawtopkills4 = {"No one",0}
data.lawtopkills5 = {"No one",0}

data.crimtoppts1 = {"No one",0}
data.crimtoppts2 = {"No one",0}
data.crimtoppts3 = {"No one",0}
data.crimtoppts4 = {"No one",0}
data.crimtoppts5 = {"No one",0}
data.crimtopkills1 = {"No one",0}
data.crimtopkills2 = {"No one",0}
data.crimtopkills3 = {"No one",0}
data.crimtopkills4 = {"No one",0}
data.crimtopkills5 = {"No one",0}
	for k,v in pairs(points) do
		if isElement(k) then
		if isLaw(k) then
			if v > data.lawtoppts1[2] then
				data.lawtoppts1 = {getPlayerName(k),v}
			elseif v > data.lawtoppts2[2] then
				data.lawtoppts2 = {getPlayerName(k),v}
			elseif v > data.lawtoppts3[2] then
				data.lawtoppts3 = {getPlayerName(k),v}
			elseif v > data.lawtoppts4[2] then
				data.lawtoppts4 = {getPlayerName(k),v}
			elseif v > data.lawtoppts5[2] then
				data.lawtoppts5 = {getPlayerName(k),v}
			end
		else
			if v > data.crimtoppts1[2] then
				data.crimtoppts1 = {getPlayerName(k),v}
			elseif v > data.crimtoppts2[2] then
				data.crimtoppts2 = {getPlayerName(k),v}
			elseif v > data.crimtoppts3[2] then
				data.crimtoppts3 = {getPlayerName(k),v}
			elseif v > data.crimtoppts4[2] then
				data.crimtoppts4 = {getPlayerName(k),v}
			elseif v > data.crimtoppts5[2] then
				data.crimtoppts5 = {getPlayerName(k),v}
			end
		end
		end
	end
	for k,v in pairs(kills) do
		if isElement(k) then
		if isLaw(k) then
			if v > data.lawtopkills1[2] then
				data.lawtopkills1 = {getPlayerName(k),v}
			elseif v > data.lawtopkills2[2] then
				data.lawtopkills2 = {getPlayerName(k),v}
			elseif v > data.lawtopkills3[2] then
				data.lawtopkills3 = {getPlayerName(k),v}
			elseif v > data.lawtopkills4[2] then
				data.lawtopkills4 = {getPlayerName(k),v}
			elseif v > data.lawtopkills5[2] then
				data.lawtopkills5 = {getPlayerName(k),v}
			end
		else
			if v > data.crimtopkills1[2] then
				data.crimtopkills1 = {getPlayerName(k),v}
			elseif v > data.crimtopkills2[2] then
				data.crimtopkills2 = {getPlayerName(k),v}
			elseif v > data.crimtopkills3[2] then
				data.crimtopkills3 = {getPlayerName(k),v}
			elseif v > data.crimtopkills4[2] then
				data.crimtopkills4 = {getPlayerName(k),v}
			elseif v > data.crimtopkills5[2] then
				data.crimtopkills5 = {getPlayerName(k),v}
			end
		end
		end
	end
	sendUpdatedData()
end

addEventHandler("onPlayerWasted",root,function(_,killer)
	if isElementWithinColShape(source,shipCol) == false then return end
	if kills[killer] == nil then kills[killer] = 0 end
	if points[exports.server:getPlayerAccountName(killer)] == nil then points[exports.server:getPlayerAccountName(killer)] = 0 end

	if isLaw(killer) then
		if isLaw(source) == true then return end
		if getTeamName(getPlayerTeam(source)) ~= "Criminals" then return end
		local pts = getElementData(source,"wantedPoints")
		if pts > 50 then
			points[exports.server:getPlayerAccountName(killer)]=points[exports.server:getPlayerAccountName(killer)]+20
		end
		if pts > 70 then
			points[exports.server:getPlayerAccountName(killer)]=points[exports.server:getPlayerAccountName(killer)]+10
		end
		if pts > 90 then
			points[exports.server:getPlayerAccountName(killer)]=points[exports.server:getPlayerAccountName(killer)]+10
		end
		if getElementData(killer,"skill") == "Drug Squad" then
			points[killer]=points[exports.server:getPlayerAccountName(killer)]+10
		end
		kills[killer]=kills[killer]+1
		givePlayerMoney(killer,4000)
	else
		if getTeamName(getPlayerTeam(killer)) ~= "Criminals" then return end
		if isLaw(source) then
			points[exports.server:getPlayerAccountName(killer)]=points[exports.server:getPlayerAccountName(killer)]+15
			kills[killer]=kills[killer]+1
			givePlayerMoney(killer,3000)
		end
	end
	exports.CSGscore:givePlayerScore(killer,1.5)
	exports.dendxmsg:createNewDxMessage(source,"Drug Shipment: You died! You can still go back in attempt to get more drug points if you dare!",0,255,0)
	recalcTops()
	sendUpdatedData()
end)

function getLawTable()
	local law = {}
	for k,v in pairs (lawTeams) do
		local list = getPlayersInTeam(getTeamFromName(v))
		for k,v in pairs(list) do
			table.insert(law,v)
		end
	end
	return law
end

function warnLaw(msg)
	local law = getLawTable()
	for k,v in pairs(law) do
		-- exports.DENdxmsg:createNewDxMessage(v,"---Notice---",0,255,0)
		 exports.DENdxmsg:createNewDxMessage(v,msg,0,255,0)
	end
end

function warnCriminals(msg)
	local list = getPlayersInTeam(getTeamFromName("Criminals"))
	for k,v in pairs(list) do
		 exports.DENdxmsg:createNewDxMessage(v,msg,255,0,0)
	end
end
setTimer(function() timeLeft=timeLeft-1 end,1000,0)
--setTimer(function() triggerClientEvent(root,"CSGdrugEvent.recBoatCol",root,shipCol) end,5000,1)
addEventHandler("onPlayerLogin",root,function() if started==false then return end
	triggerClientEvent(source,"CSGdrugEvent.recBoatCol",source,shipCol)
	sendUpdatedData(source)
	end)

for k,v in pairs(objects) do
	if k ~= 1 then
		local x,y,z = getElementPosition(v)
		local rx,ry,rz = getElementRotation(v)
		attachElements(v,hull,x-mx,y-my,z-mz,rx-mrz,ry-mry,rz-mrz)
	end
end

setTimer(doShip,1000,0)

local initialCratesTable = {
{2517.83, -2684.12, 13.44},
{2519.66, -2683.99, 13.44},
{2521.4, -2683.93, 13.43},
{2523.46, -2684.12, 13.43},
{2507.79, -2686.26, 13.43},
{2510.61, -2686.11, 13.43},
}

function initialCrates ()
	for i=1, #initialCratesTable do
		local crate = createObject(1685, initialCratesTable[i][1],initialCratesTable[i][2],initialCratesTable[i][3])
		setElementData(crate, "X", initialCratesTable[i][1])
		setElementData(crate, "Y", initialCratesTable[i][2])
		setElementData(crate, "Z", initialCratesTable[i][3])
		table.insert(crateTable,crate)
	end
end
initialCrates()

function pickCrate (crate)
	local p = getVehicleController(source)
	if isLaw(p) == false then
		if getTeamName(getPlayerTeam(p)) ~= "Criminals" then
			exports.dendxmsg:createNewDxMessage(p,"You cannot pick a drug crate! Only criminals or law can",255,0,0)
			triggerClientEvent(p,"cancelPickCrate",p,source,crate)
			return
		end
	end
	if isElementWithinColShape(source,shipCol2) == true then
		if isLaw(p) == false then
			exports.dendxmsg:createNewDxMessage(p,"You cannot unload a crate thats already on the boat, only Law can!",255,0,0)
			triggerClientEvent(p,"cancelPickCrate",p,source,crate)
			return
		else

		end
	end

	if started==false then
		if isElement(p) then
			triggerClientEvent(p,"cancelPickCrate",p,source,crate)
			exports.dendxmsg:createNewDxMessage(p,"You cannot load the crate! Drug shipment has not started yet",255,0,0)
			return
		end
	end
	attachElements(crate, source, 0, 1, 0.5)
	if isElementWithinColShape(p,shipCol2) then
		remainingCrates=remainingCrates+1
		loadedCrates=loadedCrates-1
		if isLaw(p) then
			--points[p]=points[p]+30
		else

		end
		recalcTops()
		data.remainingCrates=remainingCrates
		data.loadedCrates=loadedCrates
		sendUpdatedData()
	end
end
addEvent("pickCrate", true)
addEventHandler("pickCrate", root, pickCrate)

function dropCrate ()
	if isElement(source) then
	local rx,ry,rz = getElementRotation(source)
	local veh = getElementAttachedTo(source)
	if isElement(veh) then
	detachElements(source)
	attachElements(source, veh, 0,2,0)
	detachElements(source)
	setElementRotation(source, rx, ry, rz)
	local x,y,z = getElementPosition(source)
	local mx,my,mz = getElementPosition(hull)
	local mrx,mry,mrz = getElementRotation(hull)
	attachElements(source,hull,x-mx,y-my,z-mz,rx-mrz,ry-mry,rz-mrz)
	if isElement(veh) == false then return end
	p = getVehicleController(veh)
	if isElement(p) == false then return end
	if isElementWithinColShape(p,shipCol2) == true then
		warnCriminals(""..getPlayerName(p).." has loaded a drug crate onto the ship!")
		if points[exports.server:getPlayerAccountName(p)] == nil then points[exports.server:getPlayerAccountName(p)] = 0 end
		points[exports.server:getPlayerAccountName(p)]=points[exports.server:getPlayerAccountName(p)]+50
		recalcTops()
		remainingCrates=remainingCrates-1
		loadedCrates=loadedCrates+1
		data.remainingCrates=remainingCrates
		data.loadedCrates=loadedCrates
		sendUpdatedData()
		warnCriminals("So far: "..remainingCrates.." drug crates remaining!")
	end
	end
	end
end
addEvent("dropCrate", true)
addEventHandler("dropCrate", root, dropCrate)

sendTimer=false
function sendUpdatedData(p)
	if (p) then
		if points[exports.server:getPlayerAccountName(p)] == nil then points[exports.server:getPlayerAccountName(p)] = 0 end
		if kills[p] == nil then kills[p] = 0 end
		data.mykills=kills[p]
		data.mypoints=points[exports.server:getPlayerAccountName(p)]
		triggerClientEvent(p,"CSGdrugEvent.recData",p,d)
	else
		if isTimer(sendTimer) == true then return end
		sendTimer=setTimer(function()
			for k,v in pairs(getElementsByType("player")) do
				local d = data
				if points[exports.server:getPlayerAccountName(v)] == nil then points[exports.server:getPlayerAccountName(v)] = 0 end
				if kills[v] == nil then kills[v] = 0 end
				data.mykills=kills[v]
				data.mypoints=points[exports.server:getPlayerAccountName(v)]
				triggerClientEvent(v,"CSGdrugEvent.recData",v,d)
			end
		end,1000,1)
	end
end

setTimer(function()
	if started==true and (timeTillArriveSF==nil or timeTillArriveSF>0) then
		local crimCount = 0
		for k,v in pairs(getElementsWithinColShape(shipCol)) do
			if isElement(v) == true then
				if getElementType(v) == "vehicle" then
					local p = getVehicleController(v)
					if isElement(p) then
						if getTeamName(getPlayerTeam(p)) == "Criminals" then
							crimCount=crimCount+1
						end
					end
				elseif getElementType(v) == "player" then
					if getTeamName(getPlayerTeam(v)) == "Criminals" then
						crimCount=crimCount+1
					end
				end
			end
		end
		if crimCount==0 then
			allDied=true
			exports.dendxmsg:createNewDxMessage(root,"All criminals on the ship have died!",0,255,0)
			exports.dendxmsg:createNewDxMessage(root,"The drug shipment can no longer continue!",0,255,0)
			exports.dendxmsg:createNewDxMessage(root,"Redeem your drug shipment points at the drug factory!",0,255,0)
			started=false
		end
	end
end,1000,0)
setTimer(function()
	for k,v in pairs(points) do
		if isElement(k) then
		if v > 0 then
			if timeTillReset == nil then timeTillReset=30 end
			exports.dendxmsg:createNewDxMessage(k,""..getPlayerName(k).." you have "..v.." drug points!",0,255,0)
			exports.dendxmsg:createNewDxMessage(k,"Redeem them at the drug factory, you only have "..timeTillReset.." seconds left!",0,255,0)
		end
		end
	end
end,180000,0)

function restart()
	exports.dendxmsg:createNewDxMessage(root,"The Drug Shipment is now over! You can no longer redeem your drug points!",0,255,0)
	local res = getResourceFromName("CSGdrugEvent")
	restartResource(res)
end
addCommandHandler("resdrug",restart)

--addCommandHandler("startdrug",function() started=true end)

addCommandHandler("drugtime",function(ps)
	if timeTillActuallyReady>0 then
		if timeTillActuallyReady>60 then
			local minutes = math.floor(timeTillActuallyReady/60)
			exports.dendxmsg:createNewDxMessage(ps,"The next Drug Shipment (LS Docks) can be done in "..minutes.." minutes!",0,255,0)
		else
			exports.dendxmsg:createNewDxMessage(ps,"The next Drug Shipment (LS Docks) can be done in "..timeTillActuallyReady.." seconds!",0,255,0)
		end
	return
	end
	if started == false and leftLS == false and allDied == false then
		exports.dendxmsg:createNewDxMessage(ps,"Drug Shipment (LS Docks) can be started in "..timeLeft.." seconds!",255,0,0)
	else
		if leftLS==false and started==true then
		exports.dendxmsg:createNewDxMessage(ps,"The Drug Shipment is occuring rightnow (LS Docks), drugs are being smuggled!",255,0,0)
		elseif allDied == false and leftLS==true and timeTillArriveSF > 0 and started == true then
		exports.dendxmsg:createNewDxMessage(ps,""..timeTillArriveSF.." seconds until Drug Shipment Boat arrives in San Fierro",255,255,0)
		elseif allDied == true or timeTillArriveSF <= 0 then
			exports.dendxmsg:createNewDxMessage(ps,"The Drug Shipment just recently finished.",0,255,0)
			if timeTillReset > 60 then
			local minutes = timeTillReset
			minutes=math.floor(minutes/60)
			exports.dendxmsg:createNewDxMessage(ps,"You have "..minutes.." minutes to redeem your drug points at the drug factory!",0,255,0)
			else
			exports.dendxmsg:createNewDxMessage(ps,"You have "..timeTillReset.." seconds to redeem your drug points at the drug factory!",0,255,0)
			end
		end
	end
end)

addEvent("CSGdrugEvent.bought",true)
addEventHandler("CSGdrugEvent.bought",root,function(name,am,cost)
	if points[exports.server:getPlayerAccountName(source)] == nil then return end
	exports.CSGdrugs:giveDrug(source,name,am)
	exports.dendxmsg:createNewDxMessage(source,"You have exchanged "..cost.." drug points for "..am.." "..name.."",0,255,0)

	points[exports.server:getPlayerAccountName(source)]=points[exports.server:getPlayerAccountName(source)]-cost
	if points[source] == 0 then
		exports.CSGscore:givePlayerScore(source,4)
		exports.dendxmsg:createNewDxMessage(source,"You got +5 Score for redeeming all your drug points!",0,255,0)
	end
end)

canSpawnVeh=true
local spawnedvehs = {}
function hitVehMarker(e)
	if getElementType(e) ~= "player" then return end
	if isPedInVehicle(e) == true then return end
	if canSpawnVeh == false then exports.dendxmsg:createNewDxMessage(e,"Please wait a few seconds before another fork lift can be spawned",255,255,0) return end
	canSpawnVeh=false
	setTimer(function() canSpawnVeh=true end,8000,1)
	if spawnedvehs[e] ~= nil then if isElement(spawnedvehs[e]) then destroyElement(spawnedvehs[e]) end end
	local veh = createVehicle(getVehicleModelFromName("Forklift"),getElementPosition(e))
	spawnedvehs[e] = veh
	warpPedIntoVehicle(e,veh)
end
addEventHandler("onPlayerQuit",root,function() if spawnedvehs[source] ~= nil then destroyElement(spawnedvehs[source]) end end)

local m = createMarker( 2505.77, -2674.83, 12.64,"cylinder",2,255,255,0)
addEventHandler("onMarkerHit",m,hitVehMarker)

addCommandHandler("setdruglefttime",function(ps,cmdname,tim) timeTillActuallyReady=tonumber(tim) end)
