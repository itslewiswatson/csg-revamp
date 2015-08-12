

local gui = {}
GUIEditor = {
    tab = {},
    button = {},
    memo = {},
    window = {},
    gridlist = {},
    checkbox = {},
    label = {},
    tabpanel = {},
}
window = guiCreateWindow(371, 207, 539, 355, "Community of Social Gaming ~ Health Inspector", false)
guiWindowSetSizable(window, false)

GUIEditor.button[1] = guiCreateButton(10, 322, 520, 23, "Close", false, window)
GUIEditor.tabpanel[1] = guiCreateTabPanel(10, 25, 520, 291, false, window)

GUIEditor.tab[1] = guiCreateTab("Stores", GUIEditor.tabpanel[1])

GUIEditor.gridlist[1] = guiCreateGridList(10, 10, 491, 227, false, GUIEditor.tab[1])
guiGridListAddColumn(GUIEditor.gridlist[1], "Store", 0.2)
guiGridListAddColumn(GUIEditor.gridlist[1], "Location", 0.4)
guiGridListAddColumn(GUIEditor.gridlist[1], "Needs Inspection", 0.1)
guiGridListAddColumn(GUIEditor.gridlist[1], "Distance", 0.2)
GUIEditor.button[2] = guiCreateButton(10, 240, 101, 23, "Mark All", false, GUIEditor.tab[1])
GUIEditor.button[3] = guiCreateButton(140, 240, 101, 23, "Unmark All", false, GUIEditor.tab[1])
GUIEditor.button[4] = guiCreateButton(270, 240, 101, 23, "Mark", false, GUIEditor.tab[1])
GUIEditor.button[5] = guiCreateButton(400, 240, 101, 23, "Unmark", false, GUIEditor.tab[1])

GUIEditor.tab[2] = guiCreateTab("Tools", GUIEditor.tabpanel[1])

GUIEditor.label[1] = guiCreateLabel(9, 16, 198, 24, "Injure Self", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[1], 83, 255, 0)
GUIEditor.button[6] = guiCreateButton(80, 14, 79, 21, "Damage", false, GUIEditor.tab[2])
GUIEditor.label[2] = guiCreateLabel(9, 40, 501, 24, "--------------------------------------------------------------------------------------------------------------------------", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[2], 83, 255, 0)
GUIEditor.label[3] = guiCreateLabel(9, 67, 35, 24, "Store:", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[3], 83, 255, 0)
GUIEditor.label[4] = guiCreateLabel(46, 67, 465, 24, "storename", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[4], 254, 0, 0)
GUIEditor.label[5] = guiCreateLabel(9, 94, 92, 24, "Last Inspected:", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[5], 83, 255, 0)
GUIEditor.label[6] = guiCreateLabel(103, 94, 410, 24, "last inspec", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[6], 254, 0, 0)
GUIEditor.checkbox[1] = guiCreateCheckBox(101, 131, 146, 22, "Amazing Food Quality", false, false, GUIEditor.tab[2])
GUIEditor.checkbox[2] = guiCreateCheckBox(242, 131, 146, 22, "Good Food Quality", true, false, GUIEditor.tab[2])
GUIEditor.checkbox[3] = guiCreateCheckBox(371, 131, 146, 22, "Disturbing Food Quality", false, false, GUIEditor.tab[2])
GUIEditor.label[7] = guiCreateLabel(9, 134, 92, 24, "Food Quality", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[7], 83, 255, 0)
GUIEditor.label[8] = guiCreateLabel(9, 113, 501, 24, "--------------------------------------------------------------------------------------------------------------------------", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[8], 83, 255, 0)
GUIEditor.label[9] = guiCreateLabel(9, 158, 92, 24, "Cleanliness", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[9], 83, 255, 0)
GUIEditor.checkbox[4] = guiCreateCheckBox(101, 156, 146, 22, "Very Clean", false, false, GUIEditor.tab[2])
GUIEditor.checkbox[5] = guiCreateCheckBox(242, 156, 146, 22, "Some-what Clean", true, false, GUIEditor.tab[2])
GUIEditor.checkbox[6] = guiCreateCheckBox(371, 156, 146, 22, "Unclean - Bad Odour", false, false, GUIEditor.tab[2])
GUIEditor.label[10] = guiCreateLabel(9, 183, 92, 24, "Safety", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[10], 83, 255, 0)
GUIEditor.checkbox[7] = guiCreateCheckBox(101, 179, 146, 22, "Very Safe", true, false, GUIEditor.tab[2])
GUIEditor.checkbox[8] = guiCreateCheckBox(242, 179, 146, 22, "Some-what Safe", false, false, GUIEditor.tab[2])
GUIEditor.checkbox[9] = guiCreateCheckBox(371, 179, 146, 22, "Dangerous", true, false, GUIEditor.tab[2])
GUIEditor.label[11] = guiCreateLabel(10, 207, 143, 24, "Rate the store out of 30:", false, GUIEditor.tab[2])
guiLabelSetColor(GUIEditor.label[11], 83, 255, 0)
edit = guiCreateEdit(153, 201, 69, 26, "rating", false, GUIEditor.tab[2])
button = guiCreateButton(9, 230, 505, 26, "Submit Report", false, GUIEditor.tab[2])

gui["tab_3"] = guiCreateTab("Stats", GUIEditor.tabpanel[1])

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

gui["tab_5"] = guiCreateTab("Ranks", GUIEditor.tabpanel[1])

	gui["listRanks"] = guiCreateGridList(10, 10, 491, 221, false, gui["tab_5"])
	guiGridListSetSortingEnabled(gui["listRanks"], false)
	gui["listRanks_col0"] = guiGridListAddColumn(gui["listRanks"], "Rank", 0.403666)
	gui["listRanks_col1"] = guiGridListAddColumn(gui["listRanks"], "Points Needed", 0.133666)
	gui["listRanks_col2"] = guiGridListAddColumn(gui["listRanks"], "Net Value", 0.103666)
	gui["listRanks_col3"] = guiGridListAddColumn(gui["listRanks"], "Benifits", 0.303666)

	gui["lblCurrentRank"] = guiCreateLabel(10, 240, 231, 16, "Current Rank:", false, gui["tab_5"])
	guiLabelSetHorizontalAlign(gui["lblCurrentRank"], "left", false)
	guiLabelSetVerticalAlign(gui["lblCurrentRank"], "center")


	GUIEditor.tab[5] = guiCreateTab("Documentation", GUIEditor.tabpanel[1])

	GUIEditor.memo[1] = guiCreateMemo(10, 10, 501, 251, "Health Inspector Information Memo\n\nYour Task: Fish and sell for profit\n\nHow: 1st and foremost you need a fishing permit. If you don't have one you will get wanted stars for illegally fishing. You can ethier buy a permit, or you can get the Fisherman Job at the local harbor. Benifits of the Fisherman Job include Ranks and  free permit for as long as your a Fisherman. After your done that, you need a fishing boat. Boats that will work for fishing include:\n	- Reefer\nOnce you have one of these boats, get in the driver seat and Press 1 to toggle fishing on and off, and Press 2 to \"fish\" when you are notified to. Use your panel to eat,sell,drop,release fish.\n\nTo sell fish, go to the Fisherman harbor OR any local 24/7 shop. Once you near a Fisherman hut, OR, inside a shop, simply open your panel and select a fish, and press sell.\n\nRecords: Each fish has specific records (its size). If you beat it, you will get a small reward for doing so. Records reset after an X amount of that fish has been caught.\n\nYou can ONLY carry 12 fish at a time, so choose which ones you want to keep wisely.\nYou can be eaten by jaws, attacked by sea monsters, find out.\nThere are tons of fish and other things to catch!\n        \nRanks: In your panel you have available to you a stats list. Each stat point has a rank value and your total rank\n            Value will determine your rank. Refer to rank menu to find the list of ranks and benifits.\n            * Ranks will only work IF you have the Fisherman job.\n            * Fish Permit = # of fish you can fish without getting wanted. \n             * ONLY fish that you caught while under Fisherman job will be applied rank bonus! ", false, GUIEditor.tab[5])
	guiSetVisible(window,false)

local rankI = {}
local ranks = {
	{"H-Inspector in Training",0,0,"Base Salary"},
	{"Trained Health Inspector",15,0,"Base Salary"},
	{"Trusted Health Inspector",200,0,"Base Salary"},
	{"Comissionary Health Inspector",1000,0,"Base Salary + 2% More"},
	{"Secretary Health Inspector",1500,0,"Base Salary + 5% More"},
	{"Principal Health Inspector",2000,0,"Base Salary + 10% More"},
	--{"Commander of the FFS",3000,0,"Base Salary + 15% More"},
	--{"Commander of the FFS II",5000,0,"Base Salary + 20% More"},
	{"Head Health Inspector",6500,0,"Base Salary + 30% More"},
	{"CSG Health Services CEO",11000,0,"Base Salary + 40% More"}
}

function tog()
	guiSetVisible(window,not guiGetVisible(window))
	if guiGetVisible(window) then updateStatsMenu() updateRanksMenu() showCursor(true) else showCursor(false) end
end
addCommandHandler("viewhgui",tog)

databaseStats={}
function recData(t)
	if t == nil then t = {{},{0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0}} end
	databaseStats = t[2]
end
recData()

local nameToI = {
	["# of Stores reported"] = 1,
	["# of reports w/ accuracy 0-50"] = 2,
	["# of reports w/ accuracy 51-60"] = 3,
	["# of reports w/ accuracy 61-70"] = 4,
	["# of reports w/ accuracy 71-80"] = 5,
	["# of reports w/ accuracy 81-90"] = 6,
	["# of reports w/ accuracy 91-100"] = 7,
	["Average accuracy"] = 8,
	["$ Money earned"] = 9,
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
		  {"# of Stores reported",databaseStats[nameToI["# of Stores reported"]],0,0},
		 {"# of reports w/ accuracy 0-50",databaseStats[nameToI["# of reports w/ accuracy 0-50"]],0,0},
		 {"# of reports w/ accuracy 51-60",databaseStats[nameToI["# of reports w/ accuracy 51-60"]],1,0},
		 {"# of reports w/ accuracy 61-70",databaseStats[nameToI["# of reports w/ accuracy 61-70"]],2,0},
		 {"# of reports w/ accuracy 71-80",databaseStats[nameToI["# of reports w/ accuracy 71-80"]],3,0},
		 {"# of reports w/ accuracy 81-90",databaseStats[nameToI["# of reports w/ accuracy 81-90"]],4,0},
		  {"# of reports w/ accuracy 91-100",databaseStats[nameToI["# of reports w/ accuracy 91-100"]],5,0},
		  {"Average accuracy",databaseStats[nameToI["Average accuracy"]],0,0},
		 {"$ Money earned",databaseStats[nameToI["$ Money earned"]],0,0,},

	}
	totalRankPoints = 0
	totalPoints = 0
	for k,v in pairs(stats) do

		local ptsToAdd = (tonumber(v[2])*tonumber(v[3]))
		totalRankPoints=totalRankPoints+ptsToAdd
		stats[k][4] = ptsToAdd
		totalPoints=totalPoints+tonumber(v[2])
		local row = guiGridListAddRow(gui["listStats"])
		guiGridListSetItemText(gui["listStats"], row, 1, ""..stats[k][1].."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 2, ""..stats[k][2].."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 3, ""..stats[k][3].."", false, false )
		guiGridListSetItemText(gui["listStats"], row, 4, ""..stats[k][4].."", false, false )
		if v[3] > 0 then
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

