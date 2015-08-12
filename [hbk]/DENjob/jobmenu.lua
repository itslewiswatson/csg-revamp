exports.DENsettings:addPlayerSetting("jobcalls", "true")

function createJobWindow()

	jobWindow = guiCreateWindow(289,332,269,204,"CSG ~ Job",false)
	jobLabel1 = guiCreateLabel(12,29,241,17,"Current occupation:",false,jobWindow)
	guiLabelSetHorizontalAlign(jobLabel1,"center",false)
	guiSetFont(jobLabel1,"default-bold-small")
	jobCheckBox = guiCreateCheckBox(21,72,239,29,"Accept service requests from users",false,false,jobWindow)
	guiCheckBoxSetSelected(jobCheckBox,true)
	guiSetFont(jobCheckBox,"default-bold-small")
	jobButton1 = guiCreateButton(9,112,251,38,"End shift",false,jobWindow)
	jobButton2 = guiCreateButton(9,156,251,38,"Quit job",false,jobWindow)
	jobLabel2 = guiCreateLabel(12,48,241,17,"Leading Staff",false,jobWindow)
	guiLabelSetColor(jobLabel2,238	,154	,0)
	guiLabelSetHorizontalAlign(jobLabel2,"center",false)
	guiSetFont(jobLabel2,"default-bold-small")

	guiWindowSetMovable (jobWindow, true)
	guiWindowSetSizable (jobWindow, false)
	guiSetVisible (jobWindow, false)

	local screenW,screenH=guiGetScreenSize()
	local windowW,windowH=guiGetSize(jobWindow,false)
	local x,y = (screenW-windowW)/2,(screenH-windowH)/2
	guiSetPosition(jobWindow,x,y,false)

	addEventHandler("onClientGUIClick", jobButton1, onEndShift, false)
	addEventHandler("onClientGUIClick", jobButton2, onQuitJob, false)
	addEventHandler("onClientGUIClick", jobCheckBox, onCheckJobCheckboxClick, false)

end

addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), 
	function ()
		createJobWindow()
	end
)

function onCheckJobCheckboxClick ()
	exports.DENsettings:setPlayerSetting("jobcalls", tostring(guiCheckBoxGetSelected( jobCheckBox )) )
	setElementData( localPlayer, "doesWantJobCalls", guiCheckBoxGetSelected( jobCheckBox ) )
end

function showJobGUI () 
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) then
		if not guiGetVisible(jobWindow) then
			guiSetVisible(jobWindow,true)
			showCursor(true)
			updateLabel ()
			-- Check the occupation and set the label status
			occupation = getElementData( localPlayer, "Occupation" )
			if occupation == "" then
				guiSetText(jobLabel2, "Unemployed")
			else
				guiSetText(jobLabel2, occupation)
			end
		else
			guiSetVisible(jobWindow,false)
			showCursor(false)
		end
	end
end
bindKey("F2","down",showJobGUI)

addEvent( "updateLabel", true )
function updateLabel ()

	-- Check the occupation and set the label status
	local occupation = getElementData( localPlayer, "Occupation" )
	if occupation == "" then
		guiSetText(jobLabel2, "Unemployed")
	else
		guiSetText(jobLabel2, occupation)
	end

	-- Check the team and set the shift status
	if (getTeamName(getPlayerTeam(localPlayer)) == "Unoccupied") then
		guiSetText ( jobButton1, "Start shift" )
	else
		guiSetText ( jobButton1, "End shift" )
	end
	
	-- Check is player has no job
	if (getTeamName(getPlayerTeam(localPlayer)) == "Unemployed") then
		guiSetEnabled ( jobButton1, false )
		guiSetEnabled ( jobButton2, false )
	else
		guiSetEnabled ( jobButton1, true )
		guiSetEnabled ( jobButton2, true )
	end
end
addEventHandler( "updateLabel", root, updateLabel )

local shift = 1

function onEndShift ()
	if ( onSpamProtection () ) then
		if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Criminals")  then
			exports.DENdxmsg:createNewDxMessage("You can't go off-duty as a criminal!", 200, 0, 0)
		elseif ( isPedInVehicle( localPlayer ) ) then
			exports.DENdxmsg:createNewDxMessage("You can't go off-duty in a car!", 200, 0, 0)
		elseif shift == 1 then
			shift = 0
			-- You are on shift
			triggerServerEvent( 'onEndShift', localPlayer )
			triggerEvent( "onClientPlayerTeamChange", localPlayer )
		else
			shift = 1
			-- You are off shift
			restoreShift = getElementData( localPlayer, "Occupation" )
			triggerServerEvent( 'onStartShift', localPlayer, restoreShift )
			triggerEvent( "onClientPlayerTeamChange", localPlayer )
		end
	else
		exports.DENdxmsg:createNewDxMessage("Stop clicking the off-duty button! Now wait 30 seconds", 200, 0, 0)
	end
end

local theSpam = {}

function onSpamProtection ()
	if not ( theSpam[localPlayer] ) then
		theSpam[localPlayer] = 1
		return true
	elseif ( theSpam[localPlayer] >= 4 ) then
		return false
	else
		theSpam[localPlayer] = theSpam[localPlayer] +1
		if ( theSpam[localPlayer] >= 4 ) and not ( isTimer( clearTimer ) ) then clearTimer = setTimer( clearSpamProtection, 40000, 1 ) end
		return true
	end	
end

function clearSpamProtection ()
	if ( theSpam[localPlayer] ) then
		theSpam[localPlayer] = 0
	end
end

function onQuitJob ()
	-- Quit yourjob permanent
	if ( getTeamName( getPlayerTeam( localPlayer ) ) == "Criminals")  then
		exports.DENdxmsg:createNewDxMessage("You can't quit your job as a criminal!", 200, 0, 0)
	elseif ( isPedInVehicle( localPlayer ) ) then
		exports.DENdxmsg:createNewDxMessage("You can't quit your job in a car!", 200, 0, 0)
	else
		oldShift = getElementData( localPlayer, "Occupation" )
		triggerServerEvent( 'onQuitJob', localPlayer, oldShift )
		triggerEvent( "onClientPlayerTeamChange", localPlayer )
	end
end