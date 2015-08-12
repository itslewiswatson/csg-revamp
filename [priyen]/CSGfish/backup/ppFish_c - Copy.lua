	local gui = {}
	gui._placeHolders = {}

	local screenWidth, screenHeight = guiGetScreenSize()
	local windowWidth, windowHeight = 511, 335
	local left = screenWidth/2 - windowWidth/2
	local top = screenHeight/2 - windowHeight/2
	windowFishInv = guiCreateWindow(left, top, windowWidth, windowHeight, "Community of Social Gaming ~ Fish Inventory", false)
	guiWindowSetSizable(windowFishInv, false)
	--warnImage = guiCreateStaticImage((screenWidth*0.5)-257,screenHeight*0.1,514,53,"warn2.png",false)
	--guiSetVisible(warnImage,false)
	gui["listFishInv"] = guiCreateGridList(10, 35, 491, 231, false, windowFishInv)
	guiGridListSetSortingEnabled(gui["listFishInv"], false)
	gui["listFishInv_col0"] = guiGridListAddColumn(gui["listFishInv"], "Fish", 0.2503666)
	gui["listFishInv_col1"] = guiGridListAddColumn(gui["listFishInv"], "Weight (Kg)", 0.223666)
	gui["listFishInv_col2"] = guiGridListAddColumn(gui["listFishInv"], "CSG Record (Kg)", 0.223666)
	gui["listFishInv_col3"] = guiGridListAddColumn(gui["listFishInv"], "Value ($)", 0.223666)
	guiGridListSetSelectionMode(gui["listFishInv"],0)
	local listFishInv_row = nil

	gui["btnSell"] = guiCreateButton(10, 275, 101, 23, "Sell", false, windowFishInv)

	gui["btnDrop"] = guiCreateButton(270, 275, 101, 23, "Drop", false, windowFishInv)

	gui["btnEat"] = guiCreateButton(140, 275, 101, 23, "Eat", false, windowFishInv)

	gui["btnCloseInv"] = guiCreateButton(10, 305, 491, 23, "Close", false, windowFishInv)

	gui["btnRelease"] = guiCreateButton(400, 275, 101, 23, "Release", false, windowFishInv)
	guiSetVisible(windowFishInv,false)
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
		guiGridListSetItemText ( gui["listFishInv"], row, 2, v[2].."  ("..sizeName..")", false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 3, "   "..records[v[1]][2].." ("..recordSizeName..")", false, false )
		guiGridListSetItemText ( gui["listFishInv"], row, 4, "  "..v[3], false, false )
	end
	if (bool) then
		if bool == false then return end
	end
	triggerServerEvent("CSGfishRecMyFishUpdate",localPlayer,myFish)
end

function isFishingVeh(v)
	if getElementModel(v) == 453 then return true end
	return false
end

showWarn = false
function fish0()
	if fishingMode == "Off" then return end
	local veh = getPedOccupiedVehicle(localPlayer)
	if veh == false then return end
	if isFishingVeh(veh) == true then
		if showWarn == false and reelingIn == false then
			local num = math.random(1,100)
			if num > 80 then --8% chance for it to come while driving
				showWarn = true
				bindKey("2","down",fish)
				setTimer(function()
					unbindKey("2","down",fish)
				showWarn = false end,5000,1)
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

reelingIn = false
function fish()
	local t = {}
	local num = math.random(1,100)
	reelingIn = true
	local tim = math.random(2000,4000)
	exports.CSGrozmisc:startProgressBar(255,255,0,0,255,0,"CSGfish.barFinish","Reeling In...", 50) -- 5 secs to finish
	if num < 10 then
		reelingIn = false
		setTimer(function() exports.CSGrozmisc:cancelProgressBar() end,tim,1)
	else

	end
	if num >= 10 then -- a catch
		if num <= 80 then	-- common catches
			catch0(common,10)
		elseif num > 80 and num <= 85 then -- rare
			catch0(rare,7)
		elseif num > 85 and num <= 87.5 then -- very rare
			catch0(veryrare,3)
		elseif num > 87.5 and num <= 93.5 then -- other good
			otherCatch(othergood)
			setTimer(function() exports.CSGrozmisc:cancelProgressBar() end,tim,1)
			return
		elseif num > 93.5 then --other bad
			otherCatch(otherbad)
			setTimer(function() exports.CSGrozmisc:cancelProgressBar() end,tim,1)
			return
		end
	else -- nothing
		setTimer(function () exports.DENhelp:createNewHelpMessage("Caught nothing",255,255,0) end,tim,1)
	end
end
addCommandHandler("mefish",fish)

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
		local weight = math.random(weightMin,weightMax)
		weight=weight*0.453592
		weight=math.floor(weight+0.5)
		local value = weight*(t[k].pricePerKg)
		value=value/5
		value=math.floor(value+0.5)
		table.insert(myFish,{k,weight,value})
		exports.DENhelp:createNewHelpMessage("Caught a "..weight.." Kg "..k.."!",0,255,0)
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
			exports.DENhelp:createNewHelpMessage("Caught a dead body. If the police ask, You forget",255,255,0)
		elseif i == 5 then --
			exports.DENhelp:createNewHelpMessage("Caught a jelly fish and got attacked!",255,0,0)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 6 then --
			exports.DENhelp:createNewHelpMessage("Caught a crab and got attacked!",255,0,0)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 7 then --
			exports.DENhelp:createNewHelpMessage("You caught something, but for some reason you mysteriously throw it back",255,255,0)
		elseif i == 8 then --
			exports.DENhelp:createNewHelpMessage("Caught a mermaid! A bad one! You got attacked!",255,0,0)
			local h = getElementHealth(localPlayer)
			setElementHealth(localPlayer,h*((math.random(1,99))/100))
		elseif i == 9 then --
			exports.DENhelp:createNewHelpMessage("Caught a whale and its weight sank the boat!",255,255,0)
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

		else
			exports.DENhelp:createNewHelpMessage("You can only sell fish at the Fisherman job Hut OR a 24/7 Shop",255,255,0)
		end
	elseif source == gui["btnDrop"] then

	elseif source == gui["btnEat"] then
		local row = guiGridListGetSelectedItem(gui["listFishInv"])
		if row == false or row == -1 then

		else
			row=row+1
			local name = myFish[row][1]
			local weight = myFish[row][2]
			exports.DENhelp:createNewHelpMessage("Ate a "..weight.." Kg "..name.." for some health",255,255,0)
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
	end
end
addEventHandler("onClientGUIClick",root,click)

function isInValidShop()
	return false
end

function show()
	guiSetVisible(windowFishInv,true)
	showCursor(true)
end

function hide()
	guiSetVisible(windowFishInv,false)
	showCursor(false)
end

function toggle()
	if guiGetVisible(windowFishInv) == true then
		hide()
	else
		show()
	end
end
addCommandHandler("fishinv",toggle)

function createText()
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Fishing: #33FF33"..fishingMode.."", screenWidth*0.09, screenHeight*0.95, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Fishing: #33FF33"..fishingMode.."", screenWidth*0.09, screenHeight*0.95, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
end

function isInValidBoat(v)
	local model = getElementModel(v)
	if model == 453 then return true end
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
		exports.CSGrozmisc:cancelProgressBar()
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
	exports.CSGrozmisc:cancelProgressBar()
	if isTimer(fishTimer) then
		killTimer(fishTimer)
	end
	--guiSetVisible(warnImage,false)
	unbindKey("1","down",toggleFishingMode)
	removeEventHandler("onClientRender",root,createText)
end

function CSGfishRecInv(t)
	if t == nil then t = {} end
	myFish = t
	updateInv(false)
end
addEvent("CSGfishRecInv",true)
addEventHandler("CSGfishRecInv",localPlayer,CSGfishRecInv)

function CSGfishRecRecords(t)
	records = t
	updateInv(false)
end
addEvent("CSGfishRecRecords",true)
addEventHandler("CSGfishRecRecords",localPlayer,CSGfishRecRecords)

txd = engineLoadTXD ( "sea.txd" )
engineImportTXD ( txd, 49 )
dff = engineLoadDFF ( "sea.dff", 49 )
engineReplaceModel ( dff, 49 )
