disallowedVehicles = {{592},{511},{584},{512},{593},{417},{487},{553},{488},{563},{476},{519},{460},{469},{513},{472},{473},{493},{595},{484},{430},{453},{452},{446},{454},{403},{514},{443},{515},{455},{406},{486},{578},{532},{524},{498},{609},{568},{457},{508},{571},{539},{606},{607},{485},{581},{509},{481},{462},{521},{463},{510},{461},{448},{468},{586},{485},{552},{431},{438},{437},{574},{525},{408},{416},{443},{427},{490},{528},{407},{544},{523},{470},{596},{597},{598},{599},{532},{601},{428},{499},{449},{537},{538},{570},{569},{590},{441},{464},{501},{465},{564},{594}}

function setVehicleNeonColor(vehicle,r,g,b)
	setElementData(vehicle,"neonlight",tostring(r)..","..tostring(g)..","..tostring(b)..","..tostring(a))
	for i,mark in ipairs(getElementsByType("marker")) do
		local type = getMarkerType(mark)
		if type == "corona" then
			local data1 = getElementData(vehicle,"neonMarker1")
			local data2 = getElementData(vehicle,"neonMarker2")
			if data1 == mark or data2 == mark then
				setMarkerColor(mark,r,g,b,80)
			end
		end
	end
	return true
end
addCommandHandler("neon",
function(player,_,r,g,b)
	if (isPedInVehicle(player)) then
		vehicle = getPedOccupiedVehicle(player)
		seat = getPedOccupiedVehicleSeat(player)
		if (vehicle) then
			if (seat == 0) then
				if not (r) then r = math.random(255) end
				if not (g) then g = math.random(255) end
				if not (b) then b = math.random(255) end
				if getVehicleType(vehicle) == "Automobile" then
						setVehicleNeonColor(vehicle,r,g,b)
				else
					outputChatBox("This vehicle cannot have neons!",player,255,0,0)
				end
			else
				outputChatBox("You are not the driver of this vehicle!",player,255,0,0)
			end
		end
	else
		outputChatBox("You are not in a vehicle!",player,255,0,0)
	end
end)

function hasVehicleHaveNeon(vehicle)
	local data = getElementData(vehicle,"haveneon")
	if data then
		return true
	else
		return false
	end
end

function addVehicleNeon(vehicle,state)
	if getElementType(vehicle) == "vehicle" then
		if state then
			setElementData(vehicle,"haveneon",true)
			x,y,z = getElementPosition(vehicle)
			--
			local exist = nil
			for i,mark in ipairs(getElementsByType("marker")) do
				data = getElementData(vehicle,"neonMarker1")
				if data == mark then
					local exist = mark
				end
			end
			if not exist then
				local marker1 = createMarker(x,y,z,"corona",2,0,0,0,0)
				attachElements(marker1,vehicle,0,-1,-1.2)
				setElementData(vehicle,"neonMarker1",marker1)
				local marker2 = createMarker(x,y,z,"corona",2,0,0,0,0)
				attachElements(marker2,vehicle,0,1,-1.2)
				setElementData(vehicle,"neonMarker2",marker2)
			end
			--
			return true
		else
			setElementData(vehicle,"haveneon",false)
			setElementData(veh,"neonlight","off")
			--
			for i,mark in ipairs(getElementsByType("marker")) do
				local type = getMarkerType(mark)
				if type == "corona" then
					local data1 = getElementData(vehicle,"neonMarker1")
					local data2 = getElementData(vehicle,"neonMarker2")
					if data1 == mark or data2 == mark then
					setMarkerColor(mark,0,0,0,0)
				end
			end
		end
		--
		end
		return true
	else
		return false
	end
end


function canVehicleHaveNeon(veh)
	model = getElementModel(veh)
	if veh and getElementType(veh) == "vehicle" then
		x = mayHaveNeon(model)
		if (x) then
			return true
		else
			return false
		end
	end
end

function mayHaveNeon(model)
	for k,v in ipairs(disallowedVehicles) do
		if not(disallowedVehicles[v] == model) then
			return true
		else
			return false
		end
	end
end


function removeVehicleNeon(vehicle)
	if getElementType(vehicle) == "vehicle" then
		setElementData(vehicle,"neonlight","off")
		for i,mark in ipairs(getElementsByType("marker")) do
			local type = getMarkerType(mark)
			if type == "corona" then
				local data1 = getElementData(vehicle,"neonMarker1")
				local data2 = getElementData(vehicle,"neonMarker2")
				if data1 == mark or data2 == mark then
					setMarkerColor(mark,0,0,0,0)
				end
			end
		end
		return true
	else
		return false
	end
end

addCommandHandler("remove",
function(player)
	if (isPedInVehicle(player)) then
		removeVehicleNeon(getPedOccupiedVehicle(player))
	end
end)

addEventHandler("onPlayerJoin",root,
function()
	for i,veh in ipairs(getElementsByType("vehicle")) do
		data = getElementData(veh,"neonlight")
		setElementData(veh,"neonlight",data)
	end
end)

for i,veh in ipairs(getElementsByType("vehicle")) do
	removeVehicleNeon(veh)
end