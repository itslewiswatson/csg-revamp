--------------Table (with dimention
posTable = {
[1] = {1963.8226318359,1037.1188964844,991.47448730469,10},
[2] = {1965.8908691406,1037.5777587891,991.46875,10},
[3] = {1961.3045654297,1042.9111328125,991.46875,10},
[4] = {1963.0009765625,1044.0911865234,991.46875,10},
[5] = {1958.0642089844,1049.0533447266,991.46875,10},
[6] = {1956.9056396484,1047.3427734375,991.46875,10},
[7] = {1958.2021484375,986.60021972656,991.46875,10},
[8] = {1956.9622802734,988.25408935547,991.46875,10},
[9] = {1961.302734375,992.56018066406,991.46875,10},
[10] = {1963.0461425781,991.45574951172,991.46875,10},
[11] = {1965.869140625,998.21820068359,991.46875,10},
[12] = {1963.8336181641,998.55065917969,991.47448730469,10}
}
function onStart ()
	for i=1, #posTable do
		local marker = createMarker(posTable[i][1],posTable[i][2],posTable[i][3],"cylinder", 1, 255,255,0)
		setElementInterior(marker, posTable[i][4])
		addEventHandler("onClientMarkerHit", marker, showGUI )
		addEventHandler("onClientMarkerLeave", marker, hideGUI )
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onStart)
--------------Marker/player handlers
function showGUI ( hitElement, md )
	if hitElement == localPlayer and md then
		if getElementInterior(localPlayer) ~= getElementInterior(source) then return end
		if slotWindow then
			showCursor(true)
			guiSetVisible(slotWindow, true)
			guiSetEnabled(btnSpin, false)
			guiSetEnabled(btnStop, false)
			guiSetEnabled(btnBet, true)
		else
			local screenWidth, screenHeight = guiGetScreenSize()
			local Width, Height = 250, 350
			local X = ( screenWidth/2 ) - ( Width/2 )
			local Y = ( screenHeight/2 ) - ( Height/2 )
			slotWindow = guiCreateWindow(X, Y, Width, Height, "CSG ~ Slot Machine", false)
			guiWindowSetSizable(slotWindow, false)
			guiCreateLabel(25, 245, 80, 30, "Bet amount:", false, slotWindow)
			betAmount = guiCreateEdit(105, 240,55, 30,"50", false, slotWindow)
			addEventHandler("onClientGUIBlur", betAmount, setMinBet)

			btnBet = guiCreateButton(165, 240, 60, 30, "Bet", false, slotWindow)
			addEventHandler("onClientGUIClick", btnBet, submitBet)

			btnSpin = guiCreateButton(25, 280, 90, 30, "Spin", false, slotWindow)
			guiSetEnabled(btnSpin, false)
			addEventHandler("onClientGUIClick", btnSpin, startSpining)

			btnStop = guiCreateButton(135, 280, 90, 30, "Stop", false, slotWindow)
			guiSetEnabled(btnStop, false)
			addEventHandler("onClientGUIClick", btnStop, stopSpining)

			btnClose = guiCreateButton(25, 315, 200, 30, "Close", false, slotWindow)
			addEventHandler("onClientGUIClick", btnClose, closeGUI)

			bg = guiCreateStaticImage(25, 30, 200, 200, "images/bg.png", false, slotWindow)
			lane1 = guiCreateStaticImage(15, -288, 53, 576, "images/lane.png", false, bg)
			lane2 = guiCreateStaticImage(73.5, 0, 53, 576, "images/lane.png", false, bg)
			lane3 = guiCreateStaticImage(132, -288, 53, 576, "images/lane.png", false, bg)
			showCursor(true)
		end
	end
end
function setMinBet ()
	if tonumber(guiGetText(betAmount)) < 50 then guiSetText(betAmount, 50)end
	if tonumber(guiGetText(betAmount)) > 5000 then guiSetText(betAmount, 5000)end
end


function submitBet ()
	if source ~= btnBet then return end
	local bet = tonumber(guiGetText(betAmount))
	if getPlayerMoney() < bet then exports.DENdxmsg:createNewDxMessage("You don't have that amount of money!", 255, 0, 0)
	else
		guiSetEnabled(btnBet, false)
		guiSetEnabled(betAmount, false)
		triggerServerEvent("slot:takeBetMoney", localPlayer, bet)
	end
end
function securityCheck ()
	if source == localPlayer then
		guiSetEnabled(btnSpin, true)
	end
end
addEvent("slot:continue",true)
addEventHandler("slot:continue",root, securityCheck)




function startSpining ()
	if source ~= btnSpin then return end
	guiSetEnabled(btnSpin, false)
	stopTimer = setTimer(guiSetEnabled, 3000, 1, btnStop, true)
	setTimer(deleteTimer, 3000, 1)
	addEventHandler("onClientRender", root, roll)
end
function deleteTimer ()
	stopTimer = nil
end
function stopSpining ()
	if source ~= btnStop then return end
	guiSetEnabled(btnStop, false)
	guiSetEnabled(btnBet, true)
	removeEventHandler("onClientRender", root, roll)
	getResults(localPlayer)
	guiSetEnabled(betAmount, true)
end

function closeGUI ()
	if source ~= btnClose then return end
		guiSetVisible(slotWindow, false)
		showCursor(false)
		removeEventHandler("onClientRender", root, roll)
		guiSetEnabled(btnStop, false)
		guiSetEnabled(btnSpin, false)
		guiSetEnabled(btnBet, true)
		guiSetEnabled(betAmount, true)
		if stopTimer then
			killTimer(stopTimer)
			stopTimer = nil
		end
end



function hideGUI ( hitElement )
	if hitElement == localPlayer and slotWindow then
		guiSetVisible(slotWindow, false)
		showCursor(false)
		removeEventHandler("onClientRender", root, roll)
		guiSetEnabled(btnStop, false)
		guiSetEnabled(btnSpin, false)
		guiSetEnabled(btnBet, true)
		guiSetEnabled(betAmount, true)
		if stopTimer then
			killTimer(stopTimer)
			stopTimer = nil
		end
	end
end


---------arrest/kill handlers
function onArrest ( theCop )
	if source == localPlayer then
		hideGUI(source)
	end
end
addEvent( "onClientPlayerArrested" )
addEventHandler( "onClientPlayerArrested", root, onArrest)
addEventHandler("onClientPlayerWasted", getLocalPlayer(), hideGUI)

------------The machine
function roll ()
	local x1,y1 = guiGetPosition(lane1, false)
	local x2,y2 = guiGetPosition(lane2, false)
	local x3,y3 = guiGetPosition(lane3, false)
		if x1 and y1 and x2 and y2 and x3 and y3 then
			if y1 >= 0 then y1 = -288 end
			if y2 <= -288 then y2 = 0 end
			if y3 >= 0 then y3 = -288 end
			guiSetPosition(lane1, x1,y1+10,false)
			guiSetPosition(lane2, x2,y2-10,false)
			guiSetPosition(lane3, x3,y3+15,false)
		end
end

combination = {
[1]={1,"Bell",-264},
[2]={2,"Bar",-216},
[3]={3,"Watermelon",-168},
[4]={4,"Seven",-120},
[5]={5,"Orange",-72},
[6]={6,"Grape",-28}
}

function getResults (player)
if player == localPlayer then
	local x1,y1 = guiGetPosition(lane1, false)
	local x2,y2 = guiGetPosition(lane2, false)
	local x3,y3 = guiGetPosition(lane3, false)

	local rLane1 = math.random(1,6)
		for i=1, #combination do
			if rLane1 == combination[i][1] then
				guiSetPosition(lane1, x1,combination[i][3],false)
				lane1result = combination[i][2]
			end
		end

	local rLane2 = math.random(1,6)
		for i=1, #combination do
			if rLane2 == combination[i][1] then
				guiSetPosition(lane2, x2,combination[i][3],false)
				lane2result = combination[i][2]
			end
		end

	local rLane3 = math.random(1,6)
		for i=1, #combination do
			if rLane3 == combination[i][1] then
				guiSetPosition(lane3, x3,combination[i][3],false)
				lane3result = combination[i][2]
			end
		end

	if lane1result and lane2result and lane3result then
		if (lane1result == lane3result) and (lane2result ~= lane3result) then prize = 1.5
		elseif (lane1result ~= lane3result) and ((lane1result == lane2result) or (lane2result == lane3result)) then prize = 1
		elseif (lane1result == lane2result) and (lane2result == lane3result) and (lane2result ~= "Bar") then prize = 3
		elseif (lane1result == lane2result) and (lane2result == lane3result) and (lane2result == "Bar") then prize = 5
		else prize = 0
		end
	end

	if prize then
		local bet = tonumber(guiGetText(betAmount))

		if prize == 0 then exports.DENdxmsg:createNewDxMessage("No prize for you!", 255, 0, 0) end
		if prize == 1 then exports.DENdxmsg:createNewDxMessage("Normal pair! Here is your money back.", 255, 215, 0) end
		if prize == 1.5 then exports.DENdxmsg:createNewDxMessage("Symmetric pair! Here is your prize: "..(bet*prize).." ." , 0, 255, 0) end
		if prize == 5 or prize ==  3 then exports.DENdxmsg:createNewDxMessage("Jackpot!!! Here is your prize : "..(bet*prize).." ." , 0, 255, 0) end

		triggerServerEvent("slot:givePrizeMoney", localPlayer, bet, prize)
		prize = nil
	end
end
end
