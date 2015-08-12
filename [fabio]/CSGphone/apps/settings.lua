local settingsTable
local phoneBackgroundCombo
local settingsGUI = {}
local currentPage = 1
local goToNextPageButton
local goToPreviousPageButton
local pageButtonSize = 20
local settingCheckboxWidth, settingCheckboxHeight = 110, 25

addEventHandler ( 'onClientResourceStart', getResourceRootElement(getThisResource()),
function ()
	settingsTable =
	{
		{
		{nil, "blur", "false", "Blur"},
		{nil, "heathaze", "false", "Heat Haze"},
		{nil, "clouds", "true", "Clouds"},
		{nil, "fpsmeter", "false", "FPS Meter"},
		{nil, "chatbox", "true", "Chat Box"},
		{nil, "smschatbox", "true", "SMS Output"},
		{nil, "speedmeter", "true", "Speedometer"},
		{nil, "damagemeter", "true", "Damage Meter"},
		{nil, "fuelmeter", "true", "Fuel Meter"},
		{nil, "gpsonhud", "true", "GPS Location"},
		{nil, "shaders", "false", "Toggle shaders"},
		{nil, "crimlog", "true", "Criminal log"},
		{nil, "jobcalls", "true", "Enable job calls"},
		{nil, "radar", "true", "See all players"},
		{nil, "drugtimer","true","See drug timers"},
		{nil, "premchat","true","See premium chat"},
		{nil, "killcam","true","See killcam"},
		{nil, "supportchat","true","Support chat"},
		{nil, "musiccontrol","true","Music controller"},

		},
		{ -- second screen
		},
		{ -- third screen
		{nil, "smsnotification", "true", "SMS Unread"},
		{nil, "smsringtone", "true", "SMS Ringtone"},
		{nil, "joinquit", "true", "Join/quit messages"},
		}

	}
	for i=1,#settingsTable do
		for ind=1,#settingsTable[i] do
			if not exports.DENsettings:getPlayerSetting(settingsTable[i][ind][2]) then
				exports.DENsettings:addPlayerSetting(settingsTable[i][ind][2], settingsTable[i][ind][3])
			end
		end
	end

	exports.DENsettings:addPlayerSetting("phoneBackground", "1")
	if sH >= 700 then
		settingCheckboxHeight = 25
	end
end
)

addEvent("onPlayerSettingChange",true)
addEventHandler("onPlayerSettingChange",localPlayer,function(s,v)
	if s == "supportchat" and v == false then
		setElementData(localPlayer,"chatOutputSupport",false,true)
	elseif s == "supportchat" and v == true then
		setElementData(localPlayer,"chatOutputSupport",true,true)
	end
end)

function onOpenSettingsApp ( )
	apps[4][7] = true

	goToPreviousPageButton = guiCreateButton( BGX, BGY, pageButtonSize, pageButtonSize, "<",false)
	goToNextPageButton = guiCreateButton( (BGX+BGWidth)-pageButtonSize, BGY, pageButtonSize, pageButtonSize, ">",false)
	guiSetProperty ( goToPreviousPageButton, "AlwaysOnTop", "True" )
	guiSetProperty ( goToNextPageButton, "AlwaysOnTop", "True" )
	if currentPage == 1 then guiSetEnabled(goToPreviousPageButton,false) end
	if currentPage == #settingsTable then guiSetEnabled(goToNextPageButton,false) end
	createPageGUI()

	addEventHandler( "onClientGUIClick", root, onSettingsClick )
	addEventHandler('onClientGUIComboBoxAccepted',root,onGUIComboBoxAccepted)

end
apps[4][8] = onOpenSettingsApp

function onCloseSettingsApp ()

	destroyElement(goToPreviousPageButton)
	destroyElement(goToNextPageButton)

	removeEventHandler( "onClientGUIClick", root, onSettingsClick )
	apps[4][7] = false
	clearPageGUI()
	removeEventHandler('onClientGUIComboBoxAccepted',root,onGUIComboBoxAccepted)

end

function onSettingsClick()

	if ( source == settingsGUI[1] ) or ( source == settingsGUI[2] ) or ( source == settingsGUI[4] ) or ( source == settingsGUI[5] ) or ( source == settingsGUI[6] ) then
		guiSetText( source, "")
		if ( source == settingsGUI[2] ) or ( source == settingsGUI[4] ) or ( source == settingsGUI[5] ) or ( source == settingsGUI[6] ) then
			guiEditSetMasked( source, true)
		end
	end

	local setting

	for i=1,#settingsTable[currentPage] do

		if ( source == settingsTable[currentPage][i][1] ) then

			setting = settingsTable[currentPage][i][2]
			break

		end

	end

	if setting then
		exports.DENsettings:setPlayerSetting(setting, tostring(guiCheckBoxGetSelected( source )) )
	end

	if source == goToPreviousPageButton then

		if settingsTable[currentPage-1] then

			switchToPage(currentPage-1)

		end

	elseif source == goToNextPageButton then

		if settingsTable[currentPage+1] then

			switchToPage(currentPage+1)

		end

	end

end

function switchToPage(page)

	clearPageGUI(currentPage)
	currentPage = page
	createPageGUI()
	if page == 1 then

		guiSetEnabled(goToPreviousPageButton, false)

	else

		guiSetEnabled(goToPreviousPageButton, true)

	end

	if page == #settingsTable then

		guiSetEnabled(goToNextPageButton, false)

	else

		guiSetEnabled(goToNextPageButton, true)

	end

end

function clearPageGUI(page)

	local pageToRemove = page or currentPage
	if pageToRemove == 1 then

		destroyElement(phoneBackgroundCombo)
		
	elseif pageToRemove == 2 then

		for i=1,#settingsGUI do
			destroyElement(settingsGUI[i])
		end

	elseif pageToRemove == 3 then
	
		destroyElement(SMSringtoneCombo)

	end

	for i=1,#settingsTable[currentPage] do

		if isElement(settingsTable[currentPage][i][1]) then

			destroyElement(settingsTable[currentPage][i][1])

		end

	end

	removeEventHandler( "onClientGUIBlur", root, onGUIBlur )

end

function createPageGUI()

	local rowsDone

	for i=1,#settingsTable[currentPage] do

		local row = math.floor((i-1)/2)
		if i == 1 then row = 0 end
		local isFirstOfTheRow = ( i/2 ~= math.floor(i/2) ) or i == 1
		local x,y, width, height = BGX+(0.05*BGWidth),BGY+math.max(20,0.05*BGHeight)+((row)*settingCheckboxHeight),settingCheckboxWidth,settingCheckboxHeight
		if not isFirstOfTheRow then
			x = BGX+(0.05*BGWidth)+110
		end

		local settings = settingsTable[currentPage]
		local state = exports.DENsettings:getPlayerSetting(settings[i][2])
		settings[i][1] = guiCreateCheckBox ( x,y, width, height, settings[i][4], state, false )
		guiSetProperty ( settings[i][1], "AlwaysOnTop", "True" )
	end

	if currentPage == 1 then

		phoneBackgroundCombo = guiCreateComboBox ( BGX+(0.05*BGWidth),BGY+math.max(40,0.06*BGHeight)+(settingCheckboxHeight*(#settingsTable[1]/2)), 0.90*BGWidth, 0.4*BGHeight, "Phone Background",false)
		guiSetProperty ( phoneBackgroundCombo, "AlwaysOnTop", "True" )

		for i=1,8 do
			guiComboBoxAddItem ( phoneBackgroundCombo, 'Background ' .. tostring(i))
		end
		
	elseif currentPage == 2 then

		local BGy = settingCheckboxHeight + BGY
		settingsGUI[1] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.05*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"New email",false) -- Email
		settingsGUI[2] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.12*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Current password",false) -- Current password
		settingsGUI[3] = guiCreateButton(BGX+(0.05*BGWidth),BGy+(0.19*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Change email",false) -- Change mail button

		settingsGUI[4] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.30*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"New password",false) -- New pass
		settingsGUI[5] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.37*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Confirm new password",false) -- New pass confirm
		settingsGUI[6] = guiCreateEdit(BGX+(0.05*BGWidth),BGy+(0.44*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Current password",false) -- Old pass
		settingsGUI[7] = guiCreateButton(BGX+(0.05*BGWidth),BGy+(0.51*BGHeight), 0.90*BGWidth, 0.056704228520393*BGHeight,"Change password",false) -- Change pass button

		for i=1,#settingsGUI do
			guiSetProperty( settingsGUI[i], "AlwaysOnTop", "True" )
		end

		addEventHandler( "onClientGUIClick", settingsGUI[3], onChangePlayerEmail )
		addEventHandler( "onClientGUIClick", settingsGUI[7], onChangePlayerPassword )

		
	elseif currentPage == 3 then
	
		SMSringtoneCombo = guiCreateComboBox ( BGX+(0.05*BGWidth),BGY+40+(settingCheckboxHeight*(#settingsTable[3]/2)), 0.90*BGWidth, 0.2*BGHeight, "SMS Ringtone",false)
		guiSetProperty( SMSringtoneCombo, "AlwaysOnTop", "True" )
		for i=1,4 do
			guiComboBoxAddItem ( SMSringtoneCombo, 'Ringtone ' .. tostring(i))
		end
	end

	addEventHandler( "onClientGUIBlur", root, onGUIBlur )

end

function onGUIComboBoxAccepted(comboBox)
	if currentPage == 1 and comboBox == phoneBackgroundCombo then
		local selectedBG = guiComboBoxGetItemText(phoneBackgroundCombo,guiComboBoxGetSelected(phoneBackgroundCombo))
		local selectedBG = string.sub(selectedBG, 12 )
		if ( selectedBG ~= "round" ) then
			BGnumber = selectedBG
			exports.DENsettings:setPlayerSetting("phoneBackground", selectedBG )
		end
	elseif currentPage == 3 and comboBox == SMSringtoneCombo then
		local selectedRingtone = guiComboBoxGetItemText(SMSringtoneCombo,guiComboBoxGetSelected(SMSringtoneCombo))
		local selectedRingtone = string.gsub(selectedRingtone, "Ringtone ","" )
		if ( #selectedRingtone >= 1  ) then
			exports.DENsettings:setPlayerSetting("smsringtonenumber", selectedRingtone )
			playSound("apps\\ringtones\\"..tostring(selectedRingtone)..".mp3")
		end		
	end	
end

function onGUIBlur()

	if currentPage == 2 then
		onSetEditDataBack ()
	end

end

function onSetEditDataBack ()
	if ( string.match(guiGetText(source), "^%s*$") ) then
		if ( source == settingsGUI[1] ) then
			guiSetText( source, "New email")
		elseif ( source == settingsGUI[2] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "Current password")
		elseif ( source == settingsGUI[4] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "New password")
		elseif ( source == settingsGUI[5] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "Confirm new password")
		elseif ( source == settingsGUI[6] ) then
			guiEditSetMasked( source, false)
			guiSetText( source, "Current password")
		end
	end
end

addEvent( "resetSettingsEditFields", true )
function resetSettingsEditFields ()
	guiEditSetMasked( settingsGUI[1], false)
	guiEditSetMasked( settingsGUI[2], false)
	guiEditSetMasked( settingsGUI[4], false)
	guiEditSetMasked( settingsGUI[5], false)
	guiEditSetMasked( settingsGUI[6], false)
end
addEventHandler( "resetSettingsEditFields", root, resetSettingsEditFields )

function onChangePlayerEmail ()
	local theEmail = guiGetText(settingsGUI[1])
	local thePassword = guiGetText(settingsGUI[2])
	triggerServerEvent( "onPlayerEmailChange", localPlayer, theEmail, thePassword )
end

function onChangePlayerPassword ()
	local newPassword1 = guiGetText(settingsGUI[4])
	local newPassword2 = guiGetText(settingsGUI[5])
	local oldPassword = guiGetText(settingsGUI[6])
	triggerServerEvent( "onPlayerPasswordChange", localPlayer, newPassword1, newPassword2, oldPassword )
end

apps[4][9] = onCloseSettingsApp
