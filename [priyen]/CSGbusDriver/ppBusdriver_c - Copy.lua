------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppBusdriver_c.luac (client-side)
--  Bus Driver Job
--  Priyen Patel
------------------------------------------------------------------------------------

--local cooldown = { [1] = 0, [2] = 0, [3] = 0 }
local localPlayer = getLocalPlayer()
local jobInProgress = 0
local routes = { }
local activeRoute = 999
local nextStopString = ""
local currentStopIndex = 999
local routeLength = 999
local guiopen = 0
local markers = { }
local markers2 = { }
local bus = 0
local blip = 0
local fare = 100
local minfare = 0
local maxfare = 2500
local distMultiplier = 1
local gui = { }

local passengers = { }
function jobmenu()
    if exports.server:getPlayerOccupation() ~= "Bus Driver" then return end
    if guiopen == 1 then
		destroyGui()
		showCursor(false)
		guiopen = 0
    else
		showCursor(true)
		guiopen = 1
		destroyGui()
		makeGui()
    end   
end
bindKey ( "F5", "down", jobmenu)
 
function makeGui()
    showCursor(true)   
	gui = {}
	gui._placeHolders = {}
	
	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 800, 471
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	gui["_root"] = guiCreateWindow(left, top, windowWidth, windowHeight, "CSG Bus Driver Control Panel", false)
	guiWindowSetSizable(gui["_root"], false)
	
	gui["globalScoreLbl"] = guiCreateLabel(11, 26, 778, 16, ""..getPlayerName(localPlayer).." --- Fare: $"..fare.."", false, gui["_root"])
	guiLabelSetHorizontalAlign(gui["globalScoreLbl"], "center", false)
	guiLabelSetVerticalAlign(gui["globalScoreLbl"], "center")
	
	gui["tabWidget"] = guiCreateTabPanel(11, 48, 778, 382, false, gui["_root"])
	gui["tab_4"] = guiCreateTab("Assignments", gui["tabWidget"])
	
	--gui["tab_2"] = guiCreateTab("Personal Stats", gui["tabWidget"])
	
	--gui["tabWidget_3"] = guiCreateTabPanel(0, 0, 781, 361, false, gui["tab_2"])
	
	--gui["tab_6"] = guiCreateTab("", gui["tabWidget_3"])
	
	--gui["label_3"] = guiCreateStaticImage(11, 66, 170, 200, "mtalogo.png", false, gui["tab_6"])
	
	--gui["label_6"] = guiCreateLabel(187, 11, 577, 16, "Personal statistics:", false, gui["tab_6"])
	--guiLabelSetHorizontalAlign(gui["label_6"], "left", false)
	--guiLabelSetVerticalAlign(gui["label_6"], "center")
	--gui["sectionList_1PStats"] = guiCreateGridList(187, 34, 239, 247, false, gui["tab_6"])
	--guiGridListSetSortingEnabled(gui["sectionList_1PStats"], false)
    
	--gui["sectionList_1PStats_col"] = guiGridListAddColumn(gui["sectionList_1PStats"], "", 0.85)
	-- sectionList_1PStats_row = nil
     
    --gui["sectionList_2PStats"] = guiCreateGridList(434, 34, 239, 247, false, gui["tab_6"])
	--guiGridListSetSortingEnabled(gui["sectionList_2PStats"], false)
    
	--gui["sectionList_2PStats_col"] = guiGridListAddColumn(gui["sectionList_2PStats"], "", 0.85)
	-- sectionList_1PStats_row = nil
	
	--gui["dynScrollArea"] = guiCreateScrollPane(187, 33, 577, 288, false, gui["tab_6"])
	
	--gui["tab_3"] = guiCreateTab("Server Stats", gui["tabWidget"])
	
	--gui["tabWidget_2"] = guiCreateTabPanel(0, 0, 771, 361, false, gui["tab_3"])
	
	--gui["tab_5"] = guiCreateTab("", gui["tabWidget_2"])
	
	--gui["label_5"] = guiCreateStaticImage(11, 66, 170, 200, "mtalogo.png", false, gui["tab_5"])
	
	--gui["label_7"] = guiCreateLabel(187, 11, 567, 16, "Server wide statistics:", false, gui["tab_5"])
	--guiLabelSetHorizontalAlign(gui["label_7"], "left", false)
	--guiLabelSetVerticalAlign(gui["label_7"], "center")
	
	--gui["dynScrollArea_2"] = guiCreateScrollPane(187, 33, 567, 288, false, gui["tab_5"])
	
	
	gui._placeHolders["frame_1"] = {left = 11, top = 11, width = 241, height = 331, parent = gui["tab_4"]}
	
	gui["label_20"] = guiCreateLabel(12, 12, 239, 16, "Route:", false, gui["tab_4"])
	guiLabelSetHorizontalAlign(gui["label_20"], "left", false)
	guiLabelSetVerticalAlign(gui["label_20"], "center")
	
	gui["sectionList"] = guiCreateGridList(12, 34, 239, 247, false, gui["tab_4"])
	guiGridListSetSortingEnabled(gui["sectionList"], false)
	gui["sectionList_col"] = guiGridListAddColumn(gui["sectionList"], "", 0.85)
	 sectionList_row = nil	
	
	gui["pushButton"] = guiCreateButton(12, 287, 239, 24, "Start", false, gui["tab_4"])
	if on_pushButton_clicked then
		addEventHandler("onClientGUIClick", gui["pushButton"], on_pushButton_clicked, false)
	end
	
	gui["pushButton_2"] = guiCreateButton(12, 317, 239, 24, "End", false, gui["tab_4"])
	
	gui._placeHolders["frame_4"] = {left = 258, top = 11, width = 240, height = 331, parent = gui["tab_4"]}
	
	gui["label_22"] = guiCreateLabel(259, 12, 238, 16, "Bus stops:", false, gui["tab_4"])
	guiLabelSetHorizontalAlign(gui["label_22"], "left", false)
	guiLabelSetVerticalAlign(gui["label_22"], "center")
	
	gui["sectionList_2"] = guiCreateGridList(259, 34, 238, 247, false, gui["tab_4"])
	guiGridListSetSortingEnabled(gui["sectionList_2"], false)
	gui["sectionList_2_col"] = guiGridListAddColumn(gui["sectionList_2"], "", 0.85)
	 sectionList_2_row = nil
	
	--gui["progressBarForNextRank"] =  guiCreateProgressBar(259, 287, 238, 0, false, gui["tab_4"])
	--guiProgressBarSetProgress(gui["progressBarForNextRank"], 24)
	
	--gui["pushButton_3"] = guiCreateButton(259, 317, 238, 24, "Progress until the next rank", false, gui["tab_4"])

	
	gui._placeHolders["frame"] = {left = 504, top = 11, width = 257, height = 331, parent = gui["tab_4"]}
	
	gui["label_21"] = guiCreateLabel(513, 12, 239, 16, "Other Bus Drivers", false, gui["tab_4"])
	guiLabelSetHorizontalAlign(gui["label_21"], "left", false)
	guiLabelSetVerticalAlign(gui["label_21"], "center")
	
	gui["tableWidget"] = guiCreateGridList(513, 34, 239, 291, false, gui["tab_4"])
	guiGridListSetSortingEnabled(gui["tableWidget"], true)
	gui["tableWidget_col0"] = guiGridListAddColumn(gui["tableWidget"], "Name", 0.6)
	gui["tableWidget_col1"] = guiGridListAddColumn(gui["tableWidget"], "Area", 0.15)
	
	tableWidget_row = nil
	
	--gui["tab_7"] = guiCreateTab("Ranks", gui["tabWidget"])
	
	gui["tab"] = guiCreateTab("Documentation", gui["tabWidget"])
	guiCreateMemo(14,17,414,246,"CSG Bus Driver Information Memo ::: Your job is to drive through the streets of LA transporting passengers from one place to another. You can do the given routes and earn money, you will only be paid if you complete the FULL route and reach the final stop; and you can set a price that passengers can pay. You can set fare using /setfare amount and once a passenger enters your bus, after a few seconds they will be expected to pay you the fare. If they do not, it is a violation of law and they will get wanted. Good Luck!",false,gui["tab"])
	--gui["label_7"] = guiCreateLabel(187, 11, 567, 16, "Payment is 5k for completing the whole route. Time bonus will be added soon.", false, gui["tab"])
    --gui["label_99"] = guiCreateLabel(187, 25, 567, 16, "You cannot skip a stop to get to the next. MUST USE SAME BUS FOR WHOLE ROUTE.", false, gui["tab"])
    --gui["label_98"] = guiCreateLabel(187, 39, 567, 16, "Type /setfare priceHere , default = 100 , min = 0, max = 2500. Fare applies 10s after passenger enters.", false, gui["tab"])
	gui["closeBtn"] = guiCreateButton(714, 436, 75, 24, "Close", false, gui["_root"])
    addEventHandler("onClientGUIClick", gui["pushButton"], assignJobButton)
    addEventHandler("onClientGUIClick", gui["pushButton_2"], endJobButton)
    addEventHandler("onClientGUIClick", gui["closeBtn"], destroyGui)
	addEventHandler("onClientGUIClick", gui["sectionList"], selectSameIndex1)
	addEventHandler("onClientGUIClick", gui["sectionList_2"], selectSameIndex2)
    addAssignmentsToMenu()
	return gui, windowWidth, windowHeight
end

function assignJobButton()
    if jobInProgress == 1 then return end
    if getPedOccupiedVehicle(localPlayer) == false then return end
	local id = getElementModel(getPedOccupiedVehicle(localPlayer))
    if id == 431 or id == 437 then   
        local row,column = guiGridListGetSelectedItem(gui["sectionList"])
        if column == false or row == false then return end
        startRoute(row+1)
        bus = getPedOccupiedVehicle(localPlayer)
    end      
end

function startRoute(i)
    local t = routes[i]
    if t == nil then return end
		--[[
		if cooldown[1] == 0 then
        cooldown[1] = 20
        --triggerServerEvent("setStatBusdriver", localPlayer,"busdriverRoutesAttempted",1)
        end    
		--]]
    for k,v in ipairs(t) do   
		
        local x = t[k][1]
        local y = t[k][2]
        local z = t[k][3]
        local x = math.floor(x+0.5)
        local y = math.floor(y+0.5)
        local z = math.floor(z+0.5)
        local marker = createMarker(x,y,z,"cylinder", 4)
        markers[k] = marker
        addEventHandler("onClientMarkerHit", marker, hitBusStop)
        local marker2 = createMarker(x,y,z,"checkpoint",45,0,0,0,0)
        markers2[k] = marker2
        addEventHandler("onClientMarkerHit", marker2, hitApprochMarker)
        if k == 1 then
            bus = getPedOccupiedVehicle(localPlayer)
			jobInProgress = 1    
			currentStopIndex = 1
			routeLength = #t
			activeRoute = i
            exports.DENhelp:createNewHelpMessage("Bus Route Started!",0,255,0)
            blip = createBlip(x,y,z,58)
            nextStopString = ""..x.." "..y.." "..z..""
            local msg = "Next Stop : "..getZoneName(x,y,z).." ("..routes[activeRoute][currentStopIndex][4]..")"
			local r,g,b = 0,255,0
            setTimer(triggerServerEvent,2000,1,"announceToAllPassengers",root,msg,getVehicleOccupants((getPedOccupiedVehicle(localPlayer))),r,g,b)
            
        end 
    end
	destroyGui()
	makeGui()
end

function hitApprochMarker(hitPlayer, dim)
 if isPedInVehicle(hitPlayer) == true then
        if getElementModel(getPedOccupiedVehicle(hitPlayer)) == 431 or getElementModel(getPedOccupiedVehicle(hitPlayer)) == 437 then
            if getPedOccupiedVehicle(localPlayer) ~= bus then exports.DENhelp:createNewHelpMessage("This is not the same bus as when you started the route.",255,0,0) return end
            if getVehicleController(getPedOccupiedVehicle(hitPlayer)) == localPlayer then
                local veh = getPedOccupiedVehicle(hitPlayer)
                local x,y,z = getElementPosition(source)
                local x = math.floor(x+0.5)
                local y = math.floor(y+0.5)
                local z = math.floor(z+0.5)
                local stop = tostring(""..x.." "..y.." "..z.."")
                if stop == nextStopString then
                local msg = "Approching Bus Stop "..getZoneName(x,y,z).." ("..routes[activeRoute][currentStopIndex][4]..")"
				local r,g,b = 255,255,0
                triggerServerEvent("announceToAllPassengers",localPlayer,msg,getVehicleOccupants(veh),r,g,b)
                end
            end
        end
    end

 end

function hitBusStop(hitPlayer, dim)
    if isPedInVehicle(hitPlayer) == true then
		local veh = getPedOccupiedVehicle(hitPlayer)
        if getElementModel(veh) == 431 or getElementModel(veh) == 437 then
            --if getPedOccupiedVehicle(localPlayer) ~= bus then exports.DENhelp:createNewHelpMessage("This is not the same bus as when you started the route.",255,0,0)  return end
            if getVehicleController(veh) == localPlayer then
                local x,y,z = getElementPosition(source)
                local x = math.floor(x+0.5)
                local y = math.floor(y+0.5)
                local z = math.floor(z+0.5)
                local stop = tostring(""..x.." "..y.." "..z.."")
				local msg1 = "Arrived at Bus Stop ("..routes[activeRoute][currentStopIndex][4]..")"
				local r1,g1,b1 = 0,255,0
				local r2,g2,b2 = 0,255,0
                if stop == nextStopString then
                --triggerServerEvent("setStatBusdriver", localPlayer, "busdriverStopsArrivedTo", 1)
                    if currentStopIndex == routeLength then						
						local msg2 = "Please wait while passengers Exit. This is the final stop."
		
						triggerServerEvent("announceToAllPassengers",localPlayer,msg1,getVehicleOccupants(getPedOccupiedVehicle(localPlayer)),r1,g1,b1)
						triggerServerEvent("announceToAllPassengers",localPlayer,msg2,getVehicleOccupants(getPedOccupiedVehicle(localPlayer)),r2,g2,b2)
						setElementFrozen(veh, true)
						setTimer(setElementFrozen,4000,1,veh,false)
						fadeCamera ( false, 3.0, 0, 0, 0 )       
						setTimer ( fadeCamera, 3000, 1, true, 3.0 )
						endAssignment()
                  --[[  local pay = 0
                    local dist = 0
                    for k,v in pairs(routes[activeRoute]) do
                        if routes[activeRoute][k+1] == nil then break end
                        local tempDist = getDistanceBetweenPoints3D(v[1],v[2],v[3],routes[activeRoute][k+1][1],routes[activeRoute][k+1][2],routes[activeRoute][k+1][3])
                        local dist = dist + tempDist
                    end
                    pay = dist * distMultiplier
                    --]]
						local pay = math.random(2500,6500)
						triggerServerEvent("payBusDriver",localPlayer,pay)
						--triggerServerEvent("setStatBusdriver", localPlayer,"busdriverRoutesCompleted",1)
						return
                    end
				local mgs2 = "Please wait while passengers Enter / Exit."
				triggerServerEvent("announceToAllPassengers",localPlayer,msg1,getVehicleOccupants(getPedOccupiedVehicle(localPlayer)),r1,g1,b1)
				triggerServerEvent("announceToAllPassengers",localPlayer,msg2,getVehicleOccupants(getPedOccupiedVehicle(localPlayer)),r2,g2,b2)
                currentStopIndex = currentStopIndex + 1
                destroyElement(blip)
                local nx = routes[activeRoute][currentStopIndex][1]
                local ny = routes[activeRoute][currentStopIndex][2]
                local nz = routes[activeRoute][currentStopIndex][3]
                local nx = math.floor(nx+0.5)
                local ny = math.floor(ny+0.5)
                local nz = math.floor(nz+0.5)
                blip = createBlip(nx,ny,nz,58)
                nextStopString = ""..nx.." "..ny.." "..nz..""
                setElementFrozen(veh, true)               
                setTimer(setElementFrozen,4000,1,veh,false)
                fadeCamera ( false, 3.0, 0, 0, 0 )       
                setTimer ( fadeCamera, 3000, 1, true, 3.0 )
                local msg1 = "Next Stop : "..getZoneName(nx,ny,nz).." ("..routes[activeRoute][currentStopIndex][4]..")"
                 
                setTimer (triggerServerEvent,3900,1,"announceToAllPassengers",localPlayer,msg1,getVehicleOccupants(veh),r1,g1,b1)
				setTimer (function () sayIncorrect = true end,3000,1)
				sayIncorrect = false
                else
					if sayIncorrect == true then	
						exports.DENhelp:createNewHelpMessage("Go to the blip on your map! This is the incorrect bus stop.",255,0,0)
					end
                end
            end
        end
    end
end

function updateSelect()
	guiGridListSetSelectedItem(gui["sectionList"], currentAssignmentTableJobIndex,1)
	guiGridListSetSelectedItem(gui["sectionList_2"], currentAssignmentTableJobIndex,1)
end

function endJobButton()
    if jobInProgress == 0 then return end
    endAssignment()
    destroyGui()
    makeGui()
end

function endAssignment()
	if jobInProgress == 1 then
		exports.DENhelp:createNewHelpMessage("Bus Route Ended.",255,255,0)
	end
    jobInProgress = 0
    currentStopIndex = 999
    routeLength = 999
    activeRoute = 999
    destroyElement(blip)
    for k,v in pairs(markers) do
        if isElement(v) then
        destroyElement(v)
        end
    end
    for k,v in pairs(markers2) do
        if isElement(v) then
        destroyElement(v)
        end
    end
    bus = 0
end

function destroyGui()
    showCursor(false)
    if isElement(gui["_root"]) then
     removeEventHandler("onClientGUIClick", gui["closeBtn"], destroyGui)
     destroyElement(gui["_root"])   
    end
end
   
function addAssignmentsToMenu()
	local routeNameText = ""
    for k,v in pairs(routes) do
		local routeName = routes[k]["name"]
        local stop = ""
        if k == activeRoute then
			local t = routes[k]
				for k,v in ipairs(t) do
					local x,y,z = t[k][1],t[k][2],t[k][3]
					local x = math.floor(x+0.5)
					local y = math.floor(y+0.5)
					local z = math.floor(z+0.5)
					stop = tostring(""..x.." "..y.." "..z.."")
					local areaName = getZoneName(x,y,z)
					if stop == nextStopString then
						areaName = ""..areaName.." ---Next---"
					end				
					sectionList_2_row = guiGridListAddRow(gui["sectionList_2"])
					guiGridListSetItemText(gui["sectionList_2"], sectionList_2_row, gui["sectionList_2_col"], ""..areaName.."", false, false )
				end
			routeNameText = ""..tostring(routeName).." (Active)"
    	else
			routeNameText = ""..tostring(routeName)..""
		end
		sectionList_row = guiGridListAddRow(gui["sectionList"])
		guiGridListSetItemText(gui["sectionList"], sectionList_row, gui["sectionList_col"], ""..routeNameText.."", false, false )        
    end
    addBusdriversToMenu()
	--addStatsToMenu()    
end
   
function addBusdriversToMenu()
    for k,v in pairs(getElementsByType("player")) do
        if exports.server:getPlayerOccupation() == "Bus Driver" then
	tableWidget_row = guiGridListAddRow(gui["tableWidget"])
	guiGridListSetItemText(gui["tableWidget"], tableWidget_row, gui["tableWidget_col0"], ""..getPlayerName(v).."", false, false )
	guiGridListSetItemText(gui["tableWidget"], tableWidget_row, gui["tableWidget_col1"], "LS", false, false )
        end
    end
    
end

function selectSameIndex1()
   local row,column = guiGridListGetSelectedItem(gui["sectionList"])
   guiGridListSetSelectedItem(gui["sectionList_2"], row,1)
end

function selectSameIndex2()
   local row,column = guiGridListGetSelectedItem(gui["sectionList_2"])
   guiGridListSetSelectedItem(gui["sectionList"], row,1)
end
--[[
function addStatsToMenu()
    triggerServerEvent("sendStatsTableBusdriver", localPlayer)
end
 
function receiveStats(t)
   
    for k,v in pairs(t) do
        sectionList_1PStats_row = guiGridListAddRow(gui["sectionList_1PStats"])
        guiGridListSetItemText(gui["sectionList_1PStats"], sectionList_1PStats_row, gui["sectionList_1PStats_col"], ""..tostring(k).."", false, false )
         sectionList_2PStats_row = guiGridListAddRow(gui["sectionList_2PStats"])
        guiGridListSetItemText(gui["sectionList_2PStats"], sectionList_2PStats_row, gui["sectionList_2PStats_col"], ""..tostring(v).."", false, false )

    end
end
 addEvent("receiveStatsBusdriver", true)
 addEventHandler("receiveStatsBusdriver", getRootElement(), receiveStats)

function updateCooldowns()
    if exports.server:getPlayerOccupation() ~= "Bus Driver" then return end
    for k,v in pairs(cooldown) do
        if v > 0 then
        v = v-1
        end
    end 
    for k,v in pairs(passengers) do
        if v > 0 then
        v = v-1
        end
    end
end     
 setTimer(updateCooldowns, 1000, 0)
 --]]
function recRoutes(t)
    routes = t
end
addEvent("recRoutes", true)
addEventHandler("recRoutes", localPlayer, recRoutes)
triggerServerEvent("sendRoutes", localPlayer)
 
function death()
    if exports.server:getPlayerOccupation() == "Bus Driver" then
    endAssignment()
    --triggerServerEvent("setStatBusdriver", localPlayer,"busdriverDiedOnJob",1)
    end
end
 
function busExplode()
    if source == bus then
        endAssignment()
    end
end
addEventHandler("onClientPlayerWasted", localPlayer, death)
addEventHandler("onClientVehicleExplode", root, busExplode)
 
function quitBusDriver()
    --exports.CSGhelp:setBottomTextClient("You are no longer a Bus Driver", 255,255,255,255,localPlayer)
    endAssignment()
end
addEvent("quitBusDriver", true)
addEventHandler("quitBusDriver", root, quitBusDriver)

if exports.server:getPlayerOccupation() == "Bus Driver" then
    exports.DENhelp:createNewHelpMessage("Press [F5] to access the Bus Driver Control Panel.",0,255,0)
end

function setFare(commandName, price)
    if exports.server:getPlayerOccupation() == "Bus Driver" then
        if (price) then
          if type(tonumber(price)) == "number" then
            if tonumber(price) >= minfare and tonumber(price) <= maxfare then
                triggerServerEvent("CSGbusdriverNewFare",localPlayer,price)
                fare = price
                if isElement(gui["globalScoreLbl"]) then
                guiSetText(gui["globalScoreLbl"],""..getPlayerName(localPlayer).." --- Fare: $"..fare.."")
                end
                exports.DENhelp:createNewHelpMessage("Fare set to $"..fare.."",0,255,0)
            else
                exports.DENhelp:createNewHelpMessage("Fare exceeds the maximum or is below the minimum allowed of this land.",255,0,0)
            end
          else
            exports.DENhelp:createNewHelpMessage("Only enter numbers in the fare. Usage: /setfare 100",255,255,0)
          end
        else
        exports.DENhelp:createNewHelpMessage("Usage: /setfare 100",255,255,0)
        end
    end
end
addCommandHandler("setfare", setFare)
--[[
function onClientVehicleEnter(p,seat)
  --  outputChatBox("1")
    if exports.server:getPlayerOccupation() ~= "Bus Driver" then return end
    if source == getPedOccupiedVehicle(localPlayer) then
   --  outputChatBox("1+")
        local id = getElementModel(source)
        if id == 431 or id == 437 then 
       --  outputChatBox("2")
        if p ~= getVehicleController(source) then
            if passengers[p] == 0 then
            --triggerServerEvent("setStatBusdriver", localPlayer,"busdriverRealPassengers",1)
            -- outputChatBox("3")
            passengers[p] = 30
            end
            triggerServerEvent("busEnterNotice",localPlayer,p,fare)
            -- outputChatBox("3+")
        end
        end
       
    end
end
addEventHandler("onClientVehicleEnter", root, onClientVehicleEnter)
--]]
--[[
function jobVeh()
    if cooldown[3] == 0 then
    --triggerServerEvent("setStatBusdriver", localPlayer, "busdriverBusesSpawned", 1)
    cooldown[3] = 20
    end
end
addEvent("CSGbusDriverjobVehSpawned", true)
addEventHandler("CSGbusDriverjobVehSpawned", root, jobVeh)
--]]

local mapList = {}
function map(commandName,arg1)
    local x,y,z = getElementPosition(localPlayer)
    z=z-1
   local t = {x,y,z,arg1}
   table.insert(mapList,t)
end
addCommandHandler("bs",map)
function printMapped()
    for k,v in pairs(mapList) do
        outputChatBox("{"..v[1]..","..v[2]..","..v[3]..","..v[4].."},")
    end
    mapList = {}
end
addCommandHandler("bsprint",printMapped)