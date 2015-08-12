----------------------------------------------------------------------------------
 -- CSG
 -- CSGdrugs/drugFactory.lua
 -- Drugs
 -- Rozza
----------------------------------------------------------------------------------


local blip = createBlip(-1826.84, 43.76, 16.12, 17, 2, 255, 0, 0, 255, 0, 400)
local drugMarkerPos = {
	{x=2560.5, y=-1303.5, z=1043, int=2, dim=10},
	{x=2560.5, y=-1283.5, z=1043, int=2, dim=10},
	{x=2560.5, y=-1323.5, z=1043, int=2, dim=10},
	{x=2552.5, y=-1283.5, z=1043, int=2, dim=10},
	{x=2552.5, y=-1303.5, z=1043, int=2, dim=10},
	{x=2544.5, y=-1283.6, z=1043, int=2, dim=10},
	{x=2544.5, y=-1303.6, z=1043, int=2, dim=10},
}
local humanCode = 0
local humanFails = 0
local makingDrug = ""
local resX, resY = guiGetScreenSize()
local makingDrugs = false
local lBar = 0
local drugMarkers = {}
-- original: 889,512,341,205
local width,height = 341,205
local X = (resX/2) - (width/2)
local Y = (resY/2) - (height/2)
drugFacWindow1 = guiCreateWindow(X,Y,width,height,"Community of Social Gaming ~ Drug Factory",false)
drugFacRadio1 = guiCreateRadioButton(59,25,101,21,"Ritalin (5 pills)",false,drugFacWindow1)
guiSetFont(drugFacRadio1,"default-bold-small")
drugFacRadio2 = guiCreateRadioButton(176,25,124,21,"LSD (6 pills)",false,drugFacWindow1)
guiSetFont(drugFacRadio2,"default-bold-small")
drugFacRadio3 = guiCreateRadioButton(177,48,124,21,"Cocaine (5 grams)",false,drugFacWindow1)
guiSetFont(drugFacRadio3,"default-bold-small")
drugFacRadio4 = guiCreateRadioButton(59,48,105,21,"Ecstasy (5 pills)",false,drugFacWindow1)
guiSetFont(drugFacRadio4,"default-bold-small")
drugFacRadio5 = guiCreateRadioButton(178,72,123,21,"Heroine (5 grams)",false,drugFacWindow1)
guiSetFont(drugFacRadio5,"default-bold-small")
drugFacRadio6 = guiCreateRadioButton(59,71,109,21,"Weed seeds (5)",false,drugFacWindow1)
guiSetFont(drugFacRadio6,"default-bold-small")
drugFacLabel1 = guiCreateLabel(35,104,260,17,"",false,drugFacWindow1)
guiLabelSetColor(drugFacLabel1,225,0,0)
guiLabelSetHorizontalAlign(drugFacLabel1,"center",false)
guiSetFont(drugFacLabel1,"default-bold-small")
drugFacLabel2 = guiCreateLabel(82,179,5,5,"",false,drugFacLabel1)
drugFacLabel3 = guiCreateLabel(35,120,260,17,"Enter the following code: aaaa",false,drugFacWindow1)
guiLabelSetColor(drugFacLabel3,225,225,225)
guiLabelSetHorizontalAlign(drugFacLabel3,"center",false)
guiSetFont(drugFacLabel3,"default-bold-small")
drugFacEdit1 = guiCreateEdit(93,139,149,22,"",false,drugFacWindow1)
drugFacButton1 = guiCreateButton(46,170,118,23,"Start producing",false,drugFacWindow1)
drugFacButton2 = guiCreateButton(169,169,118,23,"Close",false,drugFacWindow1)
guiSetVisible(drugFacWindow1, false)
guiSetEnabled(drugFacRadio6, false)

function onMarkerHit(elem, dim)
	if (dim and elem == localPlayer) then
		local _,_,pz = getElementPosition(localPlayer)
		local _,_,mz = getElementPosition(source)
		
		local int = getElementInterior(localPlayer)
		local dim = getElementDimension(localPlayer)
		if (int ~= 2) then
			return false
		end
		if (math.abs(pz-mz) > 3 ) then
			return false
		end
		if (getTeamName(getPlayerTeam(localPlayer)) ~= "Criminals") then
			outputChatBox("You must be a criminal to make drugs", 255, 0, 0)
			return false
		end
		if (makingDrugs) then
			outputChatBox("You cannot make drugs right now", 255, 0, 0)
			return false
		end
		if (getElementHealth(localPlayer) < 5) then
			return false
		end
		guiSetVisible(drugFacWindow1, true)
		showCursor(true)
		toggleControl("walk", false)
		toggleControl("sprint", false)
		toggleControl("jump", false)
		toggleControl("crouch", false)
		toggleControl("forwards", false)
		toggleControl("backwards", false)
		toggleControl("left", false)
		toggleControl("right", false)
		setPedWeaponSlot(localPlayer, 0)
		guiSetInputMode("no_binds_when_editing")
		humanCode = math.random(1422422)
		guiSetText(drugFacLabel3, "Enter the following code: " .. humanCode)
		guiSetText(drugFacEdit1, "")
	end
end

function closeDrugFactory()
	guiSetInputMode("allow_binds")
	showCursor(false)
	guiSetVisible(drugFacWindow1, false)
	toggleControl("walk", true)
	toggleControl("sprint", true)
	toggleControl("jump", true)
	toggleControl("crouch", true)
	toggleControl("forwards", true)
	toggleControl("backwards", true)
	toggleControl("left", true)
	toggleControl("right", true)
end
addEventHandler("onClientGUIClick", drugFacButton2, closeDrugFactory, false)

for a,b in pairs(drugMarkerPos) do
	local marker = createMarker(b["x"], b["y"], b["z"], "cylinder", 2, math.random(0, 255), math.random(0, 255), math.random(0, 255))
	setElementInterior(marker, b["int"])
	setElementDimension(marker, b["dim"])
	drugMarkers[marker] = true
	addEventHandler("onClientMarkerHit", marker, onMarkerHit)
end

function makeHit()
	if (makingDrugs) then
		return false
	end
	local confirm = tonumber(guiGetText(drugFacEdit1))
	if (humanCode == confirm) then
		humanFails = 0
		if (guiRadioButtonGetSelected(drugFacRadio1)) then
			makingDrug = "Ritalin"
		elseif (guiRadioButtonGetSelected(drugFacRadio2)) then
			makingDrug = "LSD"
		elseif (guiRadioButtonGetSelected(drugFacRadio3)) then
			makingDrug = "Cocaine"
		elseif (guiRadioButtonGetSelected(drugFacRadio4)) then
			makingDrug = "Ecstasy"
		elseif (guiRadioButtonGetSelected(drugFacRadio5)) then
			makingDrug = "Heroine"
		elseif (guiRadioButtonGetSelected(drugFacRadio6)) then
			makingDrug = "Weed"
		end
		if (not makingDrug or makingDrug == "") then
			return false
		end
		startBar()
	else
		humanFails = humanFails + 1
		if (humanFails > 9) then
			triggerServerEvent("CSGdrugs.reportBot", localPlayer, humanFails)
		end
		outputChatBox("Wrong code, try again", 255, 0, 0)
	end
end
addEventHandler("onClientGUIClick", drugFacButton1, makeHit, false)

function drugMade()
	makingDrugs = false
	setElementFrozen(localPlayer, false)
	toggleControl("walk", true)
	toggleControl("sprint", true)
	toggleControl("jump", true)
	toggleControl("crouch", true)
	toggleControl("forwards", true)
	toggleControl("backwards", true)
	toggleControl("left", true)
	toggleControl("right", true)
	local hits = 0
	if (makingDrug == "Ritalin") then
		hits = 5
	elseif (makingDrug == "Ecstasy") then
		hits = 5
	elseif (makingDrug == "Weed") then
		hits = 5
	elseif (makingDrug == "LSD") then
		hits = 6
	elseif (makingDrug == "Cocaine") then
		hits = 5
	elseif (makingDrug == "Heroine") then
		hits = 5
	end
	triggerServerEvent("CSGdrugs.madeDrug", localPlayer, makingDrug, hits)
	outputChatBox("You've successfully made " .. hits .. " hits of " .. makingDrug, 0, 255, 0)
	makingDrug = ""
end
addEvent("CSGdrugs.progressBarDone", true)
addEventHandler("CSGdrugs.progressBarDone", localPlayer, drugMade)

function startBar()
	guiSetVisible(drugFacWindow1, false)
	showCursor(false)
	setElementFrozen(localPlayer, true)
	makingDrugs = true
	toggleAllControls(false, false, false)
	if getElementData(localPlayer,"Rank") == "Drug Smuggler" then
		exports.CSGprogressbar:createProgressBar( "Making..", 600, "CSGdrugs.progressBarDone" )
	else
		exports.CSGprogressbar:createProgressBar( "Making..", 800, "CSGdrugs.progressBarDone" )
	end
end

function wasted()
	if (makingDrugs) then
		makingDrugs = false
		makingDrug = ""
		exports.CSGprogressbar:cancelProgressBar()
		setElementFrozen(localPlayer, false)
		toggleControl("walk", true)
		toggleControl("sprint", true)
		toggleControl("jump", true)
		toggleControl("crouch", true)
		toggleControl("forwards", true)
		toggleControl("backwards", true)
		toggleControl("left", true)
		toggleControl("right", true)
	end
end
addEventHandler("onClientPlayerWasted", localPlayer, wasted)
