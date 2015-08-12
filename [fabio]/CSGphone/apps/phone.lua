local phoneGUI = {}
local phoneSpam = {}
addEvent('onPlayerJobCall', true )

local phoneServices = {
-- {"Occupation", "Team"}
[0] = {"Police Officer", "Police"},
[1] = {"SWAT", "SWAT"},
[2] = {"Military Forces", "Military Forces"},
[3] = {"Paramedic", "Paramedics"},
[4] = {"Pilot", "Civilian Workers"},
[5] = {"Mechanic", "Civilian Workers"},
[6] = {"Prostitute", "Civilian Workers"}
}

function openPhone()
	if not phoneGUI[1] then phoneGUI[1] = guiCreateGridList ( BGX, BGY, BGWidth, 0.92*BGHeight, false ) end
	if not phoneGUI[2] then phoneGUI[2] = guiCreateButton ( BGX+(BGWidth*0.0), BGY+(0.930*BGHeight), BGWidth, 0.068*BGHeight, "Call", false ) end
	if not phoneGUI[3] then phoneGUI[3] = guiGridListAddColumn ( phoneGUI[1], "  Services:", 0.9 ) end
	
	for i=1, 2 do
		guiSetVisible ( phoneGUI[i], true )
		guiSetProperty ( phoneGUI[i], "AlwaysOnTop", "True" )
	end
	
	guiGridListClear(phoneGUI[1])
	
	for i=0,#phoneServices do
		local serviceName = phoneServices[i][1]
		local theRow = guiGridListAddRow(phoneGUI[1])
		guiGridListSetItemText ( phoneGUI[1], theRow, 1, serviceName, false, false )
	end
	
	addEventHandler ( "onClientGUIClick", phoneGUI[2], onCallService )
	
	apps[1][7] = true

end

apps[1][8] = openPhone

function closePhone()

	removeEventHandler ( "onClientGUIClick", phoneGUI[2], onCallService )

	for i=1,2 do
		guiSetVisible ( phoneGUI[i], false )
		guiSetProperty ( phoneGUI[i], "AlwaysOnTop", "False" )
	end
	
	apps[1][7] = false

end

function onCallService ()
	local row, column = guiGridListGetSelectedItem ( phoneGUI[1] )
	if ( row ) and ( column ) and ( phoneServices[row][1] ) then
		local serviceOccupation, serviceTeam = phoneServices[row][1], phoneServices[row][2]
		if ( serviceOccupation ) and ( serviceTeam ) then
			if ( phoneSpam[serviceOccupation] ) and ( getTickCount()-phoneSpam[serviceOccupation] < 30000 ) then
				exports.DENdxmsg:createNewDxMessage("Your call was not sent due to spam protection!", 225, 0, 0)
			else
				exports.DENdxmsg:createNewDxMessage("You called to the " .. serviceOccupation .. " services!", 225, 0, 0)
				phoneSpam[serviceOccupation] = getTickCount()
				triggerServerEvent( "onPhoneCallService", localPlayer, serviceOccupation, serviceTeam )
			end
		end
	end
end

apps[1][9] = closePhone