warnWindow1 = guiCreateWindow(517,281,247,133,"CSG ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Warning!",false,warnWindow1)
guiLabelSetColor(warnLabel1,225,165,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton1 = guiCreateButton(33,97,181,27,"Close warning",false,warnWindow1)
warnLabel2 = guiCreateLabel(42,53,160,17,"You dont have this weapon!",false,warnWindow1)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(9,69,227,17,"First buy the weapon, and then ammo.",false,warnWindow1)
guiLabelSetColor(warnLabel3,225,225,225)
guiSetFont(warnLabel3,"default-bold-small")
-- 2
warnWindow2 = guiCreateWindow(517,281,247,133,"CSG ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Warning!",false,warnWindow2)
guiLabelSetColor(warnLabel1,225,165,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton2 = guiCreateButton(33,97,181,27,"Close warning",false,warnWindow2)
warnLabel2 = guiCreateLabel(36,53,174,17,"You already have this weapon!",false,warnWindow2)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(9,69,227,17,"Now you can buy ammo for this weapon!",false,warnWindow2)
guiLabelSetColor(warnLabel3,225,225,225)
guiSetFont(warnLabel3,"default-bold-small")
-- 3
warnWindow3 = guiCreateWindow(517,281,247,133,"CSG ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Succes!",false,warnWindow3)
guiLabelSetColor(warnLabel1,0,200,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton3 = guiCreateButton(33,97,181,27,"Close warning",false,warnWindow3)
warnLabel2 = guiCreateLabel(72,55,110,17,"Weapon bought!",false,warnWindow3)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(9,69,227,17,"Now you can buy ammo for this weapon!",false,warnWindow3)
guiLabelSetColor(warnLabel3,225,225,225)
guiSetFont(warnLabel3,"default-bold-small")
-- 4
warnWindow4 = guiCreateWindow(517,281,247,133,"CSG ~ Ammu Nation",false)
warnLabel1 = guiCreateLabel(96,27,55,17,"Warning!",false,warnWindow4)
guiLabelSetColor(warnLabel1,225,165,0)
guiSetFont(warnLabel1,"default-bold-small")
warnButton4 = guiCreateButton(33,97,181,27,"Close warning",false,warnWindow4)
warnLabel2 = guiCreateLabel(72,55,110,17,"Not enough money!",false,warnWindow4)
guiLabelSetColor(warnLabel2,225,225,225)
guiSetFont(warnLabel2,"default-bold-small")
warnLabel3 = guiCreateLabel(37,69,175,17,"You dont have enough money.",false,warnWindow4)
guiLabelSetColor(warnLabel3,225,225,225)
guiSetFont(warnLabel3,"default-bold-small")

guiWindowSetMovable (warnWindow1, true)
guiWindowSetSizable (warnWindow1, false)
guiSetVisible (warnWindow1, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow1,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow1,x,y,false)

guiWindowSetMovable (warnWindow2, true)
guiWindowSetSizable (warnWindow2, false)
guiSetVisible (warnWindow2, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow2,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow2,x,y,false)

guiWindowSetMovable (warnWindow3, true)
guiWindowSetSizable (warnWindow3, false)
guiSetVisible (warnWindow3, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow3,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow3,x,y,false)

guiWindowSetMovable (warnWindow4, true)
guiWindowSetSizable (warnWindow4, false)
guiSetVisible (warnWindow4, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(warnWindow4,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(warnWindow4,x,y,false)

addEventHandler("onClientGUIClick", warnButton1, function() guiSetVisible(warnWindow1, false) end, false)
addEventHandler("onClientGUIClick", warnButton2, function() guiSetVisible(warnWindow2, false) end, false)
addEventHandler("onClientGUIClick", warnButton3, function() guiSetVisible(warnWindow3, false) end, false)
addEventHandler("onClientGUIClick", warnButton4, function() guiSetVisible(warnWindow4, false) end, false)

ammoWindow = guiCreateWindow(296,113,705,503,"CSG ~ Ammu Nation",false)
coltImage = guiCreateStaticImage(25,24,59,63,"images/COLT45.png",false,ammoWindow)
coltWeapon = guiCreateButton(9,90,93,37,"Weapon (2.000$)",false,ammoWindow)
coltAmmo = guiCreateButton(9,131,93,37,"Magazine      (65$)",false,ammoWindow)
silencedImage = guiCreateStaticImage(150,25,60,60,"images/SILENCED.png",false,ammoWindow)
silencedWeapon = guiCreateButton(132,90,93,37,"Weapon (4.000$)",false,ammoWindow)
silencedAmmo = guiCreateButton(133,131,93,37,"Magazine      (65$)",false,ammoWindow)
deagleImage = guiCreateStaticImage(267,27,60,56,"images/DEAGLE.png",false,ammoWindow)
deagleWeapon = guiCreateButton(251,90,93,37,"Weapon (5.000$)",false,ammoWindow)
deagleAmmo = guiCreateButton(252,131,93,37,"Magazine      (95$)",false,ammoWindow)
shotgunImage = guiCreateStaticImage(386,29,61,53,"images/SHOTGUN.png",false,ammoWindow)
shotgunWeapon = guiCreateButton(368,90,93,37,"Weapon (7.000$)",false,ammoWindow)
shotgunAmmo = guiCreateButton(368,131,93,37,"Magazine      (200$)",false,ammoWindow)
sawnImage = guiCreateStaticImage(501,27,60,55,"images/SAWNOFF.png",false,ammoWindow)
sawmWeapon = guiCreateButton(485,90,93,37,"Weapon (10.000$)",false,ammoWindow)
sawmAmmo = guiCreateButton(485,131,93,37,"Magazine      (210$)",false,ammoWindow)
combatImage = guiCreateStaticImage(620,26,61,56,"images/COMBAT.png",false,ammoWindow)
combatWeapon = guiCreateButton(602,90,93,37,"Weapon (15.000$)",false,ammoWindow)
combatAmmo = guiCreateButton(603,131,93,37,"Magazine      (250$)",false,ammoWindow)
ak47Image = guiCreateStaticImage(25,189,59,61,"images/AK47.png",false,ammoWindow)
ak47Weapon = guiCreateButton(9,255,93,37,"Weapon (12.000$)",false,ammoWindow)
ak47Ammo = guiCreateButton(9,296,93,37,"Magazine      (450$)",false,ammoWindow)
m4Image = guiCreateStaticImage(149,187,61,59,"images/M4.png",false,ammoWindow)
m4Weapon = guiCreateButton(132,255,93,37,"Weapon (14.000$)",false,ammoWindow)
m4Ammo = guiCreateButton(133,296,93,37,"Magazine      (500$)",false,ammoWindow)
tecImage = guiCreateStaticImage(267,188,62,56,"images/TEC9.png",false,ammoWindow)
tecWeapon = guiCreateButton(251,255,93,37,"Weapon (9.000$)",false,ammoWindow)
tecAmmo = guiCreateButton(252,296,93,37,"Magazine      (350$)",false,ammoWindow)
uziImage = guiCreateStaticImage(387,185,60,58,"images/MICROUZI.png",false,ammoWindow)
uziWeapon = guiCreateButton(368,255,93,37,"Weapon (10.000$)",false,ammoWindow)
uziAmmos = guiCreateButton(368,297,93,37,"Magazine      (350$)",false,ammoWindow)
mp5Image = guiCreateStaticImage(501,187,60,54,"images/MP5.png",false,ammoWindow)
mp5Weapon = guiCreateButton(485,253,93,37,"Weapon (10.000$)",false,ammoWindow)
mp5Ammo = guiCreateButton(485,296,93,37,"Magazine      (400$)",false,ammoWindow)
rifleImage = guiCreateStaticImage(620,186,62,52,"images/RIFLE.png",false,ammoWindow)
rifleWeapon = guiCreateButton(602,254,93,37,"Weapon (8.000$)",false,ammoWindow)
rifleAmmo = guiCreateButton(603,295,93,37,"Magazine      (350$)",false,ammoWindow)
sniperImage = guiCreateStaticImage(24,354,58,58,"images/SNIPER.png",false,ammoWindow)
sniperWeapon = guiCreateButton(9,418,93,37,"Weapon (18.000$)",false,ammoWindow)
sniperAmmo = guiCreateButton(9,459,93,35,"Magazine      (500$)",false,ammoWindow)
stacelImage = guiCreateStaticImage(384,350,59,53,"images/SATCHEL.png",false,ammoWindow)
stachelBuy = guiCreateButton(368,418,93,37,"Satchel   (1000$)",false,ammoWindow)
katanaImage = guiCreateStaticImage(622,347,58,58,"images/KATANA.png",false,ammoWindow)
katanaBuy = guiCreateButton(602,418,93,37,"Katana   (5000$)",false,ammoWindow)
granadesImage = guiCreateStaticImage(149,350,60,56,"images/GRENADE.png",false,ammoWindow)
granadesBuy = guiCreateButton(132,418,93,37,"Granades (1000$)",false,ammoWindow)
tearImage = guiCreateStaticImage(270,351,59,54,"images/TEARGAS.png",false,ammoWindow)
tearBuy = guiCreateButton(251,418,93,37,"Tear Gas (1000$)",false,ammoWindow)
laserImage = guiCreateStaticImage(503,350,59,57,"images/laser.png",false,ammoWindow)
laserBuy = guiCreateButton(485,418,93,37,"Laser (5000$)",false,ammoWindow)
closeScreen = guiCreateButton(649,466,47,27,"Close",false,ammoWindow)
addEventHandler("onClientGUIClick", closeScreen, function() guiSetVisible(ammoWindow, false) showCursor(false) end, false)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(ammoWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(ammoWindow,x,y,false)

guiWindowSetMovable (ammoWindow, true)
guiWindowSetSizable (ammoWindow, false)
guiSetVisible (ammoWindow, false)

-- Set marker possitions in table and create markers
local ammoMarkers = {
[1]={307.97, -141.04, 999.6, 7, 1},
[2]={313.95, -133.69, 999.6, 7, 1},
[3]={290.15, -109.42, 1001.51, 6, 10},
[4]={291.49, -83.97, 1001.51, 4, 3},
[5]={291.4, -83.96, 1001.51, 4, 4},
[6]={291.49, -83.9, 1001.51, 4, 5},
[7]={291.46, -83.8, 1001.51, 4, 6},
[8]={290.07, -109.36, 1001.51, 6, 7},
[9]={290.02, -109.51, 1001.51, 6, 8},
[10]={295.64, -38, 1001.51, 1, 2},
[11]={290.13, -109.46, 1001.51, 6, 9},
[12]={311.88, -164.52, 999.6, 6, 11}
}


function ammoMarkerHit( hitPlayer, matchingDimension )
local px,py,pz = getElementPosition ( hitPlayer )
local mx, my, mz = getElementPosition ( source )
if matchingDimension then
	if hitPlayer == localPlayer then
		local vehicle = getPedOccupiedVehicle (localPlayer)
			if not vehicle then
				if ( pz-3 < mz ) and ( pz+3 > mz ) then
				local cost = 5000
				local tName = getTeamName(getPlayerTeam(localPlayer))
				if tName == "SWAT" or tName == "Military Forces" then
					cost = 1000
				else
					cost = 5000
				end
					guiSetText(laserBuy,"Laser ("..cost.."$)")
					guiSetVisible(ammoWindow,true)
					showCursor(true,true)
				end
			end
		end
	end
end

for ID in pairs(ammoMarkers) do
local x, y, z = ammoMarkers[ID][1], ammoMarkers[ID][2], ammoMarkers[ID][3]
local interior = ammoMarkers[ID][4]
local dimension = ammoMarkers[ID][5]
local ammoShopMarker = createMarker(x,y,z -1,"cylinder",1.5,200,0,0,225)
setElementInterior(ammoShopMarker, interior)
setElementDimension( ammoShopMarker, tonumber(dimension) )

addEventHandler("onClientMarkerHit", ammoShopMarker, ammoMarkerHit)
end

function warn1 ()

	guiSetVisible(warnWindow1,true)
	showCursor(true,true)
	guiBringToFront ( warnWindow1 )

end
addEvent ("warn1", true)
addEventHandler ("warn1", getRootElement(), warn1)

function warn2 ()

	guiSetVisible(warnWindow2,true)
	showCursor(true,true)
	guiBringToFront ( warnWindow2 )

end
addEvent ("warn2", true)
addEventHandler ("warn2", getRootElement(), warn2)

function warn3 ()

	guiSetVisible(warnWindow3,true)
	showCursor(true,true)
	guiBringToFront ( warnWindow3 )

end
addEvent ("warn3", true)
addEventHandler ("warn3", getRootElement(), warn3)

function warn4 ()

	guiSetVisible(warnWindow4,true)
	showCursor(true,true)
	guiBringToFront ( warnWindow4 )

end
addEvent ("warn4", true)
addEventHandler ("warn4", getRootElement(), warn4)

function buyLaser()
	exports.cpicker:openPicker("ammuLaser",false,"CSG ~ Pick a Laser Color")
end

function buyLaser2(id,hex,r,g,b)
	if id == "ammuLaser" then
		local cost = 5000
		local tName = getTeamName(getPlayerTeam(localPlayer))
		if tName == "SWAT" or tName == "Military Forces" then
			cost = 1000
		else
			cost = 5000
		end
		triggerServerEvent("CSGammu.buyLaser",localPlayer,cost,r,g,b)
	end
end
addEvent("onColorPickerOK",true)
addEventHandler("onColorPickerOK",root,buyLaser2)
-- weapon buys
addEventHandler("onClientGUIClick", coltWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "22", "2000" ) end, false)
addEventHandler("onClientGUIClick", silencedWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "23", "4000" ) end, false)
addEventHandler("onClientGUIClick", deagleWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "24", "5000" ) end, false)
addEventHandler("onClientGUIClick", shotgunWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "25", "7000" ) end, false)
addEventHandler("onClientGUIClick", sawmWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "26", "10000" ) end, false)
addEventHandler("onClientGUIClick", combatWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "27", "15000" ) end, false)
addEventHandler("onClientGUIClick", uziWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "28", "10000" ) end, false)
addEventHandler("onClientGUIClick", mp5Weapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "29", "10000" ) end, false)
addEventHandler("onClientGUIClick", ak47Weapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "30", "12000" ) end, false)
addEventHandler("onClientGUIClick", m4Weapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "31", "14000" ) end, false)
addEventHandler("onClientGUIClick", tecWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "32", "9000" ) end, false)
addEventHandler("onClientGUIClick", rifleWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "33", "8000" ) end, false)
addEventHandler("onClientGUIClick", sniperWeapon, function() triggerServerEvent ( "buyWeapon", localPlayer, "34", "18000" ) end, false)


-- ammo buys
addEventHandler("onClientGUIClick", coltAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "22", "65" ) end, false)
addEventHandler("onClientGUIClick", silencedAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "23", "65" ) end, false)
addEventHandler("onClientGUIClick", deagleAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "24", "95" ) end, false)
addEventHandler("onClientGUIClick", shotgunAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "25", "200" ) end, false)
addEventHandler("onClientGUIClick", sawmAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "26", "210" ) end, false)
addEventHandler("onClientGUIClick", combatAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "27", "250" ) end, false)
addEventHandler("onClientGUIClick", uziAmmos, function() triggerServerEvent ( "buyAmmo", localPlayer, "28", "350" ) end, false)
addEventHandler("onClientGUIClick", mp5Ammo, function() triggerServerEvent ( "buyAmmo", localPlayer, "29", "400" ) end, false)
addEventHandler("onClientGUIClick", ak47Ammo, function() triggerServerEvent ( "buyAmmo", localPlayer, "30", "450" ) end, false)
addEventHandler("onClientGUIClick", m4Ammo, function() triggerServerEvent ( "buyAmmo", localPlayer, "31", "500" ) end, false)
addEventHandler("onClientGUIClick", tecAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "32", "350" ) end, false)
addEventHandler("onClientGUIClick", rifleAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "33", "350" ) end, false)
addEventHandler("onClientGUIClick", sniperAmmo, function() triggerServerEvent ( "buyAmmo", localPlayer, "34", "500" ) end, false)

-- special weps
addEventHandler("onClientGUIClick", granadesBuy, function() triggerServerEvent ( "buySpecial", localPlayer, "16", "1000" ) end, false)
addEventHandler("onClientGUIClick", tearBuy, function() triggerServerEvent ( "buySpecial", localPlayer, "17", "1000" ) end, false)
--addEventHandler("onClientGUIClick", laserBuy, function() triggerServerEvent ( "buySpecial", localPlayer, "9", "5000" )  end, false)
addEventHandler("onClientGUIClick", laserBuy, buyLaser)
addEventHandler("onClientGUIClick", katanaBuy, function() triggerServerEvent ( "buySpecial", localPlayer, "8", "5000" ) end, false)
addEventHandler("onClientGUIClick", stachelBuy, function() triggerServerEvent ( "buySpecial", localPlayer, "39", "1000" ) end, false)
