local data = {
	[1] = {"Bodily Harm",0.05},
	[2] = {"Assault with a Deadly Weapon",0.075},
	[3] = {"Assault with a Melee Weapon",0.05},
	[4] = {"Bodily Harm to a Law Enforcement Officer",0.0125},
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
	[17] = {"Voluntary Bodily Harm using a Vehicle",0.3},
	[18] = {"1st Degree Murder using a Vehicle",15},
	[19] = {"Unvoluntary Bodily Harm using a Vehicle",0.15},
	[20] = {"Assault with a Deadly Weapon - Motor Vehicle",0.1},
	[21] = {"Assault with a Weapon of Mass Destruction - Motor Vehicle",1},
}


local cd = {}
local accountCurrentJailPeriod = {}
local accountToday = {}
local needsUpdatedData = {}
local currentCrimesCount = {}
local currentChargesCount = {}

function onLogin()
	local p = source
	setTimer(function() sendData(p) end,5000,1)
end
addEventHandler("onPlayerLogin",root,onLogin)

function sendData(p,bool)
	if bool == nil then bool = false end
	if needsUpdatedData[p] == nil then needsUpdatedData[p] = true end
	if needsUpdatedData[p] == false then return end
	local acc = exports.server:getPlayerAccountName(p)
	if accountCurrentJailPeriod[acc] == nil then accountCurrentJailPeriod[acc] = {} for count=1,#data do accountCurrentJailPeriod[acc][count] = 0 end end
	if accountToday[acc] == nil then accountToday[acc] = {} for count=1,#data do accountToday[acc][count] = 0 end end
	local period = {} --current period
	local today = {} --today
	currentCrimesCount[p] = 0
	currentChargesCount[p] = 0
	for k,v in pairs(accountCurrentJailPeriod[exports.server:getPlayerAccountName(p)]) do
		if v ~= 0 then
			if v > 1 then
				table.insert(period,""..v.." accounts of "..data[k][1].."")
			else
				table.insert(period,""..v.." account of "..data[k][1].."")
			end
			currentCrimesCount[p]=currentCrimesCount[p]+1
			currentChargesCount[p]=currentChargesCount[p]+v
		end
	end
	for k,v in pairs(accountToday[exports.server:getPlayerAccountName(p)]) do
		if v ~= 0 then
			if v > 1 then
				table.insert(today,""..v.." accounts of "..data[k][1].."")
			else
				table.insert(today,""..v.." account of "..data[k][1].."")
			end
		end
	end
	triggerClientEvent(p,"CSGwanted.recData",p,bool,period,today)
end
addEvent("CSGlaw.playerJailed",true)
addEventHandler("CSGlaw.playerJailed",root,function() sendData(source,true) end)

function detected(p,i,victim)
	local wantedPTS = getElementData(p,"wantedPoints")
	local toAdd = data[i][2]
	if (type(wantedPTS) == "number") then
		if tonumber(wantedPTS) < 10 then
			local needed = 10 - wantedPTS
			local pts = math.random(0.1,needed)
			toAdd=toAdd+pts
		end
		exports.server:givePlayerWantedPoints(p,toAdd)
		setElementData(p,"wantedPoints",wantedPTS+toAdd,true)

		if cd[p] == nil then cd[p] = {} end
		if cd[p][victim] == nil then cd[p][victim] = {} end
		if cd[p][victim][i] == nil then cd[p][victim][i]=false end
		if cd[p][victim][i] == false then
			local acc = exports.server:getPlayerAccountName(p)
			if accountCurrentJailPeriod[acc] == nil then accountCurrentJailPeriod[acc] = {} for count=1,#data do accountCurrentJailPeriod[acc][count] = 0 end end
			if accountToday[acc] == nil then accountToday[acc] = {} for count=1,#data do accountToday[acc][count] = 0 end end
			accountCurrentJailPeriod[acc][i] = accountCurrentJailPeriod[acc][i] + 1
			accountToday[acc][i] = accountToday[acc][i] + 1
			cd[p][victim][i] = true
			local p2,victim2,i2 = p,victim,i
			setTimer(function() cd[p2][victim2][i2] = false end,10000,1)
			sendData(p)
		end
	else
		return false
	end
end
addEvent("CSGwantedDetect.detected",true)
addEventHandler("CSGwantedDetect.detected",root,detected)

function recNewWanteds(t)
	for k,v in pairs(t) do
		for k2,v2 in pairs(v) do
			detected(k,v2,source)
		end
	end
end
addEvent("CSGwanteddetect.RecNewWanteds",true)
addEventHandler("CSGwanteddetect.RecNewWanteds",root,recNewWanteds)

arrests={}
addEvent("onPlayerArrest",true)
addEventHandler("onPlayerArrest",root,function(cop)
	local p = source
	arrests[p]=cop
end)

addEvent("onPlayerJailed",true)
addEventHandler("onPlayerJailed",root,function(tim)
	local p = source
	if arrests[p] == nil then arrests[p]="The Law" end
	local arrestor = arrests[p]
	local arrestorName = ""
	local pts = math.floor((exports.server:getPlayerWantedPoints(p))+0.5)
	if isElement(arrestor) then
		arrestorName=getPlayerName(arrestor)
	else
		arrestorName=arrestor
	end
	if currentCrimesCount[p] == nil then sendData(p,true) end
	triggerClientEvent(p,"CSGwanted.jailed",p,arrestorName,tim,pts,currentCrimesCount[p],currentChargesCount[p])
end)
------------------

-- Create Col in LV
local LVcol = createColRectangle(866,656,2100,2300)

-- Check if player is in LV
addEventHandler( "onColShapeHit", LVcol, -- Root is alle cols he
function (hitElement)
	setElementData ( hitElement, "isPlayerInLvCol", true )
end
) -- Denk dat dit het al oplost

addEventHandler( "onColShapeLeave", LVcol,
function (hitElement)
	setElementData ( hitElement, "isPlayerInLvCol", true )
end
)

addEvent ("isPlayerInLvCol", true)
function isPlayerInLvCol ()
	setElementData ( source, "isPlayerInLvCol", false )
	if isElementWithinColShape ( source, LVcol ) then
		setElementData ( source, "isPlayerInLvCol", true )
	end
end
addEventHandler ("onPlayerConnect", root, isPlayerInLvCol)
addEventHandler ("onPlayerLogin", root, isPlayerInLvCol)
addEventHandler ("isPlayerInLvCol", root, isPlayerInLvCol)

