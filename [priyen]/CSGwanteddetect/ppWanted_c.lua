local attemptedMurderCD = {}
local toSend = {}
local vehicleDamageCD = {}
local needsToBeSent=false
local LVcol = createColRectangle(866,656,2100,2300)

function fireWep(weapon, ammo, ammoInClip, fX, fY, fZ, hitElement)
	if getTeamName(getPlayerTeam(localPlayer)) == "Staff" then return end
	if isElementWithinColShape(hitElement,LVcol) == true then return end
	if getElementType(hitElement) == "vehicle" then
		local isInsideWanted = false
		local t = getVehicleOccupants(hitElement)
		local passengerCount=0
		for k,v in pairs(t) do
			if v ~= false or v ~= nil then
				local wantedpts = getElementData(v,"wantedPoints")
				if wantedpts ~= false then
					if tonumber(wantedpts) > 9 then
						isWantedInside = true
						passengerCount=passengerCount+1
					end
				end
			end
		end
		if isWantedInside == true and isLaw(localPlayer) == true then
			return
		else
			for i=0,passengerCount do
				addWanted(localPlayer,20)
			end
		end
	end
end
addEventHandler("onClientPedWeaponFire", localPlayer, fireWep)

function wasted(killer,wep)
	if isElement(killer) then
		if isElementWithinColShape(killer,LVcol) == true then return end
		if getElementType(killer) == "player" then
			if killer == localPlayer then return end
			if getTeamName(getPlayerTeam(killer)) == "Staff" then return end
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
	"Police","SWAT","Military Forces"
}

function isLaw(p)
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
wepsToI[18]=16
wepsToI[37]=2

function damageDetect(atker,wep,bodypart)
	if isElement(atker) == false then return end
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
	if isLaw(atker) == true then return end
	if veh == false then
		if wepsToI[wep] ~= nil then
			if wep == 41 then
				if getTeamName(getPlayerTeam(atker)) == "Paramedics" then
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

nearCopsCol = createColCircle(1,1,300)
attachElements(nearCopsCol,localPlayer)
function lowerWanted ()
	if (tonumber(getElementData(localPlayer, "wantedPoints")) > 0) then
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

function wanted(p,id)
	if toSend[p] == nil then toSend[p] = {} end
	table.insert(toSend[p],id)
	needsToBeSent = true
end

function send()
	if needsToBeSent == true then
		triggerServerEvent("CSGwanteddetect.RecNewWanteds",localPlayer,toSend)
		toSend={}
		needsToBeSent=false
	end
end
setTimer(send,1000,0)
--------------------------------

window = guiCreateWindow(0.3,0.2839,0.50,0.2956, "Community of Social Gaming ~ Your last committed crimes", true)
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


function recUpdatedData(bool,period,today)
	guiGridListClear(theGrid)
	if bool == true then
		guiGridListSetItemText( theGrid, guiGridListAddRow( theGrid ), 1, "Jailed For", true, false )
	show()
	else
		guiGridListSetItemText( theGrid, guiGridListAddRow( theGrid ), 1, "Currently Wanted For", true, false )
	end
	if period ~= nil then
		for k,v in pairs(period) do
			guiGridListSetItemText( theGrid, guiGridListAddRow( theGrid ), 1, v,false,false)
		end
	end
	guiGridListSetItemText( theGrid, guiGridListAddRow( theGrid ), 1, "Today", true, false )
	if today ~= nil then
		for k,v in pairs(today) do
			guiGridListSetItemText( theGrid, guiGridListAddRow( theGrid ), 1, v,false,false)
		end
	end
	guiGridListSetItemText( theGrid, guiGridListAddRow( theGrid ), 1, "Yesterday", true, false )
	guiGridListSetItemText( theGrid, guiGridListAddRow( theGrid ), 1, "November 14th, 2012", true, false )
end
recUpdatedData()
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
