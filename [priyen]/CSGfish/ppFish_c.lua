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

	gui["btnSellAll"] = guiCreateButton(140, 240, 101, 23, "Sell All", false, gui["tab"])

	gui["btnEat"] = guiCreateButton(270, 240, 101, 23, "Eat", false, gui["tab"])

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
	--guiSetEnabled(gui["btnDrop"],false)
local cd = 0
local regenTimer = ""
GUIEditor_Memo = {}
GUIEditor_Image = {}
guiFishShop={}
guiFishShop[1] = guiCreateWindow(0.401,0.3143,0.3229,0.2371,"CSG ~ Fish Shop",true)
GUIEditor_Image[1] = guiCreateStaticImage(0.1259,0.0934,0.2591,0.5879,"images/permit.png",true,guiFishShop[1])
btnBuy50 = guiCreateButton(0.063,0.6538,0.3801,0.1264,"$30000 - 50 Fish Permit",true,guiFishShop[1])
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
	--{"Commander of the FFS",3000,0,"Base Salary + 15% More"},
	--{"Commander of the FFS II",5000,0,"Base Salary + 20% More"},
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

function regenHealth()
	local h = getElementHealth(localPlayer)
	if h < 100 then
		setElementHealth(localPlayer,h+1)
	else
		if isTimer(regenTimer) then killTimer(regenTimer) return end
	end
end

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
	triggerServerEvent("CSGfishRecMyFishUpdate",localPlayer,myFish,permits)
	updateRecords()
	updateStatsMenu()
	updateRanksMenu()
end

function isFisherman()
	local te = getPlayerTeam(localPlayer)
	if te == false then return false end
	if getTeamName(te) == "Civilian Workers" then
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
				 exports.DENdxmsg:createNewDxMessage("Press 2 to Pull in Now!",255,255,0)
				--guiSetVisible(warnImage,true)
			end
		--	end
		--end
	end
end


addEventHandler("onClientPlayerWasted",localPlayer,function() onExit(localPlayer)  end)

function doPermit()
	if isFisherman() == false then
		if permits > 0 then
			permits=permits-1
			updateInv()
		else
			triggerServerEvent("CSGfishWanted",localPlayer)
		end
	end
end

reelingIn = false
function fish()
	if showWarn == false then return end
	if reelingIn == true then return end
	--[[speedx, speedy, speedz = getElementVelocity (getPedOccupiedVehicle(localPlayer))
	actualspeed = (speedx^2 + speedy^2 + speedz^2)^(0.5)
	kmh = actualspeed * 180
	if kmh < 25 then
		 exports.DENdxmsg:createNewDxMessage("Your going too slow to reel in!",255,255,0)
		return
	end--]]
	local t = {}
	local num = math.random(1,100)
	reelingIn = true
	local tim = math.random(2000,4000)
	exports.CSGprogressbar:createProgressBar("Reeling In...",50, "CSGfish.barFinish") -- 5 secs to finish
	if num < 10 then
		setTimer(function() exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
	else

	end

	if num >= 10 then -- a catch
		if num <= 90 then	-- common catches
			catch0(common,10)
			doPermit()
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"common")
			addStat("# of Fish Caught In Life Time",1)
			addStat("# of Common Fish Caught",1)
		elseif num > 90 and num <= 93 then -- rare
			catch0(rare,7)
			doPermit()
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"rare")
			addStat("# of Rare or Very Rare Fish Caught",1)
			addStat("# of Fish Caught In Life Time",1)
		elseif num > 94 and num <= 95 then -- very rare
			catch0(veryrare,3)
			triggerServerEvent("CSGfishCaughtAFish",localPlayer,"veryrare")
			doPermit()
			addStat("# of Rare or Very Rare Fish Caught",1)
			addStat("# of Fish Caught In Life Time",1)
		elseif num > 95 and num <= 97 then -- other good
			otherCatch(othergood)
			addStat("# of Other Good Caught",1)
			setTimer(function() exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
			return
		elseif num > 87 then --other bad
			otherCatch(otherbad)
			addStat("# of Other Bad Caught",1)
			setTimer(function() exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false end,tim,1)
			return
		end
	else -- nothing
		addStat("# of times nothing Caught",1)
		setTimer(function ()  exports.DENdxmsg:createNewDxMessage("Caught nothing",255,255,0) end,tim,1)
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
		value=value*0.7
		value=math.floor(value+0.5)*1.3
		addStat("$ Fish value caught",value)
		addStat("# of Kilograms of fish caught",weight)
		local fisher = isFisherman()

		 exports.DENdxmsg:createNewDxMessage("Caught a "..weight.." Kg "..k.."!",0,255,0)
		if #myFish > 12 then
			 exports.DENdxmsg:createNewDxMessage("But you threw it back because you can't carry anymore fish!",0,255,0)
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
			 exports.DENdxmsg:createNewDxMessage("Caught a car tire and threw it back into the water",255,255,0)
		elseif i == 2 then --
			 exports.DENdxmsg:createNewDxMessage("Caught some seaweed and threw it back into the water",255,255,0)
		elseif i == 3 then --
			 exports.DENdxmsg:createNewDxMessage("Caught a old toilet seat and threw it back into the water",255,255,0)
		elseif i == 4 then --
			 exports.DENdxmsg:createNewDxMessage("Caught a dead body. You forgot if the law ask.",255,255,0)
		elseif i == 5 then --
			 exports.DENdxmsg:createNewDxMessage("Caught a jelly fish and got attacked!",255,0,0)
			local h = getElementHealth(localPlayer)
			addStat("# of times attacked by things you caught",1)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 6 then --
			 exports.DENdxmsg:createNewDxMessage("Caught a crab and got attacked!",255,0,0)
			addStat("# of times attacked by things you caught",1)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 7 then --
			 exports.DENdxmsg:createNewDxMessage("You caught something, but throw it back",255,255,0)
		elseif i == 8 then --
			 exports.DENdxmsg:createNewDxMessage("Caught a mermaid! A bad one! You got attacked!",255,0,0)
			addStat("# of times attacked by things you caught",1)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 9 then --
			 exports.DENdxmsg:createNewDxMessage("Caught a whale and its weight sank the boat!",255,255,0)
			addStat("# of times attacked by things you caught",1)
			sinkBoat()
		elseif i == 10 then --
			seaMonster()
		elseif i == 11 then --
			jaws()
		elseif i == 12 then
			 exports.DENdxmsg:createNewDxMessage("Caught Waste Metal, No Luck",255,255,0)
		end
	elseif t == othergood then
		if i == 1 or i == 2 or i == 3 or i == 6 then
			triggerServerEvent("CSGfishGoodCatch",localPlayer,i)
		elseif i == 4 then -- to do body armor
			 exports.DENdxmsg:createNewDxMessage("Found a weapon suitcase!",255,255,0)
			 exports.DENdxmsg:createNewDxMessage("But you dont want it so you threw it back!",255,255,0)
		elseif i == 5 then
			 exports.DENdxmsg:createNewDxMessage("Caught some clam chowder and ate it for some nice refreshing health",0,255,0)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,100)
		end
	end
end

function jaws()
	 exports.DENdxmsg:createNewDxMessage("You got eaten by jaws and lost some of your fish!",255,0,0)
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
				 exports.DENdxmsg:createNewDxMessage("You need to select a fish to sell",255,255,0)
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
			 exports.DENdxmsg:createNewDxMessage("You can only sell fish at the Fisherman job Hut OR a 24/7 Shop",255,255,0)
		end
	elseif source == gui["btnSellAll"] then
		if isInValidShop() == true then
		for k,v in pairs(myFish) do
				local fishName = v[1]
				local weight = v[2]
				local value = v[3]
				local fisher = v[4]
				table.remove(myFish,k)
				updateInv()
				triggerServerEvent("CSGfishSoldFish",localPlayer,fishName,weight,value,fisher,rankI)
		end
		else
			 exports.DENdxmsg:createNewDxMessage("You can only sell fish at the Fisherman job Hut OR a 24/7 Shop",255,255,0)
		end
	elseif source == gui["btnEat"] then
		local row = guiGridListGetSelectedItem(gui["listFishInv"])
		if row == false or row == -1 then
			 exports.DENdxmsg:createNewDxMessage("You need to select a fish to eat",255,255,0)
		else
			row=row+1
			local name = myFish[row][1]
			local weight = myFish[row][2]
			 exports.DENdxmsg:createNewDxMessage("Ate a "..weight.." Kg "..name.." for some health",255,255,0)
			addStat("# of times eaten a fish",1)
			if weight > 5 then
				local num = math.random(1,100)
				local h = getElementHealth(localPlayer)
				if h > 75 then
					if isTimer(regenTimer) then killTimer(regenTimer) end
					regenTimer=setTimer(regenHealth,500,math.random(10,25))
					 exports.DENdxmsg:createNewDxMessage("You got full and threw the rest of it away",255,255,0)
				elseif h >= 99 then
					 exports.DENdxmsg:createNewDxMessage("You ate too much and got sick!",255,0,0)
					--make puke anim here
					setElementHealth(localPlayer,math.random(50,75))
				elseif h <= 75 then
					if isTimer(regenTimer) then killTimer(regenTimer) end
					regenTimer=setTimer(regenHealth,500,math.random(10,50))
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
				 exports.DENdxmsg:createNewDxMessage("You need to select a fish to release",255,255,0)
			else
				addStat("# of times released a fish",1)
				row=row+1
				local name = myFish[row][1]
				local weight = myFish[row][2]
				 exports.DENdxmsg:createNewDxMessage("Released the "..weight.." Kg "..name.." into the water",255,255,0)
				table.remove(myFish,row)
				updateInv()
			end
		else
			 exports.DENdxmsg:createNewDxMessage("You need to be near water to release a fish",255,255,0)
		end
	elseif source == btnBuy50 then
		triggerServerEvent("CSGfishBuy",localPlayer,50,30000)
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
		exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false
	end
end

addEventHandler("onClientVehicleEnter",root, function (p)
	if p ~= localPlayer then return end
	if isInValidBoat(source) == false then return end
	bindKey("1","down",toggleFishingMode)
	local boatName = getVehicleName(source)
	 exports.DENdxmsg:createNewDxMessage("This "..boatName.." is equiped with fishing equipment",0,255,0)
	 exports.DENdxmsg:createNewDxMessage("Press 1 to Toggle Fishing",0,255,0)
	fishTimer = setTimer(fish0,1000,0)
	addEventHandler("onClientRender",root,createText) end)
addEventHandler("onClientVehicleExit",root,function (p)
	if p ~= localPlayer then return end
	if isInValidBoat(source) == false then return end
	onExit(p)
	 end)

function onExit(p)
	if p ~= localPlayer then return end
	exports.CSGprogressbar:cancelProgressBar() reelingIn = false showWarn = false
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
	addStat("# of Fish Caught In Life Time",1)
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
		["# of Common Fish Caught"] = {databaseStats[nameToI["# of Common Fish Caught"]],3,0},
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
		first = false
		rank = currentRank
	end
	if rank ~= currentRank then
		exports.DENdxmsg:createNewDxMessage("Congratulations! You have been promoted to "..currentRank.."!",0,255,0)
		rank = currentRank
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
	 exports.DENdxmsg:createNewDxMessage("Welcome to the CSG Fish Shop! You can sell your fish here.",0,255,0)
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

function printR()
	local str = toJSON(records)
	outputConsole(str)
end
addCommandHandler("printrecords",printR)

addEvent( "onPlayerRankChange" )
addEventHandler( "onPlayerRankChange", root,
	function ( oldRank, newRank )
		updateInv(false)
	end
)

createObject ( 11497, 982.70001220703, -2092.1999511719, 3.2999999523163, 0, 0, 88 )
createObject ( 12990, 951.8994140625, -2120.5, 0.40000000596046, 0, 0, 90 )
createObject ( 3472, 937.20001220703, -2099, 0.69999998807907 )
createObject ( 1223, 978.70001220703, -2086.1999511719, 2.7000000476837 )
createObject ( 12990, 950.29998779297, -2103.3999023438, 0.20000000298023, 0, 0, 357.98950195313 )
createObject ( 902, 967, -2104.8000488281, 1.1000000238419 )
createObject ( 1461, 937.70001220703, -2118.8000488281, 1.1000000238419 )
createObject ( 804, 954, -2073.5, -1.2000000476837 )
createObject ( 1461, 939.90002441406, -2054.6999511719, 1.2000000476837 )
createObject ( 804, 955.09997558594, -2066.8999023438, -1 )
createObject ( 9361, 1003.5, -2117.19921875, 14.699999809265, 0, 0, 133.9892578125 )
createObject ( 11290, 963.09997558594, -2151.3000488281, 17, 0, 0, 354 )
createObject ( 9362, 1002.299987793, -2119.1000976563, 13.10000038147, 0, 0, 176.99523925781 )
createObject ( 13198, 995.099609375, -2140.599609375, 17.39999961853 )
createObject ( 3626, 1007.5999755859, -2104.5, 13.5, 0, 0, 260 )
createObject ( 3472, 940.79998779297, -2122.5, 0.60000002384186 )
createObject ( 902, 969, -2079.3994140625, 0.40000000596046 )
createObject ( 1608, 989.20001220703, -2121.5, 21.200000762939, 0, 0, 268 )
createObject ( 1267, 983, -2099.8999023438, 20.10000038147, 0, 0, 44.97802734375 )
createObject ( 1243, 895.09997558594, -2065, -2.9000000953674 )
createObject ( 1243, 896.69921875, -2144.099609375, -2.9000000953674 )
createObject ( 5838, 991.70001220703, -2060.3999023438, 19, 0, 0, 354 )
createObject ( 4238, 981.20001220703, -2100.5, 25.60000038147, 0, 0, 338 )
createObject ( 4238, 984.5, -2097.8999023438, 25.60000038147, 0, 0, 171.99645996094 )
createObject ( 12990, 948.7998046875, -2097.7998046875, 0.20000000298023, 0, 0, 85.995483398438 )
createObject ( 12990, 951.09997558594, -2073.3000488281, 0.10000000149012, 0, 0, 357.98950195313 )
createObject ( 12990, 952.09997558594, -2057.3000488281, 0.10000000149012, 0, 0, 265.99499511719 )
createObject ( 1461, 939.2998046875, -2095.3994140625, 1.6000000238419 )
createObject ( 2406, 972.20001220703, -2095.6000976563, 2.7999999523163, 0, 0, 91.99951171875 )
createObject ( 2406, 972.29998779297, -2093.3000488281, 2.7000000476837, 0, 0, 91.99951171875 )
createObject ( 1348, 977.29998779297, -2120.6000976563, 12.800000190735 )
createObject ( 1646, 974.29998779297, -2046.9000244141, 2, 0, 0, 260 )
createObject ( 1646, 974.70001220703, -2044.8000488281, 2, 0, 0, 261.99792480469 )
createObject ( 1646, 975.20001220703, -2042.4000244141, 2.2000000476837, 0, 0, 255.99792480469 )
createObject ( 1594, 976, -2104.6000976563, 3.5 )
createObject ( 1594, 976.40002441406, -2109.1999511719, 3.7999999523163 )
createObject ( 1594, 976.40002441406, -2099.3000488281, 3.5 )
createObject ( 648, 968.59997558594, -2109.5, 1.6000000238419 )
createObject ( 648, 969.59997558594, -2081.5, 0.69999998807907 )
createObject ( 648, 974.90002441406, -2032.6999511719, 1.3999999761581 )
createObject ( 648, 968.599609375, -2109.5, 1.6000000238419 )
createObject ( 1598, 976, -2102.5, 3.2000000476837 )
createObject ( 1598, 964.59997558594, -2096.6000976563, 0.69999998807907 )
createObject ( 1637, 992.099609375, -2039.69921875, 6.8000001907349, 0, 0, 175.99548339844 )
createObject ( 4729, 1032, -2074.8000488281, 22.299999237061, 0, 0, 100 )
createObject ( 1243, 915.40002441406, -2163.1999511719, -2.9000000953674 )
createObject ( 1243, 915.40002441406, -2043.9000244141, -3 )
createObject ( 1243, 938.79998779297, -2030.1999511719, -3 )
createObject ( 1243, 937.70001220703, -2173.8999023438, -2.9000000953674 )
createObject ( 11497, 1590.5999755859, 603.90002441406, 6.8000001907349 )
createObject ( 11497, -2414.6999511719, 2325.8999023438, 4, 0, 0, 192 )
createObject ( 2229, 937.40002441406, -2099.3000488281, 8.8999996185303, 0, 0, 270 )
