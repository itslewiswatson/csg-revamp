
	local hRow = nil

    VipHats = guiCreateWindow( 700, 200, 280, 380, "CSG ~ VipHats", false );
    Button_Buy = guiCreateButton( 20, 348, 100, 28, "Apply", false, VipHats );
	Button_close = guiCreateButton( 150, 348, 100, 28, "Close", false, VipHats );
--	guiLabelSetHorizontalAlign(Button_label,"center")
--	guiLabelSetVerticalAlign(Button_label,"center")
	guiSetVisible(VipHats,false)
	showCursor(false)

    local aObjects =
    {

        { "Grass Hat", 861,scale=0.5},
        { "Grass Hat 2", 862,scale=0.5 },
        { "Pizza Box", 2814 },
        { "Roulete", 1895,scale=0.3 },
        { "Model Car", 2485 },
        { "Ventilator", 1661,scale=0.7 },
		{ "Green Flag", 2993 },
		{ "TV", 1518,scale=0.7},
		{ "Arrow", 1318,scale=0.5 },
	    { "Tree", 811,scale=0.3 },
		{ "Skull",1254},
		{"Dolphin",1607,scale=0.05},
		{"Parking Sign",1233,scale=0.3},
		--{ "WW1 hat", 2052 },
        { "WW2 hat", 2053 },
		{ "Captain 3", 2054 },
		{ "Donuts",  2222},
     	{ "Hoop",  1316, scale=0.1},
		{"Turtle",1609,scale=0.1},
		{"SAM",3267,scale=0.2},
		{"MG",2985,scale=0.5},
		{"Money",1274,scale=3},
		{"Para",3108,scale=0.1},
		{"Torch",3461,scale=0.5},

		{ "Remove hat" }

		};


    hGrid = guiCreateGridList( 5, 20, 270, 318, false, VipHats );
    guiGridListAddColumn( hGrid, "Hats", 0.85 );

    for i,m_obj in ipairs( aObjects ) do

			hRow = guiGridListAddRow( hGrid );
			--
			guiGridListSetItemText ( hGrid, hRow, 1, tostring( m_obj [ 1 ] ), false, false );
			if m_obj [ 2 ] then guiGridListSetItemData ( hGrid, hRow, 1, tostring( m_obj [ 2 ] ) ) end

    end

function Buy ( )
    local row, col = guiGridListGetSelectedItem ( hGrid )
    if ( row and col and row ~= -1 and col ~= -1 ) then
        local model = tonumber ( guiGridListGetItemData ( hGrid, row, 1 ) )
		local scale=1
		local name = ""
		for k,v in pairs(aObjects) do
			if v[2] == model then
				name=v[1]
				if v.scale ~= nil then scale=v.scale break end
			end
		end
		if model ~= nil then
			exports.dendxmsg:createNewDxMessage("You are now wearing the "..name.." hat",0,255,0)
		end
		triggerServerEvent("vipHats_changeHat",localPlayer,model,scale)

    end

end
addEventHandler ( "onClientGUIClick", Button_Buy, Buy, false )

function toggleHatGUI()
	local prem = getElementData(localPlayer,"Premium")
	--prem="Yes"
	if prem==false then prem="No" end
	if guiGetVisible(VipHats) then
		guiSetVisible(VipHats, false)
		showCursor(false)
	elseif prem=="Yes" then
		guiSetVisible(VipHats, true)
		showCursor(true)
	end
end
addCommandHandler("premhat",toggleHatGUI,false)

addEventHandler("onClientGUIClick", Button_close, toggleHatGUI,false)
