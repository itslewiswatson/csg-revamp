local skinShops = {
-- LS shops
{207.58, -101.21, 1005.25, 15, 5, 2.3263854980469},
{204.23, -160.03, 1000.52, 14, 12, 0.53009033203125},
{161.38, -84.08, 1001.8, 18, 1, 1.8814392089844},
{207.11, -129.94, 1003.5, 3, 13, 1.8814392089844},
-- SF shops
{204.01, -43.9, 1001.8, 1, 1, 2.8921813964844},
{207.9, -101.35, 1005.25, 15, 6, 357.28359985352},
{161.38, -84, 1001.8, 18, 2, 356.77270507812},
{207.33, -10.34, 1001.21, 5, 10, 356.77270507812},
-- LV shops
{207.83, -100.99, 1005.25, 15, 7, 1.3266296386719},
{161.51, -84.46, 1001.8, 18, 3, 1.1069030761719},
{207.64, -100.76, 1005.25, 15, 8, 3.4195556640625},
{161.35, -84.88, 1001.8, 18, 4, 1.1069030761719},
{203.96, -44.04, 1001.8, 1, 2, 2.4195556640625}
}

local premiumSkins = {}
local skinShopsMarkers = {}
local skinShopGUI = {}
local oldSkin

function onResourceStart()
	createSkinShopGUI()
	for i=1,#skinShops do
		local x,y,z,int,dimension = unpack(skinShops[i])
		local marker = createMarker(x,y,z-1,"cylinder",2,200,0,0,150)
		setElementInterior(marker, int)
		setElementDimension(marker, dimension)
		addEventHandler("onClientMarkerHit",marker,onSkinShopMarkerHit)
	end
end
addEventHandler("onClientResourceStart",resourceRoot,onResourceStart)

function onResourceStop()
	if oldSkin then
		setElementModel ( localPlayer, tonumber(oldSkin) )	
	end
end
addEventHandler("onClientResourceStop",resourceRoot,onResourceStop)

function onSkinShopMarkerHit(hitElement,matchingDimensions)
	if hitElement ~= localPlayer or not matchingDimensions then return false end
	local _,_,pz = getElementPosition(localPlayer)
	local _,_,mz = getElementPosition(source)
	if math.abs(pz-mz) < 2.5 then
		oldSkin = getElementModel(localPlayer)
		guiSetVisible(skinShopGUI.window,true)
		showCursor(true)
		guiSetEnabled(skinShopGUI.premiumSkins,exports.server:isPlayerPremium(localPlayer))
		
		local sX,sY = guiGetScreenSize()
		local wWidth,wHeight = guiGetSize(skinShopGUI.window,false)
		guiSetPosition(skinShopGUI.window,sX-wWidth,sY-wHeight,false)
	end
end

function closeSkinShopGUI(keepSkin)
	guiSetVisible(skinShopGUI.window, false) 
	showCursor(false)
	if not keepSkin then
		setElementModel ( localPlayer, tonumber(oldSkin) )
	end
	oldSkin = false
end

function createSkinShopGUI()
	skinShopGUI.window = guiCreateWindow(337,88,289,518,"CSG ~ Clothes Store",false)
	skinShopGUI.grid = guiCreateGridList(9,24,271,423,false,skinShopGUI.window)
		guiGridListSetSelectionMode(skinShopGUI.grid,0)
		guiGridListAddColumn( skinShopGUI.grid, "Skin Name:", 0.69 )
		guiGridListAddColumn( skinShopGUI.grid, "ID:", 0.2 )
	skinShopGUI.premiumSkins = guiCreateLabel(9,452,271,23,"Premium skins are marked orange",false,skinShopGUI.window)
		guiLabelSetVerticalAlign(skinShopGUI.premiumSkins,"center")
		guiLabelSetHorizontalAlign(skinShopGUI.premiumSkins,"center")
		guiLabelSetColor(skinShopGUI.premiumSkins,255,125,0)
	skinShopGUI.buySkin = guiCreateButton(9,486,133,29,"Buy skin ($250)",false,skinShopGUI.window)
	skinShopGUI.closeGUI = guiCreateButton(146,486,134,29,"Close",false,skinShopGUI.window)
	addEventHandler ( "onClientGUIClick", skinShopGUI.closeGUI, function () closeSkinShopGUI() end, false)
	addEventHandler ( "onClientGUIClick", skinShopGUI.grid, onSkinGridClick, false )
	addEventHandler ( "onClientGUIClick", skinShopGUI.buySkin, onBuySkin, false )
	
	for skinID,skinDesc in pairs(skinPremiumDB) do
		local row = guiGridListAddRow(skinShopGUI.grid)
		guiGridListSetItemText(skinShopGUI.grid,row,1,tostring(skinDesc),false,false)
		guiGridListSetItemText(skinShopGUI.grid,row,2,tostring(skinID),false,true)
		guiGridListSetItemColor(skinShopGUI.grid,row,1,255,125,0)
		guiGridListSetItemColor(skinShopGUI.grid,row,2,255,125,0)
		premiumSkins[skinID] = true
	end	
	for skinID,skinDesc in pairs(skinDB) do
		if not disabledSkins[skinID] then
			local row = guiGridListAddRow(skinShopGUI.grid)
			guiGridListSetItemText(skinShopGUI.grid,row,1,tostring(skinDesc),false,false)
			guiGridListSetItemText(skinShopGUI.grid,row,2,tostring(skinID),false,true)
		end
	end
	guiSetVisible(skinShopGUI.window,false)
end

local selectedSkinID
local transactionInProgress

function onSkinGridClick()
	local selRow,_ = guiGridListGetSelectedItem(skinShopGUI.grid)
	if selRow and selRow ~= -1 then
		local skin = tonumber(guiGridListGetItemText(skinShopGUI.grid,selRow,2))
		if ( not premiumSkins[skin] ) or exports.server:isPlayerPremium(localPlayer) then
			setElementModel(localPlayer,skin)
			selectedSkinID = skin
		else
			selectedSkinID = false
			exports.dendxmsg:createNewDxMessage("This is a premium skin, please donate to use this skin.",255,170,0)
		end
	else
		selectedSkinID = false
	end
end

function onBuySkin()
	if selectedSkinID and not transactionInProgress then -- prevent double buying etc
		transactionInProgress = true
		triggerServerEvent("skinShop:buySkin",localPlayer,selectedSkinID,premiumSkins[skin])
	else
		exports.dendxmsg:createNewDxMessage("Select a skin first!",255,0,0)
	end
end

addEvent("skinShop:buySkin:callBack",true)
function onBuySkinCallback(closeGUI,resetSkin)
	transactionInProgress = false
	if closeGUI then
		closeSkinShopGUI(not resetSkin)
	elseif oldSkin and resetSkin then
		setElementModel(localPlayer,oldSkin)
	end
end
addEventHandler("skinShop:buySkin:callBack",root,onBuySkinCallback)
