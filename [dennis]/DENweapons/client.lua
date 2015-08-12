local markers = {
{300.27, -138.59, 1004.06,7,1},
{300.54, -137.02, 1004.06,7,1},
{300.23, -135.61, 1004.06,7,1},
{300.51, -134.1, 1004.06,7,1},
{300.36, -132.49, 1004.06,7,1},
{300.24, -130.88, 1004.06,7,1},
{300.52, -129.46, 1004.06,7,1},
{300.23, -127.96, 1004.06,7,1},
{302.82, -59.71, 1001.51,4,5},
{302.65, -61.18, 1001.51,4,5},
{302.36, -62.61, 1001.51,4,5},
{302.46, -64.33, 1001.51,4,5},
{302.4, -65.71, 1001.51,4,5},
{302.47, -67.22, 1001.51,4,5},
{302.39, -68.9, 1001.51,4,5},
{302.84, -70.28, 1001.51,4,5},
{289.24, -24.93, 1001.51, 1, 2},
{290.67, -25.15, 1001.51, 1, 2},
{292.22, -25.22, 1001.51, 1, 2},
{293.69, -25.00, 1001.51, 1, 2},
{295.21, -25.17, 1001.51, 1, 2},
{296.76, -25.07, 1001.51, 1, 2},
{298.17, -25.15, 1001.51, 1, 2},
{299.63, -25.16, 1001.51, 1, 2}
}

local pedCoords = {
[1] = {280.59, -139.83, 1004.06,7,1},
[2] = {280.7, -135.64, 1004.06,7,1},
[3] = {284.45, -131.24, 1004.06,7,1},
[4] = {288.15, -134.05, 1004.06,7,1},
[5] = {290.01, -135.76, 1004.06,7,1},
[6] = {285.16, -137.9, 1004.06,7,1},
[7] = {279.2, -139.89, 1004.06,7,1},
[8] = {276.01, -135.35, 1004.06,7,1},
[9] = {278.4, -129.79, 1004.06,7,1},
[10] = {283.1, -130.99, 1004.06,7,1},
[11] = {289.98, -128.18, 1004.06,7,1},
[12] = {295.72, -129.21, 1004.06,7,1}
}

local pedCoords2 = {
[1] = {323.37, -68.5, 1001.51, 4, 5},
[2] = {320.66, -63.53, 1001.51, 4, 5},
[3] = {316.79, -62.98, 1001.51, 4, 5},
[4] = {312.9, -64.97, 1001.51, 4, 5},
[5] = {310.32, -60.3, 1001.51, 4, 5},
[6] = {306.83, -62.14, 1001.51, 4, 5},
[7] = {308.87, -67.33, 1001.51, 4, 5},
[8] = {313.23, -67.54, 1001.51, 4, 5},
[9] = {316.17, -62.84, 1001.51, 4, 5},
[10] = {320.66, -59.85, 1001.51, 4, 5},
[11] = {321.6, -64.51, 1001.51, 4, 5},
[12] = {324.02, -69.11, 1001.51, 4, 5}
}

local pedCoords3 = {
[1] = {296.56, -11.83, 1001.51, 4, 5},
[2] = {292.73, -14.73, 1001.51, 4, 5},
[3] = {288.87, -12.69, 1001.51, 4, 5},
[4] = {290.76, -7.56, 1001.51, 4, 5},
[5] = {295.71, -6.91, 1001.51, 4, 5},
[6] = {295.72, -16.34, 1001.51, 4, 5},
[7] = {290.51, -17.84, 1001.51, 4, 5},
[8] = {285.87, -17.87, 1001.51, 4, 5},
[9] = {289.3, -12.77, 1001.51, 4, 5},
[10] = {298.1, -7.06, 1001.51, 4, 5},
[11] = {294.38, -19.18, 1001.51, 4, 5},
[12] = {288.65, -19.67, 1001.51, 4, 5}
}

local sx,sy = guiGetScreenSize()
local isPlayerDoingTest = false
local playerTestWeapon = nil
local theTestPeds = {}
local theTestPedsCount = 0

function createRangeWindow()
	guiRangeWindow = guiCreateWindow(133,280,365,344,"CSG ~ Ammu Nation Weapon Training",false)
	guiRangeLabel1 = guiCreateLabel(9,28,346,17,"Ammu Nation Weapon Trainings",false,guiRangeWindow)
	guiLabelSetColor(guiRangeLabel1,238	,154	,0)
	guiLabelSetHorizontalAlign(guiRangeLabel1,"center",false)
	guiSetFont(guiRangeLabel1,"default-bold-small")
	guiRangeLabel2 = guiCreateLabel(9,51,347,247,"Welcome to CSG Ammu-nation weapon range!\nHere you can improve your weapon skills.\nThe higher they are, the more advantages you will\nhave when using the weapon you trained with.\nWhen reaching 100% skill level with some weapons,\nyou will unlock the dual weapon mode.\nThis is possible with the Colt 45.\n\nObviously, you must use the same weapon you started with.\nShooting with other weapons will not work.\n\nEach shooting range round costs 250$ and if you succeed in\nkilling all the targets before the time ends,\nyou will increase your weapon skill by 5%.\n\nGood luck!",false,guiRangeWindow)
	guiLabelSetHorizontalAlign(guiRangeLabel2,"center",false)
	beginBtn = guiCreateButton(9,307,168,28,"Start Training!",false,guiRangeWindow)
	cancelBtn = guiCreateButton(184,307,168,28,"No Thanks!",false,guiRangeWindow)

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(guiRangeWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(guiRangeWindow,x,y,false)

	guiWindowSetMovable (guiRangeWindow, true)
	guiWindowSetSizable (guiRangeWindow, false)
	guiSetVisible (guiRangeWindow, false)

	addEventHandler("onClientGUIClick",beginBtn,startFiringRange, false)
	addEventHandler("onClientGUIClick",cancelBtn,function(btn,state) if btn == "left" and state == "up" then guiSetVisible(guiRangeWindow,false) showCursor(false) end end, false)
end

local theMarkers = {}

addEventHandler("onClientResourceStart",resourceRoot,
function()
	createRangeWindow()
	for i,v in pairs(markers) do
		for dimension=1,5 do
			theMarkers[i] = createMarker(v[1],v[2],v[3]-1,"cylinder",1,math.random(0,225),math.random(0,225),math.random(0,225),128)
			addEventHandler("onClientMarkerHit",theMarkers[i],openRangeGUI,false)
			setElementInterior(theMarkers[i],v[4])
			setElementDimension(theMarkers[i],dimension)
		end
	end
end)

function openRangeGUI( hitElement, matchingDimension )
	if ( hitElement == localPlayer ) and ( matchingDimension ) and not ( isPlayerDoingTest ) then
		guiSetVisible(guiRangeWindow,true)
		showCursor(true)
	end
end

function startFiringRange()
	guiSetVisible(guiRangeWindow,false)
	showCursor(false)
	if ( getPlayerMoney(localPlayer) >= 250 ) then
		triggerServerEvent("takePlayerTrainingMoney", localPlayer)
		if (getElementInterior(localPlayer) == 7) then
			for i=1,#pedCoords do
				theTestPeds[i] = createPed(math.random(168,189),pedCoords[i][1],pedCoords[i][2],pedCoords[i][3] +0.5, 269)
				theTestPedsCount = theTestPedsCount +1
				setElementData( theTestPeds[i], "weaponTrainPed", true )
				setElementInterior( theTestPeds[i], 7 )
				setElementDimension( theTestPeds[i], getElementDimension(localPlayer) )
			end
			addEventHandler( "onClientRender", root, onClientRenderWeaponTraining )
			shootingTimer = setTimer ( onWeaponTrainingEnd, 120000, 1, false )
			isPlayerDoingTest = true
		elseif (getElementInterior(localPlayer) == 4) then
			for i=1,#pedCoords2 do
				theTestPeds[i] = createPed(math.random(168,189),pedCoords2[i][1],pedCoords2[i][2],pedCoords2[i][3] +0.5, 269)
				theTestPedsCount = theTestPedsCount +1
				setElementData( theTestPeds[i], "weaponTrainPed", true)
				setElementInterior( theTestPeds[i], 4 )
				setElementDimension( theTestPeds[i], getElementDimension(localPlayer) )
			end
			addEventHandler( "onClientRender", root, onClientRenderWeaponTraining )
			shootingTimer = setTimer ( onWeaponTrainingEnd, 120000, 1, false )
			isPlayerDoingTest = true
		elseif (getElementInterior(localPlayer) == 1) then
			for i=1,#pedCoords3 do
				theTestPeds[i] = createPed(math.random(168,189),pedCoords3[i][1],pedCoords3[i][2],pedCoords3[i][3] +0.5, 179)
				theTestPedsCount = theTestPedsCount +1
				setElementData( theTestPeds[i], "weaponTrainPed", true)
				setElementInterior( theTestPeds[i], 1 )
				setElementDimension( theTestPeds[i], getElementDimension(localPlayer) )
			end
			addEventHandler( "onClientRender", root, onClientRenderWeaponTraining )
			shootingTimer = setTimer ( onWeaponTrainingEnd, 120000, 1, false )
			isPlayerDoingTest = true
		end
	else
		exports.DENdxmsg:createNewDxMessage("You don't have enough money for the training!",255,0,0)
	end
end

function onClientRenderWeaponTraining ()
	remaining, executesRemaining, totalExecutes = getTimerDetails( shootingTimer )
	dxDrawText(tostring(theTestPedsCount).." peds are alive ",sx*(1118.0/1440),sy*(244.0/900),sx*(1423.0/1440),sy*(275.0/900),tocolor(255,255,255,255),0.8,"bankgothic","right","top",false,false,false)
	dxDrawText(tostring(math.floor((remaining/1000))).." seconds remaining ",sx*(1118.0/1440),sy*(204.0/900),sx*(1423.0/1440),sy*(235.0/900),tocolor(255,255,255,255),0.8,"bankgothic","right","top",false,false,false)
	if ( theTestPedsCount <= 0 ) or not ( isTimer( shootingTimer ) ) then
		onWeaponTrainingEnd( true )
	end
end

function onWeaponTrainingEnd ( state )
	for i=1,#theTestPeds do
		destroyElement(theTestPeds[i])
		theTestPeds[i] = nil
	end

	isPlayerDoingTest = false

	if ( isTimer ( shootingTimer ) ) then killTimer( shootingTimer ) end
	removeEventHandler( "onClientRender", root, onClientRenderWeaponTraining )

	if ( state ) then
		exports.DENdxmsg:createNewDxMessage("You finished the weapon training!",255,0,0)
		triggerServerEvent( "onFinishWeaponTraining", localPlayer, tonumber(playerTestWeapon) )
	else
		exports.DENdxmsg:createNewDxMessage("You failed the weapon training!",255,0,0)
	end

	playerTestWeapon = nil
	theTestPedsCount = 0
end

addEventHandler("onClientPedWasted", root,
	function( killer, weapon, bodypart )
		if ( getElementData ( source, "weaponTrainPed" ) ) and ( killer == localPlayer ) then
			for k,v in pairs(theTestPeds) do
						theTestPedsCount = theTestPedsCount -1
						return

			end
		end
	end
)

local allowedWeapons = { [22]=true, [23]=true, [24]=true, [25]=true, [26]=true, [27]=true, [28]=true, [29]=true, [32]=true, [30]=true, [31]=true, [33]=true, [34]=true  }

addEventHandler("onClientPedDamage", root,
	function( attacker, weapon, bodypart )
		if ( isElement( attacker ) ) then
			if ( getElementData ( source, "weaponTrainPed" ) ) and ( attacker == localPlayer ) then
				if not ( ( allowedWeapons[getPedWeapon ( localPlayer )] ) ) then
					exports.DENdxmsg:createNewDxMessage("You can't use this weapon to train!",255,0,0)
					cancelEvent()
					return
				elseif ( playerTestWeapon == nil ) then
					playerTestWeapon = getPedWeapon ( localPlayer )
					return
				elseif ( playerTestWeapon ~= getPedWeapon ( localPlayer ) ) then
					exports.DENdxmsg:createNewDxMessage("You need to use the same weapon for the whole training!",255,0,0)
					cancelEvent()
					return
				end
			elseif ( getElementData ( source, "weaponTrainPed" ) ) then
				cancelEvent()
			end
		end
	end
)
