local cooldown = { [1] = 0, [2] = 0, [3] = 0 }
local localPlayer = getLocalPlayer()
local jobInProgress = 0
local collectedTable = { }
local guiopen = 0
local gui = { }
local tweight = "0" --total weight
local maxweight = 100
local emptyMarkers = { }
local sweepData = { } --trash,blip
local unitpay = 40
local unitbonus = 50
local emptyLocs = {
[1] = { x=2182.96, y=-1987.42, z=12.55 }
}
local items = {
[1] = {name="Trash",weight=0.1},
[2] = {name="Trash",weight=0.9},
[3] = {name="Trash",weight=0.8},
[4] = {name="Trash",weight=0.7},
[5] = {name="Trash",weight=0.6},
[6] = {name="Trash",weight=0.5},
[7] = {name="Trash",weight=0.4},
[8] = {name="Trash",weight=0.3},
}

local objects = {}

function makeTrash()
    if isPlayerDead(localPlayer) == false then
        if isPedInVehicle(localPlayer) == true then
            if getElementModel(getPedOccupiedVehicle(localPlayer)) == 574 then
                local size = 0
                for k,v in pairs(sweepData) do

                    if v ~= nil then
                    local px,py,pz = getElementPosition(localPlayer)
                    local ox,oy,oz = getElementPosition(sweepData[k][1])
                    local dist = getDistanceBetweenPoints3D(ox,oy,oz,px,py,pz)
                        size = size + 1
                        if dist > 125 or (pz-0.5)-oz > 1.5 or oz-(pz-0.5) > 1.5 then
                        destroyElement(sweepData[k][1])
                        destroyElement(sweepData[k][2])
                        destroyElement(sweepData[k][3])
                        destroyElement(k)
                        sweepData[k] = nil
                        end

                    end
                end
                      if size < 10 then
            local px,py,pz = getElementPosition(localPlayer)
            local ox,oy,oz = (px + math.random(-100,100)),(py + math.random(-100,100)),getGroundPosition(px,py,pz+215)
            local model = 2676
            local object = createObject(model,ox,oy,oz+0.25)
            local blip = createBlip(ox,oy,oz,0,1,0,200,0,255)
            local marker = createMarker(ox,oy,oz+2.25,"arrow",2,0,255,0)
            local col = createColCircle(ox,oy,2.25)
            sweepData[col] = {object,blip,marker}
            addEventHandler("onClientColShapeHit",col,hitTrashMarker)
        end
            end

        end



    end
end

function destroyAll()
        for k,v in pairs(sweepData) do
            if v ~= nil then
                        destroyElement(sweepData[k][1])
                        destroyElement(sweepData[k][2])
                        destroyElement(sweepData[k][3])
                        destroyElement(k)
                        sweepData[k] = nil
            end
        end
end

function exitSweeper(veh)
    if source ~= localPlayer then return end
    if getElementData(localPlayer,"Occupation") == "Street Cleaner" then
		destroyAll()
    end
end
addEventHandler("onClientPlayerVehicleExit",localPlayer,exitSweeper)

function enterSweeper(veh)
    if source ~= localPlayer then return end
    if getElementData(localPlayer,"Occupation") == "Street Cleaner" and getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		if getElementModel(veh) == 574 then
			exports.dendxmsg:createNewDxMessage("Sweep the streets and collect trash. Dump the trash at the job location blue marker to be paid.",0,255,0)
		end
   end
end
addEventHandler("onClientPlayerVehicleEnter",localPlayer,enterSweeper)


function quitSC()
    if isTimer(trashTimer) then killTimer(trashTimer) end
    for k,v in pairs(emptyMarkers) do
		destroyElement(v)
		removeEventHandler("onClientMarkerHit",v,hitEmptyMarker)
    end
	destroyAll()

    emptyMarkers = { }
end
addEvent("quitSC",true)
addEventHandler("quitSC", root, quitSC)

function becameSC()
	if not(isTimer(trashTimer)) then
	for k,v in pairs(emptyLocs) do
		local x,y,z = emptyLocs[k]["x"],emptyLocs[k]["y"],emptyLocs[k]["z"]
		local m = createMarker(x,y,z,"cylinder",6)
		emptyMarkers[m]=m
        addEventHandler("onClientMarkerHit",m,hitEmptyMarker)
	end
	trashTimer = setTimer(makeTrash,1000,0)
	end
end
addEvent("becameSC", true)
addEventHandler("becameSC", root, becameSC)

function hitEmptyMarker(hit)
    if getElementType(hit) == "player" then
		if hit ~= localPlayer then return end
		if getElementData(hit,"Occupation") ~= "Street Cleaner" then return end
		emptyButton()
    end
end

function emptyButton()
    if collectedTable[1] == nil then return end
    if getPedOccupiedVehicle(localPlayer) == false then return end
    local id = getElementModel(getPedOccupiedVehicle(localPlayer))
    if id == 574 then
        if getVehicleController(getPedOccupiedVehicle(localPlayer)) ~= localPlayer then
            outputChatBox("You must be the driver to empty the vehicle",255,255,0,true)
        return end
        local isInMarker = 0
        for k,v in pairs(emptyMarkers) do
            if isElementWithinMarker(localPlayer,v) == true then
            isInMarker = 1
            end
        end
        if isInMarker == 1 then
			local pay = #collectedTable*unitbonus
			local units = #collectedTable

            collectedTable = { }

            setElementFrozen(veh, true)
            fadeCamera (false, 3.0, 0, 0, 0 )         -- fade the player's camera to red over a period of 1 second
            setTimer ( fadeCamera, 3000, 1,true, 3.0 )
            setTimer ( setElementFrozen, 3000, 1, veh, false)
			setTimer (function()
			triggerServerEvent("paygarbagecleaner",localPlayer,pay)
			exports.dendxmsg:createNewDxMessage("Got Paid $"..pay.." for collecting "..units.." trash units.",0,255,0) end,3000,1)
            setTimer(empty,3000,1)
        end

    end

end

 function death()
    if getElementData(localPlayer,"Occupation") == "Street Cleaner" then
		destroyAll()
    end
 end

 function truckExplode()
    if getElementModel(source) == 408 then

    end
 end
 addEventHandler("onClientPlayerWasted", localPlayer, death)
 addEventHandler("onClientVehicleExplode", root, truckExplode)

 function hitTrashMarker(hitPlayer)
    local marker = source
    if getElementType(hitPlayer) == "vehicle" then
		hitPlayer=getVehicleController(hitPlayer)
		if hitPlayer == false then return end
        if getElementData(hitPlayer,"Occupation") ~= "Street Cleaner" then return end
        local veh = getPedOccupiedVehicle(hitPlayer)
        if veh ~= false then
            if getVehicleController(veh) ~= hitPlayer then return end
            if getElementModel(veh) == 574 then
                local t = sweepData[source]
                destroyElement(t[1])
                destroyElement(t[2])
                destroyElement(t[3])
                destroyElement(source)
                sweepData[source] = nil

                local index = math.random(1,#items)
                local name1 = items[index]["name"]
                local weight1 = items[index]["weight"]
                setTimer(function() exports.dendxmsg:createNewDxMessage("1 Trash Unit Collected",0,255,0) end,500,1)
				exports.CSGscore:givePlayerScore(localPlayer,0.025)
                local t = {name=name1,weight=weight1}
                table.insert(collectedTable, t)

               -- triggerServerEvent("paygarbagecleaner",localPlayer,unitpay)

            else
            outputChatBox("You need a sweeper to sweep the garbage.",255,0,0,true)
            end
        else
            outputChatBox("You need a sweeper to sweep the garbage.",255,0,0,true)
        end

    end
end


if getElementData(localPlayer,"Occupation") == "Street Cleaner" then

    becameSC()
end

function drawText()
	local vehicle = getPedOccupiedVehicle(localPlayer)
	if (vehicle) then
		if getElementModel(vehicle) == 574 then
			else
			return
		end
	else
		return
	end
	screenWidth,screenHeight = guiGetScreenSize()
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Trash Units: #33FF33"..#collectedTable.."", screenWidth*0.08, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
end
addEventHandler("onClientRender",root,drawText)

function monitor()
	if getElementData(localPlayer,"Occupation") ~= "Street Cleaner" or getTeamName(getPlayerTeam(localPlayer)) ~= "Civilian Workers" then
		quitSC()
	else
		becameSC()
	end
end
setTimer(monitor,1000,0)
