--++++++++++++++++++++++++++++++++--
---------TO CLEAR ELEMENT DATA----------
--++++++++++++++++++++++++++++++++--
setElementData(localPlayer, "isPlayerInsideBank", false )
setElementData(localPlayer, "br:bag", false)
setElementData(localPlayer, "isPlayerRobbingBank", false)
setElementData(localPlayer, "bank", false)
setElementData(localPlayer, "bankrob:running", false)
local alarms = { 
}

--++++++++++++++++++++++++++++++++--
---------------START THE ROB-----------------
--++++++++++++++++++++++++++++++++--
addEvent("CSGbankrob:startAlarm", true)
function playAlarm(bank)
	local dim = getElementData(bank, "warpDim")
	local alarm = playSound3D("alarm.mp3", 457.95, -2524.98, 56.3, true)
	setElementDimension(alarm, dim)
	setSoundMaxDistance(alarm, 1000)
	alarms[#alarms+1] = { dim, alarm }
	
	local bankArea = createColSphere(0,0,0, 500)
	attachElements(bankArea, bank)
	setElementData(bank, "bankArea", bankArea)
	setElementData(bankArea, "bank", bank)
	addEventHandler("onClientColShapeLeave", bankArea, onBankAreaLeave) 
end
addEventHandler("CSGbankrob:startAlarm", root, playAlarm)


--++++++++++++++++++++++++++++++++--
-------------------STEP 1------------------------
--++++++++++++++++++++++++++++++++--
addEvent("CSGbankrob:createSecMarker", true)
function createSecMarker()
	local secMarker = createMarker( 448.09, -2529.67, 63.24, "cylinder", 1, 255, 0, 0)
	addEventHandler("onClientMarkerHit", secMarker, showGUI)
	setElementDimension(secMarker, getElementData(source, "warpDim"))
	setElementData(source, "secMarker", secMarker)
	setElementData(secMarker, "isGUIOpen", false)
end
addEventHandler("CSGbankrob:createSecMarker", root, createSecMarker)



function showGUI(hitElement, matchingDimension)
	if hitElement == localPlayer and matchingDimension and not getElementData(getElementData(hitElement, "bank"), "isGUIOpen") then
		local x,y,z = getElementPosition(hitElement)
		local mx,my,mz = getElementPosition(source)
		if not (z-2 > mz) then
			setElementData(getElementData(hitElement, "bank"), "isGUIOpen", true)
			guiSetVisible(secPanel, true)
			showCursor(true)		
		end
	end
end
function hideGUI ()
	if source ~= closeBtn then return end
	if secPanel then
		guiSetVisible(secPanel, false)
		showCursor(false)
		setElementData(getElementData(localPlayer, "bank"), "isGUIOpen", false)
	end
end
function checkCodes ()
	if source ~= openDoorBtn then return end
		local bank = getElementData(localPlayer, "bank")
		local bankManager = getElementData(bank, "bankManager")
		local bankCashier = getElementData(bank, "bankCashier")
		local codeOne = getElementData(bankCashier,"bankCode")
		local codeTwo = getElementData(bankManager,"bankCode")
		if tonumber(guiGetText(code1)) == tonumber(codeOne) and tonumber(guiGetText(code2)) == tonumber(codeTwo) then
			guiSetVisible(loadingLabel, true)
			guiSetText(loadingLabel, "Loading...")
			progressTimer = setTimer(increaseProgressBar, 1000, 0, bank)
			guiSetEnabled(source, false)
		else 
			guiSetVisible(loadingLabel, true)
			guiSetText(loadingLabel, "Incorrect code(s)")
			guiSetEnabled(source, true)
		end
end
function increaseProgressBar (bank)
	guiProgressBarSetProgress(progBar, guiProgressBarGetProgress(progBar)+5)
	if guiProgressBarGetProgress(progBar) == 100 then
		killTimer(progressTimer)
		guiSetVisible(loadingLabel, false)
		if secPanel then
			guiSetVisible(secPanel, false)
			showCursor(false)
			setElementData(getElementData(localPlayer, "bank"), "isGUIOpen", false)
		end
		guiSetText(code1, "")
		guiSetText(code2, "")
		guiProgressBarSetProgress(progBar, 0)
		guiSetEnabled(openDoorBtn, true)
		triggerServerEvent("CSGbankrob:openAccessDoor", root, bank)
	end
end

--++++++++++++++++++++++++++++++++--
-----------------START STEP 2-----------------
--++++++++++++++++++++++++++++++++--
function onExplosion( x, y, z )
if getElementType(source) == "player" then
	for i,v in ipairs(getElementsByType("object")) do
		if (getElementModel ( v ) == 2634) and getElementDimension(v) == getElementDimension(source) then
			local doorx, doory, doorz = getElementPosition(v)
			local distance = getDistanceBetweenPoints3D(doorx, doory, doorz, x, y, z)
			if (distance <= 3) then
				triggerServerEvent("CSGbankrob:onVaultExplosion", v )
			end
		end
	end
end
end
addEventHandler("onClientExplosion", root, onExplosion)

addEvent("CSGbankrob:collectingMoney", true)
function collectingMoney()
	if source == localPlayer then
		exports.CSGprogressbar:createProgressBar("Picking the money...",50,"CSGbankrob:pickMoney") 
	end
end
addEventHandler("CSGbankrob:collectingMoney", root, collectingMoney)

addEvent("CSGbankrob:stopCollectingMoney", true)
function stopCollectingMoney ()
	if source == localPlayer then
		exports.CSGprogressbar:cancelProgressBar()
	end
end
addEventHandler("CSGbankrob:stopCollectingMoney", root, stopCollectingMoney)

addEvent("CSGbankrob:pickMoney")
function giveMoneyBag ()
	if source == localPlayer then
		setElementData(localPlayer, "bankrob:running", true)
		triggerServerEvent("CSGbankrob:givebag", localPlayer)
	end
end
addEventHandler("CSGbankrob:pickMoney", root, giveMoneyBag)
--      /-------------------------------------------
--  <++++++++SERVER+++++++++++++++
--      \-------------------------------------------


--++++++++++++++++++++++++++++++++--
----------END ROB FOR PLAYER--------------
--++++++++++++++++++++++++++++++++--
function onBankAreaLeave (hitElement, matchingDimension)
	if hitElement == localPlayer and matchingDimension then
		if getElementData(hitElement, "bankrob:running") and getElementData(localPlayer, "bank") == getElementData(source, "bank")then
			setElementData(hitElement, "bankrob:running", false)
			setElementData(hitElement, "isPlayerRobbingBank", false)
			triggerServerEvent("CSGbankrob:robSuccess", hitElement)
			destroyElement(source)
		end
	end
end
--      /-------------------------------------------
--  <++++++++SERVER+++++++++++++++
--      \-------------------------------------------

addEvent("CSGbankrob:onArrest", true)
function onPlayerDead ()
	if source == localPlayer and getElementData(source, "isPlayerRobbingBank") then
		if secPanel then
			guiSetVisible(secPanel, false)
			showCursor(false)
			setElementData(getElementData(localPlayer, "bank"), "isGUIOpen", false)
		end
		local bag = getElementData(source, "br:bag")
		local bank = getElementData(source, "bank")
		showCursor(false)
		setElementData(source, "bankrob:running", false)
		guiSetText(code1, "")
		guiSetText(code2, "")
		guiSetVisible(loadingLabel, false)
		guiProgressBarSetProgress(progBar, 0)
		guiSetEnabled(openDoorBtn, true)
		triggerServerEvent("CSGbankrob:RobFailed", bag, localPlayer )
		setElementData(localPlayer, "isPlayerRobbingBank", false)
		setElementData(source, "isPlayerInsideBank", false)
	end
end
addEventHandler("onClientPlayerWasted", root, onPlayerDead)
addEventHandler("CSGbankrob:onArrest", root, onPlayerDead)




--++++++++++++++++++++++++++++++++--
--------------------END ROB --------------------
--++++++++++++++++++++++++++++++++--
addEvent("CSGbankrob:endRob", true)
function endRob ()
	for i = 1, #alarms do 
		if alarms[i][1] == getElementData(source, "warpDim") then
			if isElement(alarms[i][2]) then destroyElement(alarms[i][2]) end
		end
	end
end
addEventHandler("CSGbankrob:endRob", root, endRob)


--++++++++++++++++++++++++++++++++--
---------SECURITY PANEL GUI----------------
--++++++++++++++++++++++++++++++++--
local screenWidth, screenHeight = guiGetScreenSize()
local Width, Height =  251, 264
local X = ( screenWidth/2 ) - ( Width/2 )
local Y = ( screenHeight/2 ) - ( Height/2 )

secPanel = guiCreateWindow(X, Y, Width, Height, "CSG ~ Bank Security Panel", false)
guiWindowSetSizable(secPanel, false)

openDoorBtn = guiCreateButton(10, 226, 113, 28, "Open door", false, secPanel)
	addEventHandler("onClientGUIClick", openDoorBtn, checkCodes)
closeBtn = guiCreateButton(135, 226, 113, 28, "Close", false, secPanel)
	addEventHandler("onClientGUIClick", closeBtn, hideGUI)
	
progBar = guiCreateProgressBar(10, 194, 230, 26, false, secPanel)

loadingLabel = guiCreateLabel(0, 0, 1, 1, "Loading...", true, progBar)
guiLabelSetHorizontalAlign(loadingLabel,"center")
guiLabelSetVerticalAlign(loadingLabel,"center")
guiLabelSetColor(loadingLabel, 255, 0, 0)
guiSetVisible(loadingLabel, false)

code1 = guiCreateEdit(73, 66, 110, 31, "", false, secPanel)
code2 = guiCreateEdit(73, 148, 110, 31, "", false, secPanel)
guiCreateLabel(102, 41, 81, 21, "Code #1:", false, secPanel)
guiCreateLabel(102, 122, 81, 21, "Code #2:", false, secPanel)
guiSetVisible(secPanel, false)


