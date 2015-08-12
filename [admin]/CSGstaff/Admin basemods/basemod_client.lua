local baseModGUI = {}

local getSelectedBaseResource = function ()
	local selRow,_ = guiGridListGetSelectedItem(baseModGUI.grid)
	if selRow and selRow ~= -1 then
		return guiGridListGetItemText(baseModGUI.grid,selRow,1)
	end
	return false
end

local changeRes = function (event)
	local res = getSelectedBaseResource()
	if res then
		triggerServerEvent("CSGStaff.basemod."..event,localPlayer,res)
		setTimer(loadBaseModResources,1000,1)
	end
end


function createBaseModGUI()
	if isPlayerBaseMod(localPlayer) then
		baseModGUI.window = guiCreateWindow(562, 305, 361, 326, "", false)
		guiWindowSetSizable(baseModGUI.window, false)

		baseModGUI.grid = guiCreateGridList(9, 25, 343, 256, false, baseModGUI.window)
			guiGridListAddColumn(baseModGUI.grid,"Resource",0.9)
		baseModGUI.start = guiCreateButton(13, 289, 82, 28, "Start", false, baseModGUI.window)
		baseModGUI.stop = guiCreateButton(105, 289, 82, 28, "Stop", false, baseModGUI.window)
		baseModGUI.restart = guiCreateButton(203, 289, 82, 28, "Restart", false, baseModGUI.window)
		baseModGUI.close = guiCreateButton(298, 289, 53, 28, "Close", false, baseModGUI.window)
		addEventHandler("onClientGUIClick",baseModGUI.close,toggleBaseModGUI,false)
		addEventHandler("onClientGUIClick",baseModGUI.start,function () changeRes("start") end,false)
		addEventHandler("onClientGUIClick",baseModGUI.stop,function () changeRes("stop") end,false)
		addEventHandler("onClientGUIClick",baseModGUI.restart,function () changeRes("restart") end,false)
		loadBaseModResources()
	end
end

function loadBaseModResources()
	guiGridListClear(baseModGUI.grid)
	for resName,_ in pairs(baseModResList) do
		local state = (getResourceFromName(resName) and isElement(getResourceDynamicElementRoot(getResourceFromName(resName))))
		local row = guiGridListAddRow(baseModGUI.grid)
		guiGridListSetItemText(baseModGUI.grid,row,1,resName,false,false)
		local r,g,b = 0,255,0
		if not state then
			r,g = 255,0
		end
		guiGridListSetItemColor(baseModGUI.grid,row,1,r,g,b)
	end
end

function toggleBaseModGUI()
	if isPlayerBaseMod(localPlayer) then
		if not isElement(baseModGUI.window) then 
			createBaseModGUI() 
		else
			guiSetVisible(baseModGUI.window, not guiGetVisible(baseModGUI.window) )
			loadBaseModResources()
		end
		local state = guiGetVisible(baseModGUI.window)
		showCursor(state)
	end
end
local add = false

addEventHandler("onClientResourceStart",resourceRoot,
	function ()
		setTimer(function () 
			if isPlayerBaseMod(localPlayer) and not add then 
				addCommandHandler("basemod",toggleBaseModGUI)
				add = true
			end
		end,15000,1)
	end
)

addEventHandler("onClientPlayerLogin",localPlayer,
	function ()
		setTimer(function () 
			if isPlayerBaseMod(localPlayer) and not add then 
				addCommandHandler("basemod",toggleBaseModGUI)
				add = true
			end
		end, 10000,3)
	end
)