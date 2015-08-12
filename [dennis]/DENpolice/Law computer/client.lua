

-- Police window GUI
policeComputerWindow = guiCreateWindow(318,174,778,561,"CSG ~ law enforcement computer",false)
policeComputerLabel1 = guiCreateLabel(16,24,305,16,"List of all wanted players in San Andreas",false,policeComputerWindow)
guiLabelSetColor(policeComputerLabel1,30,144,255)
guiSetFont(policeComputerLabel1,"default-bold-small")
policeComputerGrid = guiCreateGridList(9,43,761,334,false,policeComputerWindow)
guiGridListSetSelectionMode(policeComputerGrid,0)

local column1 = guiGridListAddColumn(policeComputerGrid,"  Playername:",0.30)
local column2 = guiGridListAddColumn(policeComputerGrid,"WL:",0.05)
local column3 = guiGridListAddColumn(policeComputerGrid,"City:",0.06)
local column4 = guiGridListAddColumn(policeComputerGrid,"Location:",0.30)
local column5 = guiGridListAddColumn(policeComputerGrid,"Transport:",0.12)
local column6 = guiGridListAddColumn(policeComputerGrid,"Wantedpoints:",0.13)

policeComputerRadio1 = guiCreateRadioButton(10,386,182,21,"Show all wanted players",false,policeComputerWindow)
policeComputerRadio2 = guiCreateRadioButton(10,411,182,21,"Show only players with 1 star",false,policeComputerWindow)
policeComputerRadio3 = guiCreateRadioButton(10,435,182,21,"Show only players with 2 star",false,policeComputerWindow)
policeComputerRadio4 = guiCreateRadioButton(10,460,182,21,"Show only players with 3 star",false,policeComputerWindow)
policeComputerRadio5 = guiCreateRadioButton(10,484,182,21,"Show only players with 4 star",false,policeComputerWindow)
policeComputerRadio6 = guiCreateRadioButton(10,506,182,21,"Show only players with 5 star",false,policeComputerWindow)
policeComputerRadio7 = guiCreateRadioButton(10,529,182,21,"Show only players with 6 star",false,policeComputerWindow)
guiRadioButtonSetSelected(policeComputerRadio1,true)

policeComputerCheckBox1 = guiCreateCheckBox(732,22,34,19,"LV",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox1,true)
policeComputerCheckBox2 = guiCreateCheckBox(689,22,34,19,"SF",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox2,true)
policeComputerCheckBox3 = guiCreateCheckBox(645,22,34,19,"LS",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox3,true)

policeComputerLabel2 = guiCreateLabel(207,389,141,17,"Your police stats:",false,policeComputerWindow)
guiLabelSetColor(policeComputerLabel2,30,144,255)
guiSetFont(policeComputerLabel2,"default-bold-small")
policeComputerLabel3 = guiCreateLabel(206,412,235,17,"Arrests:",false,policeComputerWindow)
guiSetFont(policeComputerLabel3,"default-bold-small")
policeComputerLabel4 = guiCreateLabel(206,433,240,17,"Arrest points:",false,policeComputerWindow)
guiSetFont(policeComputerLabel4,"default-bold-small")
policeComputerLabel5 = guiCreateLabel(205,457,222,17,"Tazer shots fired:",false,policeComputerWindow)
guiSetFont(policeComputerLabel5,"default-bold-small")
policeComputerLabel6 = guiCreateLabel(206,481,205,17,"Police occupation:",false,policeComputerWindow)
guiSetFont(policeComputerLabel6,"default-bold-small")
-- policeComputerLabel7 = guiCreateLabel(205,505,233,17,"Total time played as police:",false,policeComputerWindow)
-- guiSetFont(policeComputerLabel7,"default-bold-small")

policeComputerCheckBox4 = guiCreateCheckBox(610,385,156,18,"Accept Military requests",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox4,true)
policeComputerCheckBox5 = guiCreateCheckBox(610,406,157,18,"Accept SWAT requests",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox5,true)
policeComputerCheckBox6 = guiCreateCheckBox(610,447,157,18,"Accept Police requests",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox6,true)
policeComputerCheckBox7 = guiCreateCheckBox(610,426,157,18,"Accept FBI requests",false,false,policeComputerWindow)
guiCheckBoxSetSelected(policeComputerCheckBox7,true)

policeComputerButton1 = guiCreateButton(610,472,159,22,"Requesting transport",false,policeComputerWindow)
policeComputerButton2 = guiCreateButton(610,500,159,22,"Requesting light backup",false,policeComputerWindow)
policeComputerButton3 = guiCreateButton(610,528,159,22,"Request heavy backup",false,policeComputerWindow)
policeComputerButton4 = guiCreateButton(337,528,131,22,"Toggle selected player",false,policeComputerWindow)
policeComputerButton5 = guiCreateButton(474,528,131,22,"Remove all blips",false,policeComputerWindow)
policeComputerButton6 = guiCreateButton(201,528,131,22,"Mark all players",false,policeComputerWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(policeComputerWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(policeComputerWindow,x,y,false)

guiWindowSetMovable (policeComputerWindow, true)
guiWindowSetSizable (policeComputerWindow, false)
guiSetVisible (policeComputerWindow, false)

addEventHandler("onClientGUIClick", root,
function ()
	if ( source == policeComputerCheckBox4 ) then
		exports.DENsettings:setPlayerSetting("mfRequest", tostring(guiCheckBoxGetSelected( policeComputerCheckBox4 )) )
		setElementData( localPlayer, "mfRequest", guiCheckBoxGetSelected( policeComputerCheckBox4 ) )
	elseif ( source == policeComputerCheckBox5 ) then
		exports.DENsettings:setPlayerSetting("swatRequest", tostring(guiCheckBoxGetSelected( policeComputerCheckBox5 )) )
		setElementData( localPlayer, "swatRequest", guiCheckBoxGetSelected( policeComputerCheckBox5 ) )
	elseif ( source == policeComputerCheckBox6 ) then
		exports.DENsettings:setPlayerSetting("policeRequest", tostring(guiCheckBoxGetSelected( policeComputerCheckBox6 )) )
		setElementData( localPlayer, "policeRequest", guiCheckBoxGetSelected( policeComputerCheckBox6 ) )
	elseif ( source == policeComputerCheckBox7 ) then
		exports.DENsettings:setPlayerSetting("dodRequest", tostring(guiCheckBoxGetSelected( policeComputerCheckBox7 )) )
		setElementData( localPlayer, "dodRequest", guiCheckBoxGetSelected( policeComputerCheckBox7 ) )
	end
end
)

local doAutoUpdateBlips = false

function showPoliceComputer ()
	local thePlayerTeam = getTeamName(getPlayerTeam(localPlayer))
	if ( getElementData ( localPlayer, "isPlayerLoggedin" ) ) and ( thePlayerTeam == "Police" ) or ( thePlayerTeam == "SWAT" ) or ( thePlayerTeam == "Military Forces" ) or ( thePlayerTeam == "Government Agency" ) then
		if guiGetVisible(policeComputerWindow) then
			guiSetVisible(policeComputerWindow, false)
			showCursor(false,false)
		else
			-- exports.DENstats:forcePlayerStatsSync()
			guiSetText( policeComputerLabel6, "Police occupation: "..getElementData( localPlayer, "Occupation" ) )
			guiSetText( policeComputerLabel5, "Police team: "..getTeamName(getPlayerTeam(localPlayer)) )
			guiSetText( policeComputerLabel3, "Arrests: "..exports.DENstats:getPlayerAccountData( localPlayer, "arrests" ) )
			guiSetText( policeComputerLabel4, "Arrest points: "..exports.DENstats:getPlayerAccountData( localPlayer, "arrestpoints" ) )
			guiSetVisible(policeComputerWindow,true)
			showCursor(true,true)
			loadWantedPlayers()
		end
	end
end
bindKey ( "F5", "down", showPoliceComputer )

function onUserChangedMedicPanelSetting ()
	if ( source == policeComputerRadio1 ) or ( source == policeComputerRadio2 ) or ( source == policeComputerRadio3 ) or ( source == policeComputerRadio4 ) or ( source == policeComputerRadio5 ) or ( source == policeComputerRadio6 ) or ( source == policeComputerRadio7 ) then
		loadWantedPlayers()
	end

	if ( source == policeComputerCheckBox1 ) or ( source == policeComputerCheckBox2 ) or ( source == policeComputerCheckBox3 ) then
		loadWantedPlayers()
	end
end
addEventHandler ( "onClientGUIClick", root, onUserChangedMedicPanelSetting )


local blips = {}


function loadWantedPlayers()
	local wantedSetting = 0
	if ( guiRadioButtonGetSelected( policeComputerRadio1 ) ) then wantedSetting = 0 end
	if ( guiRadioButtonGetSelected( policeComputerRadio2 ) ) then wantedSetting = 10  end
	if ( guiRadioButtonGetSelected( policeComputerRadio3 ) ) then wantedSetting = 20  end
	if ( guiRadioButtonGetSelected( policeComputerRadio4 ) ) then wantedSetting = 30  end
	if ( guiRadioButtonGetSelected( policeComputerRadio5 ) ) then wantedSetting = 40  end
	if ( guiRadioButtonGetSelected( policeComputerRadio6 ) ) then wantedSetting = 50  end
	if ( guiRadioButtonGetSelected( policeComputerRadio7 ) ) then wantedSetting = 60  end

	local playersFound = false

	guiGridListClear ( policeComputerGrid )
	for id, player in ipairs(getElementsByType("player")) do
		if not ( player == localPlayer ) then
			if ( wantedSetting == 0 ) then
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= 10 ) then
					if ( guiCheckBoxGetSelected( policeComputerCheckBox1 ) ) and ( exports.server:getPlayChatZone( player ) == "LV" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox2 ) ) and ( exports.server:getPlayChatZone( player ) == "SF" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox3 ) ) and ( exports.server:getPlayChatZone( player ) == "LS" ) then
						playersFound = true
						local row = guiGridListAddRow ( policeComputerGrid )
						local x, y, z = getElementPosition ( player )
						local wantedLevel = math.floor((getElementData( player, "wantedPoints" )/10))
						if ( wantedLevel ) > 6 then wantedLevel = 6 end
						if ( isPedInVehicle( player ) ) then transport = "Vehicle" else transport = "Foot" end
						local zName = getZoneName ( x, y, z )

						if getElementData(player,"isPlayerArrested") == true then zName = "Arrested" end
						if getElementData(player,"isPlayerJailed") == true then zName = "In Jail" end

						guiGridListSetItemText ( policeComputerGrid, row, 1, getPlayerName ( player ), false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 2, wantedLevel, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 3, "("..exports.server:getPlayChatZone( player )..")", false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 4, zName, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 5, transport, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 6, math.floor((getElementData( player, "wantedPoints" ))+0.5), false, false )
						if blips[player] ~= nil and isElement(blips[player]) == true then
							local r,g,b = getTeamColor(getPlayerTeam(player))
							for i=1,6 do
								guiGridListSetItemColor(policeComputerGrid,row,i,r,g,b)
							end
						end
					end
				end
			else
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= wantedSetting ) then
					if ( guiCheckBoxGetSelected( policeComputerCheckBox1 ) ) and ( exports.server:getPlayChatZone( player ) == "LV" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox2 ) ) and ( exports.server:getPlayChatZone( player ) == "SF" ) or ( guiCheckBoxGetSelected( policeComputerCheckBox3 ) ) and ( exports.server:getPlayChatZone( player ) == "LS" ) then
						playersFound = true
						local row = guiGridListAddRow ( policeComputerGrid )
						local x, y, z = getElementPosition ( player )
						if ( isPedInVehicle( player ) ) then transport = "Vehicle" else transport = "Foot" end
						local zName = getZoneName ( x, y, z )
						if getElementData(player,"isPlayerJailed") == true then
							zName = "In Jail"
						elseif getElementData(player,"isPlayerArrested") == true then
							zName = "Arrested"
						end

						guiGridListSetItemText ( policeComputerGrid, row, 1, getPlayerName ( player ), false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 2, wantedLevel, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 3, "("..exports.server:getPlayChatZone( player )..")", false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 4, zName, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 5, transport, false, false )
						guiGridListSetItemText ( policeComputerGrid, row, 6, getElementData( player, "wantedPoints" ), false, false )
						if blips[player] ~= nil and isElement(blips[player]) == true then
							local r,g,b = getTeamColor(getPlayerTeam(player))
							for i=1,6 do
								guiGridListSetItemColor(policeComputerGrid,row,i,r,g,b)
							end
						end
					end
				end
			end
		end
	end
	if not ( playersFound ) then
		local row = guiGridListAddRow ( policeComputerGrid )
		guiGridListSetItemText ( policeComputerGrid, row, 1, "No players found", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 2, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 3, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 4, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 5, "N/A", false, false )
		guiGridListSetItemText ( policeComputerGrid, row, 6, "N/A", false, false )
	end
end



function onMarkAllPlayers ()
	local wantedSetting = 0
	if ( guiRadioButtonGetSelected( policeComputerRadio1 ) ) then wantedSetting = 0 end
	if ( guiRadioButtonGetSelected( policeComputerRadio2 ) ) then wantedSetting = 10  end
	if ( guiRadioButtonGetSelected( policeComputerRadio3 ) ) then wantedSetting = 20  end
	if ( guiRadioButtonGetSelected( policeComputerRadio4 ) ) then wantedSetting = 30  end
	if ( guiRadioButtonGetSelected( policeComputerRadio5 ) ) then wantedSetting = 40  end
	if ( guiRadioButtonGetSelected( policeComputerRadio6 ) ) then wantedSetting = 50  end
	if ( guiRadioButtonGetSelected( policeComputerRadio7 ) ) then wantedSetting = 60  end

	for id, player in ipairs(getElementsByType("player")) do
		if ( player ~= localPlayer ) and (blips[player] == nil or blips[player] == false) then
			if getElementData(player,"isPlayerJailed") == false then

			if ( wantedSetting == 0 ) then
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= 10 ) then
					local theBlip = createBlipAttachedTo ( player, 41 )
					blips[player]=theBlip
					--doAutoUpdateBlips = true
				end
			else
				if ( getElementData( player, "wantedPoints" ) ) and ( getElementData( player, "wantedPoints" ) >= wantedSetting ) then
					local theBlip = createBlipAttachedTo ( player, 41 )
					blips[player]=theBlip
					--doAutoUpdateBlips = true
				end
			end

			end
		end
	end
	loadWantedPlayers()
end
addEventHandler("onClientGUIClick", policeComputerButton6, onMarkAllPlayers, false)

function onRemoveAllBlips ()
	for k,v in pairs(blips) do
		if isElement(v) == true then
			destroyElement(v)
			blips[k]=false
		end
	end
	loadWantedPlayers()
end
addEventHandler("onClientGUIClick", policeComputerButton5, onRemoveAllBlips, false)

function onMarkSelectedPlayer ()
	local thePlayer = guiGridListGetItemText ( policeComputerGrid, guiGridListGetSelectedItem ( policeComputerGrid ), 1 )
	if thePlayer == "" or thePlayer == " " then
		exports.DENdxmsg:createNewDxMessage("You didn't select a player!", 225 ,0 ,0)
	else
		thePlayer=getPlayerFromName(thePlayer)
		if isElement(thePlayer)==true then
			if blips[thePlayer]==nil or blips[thePlayer]==false then
				if getElementData(thePlayer,"isPlayerJailed") == true then
					exports.DENdxmsg:createNewDxMessage("You can't mark a player that is in jail",255,255,0)
					return
				end
				theBlip = createBlipAttachedTo ( thePlayer, 41 )
				blips[thePlayer]=theBlip
			else
				if isElement(blips[thePlayer]) then
					destroyElement(blips[thePlayer])
					blips[thePlayer]=false
				end
			end
		end
	end
	loadWantedPlayers()
end
addEventHandler("onClientGUIClick", policeComputerButton4, onMarkSelectedPlayer, false)

function onPressRequestButton ()
	local x, y, z = getElementPosition(localPlayer)
	local locationString = getZoneName ( x, y, z ).." (" .. exports.server:getPlayChatZone() .. ")"
	if ( source == policeComputerButton1 ) then
		triggerServerEvent( "onSendRequestMessage", localPlayer, getTeamName(getPlayerTeam(localPlayer)), getPlayerName(localPlayer).." is requesting transport near "..locationString )
	elseif ( source == policeComputerButton2 ) then
		triggerServerEvent( "onSendRequestMessage", localPlayer, getTeamName(getPlayerTeam(localPlayer)), getPlayerName(localPlayer).." is requesting backup near "..locationString )
	elseif ( source == policeComputerButton3 ) then
		triggerServerEvent( "onSendRequestMessage", localPlayer, getTeamName(getPlayerTeam(localPlayer)), getPlayerName(localPlayer).." is requesting heavy backup near "..locationString )
	end
end
addEventHandler("onClientGUIClick", policeComputerButton1, onPressRequestButton, false)
addEventHandler("onClientGUIClick", policeComputerButton2, onPressRequestButton, false)
addEventHandler("onClientGUIClick", policeComputerButton3, onPressRequestButton, false)

local settingTable = { "swatRequest", "mfRequest", "dodRequest", "policeRequest" }
local checkboxTable = { policeComputerCheckBox5, policeComputerCheckBox4, policeComputerCheckBox7, policeComputerCheckBox6 }

for i=1,4 do
	exports.DENsettings:addPlayerSetting(settingTable[i], "true")
	local state = exports.DENsettings:getPlayerSetting(settingTable[i])
	setElementData( localPlayer, settingTable[i], state )
	guiCheckBoxSetSelected( checkboxTable[i], state )
end

addEvent( "onClientPlayerTeamChange" )
addEventHandler ( "onClientPlayerTeamChange", root,
function ()
	if ( source == localPlayer ) then
		onRemoveAllBlips ()
	end
end
)

addEvent("policeUnblip",true)
addEventHandler("policeUnblip",localPlayer,function()
	if blips[p] ~= nil then if isElement(blips[p]) then destroyElement(blips[p]) end end
end)
