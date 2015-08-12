----------------------------------------------------------------------------------
 -- CSG
 -- CSGdrugs/drugsServer.slua
 -- Drugs
 -- Rozza, Dennis(GUI code)
----------------------------------------------------------------------------------

local DrugsGUI = {}
local DrugsGUIS = {}
local drugsTable
local drugNames = {}
local drugsTaken = {}
local drugsTimer = {}
local drugTime = {}
local madeTables = false
resX,resY = guiGetScreenSize()
-- original: 502,275,335,276
local width,height = 335,276
local X = (resX/2) - (width/2)
local Y = (resY/2) - (height/2)
DrugsGUI[1] = guiCreateWindow(X,Y,width,height,"Community of Social Gaming ~ Drugs",false)
guiWindowSetMovable(DrugsGUI[1], false)
guiWindowSetSizable(DrugsGUI[1], false)
DrugsGUIS[11] = guiCreateLabel(11,28,313,19,"Drugs and narcotics:",false,DrugsGUI[1])
guiLabelSetColor(DrugsGUIS[11],238,154,0)
DrugsGUIS[3] = guiCreateRadioButton(9,52,119,25,"Ritalin (0)",false,DrugsGUI[1])
DrugsGUIS[4] = guiCreateRadioButton(9,78,119,25,"LSD (0)",false,DrugsGUI[1])
DrugsGUIS[5] = guiCreateRadioButton(9,103,119,25,"Cocaine (0)",false,DrugsGUI[1])
DrugsGUIS[6] = guiCreateRadioButton(9,128,119,25,"Ecstasy (0)",false,DrugsGUI[1])
DrugsGUIS[7] = guiCreateRadioButton(9,153,119,25,"Heroine (0)",false,DrugsGUI[1])
DrugsGUIS[8] = guiCreateRadioButton(9,180,119,25,"Weed (0)",false,DrugsGUI[1])
DrugsGUI[2] = guiCreateButton(9,215,154,25,"Take a hit",false,DrugsGUI[1])
DrugsGUI[11] = guiCreateButton(165,215,161,25,"Start selling",false,DrugsGUI[1])
DrugsGUI[4] = guiCreateButton(165,244,161,23,"Drop drugs",false,DrugsGUI[1])
DrugsGUI[3] = guiCreateEdit(9,243,155,24,"",false,DrugsGUI[1])
DrugsGUI[5] = guiCreateLabel(134,56,198,23,"Faster movement and weapon fire",false,DrugsGUI[1])
DrugsGUI[6] = guiCreateLabel(134,82,198,23,"Slower movement, higher jumping",false,DrugsGUI[1])
DrugsGUI[7] = guiCreateLabel(134,109,198,23,"Hallucinate effects everywhere",false,DrugsGUI[1])
DrugsGUI[8] = guiCreateLabel(134,136,198,23,"Random drug",false,DrugsGUI[1])
DrugsGUI[9] = guiCreateLabel(134,160,198,23,"Ability to have more health", false,DrugsGUI[1])
DrugsGUI[10] = guiCreateLabel(134,186,198,23,"Half damage when hurt",false,DrugsGUI[1])
local idToElem = {
	[1] = DrugsGUIS[3],--Ritalin
	[2] = DrugsGUIS[5],--cocaine
	[3] = DrugsGUIS[6],--Ecstasy
	[4] = DrugsGUIS[7],--heroine
	[5] = DrugsGUIS[8],--weed
	[6] = DrugsGUIS[4],--lsd
}
guiSetEnabled(DrugsGUI[11], false)
guiSetVisible(DrugsGUI[1], false)
guiSetFont(DrugsGUIS[11], "default-bold-small")
guiSetFont(DrugsGUIS[3], "default-bold-small")
guiSetFont(DrugsGUIS[4], "default-bold-small")
guiSetFont(DrugsGUIS[5], "default-bold-small")
guiSetFont(DrugsGUIS[6], "default-bold-small")
guiSetFont(DrugsGUIS[7], "default-bold-small")
guiSetFont(DrugsGUIS[8], "default-bold-small")


local effectHealths = {

}

local effectVars = {

}

setTimer(function()
	for k,v in pairs(effectHealths) do
		if k ~= nil then
			if v ~= nil and effectHealths[k] ~= nil and v > 0 then
				effectHealths[k]=effectHealths[k]-1
			end
			if effectHealths[k] ~= nil and effectHealths[k] == 0 then
				effectHealths[k]=nil
				effectTake(k,effectVars[k][2])
			end
		end
	end
end,1000,0)
local showingDrugs = true

addCommandHandler("showd",function() showingDrugs=true end)

addEvent("onPlayerSettingChange",true)
addEventHandler("onPlayerSettingChange",localPlayer,function(s,v)
	if s == "drugtimer" and v == false then
		showingDrugs=false
		removeEventHandler("onClientRender",root,draw)
	elseif s == "drugtimer" and v == true then
		showingDrugs=true
		addEventHandler("onClientRender",root,draw)
	end
end)

sx,sy=guiGetScreenSize()


function draw()
	if showingDrugs == true then
		local toAdd=0

		for k,v in pairs(effectHealths) do
			local id2 = tonumber(k)
			if effectHealths[k] ~= nil and effectHealths[k] > 0 then
			local vehFuelColor = math.max((effectHealths[k] * 10) - 250, 0)/750
			local vehFuelthColorMath = -510*(vehFuelColor^2)
			local rf, gf = math.max(math.min(vehFuelthColorMath + 255*vehFuelColor + 255, 255), 0), math.max(math.min(vehFuelthColorMath + 765*vehFuelColor, 180), 0)
			dxDrawRectangle((289/1268)*sx,((592+toAdd)/768)*sy, (104/1268)*sx, (23/768)*sy, tocolor(0, 0, 0, 196), false)
			dxDrawRectangle((292/1268)*sx, ((595+toAdd)/768)*sy, (100*(98/1268)*sx)/100, (17/768)*sy, tocolor(rf, gf, 0, 196), false)
			dxDrawText(""..k..": "..v.."", (296/1268)*sx, ((596+toAdd)/768)*sy, (1118/1268)*sx, (690/768)*sy, tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, false, false, false)
			--dxDrawImage((225/1268)*sx, (679/768)*sy, (17/1920)*sx, (17/1080)*sy, "images/fuel.png", 0, 0, 0, tocolor(255, 255, 255, 255), false)
			toAdd=toAdd+23
			end
		end
	end
end
addEventHandler("onClientRender",root,draw)
function windowToggle()
	if (getElementHealth(localPlayer) ~= 0) then
		if guiGetVisible(DrugsGUI[1]) == true then
			guiSetVisible(DrugsGUI[1], false)
			showCursor(false)
			setElementData(localPlayer,"drugsOpen",false)
		else
			updateLabels()
			setElementData(localPlayer,"drugsOpen",true)
			guiSetVisible(DrugsGUI[1], true)
			showCursor(true)
		end
	end
end
bindKey("F4", "down", windowToggle)
addCommandHandler("drugs",windowToggle)

local commHits = {
	[1] = "ritalin",
	[2] = "lsd",
	[3] = "cocaine",
	[4] = "ecstasy",
	[5] = "heroine",
	[6] = "weed",
}

local canTake = true
addCommandHandler("takehit",function(_,name,amount)
	if name == nil then
		exports.dendxmsg:createNewDxMessage("Syntax: /takehit name amount. If no amount, then 1",255,255,0)
		return
	end
	if amount == nil then
		amount=1
	end
if not (tonumber(amount) >= 1) then
		amount = 1
	end
	if type(tonumber(amount)) ~= "number" then
		amount=1
	end

	for k,v in pairs(commHits) do
		if v == string.lower(name) then
			if canTake == false then return end
			canTake=false
			setTimer(function() canTake=true end,800,1)

				takeDrugStart(k,amount)

			return
		end
	end
	exports.dendxmsg:createNewDxMessage("There is no drug named '"..name.."'",255,255,0)
end,false)

function updateLabels()
	for a,b in pairs(drugsTable) do
		local a = tostring(a)
		local a2 = tonumber(a)
		if (drugNames[a2]) then
			local elem = idToElem[a2]
			if (isElement(elem)) then
				guiSetText(elem, drugNames[a2] .. " (" .. b .. ")")
				if (drugNames[a2] == "Cocaine") then
					--guiSetEnabled(elem, false)
				end
			end
		end
	end
	if (not madeTables) then
		for a,b in pairs(drugsTable) do
			drugsTimer[a] = {}
		end
		madeTables = true
	end
end

function getDrugsTable()
	return drugsTable,drugNames
end

function updateTable(tab, tab2)
	drugsTable = tab
	drugNames = tab2
	guiSetText(DrugsGUI[3], "")
	updateLabels()
end
addEvent("CSGdrugs.sendDrugTable", true)
addEventHandler("CSGdrugs.sendDrugTable", localPlayer, updateTable)

function getSelectedDrug()
	local drug = 0
	if (guiRadioButtonGetSelected(DrugsGUIS[3])) then
		drug = 1
	elseif (guiRadioButtonGetSelected(DrugsGUIS[5])) then
		drug = 2
	elseif (guiRadioButtonGetSelected(DrugsGUIS[6])) then
		drug = 3
	elseif (guiRadioButtonGetSelected(DrugsGUIS[7])) then
		drug = 4
	elseif (guiRadioButtonGetSelected(DrugsGUIS[8])) then
		drug = 5
	elseif (guiRadioButtonGetSelected(DrugsGUIS[4])) then
		drug = 6
	end
	local drug = drugNames[drug]
	return drug
end

function takeDrug1()
	local drug = 0
	if (guiRadioButtonGetSelected(DrugsGUIS[3])) then
		drug = 1
	elseif (guiRadioButtonGetSelected(DrugsGUIS[5])) then
		drug = 2
	elseif (guiRadioButtonGetSelected(DrugsGUIS[6])) then
		drug = 3
	elseif (guiRadioButtonGetSelected(DrugsGUIS[7])) then
		drug = 4
	elseif (guiRadioButtonGetSelected(DrugsGUIS[8])) then
		drug = 5
	elseif (guiRadioButtonGetSelected(DrugsGUIS[4])) then
		drug = 6
	end
	if (drug ~= 0) then
		takeDrugStart(drug)
	end
end
addEventHandler("onClientGUIClick", DrugsGUI[2], takeDrug1, false)

function drugEffect2(start, id, id2)
	local id = tostring(id)
	local id2 = tonumber(id)
	if (start) then
		if (not drugsTaken[id]) then
			if (drugsTable[id] > 1) then
				drugsTaken[id] = 1
				effectStart(drugNames[id2], id)
			end
		else
			if (drugNames[id2] == "Cocaine") then
				return false
			else
				drugsTaken[id] = drugsTaken[id] + 1
			end
		end
	else

		if (effectHealths[drugNames[id2]] == 1) then
			if (drugNames[id2] ~= "Cocaine") then
				outputChatBox(drugNames[id2] .. " has ended", 0, 255, 0)
			end
			drugsTaken[id] = nil
		else
			effectStart(drugNames[id2], id)
		end
	end
end


function effectTake(drug, id, id2)
	exports.dendxmsg:createNewDxMessage(""..drug.." effect has ended",0,255,0)
	--drugsTaken[id] = drugsTaken[id] - 1
	if (drug == "LSD") then
		stopLSD()
	end
	if (drug == "Ritalin") then
		setGameSpeed(1)
	end
	if (drug == "Ecstasy") then
		triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, drug)
	end
	if (drug == "Heroine") then
		triggerServerEvent("CSGdrugs.drugEffectStop", localPlayer, drug)
	end
	if (drug == "Weed") then
		setGravity(0.008)
		setGameSpeed(1)
	end
	--drugEffect(false, id, id2)
end



function effectStart(drug, id, id2)
	--local timer = setTimer(effectTake, 120000, 1, drug, id, id2)


	--outputDebugString("EFFECT START: " .. tostring(drug) .. " - " .. tostring(id))

	--drugsTimer[id][timer] = true
	--drugTime[id] = 60
	--setTimer(timeDown, 1000, 1, id)
	if (drug == "LSD") then
		startLSD()
	end
	if (drug == "Ritalin") then
		setGameSpeed(1.15)
	end
	if (drug == "Ecstasy") then
		triggerServerEvent("CSGdrugs.drugEffectStart", localPlayer, drug)
	end
	if (drug == "Heroine") then
		triggerServerEvent("CSGdrugs.drugEffectStart", localPlayer, drug)
	end
	if (drug == "Weed") then
		setGravity(0.008 - 0.0038)
		setGameSpeed(0.80)
	end
	if (drug == "Cocaine") then
		while (true) do
			local rand = math.random(1, 5)
			if (rand == 3) then
				rand = 6
			end
			outputChatBox("The random drug is: " .. drugNames[rand], 0, 255, 0)
			--drugEffect(true, tostring(rand), tonumber(rand))
			break
		end
	end
end

function takeDrugStart(id,am)
	local id = tostring(id)
	local id2 = tonumber(id)
	local taken = drugsTaken[id] or 0
	local taken = tonumber(taken)
	if am == nil then am=1 end
	am=tonumber(am)
	if (drugNames[id2] == "Cocaine" and taken == 1) then
		outputChatBox("You can only take one hit of Cocaine at a time", 0, 255, 0)
		return false
	end
	if (drugsTable[id] < am) then
		exports.dendxmsg:createNewDxMessage("You don't have "..am.." "..drugNames[id2].."", 255, 255, 0)
		return false
	end
	triggerServerEvent("CSGdrugs.takeDrug", localPlayer, id,am)
	if effectHealths[drugNames[id2]] == nil then effectHealths[drugNames[id2]]=0 end

	for i=1,am do
	local toAdd=48
	if effectHealths[drugNames[id2]] > 60 then
		toAdd=toAdd-14
	end
	if effectHealths[drugNames[id2]] > 120 then
		toAdd=toAdd-14
	end
	if effectHealths[drugNames[id2]] > 180 then
		toAdd=toAdd-14
	end
	effectHealths[drugNames[id2]] = effectHealths[drugNames[id2]]+(math.floor(math.random(toAdd*0.8,toAdd*1.2)))
	effectVars[drugNames[id2]] = {id,id2}
	effectStart(drugNames[id2])
	end
end

function takeDrugFinish(id,am)
	drugsTable[id] = drugsTable[id] - am
	updateLabels()
	--drugEffect(true, id, id2)
end
addEvent("CSGdrugs.takeDrugC", true)
addEventHandler("CSGdrugs.takeDrugC", localPlayer, takeDrugFinish)

function listTime()
	for a,b in pairs(drugTime) do
		local a = tostring(a)
		local a2 = tonumber(a)
		outputDebugString(tostring(a))
		outputDebugString(tostring(b))
		outputChatBox(drugNames[a2] .. " has " .. tonumber(b) .. " seconds remaining")
	end
end
addCommandHandler("timeleft", listTime)

triggerServerEvent("CSGdrugs.clientLoaded", localPlayer)
local badChars = {
	["-"] = true,
	["+"] = true,
	["*"] = true,
	["/"] = true,
}

function dropDrugC(amount)
	local id = getSelectedDrug()
	if (id ~= 0 and id) then
		if (string.match(amount, '^%d+$')) then
			local amount = tonumber(amount)
			if (not amount or amount == "" or amount == 0) then return false end
			triggerServerEvent("CSGdrugs.dropDrug", localPlayer, id, amount)
		end
	end
end

function dropDrugsC()
	local amount = guiGetText(DrugsGUI[3])
	dropDrugC(amount)
end
addEventHandler("onClientGUIClick", DrugsGUI[4], dropDrugsC, false)

function dropDrugCom(_, am)
	dropDrugC(am)
end
addCommandHandler("dropdrug", dropDrugCom)
