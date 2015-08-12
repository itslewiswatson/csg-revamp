-- Tables
local theCategories = { [0]="Shirt", [1]="Haircuts", [2]="Trousers", [3]="Shoes", [4]="Tattoos: Left Upper Arm", [5]="Tattoos: Left Lower Arm", [6]="Tattoos: Right Upper Arm", [7]="Tattoos: Right Lower Arm", [8]="Tattoos: Back", [9]="Tattoos: Left Chest", [10]="Tattoos: Right Chest", [11]="Tattoos: Stomach", [12]="Tattoos: Lower Back", [13]="Necklaces", [14]="Watches", [15]="Glasses", [16]="Hats", [17]="Extras" }

local theMarkers = {
{ 217.43, -99.17, 1005.25, 15, 5 },
{ 199.03, -128.57, 1003.51, 3, 13 },
{ 215.37, -155.77, 1000.52, 14, 12 },
{ 210.3, -8.03, 1005.21, 5, 9 },
{ 214.51, -40.93, 1002.02, 1, 1 },
{ 217.48, -98.81, 1005.25, 15, 6 },
{ 210.84, -8.74, 1005.21, 5, 10 },
{ 181.22, -88.35, 1002.03, 18, 2 },
{ 217.19, -99.32, 1005.25, 15, 7 },
{ 217.44, -99.42, 1005.25, 15, 8 },
{ 181.45, -88.64, 1002.03, 18, 4 },
{ 181.33, -88.68, 1002.03, 18, 3 },
{ 214.11, -41.76, 1002.02, 1, 2 },
{ 210.57, -8.96, 1005.21, 5, 11 },
{ 198.98, -128.71, 1003.51, 3, 14 },
{ 180.62, -88.14, 1002.02, 18, 1 }
}

local x, y, z, int, dim = nil, nil, nil, nil, nil
local pricesModel = {}
local previousModel = nil

-- GUI Window
CJClothesWindow = guiCreateWindow(509,153,444,480,"CSG ~ CJ Clothes",false)
CJClothesLabel1 = guiCreateLabel(12,22,203,16,"Categories:",false,CJClothesWindow)
guiLabelSetHorizontalAlign(CJClothesLabel1,"center",false)
guiSetFont(CJClothesLabel1,"default-bold-small")
CJClothesCatoGrid = guiCreateGridList(9,41,214,320,false,CJClothesWindow)
guiGridListSetSelectionMode(CJClothesCatoGrid,0)
CJClothesItemGrid = guiCreateGridList(225,40,210,321,false,CJClothesWindow)
guiGridListSetSelectionMode(CJClothesItemGrid,0)
CJClothesLabel2 = guiCreateLabel(230,22,203,16,"Items:",false,CJClothesWindow)
guiLabelSetHorizontalAlign(CJClothesLabel2,"center",false)
guiSetFont(CJClothesLabel2,"default-bold-small")
CJClothesLabel3 = guiCreateLabel(9,400,422,46,"Select a categorie and doubleclick a item to change the clothes of your ped.\nIf you like the new skin press save, otherwise click don't save to return.\nThis skin will be saved and set whenever you use the CJ skin.",false,CJClothesWindow)
guiLabelSetHorizontalAlign(CJClothesLabel3,"center",false)
CJClothesLabel4 = guiCreateLabel(15,452,414,20,"Total price: $0",false,CJClothesWindow)
guiLabelSetColor(CJClothesLabel4,48,128,20)
guiLabelSetHorizontalAlign(CJClothesLabel4,"center",false)
guiSetFont(CJClothesLabel4,"default-bold-small")
CJClothesBuyButton = guiCreateButton(225,364,210,30,"Close and save skin",false,CJClothesWindow)
CJClothesCancelButton = guiCreateButton(11,364,211,30,"Close and don't save skin",false,CJClothesWindow)

local column1 = guiGridListAddColumn( CJClothesCatoGrid, "  Categorie:", 0.8 )
local column2 = guiGridListAddColumn( CJClothesItemGrid, "  Name:", 0.6 )
local column3 = guiGridListAddColumn( CJClothesItemGrid, "  Price:", 0.3 )

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(CJClothesWindow,false)
local x,y = (screenW-windowW)/1,(screenH-windowH)/1
guiSetPosition(CJClothesWindow,x,y,false)

guiWindowSetMovable (CJClothesWindow, true)
guiWindowSetSizable (CJClothesWindow, false)
guiSetVisible (CJClothesWindow, false)

for i=0,17 do
	local categorie = theCategories[i]
	local row = guiGridListAddRow ( CJClothesCatoGrid )
	guiGridListSetItemText ( CJClothesCatoGrid, row, 1, categorie, false, true )
	guiGridListSetItemData ( CJClothesCatoGrid, row, 1, i )
end

function createClothesJSONString ( returnType )
	local clothesTable = {}
	local smtn = false
	for i=0,17 do
		local texture, model = getPedClothes ( localPlayer, i )
		if ( texture ) then
			local theType, theIndex = getTypeIndexFromClothes ( texture, model )
			clothesTable[theType] = theIndex
			smtn = true
		end
	end
	if ( smtn ) then
		if ( returnType == "JSON" ) then
			return "" .. toJSON( clothesTable ):gsub( " ", "" ) .. ""
		else
			return clothesTable
		end
	else
		return "NULL"
	end
end 

function updatePlayerCJSkin ( CJClothesTable )
	if ( CJClothesTable ) then
		for int, index in pairs( CJClothesTable ) do
			local texture, model = getClothesByTypeIndex ( int, index )
			if ( texture ) then
				addPedClothes ( source, texture, model, int )
			end
		end
	end
	triggerServerEvent( "onChangeClothesCJ", localPlayer, CJClothesTable, createClothesJSONString ( "JSON" ) )
end

function onClientCJMarkerHit ( hitElement, matchingDimension )
	if ( matchingDimension ) then
		if ( hitElement == localPlayer ) then
			if ( getElementModel ( localPlayer ) == 0 ) then
				if ( getElementData( localPlayer, "wantedPoints" ) < 10 ) then
					fadeCamera( false, 1.0, 0, 0, 0 )
					setTimer( fadeCamera, 2000, 1, true, 1.0, 0, 0, 0 )
					
					toggleAllControls ( false, true, false )
					
					local px, py, pz = getElementPosition( localPlayer )
					x, y, z, int, dim = px, py, pz, getElementInterior( localPlayer ), getElementDimension( localPlayer )
					
					pricesModel = {}
					previousModel = createClothesJSONString ( "table" )
					
					setTimer( function ()		
					
						if ( getElementInterior( localPlayer ) ~= 1 ) then
							setElementInterior( localPlayer, 1, 209.78, -33.73, 1001.92 )
						else
							setElementPosition( localPlayer, 209.78, -33.73, 1001.92 )
						end
						
						setElementFrozen( localPlayer, true )
						
						setPedRotation( localPlayer, 135.98809814453 )
						setElementDimension( localPlayer, math.random( 10,6543 ) )
						setCameraMatrix( 206.42649841309, -37.311698913574, 1002.7904052734, 207.10893249512, -36.584545135498, 1002.716003418, 0, 70 )
						
						setTimer( function ()
							guiSetVisible ( CJClothesWindow, true )
							showCursor( true )
						end, 1000, 1 )
					end, 1200, 1 )
				else
					exports.DENdxmsg:createNewDxMessage( "Due absue you can only set CJ clothes when not wanted!", 225, 0, 0 )
				end
			else
				exports.DENdxmsg:createNewDxMessage( "You need the CJ skin before you can set clothes", 225, 0, 0 )
			end
		end
	end
end

function recountTotalPrice ()
	local totalPrice = 0
	for i=0,17 do
		if ( pricesModel[i] == nil ) then
			-- Nothing
		else
			totalPrice = ( tonumber(totalPrice) + tonumber(pricesModel[i]) )
		end
	end	
	guiSetText( CJClothesLabel4, "Total price: $"..totalPrice )
	return totalPrice
end

for i=1,#theMarkers do
	local x, y, z, int, dim = theMarkers[i][1], theMarkers[i][2], theMarkers[i][3], theMarkers[i][4], theMarkers[i][5]
	local CJMarker = createMarker( x, y, z -1, "cylinder", 2.0, 225, 0, 0, 150)
	setElementInterior( CJMarker, int )
	setElementDimension( CJMarker, dim )
	addEventHandler( "onClientMarkerHit", CJMarker, onClientCJMarkerHit )
end

addEventHandler( "onClientGUIClick", CJClothesCancelButton,
function ()				
	fadeCamera( false, 1.0, 0, 0, 0 )
	setTimer( fadeCamera, 2000, 1, true, 1.0, 0, 0, 0 )
	
	toggleAllControls ( true, true, true )
	
	guiSetVisible ( CJClothesWindow, false )
	showCursor( false )
	
	updatePlayerCJSkin ( previousModel )
	
	setElementFrozen( localPlayer, false )
	
	setTimer( function ()
		if ( getElementInterior( localPlayer ) ~= int ) then
			setElementInterior( localPlayer, int, x, y, z )
		else
			setElementPosition( localPlayer, x, y, z )
		end			
			
		setElementDimension( localPlayer, dim )
		setCameraTarget ( localPlayer )
	end, 1200, 1 )
end
, false )

addEventHandler( "onClientGUIClick", CJClothesBuyButton,
function ()	
	if ( getPlayerMoney( localPlayer ) >= tonumber( recountTotalPrice () ) ) then
		fadeCamera( false, 1.0, 0, 0, 0 )
		setTimer( fadeCamera, 2000, 1, true, 1.0, 0, 0, 0 )
		
		toggleAllControls ( true, true, true )
		
		guiSetVisible ( CJClothesWindow, false )
		showCursor( false )
		
		updatePlayerCJSkin ( createClothesJSONString ( "table" ) )
		triggerServerEvent( "onPlayerBougtSkin", localPlayer, recountTotalPrice () )
		
		setElementFrozen( localPlayer, false )
		
		setTimer( function ()
			if ( getElementInterior( localPlayer ) ~= int ) then
				setElementInterior( localPlayer, int, x, y, z )
			else
				setElementPosition( localPlayer, x, y, z )
			end			
				
			setElementDimension( localPlayer, dim )
			setCameraTarget ( localPlayer )
		end, 1200, 1 )
	else
		exports.DENdxmsg:createNewDxMessage( "You don't have enough money for all these items!", 225, 0, 0 )
	end
end
, false )

addEventHandler( "onClientGUIClick", CJClothesCatoGrid,
function ()
	guiGridListClear( CJClothesItemGrid )
	local theRow, theColumn = guiGridListGetSelectedItem ( CJClothesCatoGrid )
	if ( theRow == nil ) or ( theRow == -1 ) then
		return
	else
		local selectedCato = guiGridListGetItemData ( CJClothesCatoGrid, theRow, theColumn )
		if ( selectedCato ) then
			local theTable = getClothesTableByType ( selectedCato )
			for i=0,#theTable do
				local texture, model = getClothesByTypeIndex ( selectedCato, i )
				local row = guiGridListAddRow ( CJClothesItemGrid )
				guiGridListSetItemText ( CJClothesItemGrid, row, 1, texture.." - "..model, false, true )
				guiGridListSetItemText ( CJClothesItemGrid, row, 2, "$"..theTable[i], false, true )
				guiGridListSetItemData ( CJClothesItemGrid, row, 1, texture..","..model )
			end
		end
	end
end
, false )

addEventHandler( "onClientGUIDoubleClick", CJClothesItemGrid,
function ()
	local theRow, theColumn = guiGridListGetSelectedItem ( CJClothesItemGrid )
	if ( theRow == nil ) or ( theRow == -1 ) then
		return false
	else
		local selectedItem = guiGridListGetItemData ( CJClothesItemGrid, theRow, theColumn )
		local thePrice = guiGridListGetItemText ( CJClothesItemGrid, theRow, 2 )
		if ( selectedItem ) then
			local CJClothesTable = exports.server:stringExplode( selectedItem, "," )
			local texture, model = CJClothesTable[1], CJClothesTable[2]
			local theType, index = getTypeIndexFromClothes ( texture, model )
			local gtexture, gmodel = getPedClothes ( localPlayer, theType )
			if ( gtexture == texture ) and ( gmodel == model ) then
				removePedClothes ( localPlayer, theType, texture, model )
			else
				pricesModel[theType] = tonumber( string.sub(thePrice, 2) )
				recountTotalPrice ()
				addPedClothes ( localPlayer, texture, model, theType )
			end
		end
	end
end
, false )