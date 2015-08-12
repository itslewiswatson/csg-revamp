local cells = {}
local open={}

local cellSpace={
{x=915.27, y=-2452.73,z=5703.9125976562,rx=0,ry=0,rz=228.15380859375},
{x=915.2392578125,y=-2447.9853515625,z=5703.9111328125,rx=0,ry=0,rz=107.75830078125},
{x=915.6396484375,y=-2443.1123046875,z=5703.9111328125,rx=0,ry=0,rz=97.183807373047},
{x=915.2744140625,y=-2438.607421875,z=5703.9111328125,rx=0,ry=0,rz=94.360260009766},
{x=915.38586425781,y=-2433.7907714844,z=5703.908203125,rx=0,ry=0,rz=55.193420410156},
{x=915.47766113281,y=-2428.8347167969,z=5703.908203125,rx=0,ry=0,rz=95.618225097656},
{x=915.68957519531,y=-2424.1364746094,z=5703.908203125,rx=0,ry=0,rz=87.784851074219},
{x=915.84765625,y=-2424.1015625,z=5700.4287109375,rx=0,ry=0,rz=87.757385253906},
{x=915.5947265625,y=-2428.8505859375,z=5700.4287109375,rx=0,ry=0,rz=99.013061523438},
{x=915.669921875,y=-2433.8515625,z=5700.4287109375,rx=0,ry=0,rz=100.89721679688},
{x=915.54296875,y=-2438.40234375,z=5700.4287109375,rx=0,ry=0,rz=93.690093994141},
{x=915.62890625,y=-2443.1796875,z=5700.4287109375,rx=0,ry=0,rz=181.18104553223},
{x=915.7412109375,y=-2447.908203125,z=5700.4287109375,rx=0,ry=0,rz=90.553436279297},
{x=916.0654296875,y=-2452.6611328125,z=5700.4287109375,rx=0,ry=0,rz=103.08905029297},
{x=936.673828125,y=-2452.5556640625,z=5700.4287109375,rx=0,ry=0,rz=254.74113464355},
{x=936.76171875,y=-2447.81640625,z=5700.4287109375,rx=0,ry=0,rz=239.36552429199},
{x=936.6064453125,y=-2443.1103515625,z=5700.4287109375,rx=0,ry=0,rz=259.71252441406},
{x=936.8232421875,y=-2438.376953125,z=5700.4287109375,rx=0,ry=0,rz=263.78302001953},
{x=936.798828125,y=-2433.6826171875,z=5700.4287109375,rx=0,ry=0,rz=264.09613037109},
{x=936.6015625,y=-2428.9365234375,z=5700.4287109375,rx=0,ry=0,rz=263.78302001953},
{x=936.203125,y=-2424.08203125,z=5700.4287109375,rx=0,ry=0,rz=265.34860229492},
{x=937.01489257812,y=-2452.5949707031,z=5703.9189453125,rx=0,ry=0,rz=264.05218505859},
{x=937.04614257812,y=-2447.7424316406,z=5703.9116210938,rx=0,ry=0,rz=187.30052185059},
{x=937.18774414062,y=-2443.0246582031,z=5703.912109375,rx=0,ry=0,rz=78.720977783203},
{x=937.08911132812,y=-2438.4543457031,z=5703.9116210938,rx=0,ry=0,rz=282.85006713867},
{x=937.1103515625,y=-2433.630859375,z=5703.912109375,rx=0,ry=0,rz=268.43579101562},
{x=937.21484375,y=-2429.0849609375,z=5703.912109375,rx=0,ry=0,rz=261.85488891602},
{x=937.0029296875,y=-2424.119140625,z=5703.9116210938,rx=0,ry=0,rz=253.0821685791},
}

function createObject2(a,b,c,d,e,f,g,h,i)
	return createObject(a,b-884,c-871,d,e,f,g,h,i)
end

    table.insert(cells,createObject2(2930,1801.79150391,-1552.40869141,5702.05517578,0.00000000,0.00000000,0.48001099))--object(chinatgate) (1)
    table.insert(cells,createObject2(2930,1801.77014160,-1557.13854980,5702.05517578,0.00000000,0.00000000,0.47790527))--object(chinatgate) (2)
    table.insert(cells,createObject2(2930,1801.83581543,-1561.86804199,5702.05517578,0.00000000,0.00000000,0.47790527))--object(chinatgate) (3)
    table.insert(cells,createObject2(2930,1801.94006348,-1566.64123535,5702.05517578,0.00000000,0.00000000,0.47790527))--object(chinatgate) (4)
    table.insert(cells,createObject2(2930,1801.93615723,-1571.29345703,5702.05517578,0.00000000,0.00000000,0.47790527))--object(chinatgate) (5)
    table.insert(cells,createObject2(2930,1801.90808105,-1576.06445312,5702.05517578,0.00000000,0.00000000,0.47790527))--object(chinatgate) (6)
    table.insert(cells,createObject2(2930,1801.95166016,-1580.82141113,5702.05517578,0.00000000,0.00000000,0.47790527))--object(chinatgate) (7)
    table.insert(cells,createObject2(2930,1801.95117188,-1580.82128906,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (8)
    table.insert(cells,createObject2(2930,1801.92639160,-1576.08361816,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (9)
    table.insert(cells,createObject2(2930,1801.91748047,-1571.30688477,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (10)
    table.insert(cells,createObject2(2930,1801.90710449,-1566.63781738,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (11)
    table.insert(cells,createObject2(2930,1801.83142090,-1561.85119629,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (12)
    table.insert(cells,createObject2(2930,1801.78356934,-1557.14074707,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (13)
    table.insert(cells,createObject2(2930,1801.76660156,-1552.39672852,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (14)
    table.insert(cells,createObject2(2930,1817.90026855,-1552.16015625,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (15)
    table.insert(cells,createObject2(2930,1817.90173340,-1556.90173340,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (16)
    table.insert(cells,createObject2(2930,1817.97802734,-1561.65954590,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (17)
    table.insert(cells,createObject2(2930,1818.01013184,-1566.40661621,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (18)
    table.insert(cells,createObject2(2930,1818.06726074,-1571.15270996,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (19)
    table.insert(cells,createObject2(2930,1818.04797363,-1575.87060547,5705.54882812,0.00000000,0.00000000,0.47790527))--object(chinatgate) (20)
    table.insert(cells,createObject2(2930,1818.10192871,-1580.65954590,5705.53613281,0.00000000,0.00000000,0.47790527))--object(chinatgate) (21)
    table.insert(cells,createObject2(2930,1818.10156250,-1580.65917969,5702.04150391,0.00000000,0.00000000,0.47790527))--object(chinatgate) (22)
    table.insert(cells,createObject2(2930,1818.05444336,-1575.90368652,5702.04150391,0.00000000,0.00000000,0.47790527))--object(chinatgate) (23)
    table.insert(cells,createObject2(2930,1818.05017090,-1571.16259766,5702.04150391,0.00000000,0.00000000,0.47790527))--object(chinatgate) (24)
    table.insert(cells,createObject2(2930,1818.03869629,-1566.39038086,5702.04150391,0.00000000,0.00000000,0.47790527))--object(chinatgate) (25)
    table.insert(cells,createObject2(2930,1817.97448730,-1561.65429688,5702.04150391,0.00000000,0.00000000,0.47790527))--object(chinatgate) (26)
    table.insert(cells,createObject2(2930,1817.89257812,-1556.90429688,5702.04150391,0.00000000,0.00000000,0.47790527))--object(chinatgate) (27)
    table.insert(cells,createObject2(2930,1817.90490723,-1552.17919922,5702.04150391,0.00000000,0.00000000,0.47790527))--object(chinatgate) (28)

local moving = {}
local cellEnterMarkers = {}
local cellEnterIcons = {}
local cellAssigned = {}
local cellInmate={}
local spaceMarkers = {}
aeh=addEventHandler
ae=addEvent
tce=triggerClientEvent
	--  -884x,-871y

function hitCellMarker(e)
	for k,v in pairs(cellEnterMarkers) do
		if v == source then
			if cellInmate[k] == e then
				exports.dendxmsg:createNewDxMessage(e,"Press H to toggle the Cell Gate",0,255,0)
			end
		end
	end
end

for k,v in pairs(cells) do
	open[v]=false
	moving[v]=false
	local x,y,z = getElementPosition(v)
	local icon = createObject(1239,x,y-1,z-2)
	local marker = createMarker(x,y-1,z-2,"cylinder",1)
	setElementAlpha(marker,0)
	aeh("onMarkerHit",marker,hitCellMarker)
	cellEnterMarkers[v]=marker
	cellEnterIcons[v]=icon
	cellAssigned[v]=false
	cellInmate[v]=false
end

for k,v in pairs(cellSpace) do
		local nearestCell = false
		local smallestDist = 9999999
		local cx,cy,cz=0,0,0
		for cell,icon in pairs(cellEnterIcons) do
			local x,y,z = getElementPosition(icon)
			local dist = getDistanceBetweenPoints3D(x,y,z,v.x,v.y,v.z)
			cx,cy,cz=v.x,v.y,v.z-1
			if dist < smallestDist then smallestDist=dist nearestCell=cell end
		end
		spaceMarkers[nearestCell] = createMarker(cx,cy,cz,"cylinder",2.5)
		setElementAlpha(spaceMarkers[nearestCell],0)
	end

ae("toggleMyCell",true)
aeh("toggleMyCell",root,function(c)
	toggleCell(c)
	if open[c] == true then
		exports.dendxmsg:createNewDxMessage(source,"Your cell gate is opening.",0,255,0)
	else
		exports.dendxmsg:createNewDxMessage(source,"Your cell gate is closing.",0,255,0)
	end
end)

addCommandHandler("cpos",function(ps)
	local x,y,z = getElementPosition(cells[1])
	outputChatBox(""..x.." "..y.." "..z.."",ps)
end)

local enterMarker = createMarker(917.58, -2387.08, 5700.42,"cylinder",2)
setElementAlpha(enterMarker,0)
addEventHandler("onMarkerHit",enterMarker,function(p)
	if source == enterMarker then
		if isPlayerJailed(p) == true then
			local x,y,z = getElementPosition(p)
			setElementPosition(p,x,y,z)
			cancelEvent()
		end
	end
end)

function toggleCell(cell,str)
	if moving[cell]==true then return end
	local x,y,z = getElementPosition(cell)
	if open[cell]==true then
		moveObject(cell,5000,x,y+1,z)
		open[cell]=false
	else
		moveObject(cell,5000,x,y-1,z)
		open[cell]=true
	end
	moving[cell]=true
	setTimer(function() moving[cell]=false setElementData(cell,"st",{moving[cell],open[cell]},true) end,5000,1)
	setElementData(cell,"st",{moving[cell],open[cell]},true)
end

addCommandHandler("csgOpenPrisonCells",function()
	for k,v in pairs(cells) do
		if open[v] == false then
			toggleCell(v)
		end
	end
end)

addCommandHandler("csgClosePrisonCells",function()
	for k,v in pairs(cells) do
		if open[v] == true then
			toggleCell(v)
		end
	end
end)

addEventHandler("onPlayerLogin",root,function()
	triggerClientEvent(source,"recCells",source,cellEnterIcons,cellEnterMarkers,spaceMarkers)
end)
setTimer(function()
	for k,v in pairs(getElementsByType("player")) do triggerClientEvent(v,"recCells",v,cellEnterIcons,cellEnterMarkers,spaceMarkers) end
	for k,v in pairs(cells) do toggleCell(v) end
end,5000,1)

aeh("onPlayerQuit",root,function()
	for k,v in pairs(cellInmate) do
		if v == source then
			cellAssigned[k]=false
			cellInmate[k]=false
			if open[k]==false then toggleCell(k) end
			break
		end
	end
end)

ae("iniRelease",true)
aeh("iniRelease",root,function(c)
	exports.dendxmsg:createNewDxMessage(source,"Released from Jail! Evacuate the premesis within 3 minutes or you will be considered hostile",0,255,0)
	if open[c] == false then
		toggleCell(c)
	end
end)

function jail(p,transfer)
	for k,v in pairs(cellAssigned) do
		if v == false and moving[k] == false then
			cellAssigned[k]=true
			cellInmate[k]=p
			if open[k]==true then toggleCell(k) end
			tce(p,"assignedCell",p,k)
			if transfer ~= nil and transfer==true then
				tce(p,"jailSequence",p)
			end
			break
		end
	end
end
addCommandHandler("jailselftest",function(ps) jail(ps,true) end)

function isPlayerJailed(p)
	for k,v in pairs(cellInmate) do
		if v == p then return true end
	end
	return false
end

local stationaryBus = createVehicle(431,900.87, -2363.2, 13.24 ,0,0,211)
setElementFrozen(stationaryBus,true)
addEventHandler("onVehicleDamage",stationaryBus,function() if source==stationaryBus then setElementHealth(source,1000) end end)
