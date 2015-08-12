-- GUI variables

local GUI = {}
local onAlarmClick
local alarmSound
local updateAlarmGridTimer
local createAlarmGUI
local updateAlarmGrid
local fillAlarmGrid
local alarmTrigger
local alarms = {}

addEventHandler ( "onClientResourceStart", resourceRoot,
function ()
	apps[17][8] = openAlarm
	apps[17][9] = closeAlarm
end
)

local alarmTriggeredGUI = {}

function centerWindow(window) local width,height = guiGetSize(window,false) guiSetPosition(window,(sW-width)/2,(sH-height)/2) end

alarmTrigger = function (alarm)
	local text = alarms[alarm][2]
	--table.remove(alarms,alarm)
	killTimer(alarms[alarm][3]) -- disable alarm
	if not alarmTriggeredGUI[1] then
		local window = guiCreateWindow((sW-249)/2, (sH-142)/2, 249, 142, "Alarm(s)", false)
		centerWindow(window)
		local label = guiCreateLabel(10, 26, 213, 83, text, false, window)
		guiLabelSetVerticalAlign(label,'center')
		guiLabelSetHorizontalAlign(label,'center',false)
		local button = guiCreateButton(101, 109, 47, 23, "Close", false, window)	
		table.insert(alarmTriggeredGUI,window)
		table.insert(alarmTriggeredGUI,label)
		table.insert(alarmTriggeredGUI,button)
		alarmSound = playSound('apps\\alarm.mp3',true)
		addEventHandler("onClientGUIClick",button,
		function () 
			for i=1,#alarmTriggeredGUI do 
				if isElement(alarmTriggeredGUI[i]) then 
					destroyElement(alarmTriggeredGUI[i]) 
				end 
			end 
			stopSound(alarmSound)
			alarmTriggeredGUI = {} 
		end, false )		
	else	
		guiSetText(alarmTriggeredGUI[2],guiGetText(alarmTriggeredGUI[2]).."\n"..text)	
		local oldWidth,oldHeight = guiGetSize(alarmTriggeredGUI[1],false)
		guiSetSize(alarmTriggeredGUI[1],oldWidth,oldHeight+30,false)		
		local oldWidth,oldHeight = guiGetSize(alarmTriggeredGUI[2],false)
		guiSetSize(alarmTriggeredGUI[2],oldWidth,oldHeight+30,false)
		local oldX,oldY = guiGetPosition(alarmTriggeredGUI[3],false)
		guiSetPosition(alarmTriggeredGUI[3],oldX,oldY+30,false)		
		centerWindow(alarmTriggeredGUI[1])
	end	
	fillAlarmGrid()	
end

local openMainGUI = function ()
	if isElement(GUI[1]) then	
		for i=1,#GUI do	
			guiSetVisible(GUI[i],true)
			guiBringToFront(GUI[i])
			guiSetProperty( GUI[i], "AlwaysOnTop", "True" )		
		end
	else
		createAlarmGUI()
	end
end

function openAlarm ()
	openMainGUI()
	apps[17][7] = true
	updateAlarmGridTimer = setTimer(updateAlarmGrid,1000,0)
	addEventHandler("onClientGUIClick",root,onAlarmClick)
end

local buttonWidth, buttonHeight = 0.5*BGWidth,35

createAlarmGUI = function ()

	GUI = {
		guiCreateGridList(BGX,BGY,BGWidth,BGHeight-buttonHeight,false),
		guiCreateButton(BGX,BGY+(BGHeight-buttonHeight),buttonWidth,buttonHeight,"New alarm",false),
		guiCreateButton(BGX+buttonWidth,BGY+(BGHeight-buttonHeight),buttonWidth,buttonHeight,"Delete alarm",false)
	}
	guiGridListAddColumn(GUI[1],"Name",0.6)
	guiGridListAddColumn(GUI[1],"Seconds left",0.3)
	fillAlarmGrid()
	for i=1,#GUI do
	
		guiSetProperty(GUI[i],"AlwaysOnTop","True")
	
	end
end

fillAlarmGrid = function ()

	if not isElement(GUI[1]) then return end
	guiGridListClear(GUI[1])
	for i=1,#alarms do
	
		local totalTime,text,timer = unpack(alarms[i])
		if isTimer(timer) then
			local timeLeft,_,_ = getTimerDetails(timer)
			local row = guiGridListAddRow(GUI[1])
			guiGridListSetItemText(GUI[1],row,1,alarms[i][2], false, false)
			guiGridListSetItemText(GUI[1],row,2,math.ceil(timeLeft/1000), false, false)
			guiGridListSetItemData(GUI[1],row,2,timer)
			guiGridListSetItemData(GUI[1],row,1,i)
		end
	end
end

updateAlarmGrid = function ()
	for row=0,guiGridListGetRowCount(GUI[1])-1 do
		local timeLeft,_,_ = getTimerDetails(guiGridListGetItemData(GUI[1],row,2))
		guiGridListSetItemText(GUI[1],row,2,math.ceil(timeLeft/1000), false, false)
	end
end

local setAlarmGUI = {}

local onSetAlarm = function ()
	-- set alarm here
	local description = guiGetText(setAlarmGUI[7])
	local hours = guiGetText(setAlarmGUI[2])
	local minutes = guiGetText(setAlarmGUI[3])
	local seconds = guiGetText(setAlarmGUI[4])
	local hours,minutes,seconds = tonumber(hours),tonumber(minutes),tonumber(seconds)
	if hours and minutes and seconds then
		local hoursSeconds = hours*60*60
		local minutesSeconds = minutes*60
		local secondOffset = hoursSeconds+minutesSeconds+seconds
		table.insert(alarms,{secondOffset,description,setTimer(alarmTrigger,secondOffset*1000,1,#alarms+1)} )	
		closeSetAlarmGUI()
		openMainGUI()
		fillAlarmGrid()
	else
		exports.dendxmsg:createNewDxMessage('Invalid format!',255,0,0)
	end
end

onAlarmClick = function ()

	if source == GUI[2] then -- new alarm
	
		for i=1,#GUI do
	
			if isElement ( GUI[i] ) then guiSetVisible ( GUI[i], false ) end

		end
		setAlarmGUI[1] = guiCreateLabel(BGX,BGY,BGWidth,BGHeight*0.2,"Time from now\n( HH:MM:SS, hours:minutes:seconds )",false)
		guiLabelSetVerticalAlign(setAlarmGUI[1],"center")
		guiLabelSetHorizontalAlign(setAlarmGUI[1],"center")
		setAlarmGUI[8] = guiCreateLabel(BGX+0.15*BGWidth,BGY+0.25*BGHeight,BGWidth*0.15,BGHeight*0.05,"HH",false)
		setAlarmGUI[2] = guiCreateEdit(BGX+0.15*BGWidth,BGY+0.3*BGHeight,BGWidth*0.15,BGHeight*0.15,"00",false)
		setAlarmGUI[9] = guiCreateLabel(BGX+0.4*BGWidth,BGY+0.25*BGHeight,BGWidth*0.15,BGHeight*0.05,"MM",false)
		setAlarmGUI[3] = guiCreateEdit(BGX+0.4*BGWidth,BGY+0.3*BGHeight,BGWidth*0.15,BGHeight*0.15,"00",false)
		setAlarmGUI[10] = guiCreateLabel(BGX+0.65*BGWidth,BGY+0.25*BGHeight,BGWidth*0.15,BGHeight*0.05,"SS",false)		
		setAlarmGUI[4] = guiCreateEdit(BGX+0.65*BGWidth,BGY+0.3*BGHeight,BGWidth*0.15,BGHeight*0.15,"50",false)
		setAlarmGUI[5] = guiCreateButton(BGX+0.15*BGWidth,BGY+0.7*BGHeight,BGWidth*0.3,BGHeight*0.15,"Set",false)
		addEventHandler('onClientGUIClick',setAlarmGUI[5],onSetAlarm)
		setAlarmGUI[6] = guiCreateButton(BGX+0.55*BGWidth,BGY+0.7*BGHeight,BGWidth*0.3,BGHeight*0.15,"Cancel",false)
		addEventHandler('onClientGUIClick',setAlarmGUI[6],function () closeSetAlarmGUI() openMainGUI() end)
		setAlarmGUI[7] = guiCreateMemo(BGX+0.05*BGWidth,BGY+0.5*BGHeight,BGWidth*0.9,BGHeight*0.15,"Description",false)
	elseif source == GUI[3] then -- delete alarm	
		local row,_ = guiGridListGetSelectedItem(GUI[1])
		if row and row >= 0 then		
			local alarm = guiGridListGetItemData(GUI[1],row,1)
			killTimer(alarms[alarm][3]) -- disable alarm
			fillAlarmGrid()		
		end	
	end	
end

function closeSetAlarmGUI()
	if setAlarmGUI then
		for i=1,#setAlarmGUI do	
			if isElement ( setAlarmGUI[i] ) then destroyElement(setAlarmGUI[i]) end
		end	
	end
	setAlarmGUI = {}
end

function closeAlarm ()

	apps[17][7] = false
	for i=1,#GUI do	
		if isElement ( GUI[i] ) then guiSetVisible ( GUI[i], false ) end
		guiSetProperty( GUI[i], "AlwaysOnTop", "False" )
	end
	closeSetAlarmGUI()
	killTimer(updateAlarmGridTimer)
	removeEventHandler("onClientGUIClick",root,onAlarmClick)
end
