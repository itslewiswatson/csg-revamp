------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppFish_c.luac (server-side)
--  Fisherman Job
--  Priyen Patel
------------------------------------------------------------------------------------


	local gui = {}
	gui._placeHolders = {}

	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 539, 355
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	windowFishInv = guiCreateWindow(left, top, windowWidth, windowHeight, "Community of Social Gaming ~ Fishing", false)
	guiWindowSetSizable(windowFishInv, false)

	gui["btnCloseInv"] = guiCreateButton(10, 322, 521, 23, "Close", false, windowFishInv)

	gui["tabWidget"] = guiCreateTabPanel(10, 25, 521, 291, false, windowFishInv)

	gui["tab"] = guiCreateTab("Inventory", gui["tabWidget"])

	gui["listFishInv"] = guiCreateGridList(10, 10, 491, 227, false, gui["tab"])
	guiGridListSetSortingEnabled(gui["listFishInv"], false)
	gui["listFishInv_col0"] = guiGridListAddColumn(gui["listFishInv"], "Fish", 0.2503666)
	gui["listFishInv_col1"] = guiGridListAddColumn(gui["listFishInv"], "Weight (Kg)", 0.223666)
	gui["listFishInv_col2"] = guiGridListAddColumn(gui["listFishInv"], "CSG Record (Kg)", 0.243666)
	gui["listFishInv_col3"] = guiGridListAddColumn(gui["listFishInv"], "Value ($)", 0.203666)
	guiGridListSetSelectionMode(gui["listFishInv"],0)
	local listFishInv_row = nil

	gui["btnSell"] = guiCreateButton(10, 240, 101, 23, "Sell", false, gui["tab"])

	gui["btnEat"] = guiCreateButton(140, 240, 101, 23, "Eat", false, gui["tab"])

	gui["btnDrop"] = guiCreateButton(270, 240, 101, 23, "Drop", false, gui["tab"])

	gui["btnRelease"] = guiCreateButton(400, 240, 101, 23, "Release", false, gui["tab"])

	gui["tab_2"] = guiCreateTab("Records", gui["tabWidget"])

	gui["listRecords"] = guiCreateGridList(10, 10, 491, 241, false, gui["tab_2"])
	guiGridListSetSortingEnabled(gui["listRecords"], false)
	gui["listRecords_col0"] = guiGridListAddColumn(gui["listRecords"], "Fish", 0.303666)
	gui["listRecords_col1"] = guiGridListAddColumn(gui["listRecords"], "Record", 0.303666)
	gui["listRecords_col2"] = guiGridListAddColumn(gui["listRecords"], "Holder", 0.303666)

	local listRecords_row = nil

	gui["tab_3"] = guiCreateTab("Stats", gui["tabWidget"])

	gui["listStats"] = guiCreateGridList(10, 10, 491, 221, false, gui["tab_3"])
	guiGridListSetSortingEnabled(gui["listStats"], false)
	gui["listStats_col0"] = guiGridListAddColumn(gui["listStats"], "Stat", 0.5503666)
	gui["listStats_col1"] = guiGridListAddColumn(gui["listStats"], "Value", 0.1503666)
	gui["listStats_col2"] = guiGridListAddColumn(gui["listStats"], "Rank Value / point", 0.103666)
	gui["listStats_col3"] = guiGridListAddColumn(gui["listStats"], "Total Rank Value", 0.103666)

	local listStats_row = nil

	gui["lblTotalPoints"] = guiCreateLabel(10, 240, 200, 16, "Total Points:", false, gui["tab_3"])
	guiLabelSetHorizontalAlign(gui["lblTotalPoints"], "left", false)
	guiLabelSetVerticalAlign(gui["lblTotalPoints"], "center")

	gui["lblTotalRankPoints"] = guiCreateLabel(360, 240, 200, 20, "Total Rank Points:", false, gui["tab_3"])
	guiLabelSetHorizontalAlign(gui["lblTotalRankPoints"], "left", false)
	guiLabelSetVerticalAlign(gui["lblTotalRankPoints"], "center")

	gui["tab_5"] = guiCreateTab("Ranks", gui["tabWidget"])

	gui["listRanks"] = guiCreateGridList(10, 10, 491, 221, false, gui["tab_5"])
	guiGridListSetSortingEnabled(gui["listRanks"], false)
	gui["listRanks_col0"] = guiGridListAddColumn(gui["listRanks"], "Rank", 0.403666)
	gui["listRanks_col1"] = guiGridListAddColumn(gui["listRanks"], "Points Needed", 0.133666)
	gui["listRanks_col2"] = guiGridListAddColumn(gui["listRanks"], "Net Value", 0.103666)
	gui["listRanks_col3"] = guiGridListAddColumn(gui["listRanks"], "Benifits", 0.303666)

	local listRanks_row = nil

	listRanks_row = guiGridListAddRow(gui["listRanks"])
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col0"], "Bus Driver in Training", false, false )
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col1"], "0", false, true )
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col2"], "0", false, true )
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col3"], "Base Salary", false, false )

	listRanks_row = guiGridListAddRow(gui["listRanks"])
	guiGridListSetItemText(gui["listRanks"], listRanks_row, gui["listRanks_col0"], "", false, false )

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	listRanks_row = guiGridListAddRow(gui["listRanks"])

	gui["lblCurrentRank"] = guiCreateLabel(10, 240, 231, 16, "Current Rank:", false, gui["tab_5"])
	guiLabelSetHorizontalAlign(gui["lblCurrentRank"], "left", false)
	guiLabelSetVerticalAlign(gui["lblCurrentRank"], "center")

	gui["tab_4"] = guiCreateTab("Documentation", gui["tabWidget"])

	gui["memoDoc"] = guiCreateMemo(10, 10, 501, 251, "Fishing Information Memo\n\nYour Task: Fish and sell for profit\n\nHow: 1st and foremost you need a fishing permit. If you don't have one you will get wanted stars for illegally fishing. You can ethier buy a permit, or you can get the Fisherman Job at the local harbor. Benifits of the Fisherman Job include Ranks and  free permit for as long as your a Fisherman. After your done that, you need a fishing boat. Boats that will work for fishing include:\n	- Reefer\nOnce you have one of these boats, get in the driver seat and Press 1 to toggle fishing on and off, and Press 2 to \"fish\" when you are notified to. Use your panel to eat,sell,drop,release fish.\n\nTo sell fish, go to the Fisherman harbor OR any local 24/7 shop. Once you near a Fisherman hut, OR, inside a shop, simply open your panel and select a fish, and press sell.\n\nRecords: Each fish has specific records (its size). If you beat it, you will get a small reward for doing so. Records reset after an X amount of that fish has been caught.\n\nYou can ONLY carry 12 fish at a time, so choose which ones you want to keep wisely.\nYou can be eaten by jaws, attacked by sea monsters, find out.\nThere are tons of fish and other things to catch!\n        \nRanks: In your panel you have available to you a stats list. Each stat point has a rank value and your total rank\n            Value will determine your rank. Refer to rank menu to find the list of ranks and benifits.\n            * Ranks will only work IF you have the Fisherman job.\n            * Fish Permit = # of fish you can fish without getting wanted. \n             * ONLY fish that you caught while under Fisherman job will be applied rank bonus! ", false, gui["tab_4"])
	guiMemoSetReadOnly(gui["memoDoc"],true)
	guiSetVisible(windowFishInv,false)
	guiSetEnabled(gui["btnDrop"],false)

GUIEditor_Memo = {}
GUIEditor_Image = {}
guiFishShop={}
guiFishShop[1] = guiCreateWindow(0.401,0.3143,0.3229,0.2371,"CSG ~ Fish Shop",true)
GUIEditor_Image[1] = guiCreateStaticImage(0.1259,0.0934,0.2591,0.5879,"images/permit.png",true,guiFishShop[1])
btnBuy50 = guiCreateButton(0.063,0.6538,0.3801,0.1264,"$10000 - 50 Fish Permit",true,guiFishShop[1])
btnExitFishShop = guiCreateButton(0.063,0.8077,0.3801,0.1264,"Exit",true,guiFishShop[1])
GUIEditor_Memo[1] = guiCreateMemo(0.4964,0.1593,0.4431,0.3681,"-----------Selling Fish---------\nWelcome to the CSG Fish Shop! To sell your fish, :\n1. Press F5 or type /fish.\n2. Select your fish.\n3. Press Sell.\n4. You could get a bonus\nif you have a fisherman rank!",true,guiFishShop[1])
guiMemoSetReadOnly(GUIEditor_Memo[1],true)
GUIEditor_Memo[2] = guiCreateMemo(0.4964,0.544,0.4431,0.3626,"-----------Permits---------\nWelcome to the CSG Fish Shop! A Permit works on a per fish basis. A permit lets you fish without the fisherman job, if you fish without the fisherman job, and without the permit, you will get wanted for illegal fishing.",true,guiFishShop[1])
guiMemoSetReadOnly(GUIEditor_Memo[2],true)

guiSetVisible(guiFishShop[1],false)
local shopPos = {
	{985.369,-2087.9836,3.807},
	{1595.0528,601.610,7.307},
	{-2419.3049,2327.0178,4.507}
}
local shopMarkers = {}
local rankI = {}
local ranks = {
	{"New Fisherman",0,0,"Base Salary"},
	{"Regular Fisherman",15,0,"Base Salary"},
	{"Experienced Fisherman",200,0,"Base Salary"},
	{"Seasonal Fisherman",1000,0,"Base Salary + 2% More"},
	{"Lead Fisherman",1500,0,"Base Salary + 5% More"},
	{"Head Fisherman",2000,0,"Base Salary + 10% More"},
	{"Commander of the FFS",3000,0,"Base Salary + 15% More"},
	{"Commander of the FFS II",5000,0,"Base Salary + 20% More"},
	{"SA Fishing CEO",6500,0,"Base Salary + 30% More"},
	{"King of the Ocean",11000,0,"Base Salary + 40% More"}
}
fishingMode = "Off"
sizes = {
	["Very Small"] = {0.1,9.9},
	["Small"] = {10,24.9},
	["Medium"] = {25,99.9},
	["Large"] = {100,249.9},
	["Huge"] = {250,749.9},
	["Massive"] = {750,999.9},
	["Colossal"] = {1000,9999}
}
common = {
	["Amberjack"] = {pricePerKg = 65.44,size={"Medium","Large"}},
	["Grouper"] = {pricePerKg = 101.97,size={"Small","Medium"}},
	["Red Snapper"] = {pricePerKg = 136.11,size={"Small","Medium"}},
	["Trout"] = {pricePerKg = 16.50,size={"Very Small","Small"}},
	["Sea Bass"] = {pricePerKg = 508.56,size={"Very Small","Small"}},
	["Pike"] = {pricePerKg = 118.46,size={"Small","Medium"}},
	["Sail Fish"] = {pricePerKg = 36.41,size={"Small","Medium"}},
	["Tuna"] = {pricePerKg = 372.60,size={"Very Small","Small"}},
	["Eel"] = {pricePerKg = 341.84,size={"Very Small","Small"}},
	["Barracuda"] = {pricePerKg = 494.51,size={"Very Small","Small"}},
}
rare = {
	["Mackeral"] = {pricePerKg = 164.11,size={"Small","Medium"}},
	["Dolphin"] = {pricePerKg = 131.24,size={"Large","Very Large"}},
	["Turtle"] = {pricePerKg = 169.59,size={"Medium","Large"}},
	["Catfish"] = {pricePerKg = 656.21,size={"Very Small","Small"}},
	["Swordfish"] = {pricePerKg = 16.22,size={"Large","Huge"}},
	["Squid"] = {pricePerKg = 29.10,size={"Small","Colossal"}},
	["Pirahna"] = {pricePerKg = 1026.20,size={"Very Small","Small"}}
}
veryrare = {
	["Blue Marlin"] = {pricePerKg = 23.62,size={"Large","Colossal"}},
	["Shark"] = {pricePerKg = 27.68,size={"Huge","Colossal"}},
	["Lobster"] = {pricePerKg = 771.51,size={"Very Small","Medium"}}
}
othergood = {
	"Money Suitcase",
	"Weapon Suitcase",
	"Drug Suitcase",
	"Body Armor",
	"Clam Chowder",
	"Treasure Chest"
}
otherbad = {
	"Car Tire",
	"Seaweed",
	"Toilet Seat",
	"Dead Body",
	"Jelly Fish",
	"Crab",
	"Sunfish",
	"Mermaid",
	"10 Ton Whale",
	"Sea Monster",
	"Jaws",
	"Waste Metal"
}
records = {

}

myFish = {}

function updateInv(bool)
	guiGridListClear(gui["listFishInv"])
		guiSetText(windowFishInv,"Community of Social Gaming ~ Fishing :: Permit - "..permits.."")
	for k,v in pairs(myFish) do

		local sizeName = ""
		local recordSizeName = ""
		local weight = v[2]
		if records[v[1]] == nil then records[v[1]] = {"No one",0} end
		for k2,v2 in pairs(sizes) do
			if records[v[1]][2] >= v2[1] and records[v[1]][2] <= v2[2] then
				recordSizeName = tostring(k2)
			end
		end
		for k2,v2 in pairs(sizes) do
			if weight >= v2[1] and weight <= v2[2] then
				sizeName = tostring(k2)
			end
		end
		if weight > records[v[1]][2] then
		triggerServerEvent("CSGfishNewRecord",localPlayer,v[1],weight)
		records[v[1]][2] = weight
		end
		local row = guiGridListAddRow(gui["listFishInv"])
		guiGridListSetItemText ( gui["listFishInv"], row, 1, v[1], false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 2, v[2].." Kg  ("..sizeName..")", false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 3, "   "..records[v[1]][2].." Kg ("..recordSizeName..")", false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 4, "     "..v[3], false, false )
	end
	if (bool) then
		if bool == false then return end
	end
	triggerServerEvent("CSGfishRecMyFishUpdate",localPlayer,myFish)
	updateRecords()
	updateStatsMenu()
	updateRanksMenu()
end

function isFisherman()
	if getTeamName(getPlayerTeam(localPlayer)) == "Civilian Workers" then
		if exports.server:getPlayerOccupation() == "Fisherman" or getElementData(localPlayer,"Occupation") == "Fisherman" then
			return true
		end
	end
	return false
end

function updateRecords()
	guiGridListClear(gui["listRecords"])
	local myName = getPlayerName(localPlayer)
	local recordSize = ""
	for k,v in pairs(records) do
		for k2,v2 in pairs(sizes) do
			if v[2] >= v2[1] and v[2] <= v2[2] then
				recordSize = tostring(k2)
			end
		end
		local row = guiGridListAddRow(gui["listRecords"])
		guiGridListSetItemText ( gui["listRecords"], row,1,k,false,false)
		guiGridListSetItemText ( gui["listRecords"], row,2,v[2].." Kg ("..recordSize..")",false,false)
		guiGridListSetItemText ( gui["listRecords"], row,3,v[1],false,false)
		if myName == v[1] then
			for i=1,3 do
				guiGridListSetItemColor(gui["listRecords"],row,i,0,255,0)
			end
		end
	end
end

showWarn = false
function fish0()
	if fishingMode == "Off" then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh == false then return end
	if isInValidBoat(veh) == true then
		if showWarn == false and reelingIn == false then
			local num0 = math.random(1,100)
			if num0 < 50 then return end
			local num = math.random(1,100)
			if num > 80 then --8% chance for it to come while driving
				showWarn = true
				setTimer(function() showWarn=false end,5000,1)
			end
		end
		--if guiGetVisible(warnImage) == true then
		--	--guiSetVisible(warnImage,false)
		--else
			if showWarn == true then
				exports.DENhelp:createNewHelpMessage("Press 2 to Pull in Now!",255,255,0)
				--guiSetVisible(warnImage,true)
			end
		--	end
		--end
	end
end


addEventHandler("onClientPlayerWasted",localPlayer,function() onExit(localPlayer)  end)

function doPermit()
	if isFisherman() == false then
		permits=permits-1
		updateInv()
	end
end

reelingIn = false
function fish()
	if showWarn == false then return end
	if reelingIn == true then return end
	local t = {}
	local num = math.random(1,100)
	reelingIn = true
	local tim = math.random(2000,4000)
	exports.CSGrozmisc:startProgressBar(255,255,0,0,255,0,"CSGfish.barFinish","Reeling In...", 50) -- 5 secs to finish
	if num < 10 then
		setTimer(function() exports.CSGrozmisc:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
	else

	end
	if num >= 10 then -- a catch
		if num <= 80 then	-- common catches
			catch0(common,10)
			doPermit()
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"common")
			addStat("# of Fish Caught In Life Time",1)
			addStat("# of Common Fish Caught",1)
		elseif num > 80 and num <= 85 then -- rare
			catch0(rare,7)
			doPermit()
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"rare")
			addStat("# of Rare or Very Rare Fish Caught",1)
			addStat("# of Fish Caught In Life Time",1)
		elseif num > 85 and num <= 87.5 then -- very rare
			catch0(veryrare,3)
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"veryrare")
			doPermit()
			addStat("# of Rare or Very Rare Fish Caught",1)
			addStat("# of Fish Caught In Life Time",1)
		elseif num > 87.5 and num <= 93.5 then -- other good
			otherCatch(othergood)
			addStat("# of Other Good Caught",1)
			setTimer(function() exports.CSGrozmisc:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
			return
		elseif num > 93.5 then --other bad
			otherCatch(otherbad)
			addStat("# of Other Bad Caught",1)
			setTimer(function() exports.CSGrozmisc:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
			return
		end
	else -- nothing
		addStat("# of times nothing Caught",1)
		setTimer(function () exports.DENhelp:createNewHelpMessage("Caught nothing",255,255,0) end,tim,1)
	end
end

function catch0(t,size)
	tableToUse=t
	sizeToUse=size
end

function catch()
	reelingIn = false
	local t = tableToUse
	local size = sizeToUse
	local i = math.random(1,size)
	local count = 1
	k = ""
	for k0,v in pairs(t) do
		if count == i then k=k0 break end
			count = count + 1
	end
		local weightMin = math.random(sizes[t[k]["size"][1]][1],sizes[t[k]["size"][1]][2])
		local weightMax = math.random(sizes[t[k]["size"][2]][1],sizes[t[k]["size"][2]][2])
		if weightMax == nil then WeightMax = weightMin+1 end
		local weight = math.random(weightMin,weightMax)
		weight=weight*0.453592
		weight=math.floor(weight+0.5)
		local value = weight*(t[k].pricePerKg)
		value=value/5
		value=value*0.80
		value=math.floor(value+0.5)
		addStat("$ Fish value caught",value)
		addStat("# of Kilograms of fish caught",weight)
		local fisher = isFisherman()

		exports.DENhelp:createNewHelpMessage("Caught a "..weight.." Kg "..k.."!",0,255,0)
		if #myFish > 12 then
			exports.DENhelp:createNewHelpMessage("But you threw it back because you can't carry anymore fish!",0,255,0)
			updateInv()
			return
		end
		table.insert(myFish,{k,weight,value,fisher})

		updateInv()
end
addEvent("CSGfish.barFinish",true)
addEventHandler("CSGfish.barFinish",root,catch)

function otherCatch(t)
	local i = math.random(1,#t)
	if t == otherbad then
		if i == 1 then --car tire
			exports.DENhelp:createNewHelpMessage("Caught a car tire and threw it back into the water",255,255,0)
		elseif i == 2 then --
			exports.DENhelp:createNewHelpMessage("Caught some seaweed and threw it back into the water",255,255,0)
		elseif i == 3 then --
			exports.DENhelp:createNewHelpMessage("Caught a old toilet seat and threw it back into the water",255,255,0)
		elseif i == 4 then --
			exports.DENhelp:createNewHelpMessage("Caught a dead body. You forgot if the law ask.",255,255,0)
		elseif i == 5 then --
			exports.DENhelp:createNewHelpMessage("Caught a jelly fish and got attacked!",255,0,0)
			local h = getElementHealth(localPlayer)
			addStat("# of times attacked by things you caught",1)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 6 then --
			exports.DENhelp:createNewHelpMessage("Caught a crab and got attacked!",255,0,0)
			addStat("# of times attacked by things you caught",1)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 7 then --
			exports.DENhelp:createNewHelpMessage("You caught something, but throw it back",255,255,0)
		elseif i == 8 then --
			exports.DENhelp:createNewHelpMessage("Caught a mermaid! A bad one! You got attacked!",255,0,0)
			addStat("# of times attacked by things you caught",1)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 9 then --
			exports.DENhelp:createNewHelpMessage("Caught a whale and its weight sank the boat!",255,255,0)
			addStat("# of times attacked by things you caught",1)
			sinkBoat()
		elseif i == 10 then --
			seaMonster()
		elseif i == 11 then --
			jaws()
		elseif i == 12 then
			exports.DENhelp:createNewHelpMessage("Caught Waste Metal, No Luck",255,255,0)
		end
	elseif t == othergood then
		if i == 1 or i == 2 or i == 3 or i == 6 then
			triggerServerEvent("CSGfishGoodCatch",localPlayer,i)
		elseif i == 4 then -- to do body armor
			exports.DENhelp:createNewHelpMessage("Found a weapon suitcase!",255,255,0)
			exports.DENhelp:createNewHelpMessage("But you dont want it so you threw it back!",255,255,0)
		elseif i == 5 then
			exports.DENhelp:createNewHelpMessage("Caught some clam chowder and ate it for some nice refreshing health",0,255,0)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,100)
		end
	end
end

function jaws()
	exports.DENhelp:createNewHelpMessage("You got eaten by jaws and lost some of your fish!",255,0,0)
	setElementHealth(localPlayer,0)
	addStat("# of times eaten by jaws",1)
	--to do
end

function seaMonster()

end

function sinkBoat()
	local veh = getPedOccupiedVehicle(localPlayer)
	local rx,ry,rz = getElementRotation(veh)
	setElementFrozen(veh,true)
	ry=45
	setElementRotation(veh,rx,ry,rz)
	setTimer(function()
		local x,y,z = getElementPosition(veh) setElementPosition(veh,x,y,z-0.5)
	end,1000,10)
	setTimer(function() destroyElement(veh) end,10000,1)
end

function click()
	if source == gui["btnSell"] then
		if isInValidShop() == true then
			local row = guiGridListGetSelectedItem(gui["listFishInv"])
			if row == false or row == -1 then
				exports.DENhelp:createNewHelpMessage("You need to select a fish to sell",255,255,0)
			else
				row=row+1
				local fishName = myFish[row][1]
				local weight = myFish[row][2]
				local value = myFish[row][3]
				local fisher = myFish[row][4]
				table.remove(myFish,row)
				updateInv()
				triggerServerEvent("CSGfishSoldFish",localPlayer,fishName,weight,value,fisher,rankI)
			end
		else
			exports.DENhelp:createNewHelpMessage("You can only sell fish at the Fisherman job Hut OR a 24/7 Shop",255,255,0)
		end
	elseif source == gui["btnDrop"] then

	elseif source == gui["btnEat"] then
		local row = guiGridListGetSelectedItem(gui["listFishInv"])
		if row == false or row == -1 then
			exports.DENhelp:createNewHelpMessage("You need to select a fish to eat",255,255,0)
		else
			row=row+1
			local name = myFish[row][1]
			local weight = myFish[row][2]
			exports.DENhelp:createNewHelpMessage("Ate a "..weight.." Kg "..name.." for some health",255,255,0)
			addStat("# of times eaten a fish",1)
			if weight > 5 then
				local num = math.random(1,100)
				local h = getElementHealth(localPlayer)
				if h > 75 then
					setElementHealth(localPlayer,100)
					exports.DENhelp:createNewHelpMessage("You got full and threw the rest of it away",255,255,0)
				elseif h >= 99 then
					exports.DENhelp:createNewHelpMessage("You ate too much and got sick!",255,0,0)
					--make puke anim here
					setElementHealth(localPlayer,math.random(50,75))
				elseif h <= 75 then
					setElementHealth(localPlayer,math.random(80,100))
				end
			end
			table.remove(myFish,row)
			updateInv()
		end
	elseif source == gui["btnCloseInv"] then
		hide()
	elseif source == gui["btnRelease"] then
		if type(getWaterLevel(getElementPosition(localPlayer))) ~= "boolean" then
			local row = guiGridListGetSelectedItem(gui["listFishInv"])
			if row == false or row == -1 then
				exports.DENhelp:createNewHelpMessage("You need to select a fish to release",255,255,0)
			else
				addStat("# of times released a fish",1)
				row=row+1
				local name = myFish[row][1]
				local weight = myFish[row][2]
				exports.DENhelp:createNewHelpMessage("Released the "..weight.." Kg "..name.." into the water",255,255,0)
				table.remove(myFish,row)
				updateInv()
			end
		else
			exports.DENhelp:createNewHelpMessage("You need to be near water to release a fish",255,255,0)
		end
	elseif source == btnBuy50 then
		triggerServerEvent("CSGfishBuy",localPlayer,50,10000)
	elseif source == btnExitFishShop then
		hideShop()
	end
end
addEventHandler("onClientGUIClick",root,click)

local validInt = {
	6,18
}

function isInValidShop()
	if guiGetVisible(guiFishShop[1]) == true then
		return true
	end
	for k,v in pairs(shopMarkers) do
		if isElementWithinMarker(localPlayer,v) == true then
			return true
		end
	end
	local int = getElementInterior(localPlayer)
	if int == 6 or int == 18 then return true end
	return false
end

function show()
	guiSetVisible(windowFishInv,true)
	showCursor(true)
end

function hide()
	guiSetVisible(windowFishInv,false)
	if guiGetVisible(guiFishShop[1]) == false then
		showCursor(false)
	end
end

function toggle()
	if guiGetVisible(windowFishInv) == true then
		hide()
	else
		local bool = isFisherman()
		--outputChatBox(tostring(bool))
		if bool == true then
			show()
		end
	end
end

function toggle0(cmdName)
	if guiGetVisible(windowFishInv) == true then
		hide()
	else
		show()
	end
end
addCommandHandler("fish",toggle0)

function createText()
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Fishing: #33FF33"..fishingMode.."", screenWidth*0.09, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Fishing: #33FF33"..fishingMode.."", screenWidth*0.09, screenHeight*0.95, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
end

function isInValidBoat(v)
	local model = getElementModel(v)
	if model == 453 or model == 484 then return true end
	return false
end

function toggleFishingMode()
	if isPedInVehicle(localPlayer) == true then
		if isInValidBoat(getPedOccupiedVehicle(localPlayer)) == false then
			return
		end
	end
	if fishingMode == "Off" then
		fishingMode = "On"

	else
		fishingMode = "Off"
		--guiSetVisible(warnImage,false)
		exports.CSGrozmisc:cancelProgressBar() reelingIn = false showWarn = false
	end
end

addEventHandler("onClientVehicleEnter",root, function (p)
	if p ~= localPlayer then return end
	if isInValidBoat(source) == false then return end
	bindKey("1","down",toggleFishingMode)
	local boatName = getVehicleName(source)
	exports.DENhelp:createNewHelpMessage("This "..boatName.." is equiped with fishing equipment",0,255,0)
	exports.DENhelp:createNewHelpMessage("Press 1 to Toggle Fishing",0,255,0)
	fishTimer = setTimer(fish0,1000,0)
	addEventHandler("onClientRender",root,createText) end)
addEventHandler("onClientVehicleExit",root,function (p)
	if p ~= localPlayer then return end
	if isInValidBoat(source) == false then return end
	onExit(p)
	 end)

function onExit(p)
	if p ~= localPlayer then return end
	exports.CSGrozmisc:cancelProgressBar() reelingIn = false showWarn = false
	if isTimer(fishTimer) then
		killTimer(fishTimer)
	end
	--guiSetVisible(warnImage,false)
	unbindKey("1","down",toggleFishingMode)
	removeEventHandler("onClientRender",root,createText)
end

function CSGfishRecData(t)
	if t == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}} end
	myFish = t[1]
	databaseStats = t[2]
	permits = t[3][1]
	updateInv(false)
end
addEvent("CSGfishRecData",true)
addEventHandler("CSGfishRecData",localPlayer,CSGfishRecData)

function CSGfishRecRecords(t)
	records = t
	updateInv(false)
end
addEvent("CSGfishRecRecords",true)
addEventHandler("CSGfishRecRecords",localPlayer,CSGfishRecRecords)

local nameToI = {
	["# of Fish Caught In Life Time"] = 1,
	["# of Common Fish Caught"] = 2,
	["# of Rare or Very Rare Fish Caught"] = 3,
	["# of Other Bad Caught"] = 4,
	["# of Other Good Caught"] = 5,
	["# of times nothing Caught"] = 6,
	["# of times record broken"] = 7,
	["$ Money earned from fishing overall"] = 8,
	["$ Money earned from selling fish"] = 9,
	["$ Money earned from non-selling fish"] = 10,
	["# of times eaten by jaws"] = 11,
	["# of times attacked by things you caught"] = 12,
	["# of times ganged on by sea monsters"] = 13,
	["# of times eaten a fish"] = 14,
	["# of times dropped a fish"] = 15,
	["# of times released a fish"] = 16,
	["$ Fish value caught"] = 17,
	["# of Kilograms of fish caught"] = 18
}

function addStat(k,v)
	databaseStats[nameToI[k]] = databaseStats[nameToI[k]]+v
	updateStatsMenu()
	triggerServerEvent("CSGfishSetStat",localPlayer,tostring(k),v,"","",databaseStats,totalRankPoints)
end
addEvent("CSGfishAddStat",true)
addEventHandler("CSGfishAddStat",localPlayer,addStat)

function updateStatsMenu()
	guiGridListClear(gui["listStats"])
	stats = {
		["# of Fish Caught In Life Time"] = {databaseStats[nameToI["# of Fish Caught In Life Time"]],0,0},
		["# of Common Fish Caught"] = {databaseStats[nameToI["# of Common Fish Caught"]],1,0},
		["# of Rare or Very Rare Fish Caught"] = {databaseStats[nameToI["# of Rare or Very Rare Fish Caught"]],15,0},
		["# of Other Bad Caught"] = {databaseStats[nameToI["# of Other Bad Caught"]],0,0},
		["# of Other Good Caught"] = {databaseStats[nameToI["# of Other Good Caught"]],0,0},
		["# of times nothing Caught"] = {databaseStats[nameToI["# of times nothing Caught"]],0,0},
		["# of times record broken"] = {databaseStats[nameToI["# of times record broken"]],4,0},
		["$ Money earned from fishing overall"] = {databaseStats[nameToI["$ Money earned from fishing overall"]],0,0},
		["$ Money earned from selling fish"] = {databaseStats[nameToI["$ Money earned from selling fish"]],0,0,},
		["$ Money earned from non-selling fish"] = {databaseStats[nameToI["$ Money earned from non-selling fish"]],0,0},
		["# of times eaten by jaws"] = {databaseStats[nameToI["# of times eaten by jaws"]],0,0},
		["# of times attacked by things you caught"] = {databaseStats[nameToI["# of times attacked by things you caught"]],0,0},
		["# of times ganged on by sea monsters"] = {databaseStats[nameToI["# of times ganged on by sea monsters"]],0,0},
		["# of times eaten a fish"] = {databaseStats[nameToI["# of times eaten a fish"]],0,0},
		["# of times dropped a fish"] = {databaseStats[nameToI["# of times dropped a fish"]],0,0},
		["# of times released a fish"] = {databaseStats[nameToI["# of times released a fish"]],0,0},
		["$ Fish value caught"] = {databaseStats[nameToI["$ Fish value caught"]],0,0},
		["# of Kilograms of fish caught"] = {databaseStats[nameToI["# of Kilograms of fish caught"]],0,0},
	}
	totalRankPoints = 0
	totalPoints = 0
	for k,v in pairs(stats) do
		local ptsToAdd = (tonumber(v[1])*tonumber(v[2]))
		totalRankPoints=totalRankPoints+ptsToAdd
		stats[k][3] = ptsToAdd
		totalPoints=totalPoints+tonumber(v[1])
		local row = guiGridListAddRow(gui["listStats"])
		guiGridListSetItemText(gui["listStats"], row, 1, ""..tostring(k).."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 2, ""..stats[k][1].."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 3, ""..stats[k][2].."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 4, ""..stats[k][3].."", false, false )
		if v[2] > 0 then
			for i=1,4 do
				guiGridListSetItemColor(gui["listStats"],row,i,0,255,0)
			end
		end
	end
	guiSetText(gui["lblTotalPoints"],"Total Points: "..totalPoints.."")
	guiSetText(gui["lblTotalRankPoints"],"Total Rank Points: "..totalRankPoints.."")
end

local first = true

function updateRanksMenu()
	guiGridListClear(gui["listRanks"])
	for k,v in pairs(ranks) do
		ranks[k][3] = totalRankPoints-tonumber(ranks[k][2])
	end

	local currentRank = ""
    for k,v in pairs(ranks) do
		local needed = tonumber(v[2])
        if totalRankPoints > needed then
            ranks[k][3] = "+"..tostring((totalRankPoints-needed))..""
            currentRank = ranks[k][1]
			rankI = k
        elseif totalRankPoints < needed then
            ranks[k][3] = "-"..tostring((needed-totalRankPoints))..""
        elseif totalRankPoints == needed then
            ranks[k][3] = "0"
            currentRank = ranks[k][1]
			rankI = k
        end
    end
	guiSetText(gui["lblCurrentRank"],"Rank: "..currentRank.."")
	for k,v in pairs(ranks) do
		local row = guiGridListAddRow(gui["listRanks"])
		guiGridListSetItemText(gui["listRanks"], row, 1, tostring(v[1]), false, false )
		guiGridListSetItemText(gui["listRanks"], row, 2, tostring(v[2]), false, false )
		guiGridListSetItemText(gui["listRanks"], row, 3, tostring(v[3]), false, false )
		guiGridListSetItemText(gui["listRanks"], row, 4, tostring(v[4]), false, false )
		if v[1] == currentRank then
			for i=1,4 do
				guiGridListSetItemColor(gui["listRanks"],row,i,0,255,0)
			end
		end
	end
	if first == true then
		--triggerServerEvent("CSGbusDriverNewRank",localPlayer,totalRankPoints)
		first = false
		rank = currentRank
	end
	if rank ~= currentRank then
		exports.DENhelp:createNewHelpMessage("Congratulations! You have been promoted to "..currentRank.."!",0,255,0)
		rank = currentRank
		--triggerServerEvent("CSGbusDriverNewRank",localPlayer,totalRankPoints)
	end

end

function job(bool)
	if bool == true then
		if isFisherman() == true then
			guiSetEnabled(gui["listRanks"],true)
		end
	else
		guiSetEnabled(gui["listRanks"],false)
	end
end
addEvent("CSGfishJob",true)
addEventHandler("CSGfishJob",localPlayer,job)

function showShop()
	guiSetVisible(guiFishShop[1],true)
	showCursor(true)
	exports.DENhelp:createNewHelpMessage("Welcome to the CSG Fish Shop! You can sell your fish here.",0,255,0)
end

function hideShop()
	guiSetVisible(guiFishShop[1],false)
	if guiGetVisible(windowFishInv) == false then
		showCursor(false)
	end
	showCursor(false)
end
addEventHandler("onClientPlayerWasted",localPlayer,hideShop)

function hitShop(p)
	if p ~= localPlayer then return end
	showShop()
end

for k,v in pairs(shopPos) do
	local m = createMarker(v[1],v[2],v[3],"cylinder",2,255,255,0,100)
	addEventHandler("onClientMarkerHit",m,hitShop)
	table.insert(shopMarkers,m)
end
txd = engineLoadTXD ( "sea.txd" )
engineImportTXD ( txd, 49 )
dff = engineLoadDFF ( "sea.dff", 49 )
engineReplaceModel ( dff, 49 )

job(true)
setTimer(function() if isFisherman() == true then job(true) else job(false) end end,1000,5)
bindKey("2","down",fish)
bindKey("F5","down",toggle)
