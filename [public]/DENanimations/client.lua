function makeAnimationGUI()
    animationWindow = guiCreateWindow(237,46,244,402,"CSG ~ Animation",false)
    guiSetAlpha(animationWindow,1)
	guiSetVisible(animationWindow,false)
    guiWindowSetSizable(animationWindow,false)
    animationCategoryList = guiCreateGridList(9,32,113,312,false,animationWindow)
    guiGridListSetSelectionMode(animationCategoryList,2)

    column1 = guiGridListAddColumn(animationCategoryList,"Category",0.8)
    animationList = guiCreateGridList(124,31,111,313,false,animationWindow)
    guiGridListSetSelectionMode(animationList,2)

    column2 = guiGridListAddColumn(animationList,"Animation",0.8)
	stopButton = guiCreateButton(9,353,226,40,"Stop Animation",false,animationWindow)
	addEventHandler("onClientGUIClick",stopButton,function() setPedAnimation(getLocalPlayer(),nil,nil) end)

	for k, v in ipairs (getElementsByType("animationCategory")) do
		local row = guiGridListAddRow(animationCategoryList)
		guiGridListSetItemText(animationCategoryList,row,column1,getElementID(v),false,false)
	end

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(animationWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(animationWindow,x,y,false)

	addEventHandler("onClientGUIClick",animationCategoryList,getAnimations)
	addEventHandler("onClientGUIClick",animationList,setAnimation)
end
addEventHandler("onClientResourceStart",getResourceRootElement(getThisResource()),makeAnimationGUI)

function toggleVisible()
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) then
		if (guiGetVisible(animationWindow) == false) then
			guiSetVisible(animationWindow,true)
			showCursor(true)
		else
			guiSetVisible(animationWindow,false)
			showCursor(false)
		end
	end
end
--bindKey("F4","down",toggleVisible)

function getAnimations()
	selectedCategory = guiGridListGetItemText(animationCategoryList,guiGridListGetSelectedItem(animationCategoryList),1)
		if (selectedCategory ~= "") then
			guiGridListClear(animationList)
				for k, v in ipairs (getElementChildren(getElementByID(selectedCategory))) do
					local row = guiGridListAddRow(animationList)
					guiGridListSetItemText(animationList,row,column1,getElementID(v),false,false)
				end
		end
		if (selectedCategory == "") then
			guiGridListClear(animationList)
		end
end

function setAnimation()
	selectedAnimation = guiGridListGetItemText(animationList,guiGridListGetSelectedItem(animationList),1)
		if (selectedAnimation ~= "") then
			if (not isPlayerDead(getLocalPlayer())) then
				if (isPedInVehicle(getLocalPlayer()) == false) then
					local animationBlock = getElementData(getElementByID(selectedAnimation),"block")
					local animationID = getElementData(getElementByID(selectedAnimation),"code")
					triggerServerEvent("setAnimation",getLocalPlayer(),animationBlock,animationID)
				else
					outputChatBox("You cannot use animations while in a vehicle.",255,0,0)
				end
			else
				outputChatBox("You cannot use animations while you are dead.",255,0,0)
			end
		end
end

