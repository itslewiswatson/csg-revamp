local data = {
	{["name"]="Four Dragons Casino",px=1953.76,py=1018.31,pz=992.46,pr=270,skin=171,int=10,dim=0,offx=0,offy=1.7,offz=-1},
	{["name"]="Four Dragons Casino2",px=1947.81,py=1018.16,pz=992.47,pr=93.65,skin=171,int=10,dim=0,offx=0,offy=1.7,offz=-1},

}
local markers = {}
local peds = {}
function circle(r,s,cx,cy)
	xVals = {}
	yVals = {}
	for i=1,s-1 do
		xVals[i] = (cx+r*math.cos(math.pi*i/s*2-math.pi/2))
		yVals[i] = (cy+r*math.sin(math.pi*i/s*2-math.pi/2))
	end
end
circle(10,200,10,10)
-----------------------------------------------------------------------
screenWidth, screenHeight = guiGetScreenSize()
local screenSource = dxCreateScreenSource(screenWidth, screenHeight)
local x,y = 0,0
local count = 1
size = #xVals
iRot = 0
rotX,rotY = screenWidth/2,screenHeight/2
rotInt = 0.06
setElementData(localPlayer,"bloodAlcoholLevel", "0")
bloodAlcoholLevel = 0
-----------------------------------------------------------------------



-- Shop Items
local items = {
	--name        price strength
	[1] = {"Champagne Glass",200,0.5},
	[2] = {"Red Wine Glass",50,0.2},
	[3] = {"Vodka Glass",100,0.8},
	[4] = {"Whiskey Glass",75,0.7},
	[5] = {"Champagne Bottle",1000,2.5},
	[6] = {"Red Wine Bottle",250,1.0},
	[7] = {"Vodka Bottle",1000,4.0},
	[8] = {"Whiskey Bottle",875,3.5},
}
function cancelDmg()
	cancelEvent()
end
function onStart()
	for k,v in pairs(data) do
		local ped = createPed(v.skin,v.px,v.py,v.pz,v.pr)
		setElementFrozen(ped,true)
		setElementDimension(ped,v.dim)
		setElementInterior(ped,v.int)
		table.insert(peds,ped)
		addEventHandler("onClientPedDamage",ped,cancelDmg)
		local marker = createMarker(v.px,v.py,v.pz,"cylinder",1,255,215,0)
		addEventHandler("onClientMarkerHit", marker, showGUI )
		addEventHandler("onClientMarkerLeave", marker, hideGUI )
		setElementDimension(marker,v.dim)
		setElementInterior(marker,v.int)
		attachElements(marker,ped,v.offx,v.offy,v.offz)
	end
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), onStart)


function showGUI (hitElement)
	if hitElement == localPlayer then
		if getElementInterior(localPlayer) ~= getElementInterior(source) then return end
		if casinoBar then
			showCursor(true)
			guiSetVisible(casinoBar, true)
		else
			local Width, Height = 300, 350
			local X = ( screenWidth/2 ) - ( Width/2 )
			local Y = ( screenHeight/2 ) - ( Height/2 )
			casinoBar = guiCreateWindow(X, Y, Width, Height, "CSG ~ Bar", false)
			guiWindowSetSizable(casinoBar, false)
			btnClose = guiCreateButton(160, 300, 120, 30, "Close", false, casinoBar)
				addEventHandler("onClientGUIClick", btnClose, closeGUI)
			btnBuy = guiCreateButton(20, 300, 120, 30, "Buy", false, casinoBar)
				addEventHandler("onClientGUIClick", btnBuy, drink)
			itemList = guiCreateGridList(10, 25, 280, 250, false, casinoBar)
			itemName = guiGridListAddColumn(itemList, "Drink:", 0.70)
			itemPrice = guiGridListAddColumn(itemList, "Price:", 0.20)
			for i, v in ipairs(items) do
				local row = guiGridListAddRow(itemList)
				guiGridListSetItemText(itemList, row, itemName, items[i][1], false, false)
				guiGridListSetItemText(itemList, row, itemPrice, items[i][2], false, true)

			end

			showCursor(true)

		end
	end
end
function closeGUI ()
	if source ~= btnClose then return end
		guiSetVisible(casinoBar, false)
		showCursor(false)

end
function hideGUI ( hitElement )
	if hitElement == localPlayer and casinoBar then
		guiSetVisible(casinoBar, false)
		showCursor(false)

	end
end



function drink()
	if source ~= btnBuy then return end
	id = guiGridListGetSelectedItem(itemList)

	amount = tonumber(guiGridListGetItemText(itemList, id, itemPrice))

	if getPlayerMoney() >= amount then triggerServerEvent("casino:buyDrink", localPlayer, amount)
	else
		exports.DENdxmsg:createNewDxMessage("You don't have that amount of money!", 255, 0, 0)
	return end

	local bloodAlcoholLevel = tonumber(getElementData(localPlayer,"bloodAlcoholLevel"))
	if id and id ~= -1 then
		local bloodAlcoholLevel = bloodAlcoholLevel + items[id+1][3]
		setElementData(localPlayer,"bloodAlcoholLevel", tostring(bloodAlcoholLevel))
		if bloodAlcoholLevel < 1 then return end

		if bloodAlcoholLevel >= 1 and bloodAlcoholLevel < 3 then
			if not blur then
				blur = guiCreateStaticImage(0, 0,screenWidth, screenHeight, "images/blur.png", false)
				guiMoveToBack(blur)
			end
		end

		if bloodAlcoholLevel >= 3 and bloodAlcoholLevel < 5  then
			if not blur then
				blur = guiCreateStaticImage(0, 0,screenWidth, screenHeight, "images/blur.png", false)
				guiMoveToBack(blur)
			end
			triggerServerEvent("CSGcasinoShopEffectChange",localPlayer,true)
		end

		if bloodAlcoholLevel >= 5 then if math.random(1,5) >= 3 then
			setElementData(localPlayer,"bloodAlcoholLevel", tostring(0))
			setElementHealth(localPlayer, 0)
		else
			if not blur then
				blur = guiCreateStaticImage(0, 0,screenWidth, screenHeight, "images/blur.png", false)
				guiMoveToBack(blur)
			end
			triggerServerEvent("CSGcasinoShopEffectChange",localPlayer,true)
		end
		end

	else exports.DENdxmsg:createNewDxMessage("You haven't selected any item!", 255, 0, 0)
	end
end

function decrease()
	local bloodAlcoholLevel = tonumber(getElementData(localPlayer,"bloodAlcoholLevel"))
	if bloodAlcoholLevel > 0 then
		if bloodAlcoholLevel-0.01 <= 0 then
			triggerServerEvent("CSGcasinoShopEffectChange",localPlayer,false)
			if isElement(blur) then destroyElement(blur) end
			blur = nil
		end
		local bloodAlcoholLevel = bloodAlcoholLevel - 0.01
		setElementData(localPlayer,"bloodAlcoholLevel", tostring(bloodAlcoholLevel))
	end
end
setTimer(decrease,1000,0)


---------------------------------------------------------------------------------------------------------


function doEffect()
	local bloodAlcoholLevel = tonumber(getElementData(localPlayer,"bloodAlcoholLevel"))
	if bloodAlcoholLevel > 0 then

		x,y = xVals[count],yVals[count]
		count=count+1
		if count > size then count = 1 end
		dxUpdateScreenSource(screenSource)
		dxDrawImage(x,y,screenWidth, screenHeight,screenSource)

		iRot=iRot+rotInt
		if iRot > 11.25 or iRot < 11.25 then rotInt=rotInt*-1 end
		dxUpdateScreenSource(screenSource)
		dxDrawImage(x,y,screenWidth, screenHeight,screenSource,iRot,rotX,rotY)
	end
end
addEventHandler("onClientRender",root,doEffect)

local controls = {
	"left","right"
}
function doEffect2()
	local bloodAlcoholLevel = tonumber(getElementData(localPlayer,"bloodAlcoholLevel"))
	if bloodAlcoholLevel > 0 then
		local chance = math.random(1,100)
		if chance > 25 then
			local tim = math.random(500,1000)
			local id = math.random (1,2)
			cont = controls[id]
			setControlState(cont,true)
			toggleControl(cont,false)
			setTimer(setControlState,tim,1,cont,false)
			setTimer(toggleControl,tim,1,cont,true)
		end
	end
end
setTimer(doEffect2,8000,0)

----------------------------------------------------------------------------------------------------------

function onDead ()
	setTimer(setElementData, 2000, 1,source,"bloodAlcoholLevel", "-1")
	triggerServerEvent("CSGcasinoShopEffectChange",source,false)
	if isElement(blur) then destroyElement(blur) end
	blur = nil
end
addEventHandler("onClientPlayerWasted", localPlayer, onDead)
