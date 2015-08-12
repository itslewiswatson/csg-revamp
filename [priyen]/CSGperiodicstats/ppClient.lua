GUIEditor = {
    gridlist = {},
    label = {},
    scrollpane = {},
    window = {},
}
GUIEditor.window[1] = guiCreateWindow(912, 242, 282, 276, "CSG Statistics", false)
guiWindowSetSizable(GUIEditor.window[1], false)

GUIEditor.scrollpane[1] = guiCreateScrollPane(10, 60, 263, 201, false, GUIEditor.window[1])

grid = guiCreateGridList(1, 5, 240, 534, false, GUIEditor.scrollpane[1])

GUIEditor.label[1] = guiCreateLabel(10, 22, 263, 32, "Below are the today's game day statistics! Collected over the past 24 hour game period.", false, GUIEditor.window[1])
guiLabelSetHorizontalAlign(GUIEditor.label[1], "left", true)
guiGridListAddColumn(grid, "Name", 0.6)
guiGridListAddColumn(grid, "Value", 0.3)
guiSetVisible(GUIEditor.window[1] ,false)

guiScrollPaneSetVerticalScrollPosition(GUIEditor.scrollpane[1],0)
function scroll()
	local pos = guiScrollPaneGetVerticalScrollPosition(GUIEditor.scrollpane[1])
	pos=math.floor(pos+0.5)
	guiScrollPaneSetVerticalScrollPosition(GUIEditor.scrollpane[1],pos+1)
	outputDebugString(pos)
end



function recUpdatedData(theTable)
	guiGridListClear(grid)
	for cat,v in pairs(theTable) do
		for k,v2 in pairs(v) do
			if k == 1 then
			local catRow = guiGridListAddRow( grid )
			guiGridListSetItemText( grid, catRow, 1, v[1], true, false )
			else
			local theRow = guiGridListAddRow( grid )
				guiGridListSetItemText( grid, theRow, 1, ""..v2[1].."", false, false)
				guiGridListSetItemText( grid, theRow, 2, ""..v2[2].."", false, false)
			end
		end
	end
	setTimer(scroll,300,100)
	guiScrollPaneSetVerticalScrollPosition(GUIEditor.scrollpane[1],0)
end
local t = {
	{"Overall",
		{"Score Earned","Priyen"},
		{"Score Lost","Priyen"},
		{"Bullets Fired","Priyen"},
		{"Average Per Minute","Priyen"},
		{"Ammunation Sales ($)","Priyen"},
		{"Deaths","Priyen"},
		{"Money Gained","Priyen"},
		{"Money Transferred","Priyen"},
		{"Hours Accumulated","Priyen"},
		{"Jail Time Served","Priyen"},
		{"Wanted Points Earned","Priyen"},
		{"Hits of Drugs Taken","Priyen"},
		{"# of Store Robberies","Priyen"},
		{"# of Failed Store Robberies","Priyen"},
		{"# of Successfull Store Robberies","Priyen"},
		{"# of Player Robberies","Priyen"},
		{"# of Failed Player Robberies","Priyen"},
		{"# of Successfull Player Robberies","Priyen"},
		{"$ lost due to Robberies","Priyen"},
		{"$ gained from Store Robberies","Priyen"},
		{"Attempted Bank Robberies","Priyen"},
		{"Successfull Bank Robberies","Priyen"},
		{"# of crimes committed","Priyen"},
		{"$ Taxed Overall","Priyen"},
		{"Attempted Armored Deliveries","Priyen"},
		{"Successfull Armored Deliveries","Priyen"},
	},
	{"Law",
		{"Arrests","Priyen"},
		{"Jails","Priyen"},
		{"Assists","Priyen"},
		{"Bribes Accepted","Priyen"},
		{"$ from Bribes","Priyen"},
		{"Deaths","Priyen"},
		{"Bullets Fired","Priyen"},
		{"# of Crime Reports","Priyen"},
		{"Attempted Patrol Missions","Priyen"},
		{"Successfull Patrol Missions","Priyen"},
		{"Total # of Patrol Calls","Priyen"},
	},
	{"Civilians",
		{"Deaths","Priyen"},
		{"Money Gained","Priyen"},
		{"Bus Driver Routes Completed","Priyen"},
		{"# of Fish Caught","Priyen"},
		{"$ of Fish Caught","Priyen"},
		{"# of Fires put out","Priyen"},
		{"# of Truck Deliveries","Priyen"},
		{"# of flights Completed","Priyen"},
	},
	{"Criminals",
		{"Deaths","Priyen"},
		{"Turfs Taken","Priyen"},
		{"Deaths in LV","Priyen"},
		{"Wanted Points evaded","Priyen"},
		{"Bullets Fired","Priyen"},
	}
}
--recUpdatedData(t)
