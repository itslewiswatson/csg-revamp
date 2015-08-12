local criminalJobMarkers = {
[1]={2531.62, -1666.45, 15.16},
[2]={1407.56, -1300.06, 13.55},
[3]={-2159.34, 654.18, 52.36},
[4]={1753.87, 777.93, 10.82},
[5]={2127.69, 2377.1, 10.82}
}

crimJobWindow = guiCreateWindow(730,213,321,362,"CSG ~ Become a Criminal",false)
crimJobMemo = guiCreateMemo(9,44,303,217,"There are multiple Criminals in CSG, each with a score requirement. To see the mutliple criminal classes, go to the criminal job marker and near it is another marker to specialize into another type of criminal.  Criminals earn money through various ways. The following is criminal income(s)	> Los Venturas Turfing. Earn money when you take a turf for your group!	> Capture the Flag and deliver it! > Sell weapons or sell drugs! (/sellweps /selldrugs) > Rob stores! /holdup or /robstore at the cash register! > Destroy the armored truck and prevent it from being delivered! > Rob the casino or rob the bank!",false,crimJobWindow)
crimJobLabel = guiCreateLabel(14,22,257,17,"Information about this job:",false,crimJobWindow)
guiSetFont(crimJobLabel,"default-bold-small")
crimJobSetJob = guiCreateButton(12,268,292,36,"Become a Criminal",false,crimJobWindow)
crimJobCloseScreen = guiCreateButton(12,312,295,36,"Close Screen",false,crimJobWindow)

local screenW,screenH=guiGetScreenSize()
local windowW,windowH=guiGetSize(crimJobWindow,false)
local x,y = (screenW-windowW)/2,(screenH-windowH)/2
guiSetPosition(crimJobWindow,x,y,false)

guiWindowSetMovable (crimJobWindow, true)
guiWindowSetSizable (crimJobWindow, false)
guiSetVisible (crimJobWindow, false)


addEventHandler("onClientGUIClick", crimJobCloseScreen,
function()
	guiSetVisible( crimJobWindow, false )
	showCursor( false, false )
end, false
)

addEventHandler("onClientGUIClick", crimJobSetJob,
function()
	guiSetVisible( crimJobWindow, false )
	showCursor( false, false )

	local oldTeam = getPlayerTeam( localPlayer )
	if ( getTeamName( oldTeam ) ~= "Criminals" ) then
		triggerEvent( "onClientPlayerTeamChange", localPlayer, oldTeam, getTeamFromName ( "Criminals" ) )
	end

	triggerEvent( "onClientPlayerJobChange", localPlayer, "Criminal", getTeamFromName ( "Criminals" ) )
	triggerServerEvent( "enterCriminalJob", localPlayer )
end, false
)

function crimMarkerHit( hitPlayer, matchingDimension )
	if ( hitPlayer == localPlayer ) then
		local vehicle = getPedOccupiedVehicle ( localPlayer )
			if not ( vehicle ) then
			guiSetVisible( crimJobWindow, true )
			showCursor( true, true )
		end
	end
end

for ID in pairs( criminalJobMarkers ) do
	local x, y, z = criminalJobMarkers[ID][1], criminalJobMarkers[ID][2], criminalJobMarkers[ID][3]
	local crimMarker = createMarker(x,y,z -1,"cylinder",2.0, 200, 0, 0 ,170)
	exports.customblips:createCustomBlip ( x, y, 16, 16, "image.png", 100 )
	addEventHandler("onClientMarkerHit", crimMarker, crimMarkerHit)
end
