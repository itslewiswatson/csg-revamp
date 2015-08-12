local rankI = {}
local ranks = {
	{"Mine Worker",0,0,"Base Salary"},
	{"Mineral Extractor in Training",25,0,"Base Salary"},
	{"Recruit Mineral Extractor",50,0,"Base Salary"},
	{"Professional Mineral Extractor",75,0,"Base Salary + 5%"},
	{"Experienced Miner",100,0,"Base Salary + 5% + 100 Kg Weight Limit"},
	{"Head Miner",200,0,"Base Salary + 10%"},
	{"Iron Expert",300,0,"Base Salary + 10% + 100 Kg Weight Limit"},
	{"Elite Miner",400,0,"Base Salary + 15%"},
	{"Vice Chief of Mining",500,0,"Base Salary + 15% + 100 Kg Weight Limit"},
	{"Head Chief of Mining",600,0,"Base Salary + 20%"},
	{"God of Iron",700,0,"Base Salary + 20% + 100 Kg Weight Limit"},
	{"Iron Mining CEO",800,0,"Base Salary + 25%"},

}

local nameToI = {
	["Times deposited rocks"] = 1,
	["Money earned in total"] = 2,
	["Kg of rocks deposited"] = 3,
	["Kg of rocks mined"] = 4,
}

local rankValue = {
	["Times deposited rocks"] = 0,
	["Money earned in total"] = 0,
	["Kg of rocks deposited"] = 0.2,
	["Kg of rocks mined"] = 0.05,
}

local jobTeam = "Civilian Workers"
local jobName = "Iron Miner"
local statName = "ironminerstat"
local rankStat = "ironminer"
local desc = "test"

-- Medic panel
medicPanelWindow = guiCreateWindow(409,182,441,459,"CSG ~ "..jobName.." Panel",false)
medicPanelGrid = guiCreateMemo(9,23,423,249,desc,false,medicPanelWindow)

guiCreateStaticImage(10,300,250,150,"pic.png",false,medicPanelWindow)
btnStats = guiCreateButton(290, 320, 141, 33, "Stats", false, medicPanelWindow)
btnRanks = guiCreateButton(290, 368, 141, 33, "Ranks", false, medicPanelWindow)
btnHelp = guiCreateButton(290, 416, 141, 33, "Help / Info", false, medicPanelWindow)

GUIEditor = {
    gridlist = {},
    button = {},
    label = {},
}
winStats = guiCreateWindow(365, 105, 477, 304, "CSG ~ "..jobName.." Stats", false)
guiWindowSetSizable(winStats, false)

listStats = guiCreateGridList(9, 22, 459, 246, false, winStats)
guiGridListAddColumn(listStats, "Stat", 0.5)
guiGridListAddColumn(listStats, "Value", 0.1)
guiGridListAddColumn(listStats, "Rank Value", 0.13)
guiGridListAddColumn(listStats, "Total Rank Value", 0.2)
lblTotalRankPoints = guiCreateLabel(7, 273, 138, 19, "Total Rank Points: ", false, winStats)
btnExitStats = guiCreateButton(249, 272, 219, 23, "Hide / Exit", false, winStats)


GUIEditor = {
    label = {},
}
winRanks = guiCreateWindow(165, 105, 477, 304, "CSG ~ "..jobName.." Ranks", false)
guiWindowSetSizable(winRanks, false)

listRanks = guiCreateGridList(9, 22, 459, 246, false, winRanks)
guiGridListAddColumn(listRanks, "Rank", 0.4)
guiGridListAddColumn(listRanks, "Points Needed", 0.2)
guiGridListAddColumn(listRanks, "Net Value", 0.2)
guiGridListAddColumn(listRanks, "Benifits", 0.6)
lblRank = guiCreateLabel(10, 275, 201, 19, "Rank:", false, winRanks)
btnExitRanks = guiCreateButton(249, 272, 219, 23, "Hide / Exit", false, winRanks)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(medicPanelWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(medicPanelWindow,x,y,false)

guiWindowSetMovable (medicPanelWindow, true)
guiWindowSetSizable (medicPanelWindow, false)
guiSetVisible (medicPanelWindow, false)
guiSetVisible(winRanks,false)
guiSetVisible(winStats,false)
addEventHandler("onClientGUIClick",root,function()
	if source == btnStats then
		if guiGetVisible(winStats) then
			guiSetVisible(winStats,false)
		else
			guiSetVisible(winStats,true)
		end
	elseif source == btnRanks then
		if guiGetVisible(winRanks) then
			guiSetVisible(winRanks,false)
		else
			guiSetVisible(winRanks,true)
		end
	elseif source == btnExitRanks then
		guiSetVisible(winRanks,false)
		if not(guiGetVisible(medicPanelWindow)) and not(guiGetVisible(winStats)) then
			showCursor(false)
		end
	elseif source == btnExitStats then
		guiSetVisible(winStats,false)
		if not(guiGetVisible(medicPanelWindow)) and not(guiGetVisible(winRanks)) then
			showCursor(false)
		end
	elseif source == btnHelp then
		exports.DENdxmsg:createNewDxMessage("Please refer to F1 for help",255,255,0)
	end
end)

function showMedicPanel ()
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) and (getTeamName(getPlayerTeam(localPlayer)) == jobTeam) and getElementData(localPlayer,"Occupation") == jobName then
		if guiGetVisible(medicPanelWindow) then
			guiSetVisible(medicPanelWindow, false)
			guiSetVisible(winStats,false)
			guiSetVisible(winRanks,false)
			showCursor(false,false)
		else
			updateStatsAndRanks(false)
			guiSetVisible(medicPanelWindow,true)
			showCursor(true,true)
		end
	end
end
--bindKey ( "F5", "down", showMedicPanel )
addCommandHandler("ij",showMedicPanel)


addEvent( "onClientPlayerTeamChange" )
addEventHandler ( "onClientPlayerTeamChange", root,
function ()
	if ( source == localPlayer ) then
		--onRemoveAllBlips ()
	end
end
)

local databaseStats = {}
function updateStatsAndRanks()
	updateStatsMenu()
	updateRanksMenu()
end

addEvent( "onPlayerRankChange" )
addEventHandler( "onPlayerRankChange", root,
	function ( oldRank, newRank )
		updateStatsAndRanks(false)
	end
)

local attemped = false
function CSGironRecData()
	t = exports.DENstats:getPlayerAccountData(localPlayer,statName)
	t = fromJSON(t)
	if t == nil then
		if attemped == false then
			setTimer(function() CSGironRecData() end,4000,1)
			attemped=true
			return
		end
		t = {}
		for i=1,#nameToI do t[i]=0 end
		databaseStats=t
		triggerServerEvent("CSGiron.setDefault",localPlayer)
	end
	databaseStats=t
	for i=1,#nameToI do
		t[i]=0
		if (databaseStats[i]) == nil then databaseStats[i]=0 end
	end
end
addEvent("CSGironRecData",true)
addEventHandler("CSGironRecData",localPlayer,CSGironRecData)



function addStat(k,v)
	databaseStats[tostring(nameToI[k])] = databaseStats[tostring(nameToI[k])]+v
	updateStatsMenu()
	triggerServerEvent("CSGironSetStat",localPlayer,toJSON(databaseStats),mPoints)
end
addEvent("CSGironAddStat",true)
addEventHandler("CSGironAddStat",localPlayer,addStat)

function updateStatsMenu()
	guiGridListClear(listStats)
	--[[stats = {
		["Times deposited rocks"] = {databaseStats[tostring(nameToI["Healed Health"])],0,0},
		["Money earned in total"] = {databaseStats[tostring(nameToI["Score earned from healing"])],3,0},
		["Death on Job"] = {databaseStats[tostring(nameToI["Death on Job"])],0,0},
		["Unique person heals"] = {databaseStats[tostring(nameToI["Unique person heals"])],0,0},
		["Poor person healing incidents"] = {databaseStats[tostring(nameToI["Poor person healing incidents"])],0,0},
		["Money earned from healing"] = {databaseStats[tostring(nameToI["Money earned from healing"])],0,0},
		["Money earned from daily pay"] = {databaseStats[tostring(nameToI["Money earned from daily pay"])],0,0},
	}--]]
	stats = {}
	for k,v in pairs(nameToI) do
		local num = 0
		if (rankValue[k]) then num = rankValue[k] end
		stats[k] = {databaseStats[v] or 0,num,0}
	end

	totalRankPoints = 0
	totalPoints = 0
	for k,v in pairs(stats) do
		if v[1] == nil then
			outputDebugString(k.." 1 is nil")
		end
		local ptsToAdd = (tonumber(v[1])*tonumber(v[2]))
		totalRankPoints=totalRankPoints+ptsToAdd
		stats[k][3] = ptsToAdd
		totalPoints=totalPoints+tonumber(v[1])
		local row = guiGridListAddRow(listStats)
		guiGridListSetItemText(listStats, row, 1, ""..tostring(k).."", false, false )
		guiGridListSetItemText(listStats, row, 2, ""..stats[k][1].."", false, false )
		guiGridListSetItemText(listStats, row, 3, ""..stats[k][2].."", false, false )
		guiGridListSetItemText(listStats, row, 4, ""..stats[k][3].."", false, false )
		if v[2] > 0 then
			for i=1,4 do
				guiGridListSetItemColor(listStats,row,i,0,255,0)
			end
		end
	end
	--guiSetText(gui["lblTotalPoints"],"Total Points: "..totalPoints.."")
	guiSetText(lblTotalRankPoints,"Total Rank Points: "..totalRankPoints.."")
end

local first = true

function updateRanksMenu()
	guiGridListClear(listRanks)
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
	guiSetText(lblRank,"Rank: "..currentRank.."")
	for k,v in pairs(ranks) do
		local row = guiGridListAddRow(listRanks)
		guiGridListSetItemText(listRanks, row, 1, tostring(v[1]), false, false )
		guiGridListSetItemText(listRanks, row, 2, tostring(v[2]), false, false )
		guiGridListSetItemText(listRanks, row, 3, tostring(v[3]), false, false )
		guiGridListSetItemText(listRanks, row, 4, tostring(v[4]), false, false )
		if v[1] == currentRank then
			for i=1,4 do
				guiGridListSetItemColor(listRanks,row,i,0,255,0)
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

