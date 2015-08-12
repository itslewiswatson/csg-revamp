cra=false

function pickCrate (hitElement, force, hitPart)
	if isElement(hitElement) and getElementModel(hitElement) == 1685 and getElementModel(source) == 530 and not getElementData(source, "withCrate") and not getElementData(hitElement, "onVehicle") then
		detachElements(hitElement)
		triggerServerEvent("pickCrate", source, hitElement)
		setElementData(source, "withCrate", true)
		setElementData(hitElement, "onVehicle", true)
		bindKey("2", "down", dropCrate, source, hitElement)
		cra=hitElement
		label = guiCreateLabel(0, 0.85, 1, 0.1, "Press 2 to drop the crate.", true)
		guiLabelSetHorizontalAlign(label, "center", false)
		timer = setTimer(checkForAccident, 1000,0,hitElement, source)
	end
end

addEvent("cancelPickCrate",true)
addEventHandler("cancelPickCrate",localPlayer,function(veh,crate)
	dropCrate("","",veh,crate)
end)

function dropCrate (key, keyState, veh, crate)
	unbindKey("2")
	if label and isElement(label) then destroyElement(label) end
	triggerServerEvent("dropCrate", crate)
	setElementData(veh, "withCrate", false)
	setElementData(crate, "onVehicle", false)
	killTimer(timer)
end

function disableFork (player)
	if player == localPlayer and getElementModel(source) == 530 then --and getElementData(source, "fromDS"") then
		toggleControl("special_control_down", false)
		toggleControl("special_control_up", false)
		addEventHandler("onClientVehicleCollision", source, pickCrate)
	end
end
addEventHandler("onClientVehicleEnter", root, disableFork)

function enableFork (player)
	if player == localPlayer and getElementModel(source) == 530 then --and getElementData(source, "fromDS"") then
		toggleControl("special_control_down", true)
		toggleControl("special_control_up", true)
		removeEventHandler("onClientVehicleCollision", source, pickCrate)

	end
end
addEventHandler("onClientVehicleExit", root, enableFork)

function checkForAccident (crate, veh)
	local x1,y1,z1 = getElementPosition(crate)
	local x2,y2,z2 = getElementPosition(veh)
	if getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) > 3 and not isElementInWater(crate) then
		triggerServerEvent("pickCrate", veh, crate)
	elseif getDistanceBetweenPoints3D(x1,y1,z1,x2,y2,z2) > 3 or isElementInWater(veh) then
		local x,y,z = getElementData(crate, "X"), getElementData(crate, "Y"), getElementData(crate, "Z")
		detachElements(crate)
		setElementPosition(crate, x,y,z)
		setElementRotation(crate ,0,0,0)
		unbindKey("2")
		if label and isElement(label) then destroyElement(label) end
		setElementData(veh, "withCrate", false)
		setElementData(crate, "onVehicle", false)
		killTimer(timer)
	end
end

addEvent("CSGdrugEvent.recBoatCol",true)
addEventHandler("CSGdrugEvent.recBoatCol",localPlayer,function(c) boatCol=c allowedToSee=true end)

data=nil

addEvent("CSGdrugEvent.recData",true)
addEventHandler("CSGdrugEvent.recData",localPlayer,function(t) data=t end)

addEvent("CSGdrugEvent.playHorn",true)
addEventHandler("CSGdrugEvent.playHorn",localPlayer,function() playSound("horn.mp3") end)

addEventHandler("onClientVehicleExit",root,function(e)
	if e == localPlayer then
		if getElementModel(source) == 530 then
			dropCrate("","",source,cra)
		end
	end
end)

function AbsoluteToRelativ2( X, Y )
    local rX, rY = guiGetScreenSize()
    local x = math.floor(X*rX/1280)
    local y = math.floor(Y*rY/768)
    return x, y
end

function dxDrawText2(text,x,y,x2,y2,color,scale,font,hAlign,arg,arg2,arg3,arg4,arg5,arg6)
	x,y = AbsoluteToRelativ2(x,y)
	x2,y2 = AbsoluteToRelativ2(x2,y2)
	exports.csgpriyenmisc:dxDrawColorText(text,x,y,x2,y2,color,scale,font,hAlign,arg)
	--dxDrawText(text,x,y,x2,y2,color,scale,font,hAlign,arg,arg2,arg3,arg4,arg5,arg6)
end

function dxDrawLine2(x,y,x2,y2,color,scale,bool)
	x,y = AbsoluteToRelativ2(x,y)
	x2,y2 = AbsoluteToRelativ2(x2,y2)
	dxDrawLine(x,y,x2,y2,color,scale,bool)
end

function dxDrawRectangle2(x,y,x2,y2,color,bool)
	x,y = AbsoluteToRelativ2(x,y)
	x2,y2 = AbsoluteToRelativ2(x2,y2)
	dxDrawRectangle(x,y,x2,y2,color,bool)
end

show=false
addCommandHandler("drugmenu",function() if show==true then show=false else show=true end end)
addEventHandler("onClientRender", root,
    function()
		if data == nil or data == false then return end
		if boatCol == nil or boatCol == false then return end
		if isElementWithinColShape(localPlayer,boatCol) == true or (show==true) then else return end
		--if show == false then return end
        dxDrawRectangle2(1000, 208, 269, 386, tocolor(0, 0, 0, 103), true)
        dxDrawText2("CSG Drug Shipment (/drugmenu to toggle)", 1048, 216, 1236, 234, tocolor(225, 0, 0, 255), 1, "default", "center", "top", false, false, true, false, false)
        dxDrawText2("#ff8c00Time Until Departure: #FFFFFF"..data.depTime.."s", 1008, 245, 1250, 263, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("#ff8c00Drug Crates Loaded: #FFFFFF"..data.loadedCrates.."", 1008, 263, 1242, 281, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
        dxDrawLine2(1000, 239, 1269, 239, tocolor(1, 223, 132, 255), 1, true)
        dxDrawLine2(1000, 304, 1269, 304, tocolor(1, 223, 132, 255), 1, true)
        dxDrawText2("#ff8c00Drug Crates Remaining: #FFFFFF"..data.remainingCrates.."", 1008, 282, 1216, 300, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("#ff8c00My Drug Points: #FFFFFF"..data.mypoints.."", 1008, 325, 1142, 341, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
        dxDrawLine2(1000, 365, 1269, 365, tocolor(1, 223, 132, 255), 1, true)
        dxDrawText2("#ff8c00All Time Kills / All Time Drug Points: #FFFFFF N/A", 1008, 343, 1267, 359, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("#ff8c00My Kills: #FFFFFF"..data.mykills.."", 1008, 307, 1142, 323, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
        dxDrawLine2(1136, 366, 1136, 593, tocolor(1, 223, 132, 255), 1, true)
        dxDrawText2("#0000ffTop Law (pts)", 1002, 369, 1136, 385, tocolor(255, 255, 255, 255), 1, "default", "center", "top", false, false, true, false, false)
        dxDrawText2("#ff0000Top Criminal (pts)", 1136, 369, 1270, 385, tocolor(255, 255, 255, 255), 1, "default", "center", "top", false, false, true, false, false)
        dxDrawLine2(1000, 385, 1269, 385, tocolor(1, 223, 132, 255), 1, true)
        dxDrawText2("1. "..data.lawtoppts1[1].. " ("..data.lawtoppts1[2].. ")", 1008, 388, 1142, 404, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("2. "..data.lawtoppts2[1].. " ("..data.lawtoppts2[2].. ")", 1008, 406, 1142, 422, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("3. "..data.lawtoppts3[1].. " ("..data.lawtoppts3[2].. ")", 1008, 424, 1142, 440, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("4. "..data.lawtoppts4[1].. " ("..data.lawtoppts4[2].. ")", 1008, 442, 1142, 458, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("5. "..data.lawtoppts5[1].. " ("..data.lawtoppts5[2].. ")", 1008, 460, 1142, 476, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawLine2(1000, 479, 1269, 479, tocolor(1, 223, 132, 255), 1, true)
        dxDrawText2("#0000ffTop Law (kills)", 1002, 482, 1136, 498, tocolor(255, 255, 255, 255), 1, "default", "center", "top", false, false, true, false, false)
        dxDrawLine2(1000, 499, 1269, 499, tocolor(1, 223, 132, 255), 1, true)
        dxDrawText2("#ff0000Top Criminal (kills)", 1136, 481, 1270, 497, tocolor(255, 255, 255, 255), 1, "default", "center", "top", false, false, true, false, false)
        dxDrawText2("1. "..data.lawtopkills1[1].. " ("..data.lawtopkills1[2].. ")", 1008, 503, 1142, 519, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("2. "..data.lawtopkills2[1].. " ("..data.lawtopkills2[2].. ")", 1008, 521, 1142, 537, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("3. "..data.lawtopkills3[1].. " ("..data.lawtopkills3[2].. ")", 1008, 539, 1142, 555, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("4. "..data.lawtopkills4[1].. " ("..data.lawtopkills4[2].. ")", 1008, 557, 1142, 573, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("5. "..data.lawtopkills5[1].. " ("..data.lawtopkills5[2].. ")", 1008, 575, 1142, 591, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("1. "..data.crimtoppts1[1].. " ("..data.crimtoppts1[2].. ")", 1143, 388, 1277, 404, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("2. "..data.crimtoppts2[1].. " ("..data.crimtoppts2[2].. ")", 1143, 406, 1277, 422, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("3. "..data.crimtoppts3[1].. " ("..data.crimtoppts3[2].. ")", 1143, 424, 1277, 440, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("4. "..data.crimtoppts4[1].. " ("..data.crimtoppts4[2].. ")", 1143, 442, 1277, 458, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("5. "..data.crimtoppts5[1].. " ("..data.crimtoppts5[2].. ")", 1143, 460, 1277, 476, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("1. "..data.crimtopkills1[1].. " ("..data.crimtopkills1[2].. ")", 1143, 503, 1277, 519, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("2. "..data.crimtopkills2[1].. " ("..data.crimtopkills2[2].. ")", 1143, 521, 1277, 537, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("3. "..data.crimtopkills3[1].. " ("..data.crimtopkills3[2].. ")", 1143, 539, 1277, 555, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("4. "..data.crimtopkills4[1].. " ("..data.crimtopkills4[2].. ")", 1143, 557, 1277, 573, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawText2("5. "..data.crimtopkills5[1].. " ("..data.crimtopkills5[2].. ")", 1143, 575, 1277, 591, tocolor(255, 255, 255, 255), 0.86, "default", "left", "top", false, false, true, false, false)
        dxDrawLine2(1000, 208, 1269, 208, tocolor(1, 223, 132, 255), 1, true)
        dxDrawLine2(998, 209, 999, 592, tocolor(1, 223, 132, 255), 1, true)
        dxDrawLine2(999, 592, 1271, 592, tocolor(1, 223, 132, 255), 1, true)
        dxDrawLine2(1269, 209, 1270, 592, tocolor(1, 223, 132, 255), 1, true)
    end
)

moving = false

setTimer(function()
	if data ~= nil then
		if moving == true then
		if isElementWithinColShape(localPlayer,boatCol) then
			toggleControl("jump",false)
		else
			toggleControl("jump",true)
		end
		end
		if type(tonumber(data.depTime)) == "number" then data.depTime=data.depTime-1 else return end
		if data.depTime<=0 then moving = true data.depTime = "Heading to North SF                        " setTimer(function() moving=false toggleControl("jump",true) end,240000,1) end

	end
end,1000,0)

addEventHandler("onClientExplosion", root,
function( x, y, z, theType)
 if data == nil then return end
 if isElementWithinColShape(localPlayer,boatCol) == true then
  if ( theType == 0 ) or ( theType == 1 ) then
   cancelEvent()
  end
 end
end
)
------
GUIEditor = {
    gridlist = {},
    button = {},
    label = {},
    window = {},
}
window = guiCreateWindow(504, 252, 301, 248, "CSG Drug Shipment", false)
guiWindowSetSizable(window, false)

theGrid = guiCreateGridList(11, 52, 277, 123, false, window)
guiGridListAddColumn(theGrid, "Drug", 0.7)
guiGridListAddColumn(theGrid, "Points per Hit", 0.3)
for i = 1, 6 do
    guiGridListAddRow(theGrid)
end
guiGridListSetItemText(theGrid, 0, 1, "Ritalin", false, false)
guiGridListSetItemText(theGrid, 0, 2, "1", false, false)
guiGridListSetItemText(theGrid, 1, 1, "Weed", false, false)
guiGridListSetItemText(theGrid, 1, 2, "1", false, false)
guiGridListSetItemText(theGrid, 2, 1, "LSD", false, false)
guiGridListSetItemText(theGrid, 2, 2, "1", false, false)
guiGridListSetItemText(theGrid, 3, 1, "Cocaine", false, false)
guiGridListSetItemText(theGrid, 3, 2, "1", false, false)
guiGridListSetItemText(theGrid, 4, 1, "Ecstasy", false, false)
guiGridListSetItemText(theGrid, 4, 2, "1", false, false)
guiGridListSetItemText(theGrid, 5, 1, "Heroine", false, false)
guiGridListSetItemText(theGrid, 5, 2, "1", false, false)
GUIEditor.label[1] = guiCreateLabel(12, 26, 61, 19, "My Points:", false, window)
guiLabelSetColor(GUIEditor.label[1], 244, 93, 10)
lblMyPoints = guiCreateLabel(77, 26, 61, 19, "0", false, window)
GUIEditor.button[1] = guiCreateButton(14, 183, 135, 26, "Buy 1x", false, window)
GUIEditor.button[2] = guiCreateButton(153, 183, 135, 26, "Buy 5x", false, window)
GUIEditor.button[5] = guiCreateButton(14, 213, 274, 26, "Exit", false, window)
guiSetVisible(window,false)
guiGridListSetSelectionMode(theGrid,0)
ped=createPed(68,  -1827.2, 50.67, 15.12,264)
setElementData(ped,"showModelPed",true)
setElementFrozen(ped,true)

function hitMarker(e,bool)
	if e ~= localPlayer then return end
	if bool == true then
		if isPedInVehicle(localPlayer) == true then
			exports.dendxmsg:createNewDxMessage("Exit your vehicle first before using this marker",255,255,0)
			return
		else
			if data ~= nil then
				guiSetVisible(window,true)
				showCursor(true)
				guiSetText(lblMyPoints,data.mypoints)
			else
				exports.dendxmsg:createNewDxMessage("Drug Shipment is not active yet, or you are too late!",255,255,0)
				exports.dendxmsg:createNewDxMessage("You must exchange your points 20 minutes or before when the drug shipment ends!",255,255,0)
				return
			end
		end
	end
end
local m = createMarker( -1827.2, 50.67, 14.12,"cylinder",2,255,255,0,100)
addEventHandler("onClientMarkerHit",m,hitMarker)

function click()
	if source == GUIEditor.button[1] then
		local row = guiGridListGetSelectedItem(theGrid)
		if row ~= false and row ~= -1 and row ~= nil  then
			local name = guiGridListGetItemText(theGrid,row,1)
			local costPer = guiGridListGetItemText(theGrid,row,2)
			local totalCost = costPer*1
			if data.mypoints >= totalCost then
				data.mypoints=data.mypoints-totalCost
				guiSetText(lblMyPoints,data.mypoints)
				triggerServerEvent("CSGdrugEvent.bought",localPlayer,name,1,totalCost)
			else
				exports.dendxmsg:createNewDxMessage("You don't have enough drug points for this",255,255,0)
			end
		end
	elseif source == GUIEditor.button[2] then
		local row = guiGridListGetSelectedItem(theGrid)
		if row ~= false and row ~= -1 and row ~= nil  then
			local name = guiGridListGetItemText(theGrid,row,1)
			local costPer = guiGridListGetItemText(theGrid,row,2)
			local totalCost = costPer*5
			if data.mypoints >= totalCost then
				data.mypoints=data.mypoints-totalCost
				guiSetText(lblMyPoints,data.mypoints)
				triggerServerEvent("CSGdrugEvent.bought",localPlayer,name,5,totalCost)
			else
				exports.dendxmsg:createNewDxMessage("You don't have enough drug points for this",255,255,0)
			end
		end
	elseif source == GUIEditor.button[5] then
		guiSetVisible(window,false)
		showCursor(false)
	end
end
addEventHandler("onClientGUIClick",root,click)
