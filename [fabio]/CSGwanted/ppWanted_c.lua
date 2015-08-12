------------------------------------------------------------------------------------
--  CSG
--  v1.0
--  ppWanted_c.luac (client-side)
--  Wanted / Crime Detection System + Jail GUI's
--  Priyen Patel
------------------------------------------------------------------------------------

local attemptedMurderCD = {}
local toSend = {}
local vehicleDamageCD = {}
local needsToBeSent=false
local canGetWantedFromVehShoot=true
--local LVcol = createColRectangle(866,656,2100,2300)
local LVcol = createColRectangle(1,1,1,1)

function fireWep(weapon, ammo, ammoInClip, fX, fY, fZ, hitElement)
	if isElement(hitElement) == false then return end
	if getTeamName(getPlayerTeam(localPlayer)) == "Staff" then return end
	if isElementWithinColShape(hitElement,LVcol) == true then return end
	if getElementType(hitElement) == "vehicle" then
		if getElementData(hitElement,"vehicleOwner") == localPlayer then
			return
		end
		local isInsideWanted = false
		local t = getVehicleOccupants(hitElement)
		local passengerCount=4
		for k,v in pairs(t) do
			if isElement(v) == true then
				local wantedpts = getElementData(v,"wantedPoints")
				if wantedpts ~= false then
					if tonumber(wantedpts) > 9 then
						isWantedInside = true
					end
				end
			end
		end
		if isWantedInside == true then
			if isLaw(localPlayer) == true then return end
			if canGetWantedFromVehShoot==false then return end
			local vehHealth = getElementHealth(hitElement)
			for i=1,passengerCount do
				wanted(localPlayer,20)
				if vehHealth < 300 then
					wanted(localPlayer,23)
				end
			end
			canGetWantedFromVehShoot=false
			setTimer(function() canGetWantedFromVehShoot=true end,5000,1)
	elseif getElementType(hitElement) == "player" then
			if canGetWantedFromVehShoot==false then return end
			local vehHealth = getElementHealth(hitElement)
			for i=1,passengerCount do
				wanted(localPlayer,20)
				if vehHealth < 300 then
					wanted(localPlayer,23)
				end
			end
			canGetWantedFromVehShoot=false
			setTimer(function() canGetWantedFromVehShoot=true end,5000,1)

		end
	end
end
addEventHandler("onClientPlayerWeaponFire", localPlayer, fireWep)

function wasted(killer,wep)
	if source ~= localPlayer then return end
	if isElement(killer) then
		if isElementWithinColShape(killer,LVcol) == true then return end
		if getElementType(killer) == "player" then
			if killer == localPlayer then return end
			if getTeamName(getPlayerTeam(killer)) == "Staff" then exports.CSGscore:givePlayerScore(localPlayer,1) return end
			if isLaw(killer) == true then return end
			if wep >= 33 and wep <= 40 then
				wanted(killer,7)
			else
				wanted(killer,8)
			end
		else
			if getElementType(killer) == "vehicle" then
				local con = getVehicleController(killer)
				if con == localPlayer then return end
				if getElementType(con) == "player" then
					if isLaw(con) == false then
						wanted(con,18)
					end
				end
			end
		end
	end
end
addEventHandler("onClientPlayerWasted", localPlayer, wasted)

local Lawteams = {
	"Police","SWAT","Military Forces","Government Agency"
}

function isLaw(p)
	if getElementType(p) == "ped" then return false end
	local te = getPlayerTeam(p)
	if te == false then return false end
	local name = getTeamName(te)
	for k,v in pairs(Lawteams) do
		if v == name then return true end
	end
	return false
end

local wepsToI = {
	[0] = 1
}
for i=2,15 do wepsToI[i] = 3 end
for i=22,32 do wepsToI[i] = 2 end
for i=33,40 do wepsToI[i] = 16 end
for i=41,46 do wepsToI[i] = 3 end
wepsToI[16]=16
wepsToI[18]=13
wepsToI[37]=2

function isWanted(p)
	local pts = getElementData(p,"wantedPoints")
	if pts == nil or pts == false then return false end
	if pts > 9 then return true else return false end
end

function saveSpawn ( )
  startSaveSpawn()
end
addEventHandler ( "onClientPlayerSpawn", localPlayer, saveSpawn )

function startSaveSpawn ()
	toggleControl("fire",false)
	toggleControl("next_weapon",false)
	toggleControl("previous_weapon",false)
	triggerServerEvent("CSGspawn.alpha",localPlayer,100)
 setElementData(localPlayer, "sp_prot", true );
  setTimer(removeSaveSpawn,12000,1)
end

function removeSaveSpawn ()
	toggleControl("fire",true)
	toggleControl("next_weapon",true)
	toggleControl("previous_weapon",true)
	setElementData(localPlayer, "sp_prot", false );
	triggerServerEvent("CSGspawn.alpha",localPlayer,255)
end

function damageDetect(atker,wep,bodypart)
	if isElement(atker) == false then return end
	if wep == 33 or wep == 34 then
		if bodypart==9 and getElementAlpha(localPlayer) == 255 then
			if getElementHealth(localPlayer) > 50 then
				local r = getElementData(atker,"Rank")
				local r2 = getElementData(atker,"skill")
				if r2==false then r2="" end

					if r == "Assassin" or r2 == "Range Unit" then
						triggerServerEvent("CSGwanted.assasinate",localPlayer,atker,wep,bodypart)
					end
			end
		else
			cancelEvent()
		end
	end
	if wep > 0 and wep < 10 then
		if getElementData(localPlayer,"Rank") == "Butcher" then
			local h = getElementHealth(localPlayer)
			if h-0.5 > 0 then
				setElementHealth(localPlayer,h-0.5)
			end
		end
	end
	if isElementWithinColShape(atker,LVcol) == true then return end
	local veh = false
	if atker == false then return end
	if getElementType(atker) == "vehicle" then
		local con = getVehicleController(atker)
		if getElementType(con) == "player" then
			if getTeamName(getPlayerTeam(con)) == "Staff" then return end
			veh = atker
			atker = con
		else
			return
		end
	end
	if atker == localPlayer or veh == localPlayer then return end
	if getElementType(atker) == "vehicle" then return end
	if getTeamName(getPlayerTeam(localPlayer)) == "Staff" then return end
	if getTeamName(getPlayerTeam(atker)) == "Staff" then return end
	if isLaw(atker) == true then
		if isLaw(localPlayer) == true then return end
		if isWanted(localPlayer) == true then
			return
		end
	end
	if veh == false then
		if wepsToI[wep] ~= nil then
			if wep == 41 then
				if getTeamName(getPlayerTeam(atker)) == "Paramedics" or getElementData(atker,"skill") == "Support Unit" then
						cancelEvent()
					return
				end
			end
			if isLaw(localPlayer) == true then
				if wep > 15 then
					wanted(atker,5)
				else
					wanted(atker,4)
				end
			end
			wanted(atker,wepsToI[wep])
		end
	else
		if vehicleDamageCD[atker] == nil or vehicleDamageCD[atker] == false then
			wanted(atker,19)
			vehicleDamageCD[atker]=true
			local atker2 = atker
			setTimer(function() vehicleDamageCD[atker2] = false end,9000,1)
		else
			wanted(atker,17)
		end
	end
	local h = getElementHealth(localPlayer)
	if h < 20 then
		if attemptedMurderCD[atker] == nil or attemptedMurderCD[atker] == false then
			attemptedMurderCD[atker] = true
			local atker2 = atker
			setTimer(function() attemptedMurderCD[atker2] = false end,10000,1)
			wanted(atker,6)
		end
	end

end
addEventHandler("onClientPlayerDamage", localPlayer, damageDetect)

function wanted(p,id)
	if toSend[p] == nil then toSend[p] = {} end
	table.insert(toSend[p],id)
	needsToBeSent = true
end

function send()
	if needsToBeSent == true then
		triggerServerEvent("CSGwanted.recNewWanteds",localPlayer,toSend)
		toSend={}
		needsToBeSent=false
	end
end
setTimer(send,1000,0)

nearCopsCol = createColCircle(1,1,300)
attachElements(nearCopsCol,localPlayer)
function lowerWanted ()
	if (getElementData(localPlayer,"isPlayerArrested")) then return end
	local wantedPts = getElementData(localPlayer, "wantedPoints")
	if wantedPts == nil then return end

	if (tonumber(wantedPts) > 0) then
		local x,y = getElementPosition(localPlayer)
		local dim = getElementDimension(localPlayer)
		local int = getElementInterior(localPlayer)
		setElementDimension(nearCopsCol,dim)
		setElementInterior(nearCopsCol,int)
		local t = getElementsWithinColShape(nearCopsCol,"player")
		local copAround = false
		for k,v in pairs(t) do
			if exports.DENlaw:isPlayerLawEnforcer(v) == true then return  end
		end
		if copAround == false then
			setElementData(localPlayer, "wantedPoints", getElementData(localPlayer, "wantedPoints")-1)
		end
	end
end
setTimer(lowerWanted,30000,0)

function newStamp(stamp)
	theTimeStamp=stamp
end
addEvent("CSGwanted.newTimeStamp",true)
addEventHandler("CSGwanted.newTimeStamp",localPlayer,newStamp)
--------------------------------

window = guiCreateWindow(0.3,0.2839,0.35,0.2956, "Community of Social Gaming ~ Your last committed crimes", true)
guiWindowSetSizable(window, false)
theGrid = guiCreateGridList(0.02366,0.1,0.95,0.73, true, window)
guiGridListAddColumn( theGrid, "", 0.85 )
btnExit = guiCreateButton(0.0266,0.85, 0.95, 0.95, "Close the window", true, window)
guiSetVisible(window,false)

function show()
	guiSetVisible(window,true)
	showCursor(true)
end

function hide()
	guiSetVisible(window,false)
	showCursor(false)
end
addEventHandler("onClientGUIClick",btnExit,function() if source == btnExit then hide() end end)

function toggle()
	if guiGetVisible(window) == true then hide() else show() end
end
addCommandHandler("crimes",toggle)

addEventHandler("onClientPlayerWasted",localPlayer,hide)

function released()
	guiSetText(lblTimeLeft,"Served Jail Sentence : Released")
end
addEvent("CSGwanted.playerJailReleased",true)
addEventHandler("CSGwanted.playerJailReleased",localPlayer,released)

local crimeNames = {
	[1] = {"Bodily Harm",0.015},
	[2] = {"Assault with a Deadly Weapon",0.055},
	[3] = {"Assault with a Melee Weapon",0.015},
	[4] = {"Bodily Harm to a Law Enforcement Officer",0.0225},
	[5] = {"Aggravated Assault to a Law Enforcement Officer",0.025},
	[6] = {"Attempted Murder",4},
	[7] = {"1st Degree Murder",15},
	[8] = {"2nd Degree Murder",10},
	[9] = {"Impaired driving",5},
	[10] = {"Public Drug Usage",5},
	[11] = {"Uttering Threats",3},
	[12] = {"Theft of motor vehicle",5},
	[13] = {"Arson",5},
	[14] = {"Disorderly conduct",1},
	[15] = {"Harm to a vehicle",1},
	[16] = {"Assault with a Weapon of Mass Destruction",1},
	[17] = {"Voluntary Bodily Harm using a Vehicle",0.1},
	[18] = {"1st Degree Murder using a Vehicle",15},
	[19] = {"Unvoluntary Bodily Harm using a Vehicle",0.075},
	[20] = {"Vandalism to a vehicle",0.1},
	[21] = {"Aggravated Assault - Vehicle Jacking",10},
	[22] = {"Attempted Armored Truck Robbery",30},
	[23] = {"Vandalism to a vehicle - Attempted Murder",4},
	[24] = {"Attempted Store Robbery",10},
	[25] = {"Successfull Store Robbery",10},
	[26] = {"Successfull House Break-in",22},
	[27] = {"Attempted House Break-in",15},
	[28] = {"Attempted Bank Robbery",60},
	[29] = {"Successfull Bank Robbery",60},
	[30] = {"Aggravated Robbery",22},
	[31] = {"Attempted Robbery",12},
	[32] = {"Drug Shipment / Robbery",50},
	[33] = {"Illegal Entry - Federal Prison Premesis",10},
	[34] = {"Selling Drugs in Public",3},
	[35] = {"Buying Drugs in Public",3},
	[36] = {"Driving Stolen Vehicle",15},
	[37] = {"Delivering Stolen Vehicle",20},
	[38] = {"Illegally driving law vehicle",35},
}

local months = {
	"January","February","March","April","May","June","July","August","September","October","November","December"
}

function getFormattedDate(stamp)
	local month = ""
	local year = ""
	local day = ""
	stamp=tostring(stamp)
	for i = 1, #stamp do
		local c = stamp:sub(i,i)
		if i > 0 and i < 5 then
			year = year..""..c..""
		end
		if i == 5 or i == 6 then
			month=month..""..c..""
		end
		if i > 6 then
			day=day..""..c..""
		end
	end
	local mName=months[tonumber(month)]
	local formatted = mName.." "..day..", "..year..""
	return formatted
end

function doColor(amount,theRow)
	guiGridListSetItemColor(theGrid,theRow,1,0,255,0)
	if amount > 5 then
		guiGridListSetItemColor(theGrid,theRow,1,255,69,0)
	end
	if amount > 10 then
		guiGridListSetItemColor(theGrid,theRow,1,255,0,0)
	end

end

function recUpdatedData(theTable,period)
	guiGridListClear(theGrid)
	local catRow = guiGridListAddRow( theGrid )
	guiGridListSetItemText( theGrid, catRow, 1, "My Wanted Points: "..math.floor(getElementData(localPlayer,"wantedPoints")).."", true, false )
	catRow = guiGridListAddRow( theGrid )
	guiGridListSetItemText( theGrid, catRow, 1, "Recently Committed Crimes", true, false )
	for cat,v in pairs(period) do
		local theRow = guiGridListAddRow( theGrid )
		if v[1] > 1 then
			guiGridListSetItemText( theGrid, theRow, 1, ""..v[1].." accounts of "..(crimeNames[v[2]][1]).."", false, false)
		else
			guiGridListSetItemText( theGrid, theRow, 1, ""..v[1].." account of "..(crimeNames[v[2]][1]).."", false, false)
		end
		guiGridListSetItemColor(theGrid,theRow,1,255,165,0)
		doColor(v[1],theRow)
	end
	for cat,v in pairs(theTable) do
		if tonumber(v[1]) > 0 then
		local catRow = guiGridListAddRow( theGrid )
		if v[1] == theTimeStamp then
			guiGridListSetItemText( theGrid, catRow, 1, getFormattedDate(v[1]).." (Today) ", true, false )
		else
			guiGridListSetItemText( theGrid, catRow, 1, getFormattedDate(v[1]), true, false )
		end
		for k,data in pairs(v[2]) do
			local theRow = guiGridListAddRow( theGrid )
			if data[2] ~= nil then
			if crimeNames[data[2]] ~= nil then
			if crimeNames[data[2]][1] ~= nil then
			if data[1] > 1 then
				guiGridListSetItemText( theGrid, theRow, 1, ""..data[1].." accounts of "..(crimeNames[data[2]][1]).."", false, false)
			else
				guiGridListSetItemText( theGrid, theRow, 1, ""..data[1].." account of "..(crimeNames[data[2]][1]).."", false, false)
			end
			doColor(data[1],theRow)
			end
			end
			end
		end
		end
	end
end

addEvent("CSGwanted.recData",true)
addEventHandler("CSGwanted.recData",localPlayer,recUpdatedData)

function toggleJailWindow()
	if guiGetVisible(jailWindow) == true then
		guiSetVisible(jailWindow,false)
	else
		local dim = getElementDimension(localPlayer)
		local x,y,z = getElementPosition(localPlayer)
		local x2,y2,z2 = 1561.75, -822.47, 350.84
		if dim == 2 then
			if getDistanceBetweenPoints3D(x,y,z,x2,y2,z2) < 100 then
				guiSetVisible(jailWindow,true)
			end
		end
	end
end
bindKey("lshift", "down", toggleJailWindow)

function showJailWindow()
	guiSetVisible(jailWindow,true)
end

function hideJailWindow()
	guiSetVisible(jailWindow,true)
end

function jailed(name,tim,pts,crimesCount,chargesCount)
	showJailWindow()
	show()
	local stars = getPlayerWantedLevel()
	if stars == 6 then theStr = "Wanted Level - Felon 6 - Most Wanted" else theStr = "Wanted Level - Felon "..stars.."" end
	guiSetText(lblName,theStr)
	guiSetText(lblArrestor,"Arrested by Officer "..name.."")
	guiSetText(lblTimeLeft,"Jailed : Maximum Sentence "..tim.." Seconds")
	guiSetText(lblWantedPoints,""..pts.." Wanted Points")
	guiSetText(lblCrimes,""..chargesCount.." Charges for "..crimesCount.." Different Crimes")
end
addEvent("CSGwanted.jailed",true)
addEventHandler("CSGwanted.jailed",localPlayer,jailed)


addEventHandler("onClientResourceStart",resourceRoot,
    function()
        GUIEditor_Label = {}
        jailWindow = guiCreateWindow(0.0266,0.2839,0.2734,0.2956,"CSG Jail",true)
        guiWindowSetSizable(jailWindow,false)
        GUIEditor_Label[1] = guiCreateLabel(0.0286,0.0661,0.94,0.1806,"Busted!",true,jailWindow)
        guiLabelSetColor(GUIEditor_Label[1],0,255,0)
        guiLabelSetHorizontalAlign(GUIEditor_Label[1],"center",false)
        guiSetFont(GUIEditor_Label[1],"sa-header")
        lblName = guiCreateLabel(0.1971,0.2731,0.6,0.0925,"Wanted Level",true,jailWindow)
        guiLabelSetColor(lblName,255,0,0)
		guiSetFont(lblName,"default-bold-small")
        guiLabelSetHorizontalAlign(lblName,"center",false)
        lblCrimes = guiCreateLabel(0.2,0.3612,0.6,0.0925,"55 Charges for 6 Different Crimes",true,jailWindow)
        guiLabelSetColor(lblCrimes,255,0,0)
		guiSetFont(lblCrimes,"default-bold-small")
        guiLabelSetHorizontalAlign(lblCrimes,"center",false)
		lblWantedPoints = guiCreateLabel(0.2,0.4493,0.6,0.0925,"5644 Wanted Points Earned",true,jailWindow)
        guiLabelSetColor(lblWantedPoints,255,0,0)
		guiSetFont(lblWantedPoints,"default-bold-small")
        guiLabelSetHorizontalAlign(lblWantedPoints,"center",false)
        lblArrestor = guiCreateLabel(0.1,0.5374,0.8,0.2555,"Arrested by Officer Priyen",true,jailWindow)
        guiLabelSetColor(lblArrestor,0,0,255)
		guiSetFont(lblArrestor,"default-bold-small")
        guiLabelSetHorizontalAlign(lblArrestor,"center",true)
        lblTimeLeft = guiCreateLabel(0.1629,0.6255,0.6457,0.0925,"Time Left: 25 Seconds",true,jailWindow)
        guiLabelSetColor(lblTimeLeft,255,165,0)
		guiSetFont(lblTimeLeft,"default-bold-small")
        guiLabelSetHorizontalAlign(lblTimeLeft,"center",false)
        GUIEditor_Label[3] = guiCreateLabel(0.0286,0.7489,0.9514,0.0925,"-----------------------------------------------------------------------------------",true,jailWindow)
        guiLabelSetColor(GUIEditor_Label[3],255,250,255)
        GUIEditor_Label[4] = guiCreateLabel(0.0286,0.8062,0.9514,0.0925,"Don't do the crime if you can't do the time.",true,jailWindow)
        guiLabelSetColor(GUIEditor_Label[4],255,250,255)
        GUIEditor_Label[5] = guiCreateLabel(0.0286,0.8899,0.9514,0.0925,"Press Left Shift to toggle this window.",true,jailWindow)
        guiLabelSetColor(GUIEditor_Label[5],255,250,255)
		guiSetVisible(jailWindow,false)
    end
)
addCommandHandler("seegui",function() guiSetVisible(jailWindow,true) end)
