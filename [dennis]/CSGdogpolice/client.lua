local theDog = createPed( 21, 1545.52, -1645.42, 5.89, 143, false )
local theDog2 = createPed( 21,  1985.66, -188.32, 35.58 , 280, false )
local theMarker = createMarker( 1545.52, -1645.42, 4.89, "cylinder", 1.0, 180, 0, 0 )
local theMarker2 = createMarker(  1985.66, -188.32, 34.58 ,"cylinder",1.0,180,0,0)
setElementFrozen( theDog, true )
addEventHandler( "onClientPedDamage", theDog, function () cancelEvent() end )
addEventHandler( "onClientPedDamage", theDog2, function () cancelEvent() end )

CSGDogWindow = guiCreateWindow(583,317,253,105,"K-9 Unit Officer Dog",false)
CSGDogLabel = guiCreateLabel(14,29,222,16,"Dog name:",false,CSGDogWindow)
guiLabelSetHorizontalAlign(CSGDogLabel,"center",false)
guiSetFont(CSGDogLabel,"default-bold-small")
CSGDogEdit = guiCreateEdit(26,47,204,23,"",false,CSGDogWindow)
CSGDogButton1 = guiCreateButton(26,73,99,22,"Create",false,CSGDogWindow)
CSGDogButton2 = guiCreateButton(128,73,99,22,"Cancel",false,CSGDogWindow)

guiWindowSetSizable( CSGDogWindow, false )
guiSetVisible( CSGDogWindow, false )

addEventHandler( "onClientMarkerHit", theMarker,
	function ( hitElement )
		local _,_,pz = getElementPosition(hitElement)
		local _,_,mz = getElementPosition(source)
		if ( math.abs(pz-mz) > 3 ) then return false end
		if ( hitElement == localPlayer ) then
			if ( getElementData( localPlayer, "Occupation" ) == "K-9 Unit Officer") then
				guiSetVisible( CSGDogWindow, true )
				showCursor( true )
			else
				exports.DENdxmsg:createNewDxMessage( "You need the 'K-9 Unit Officer' occupation to get a police dog!", 225, 0, 0 )
			end
		end
	end
)

addEventHandler( "onClientMarkerHit", theMarker2,
	function ( hitElement )
		local _,_,pz = getElementPosition(hitElement)
		local _,_,mz = getElementPosition(source)
		if ( math.abs(pz-mz) > 3 ) then return false end
		if ( hitElement == localPlayer ) then
			if ( getTeamName(getPlayerTeam(localPlayer)) == "Government Agency") then
				guiSetVisible( CSGDogWindow, true )
				showCursor( true )
			else
				exports.DENdxmsg:createNewDxMessage( "You need the FBI occupation to get a police dog!", 225, 0, 0 )
			end
		end
	end
)

addEventHandler( "onClientGUIClick", CSGDogButton1,
	function ()
		local theName = guiGetText( CSGDogEdit )
		if not ( theName ) or ( theName:match( "^%s*$" ) ) or ( string.len( theName ) > 10 ) then
			exports.DENdxmsg:createNewDxMessage( "You didn't enter a dog name or this name is to long!", 225, 0, 0 )
		else
			triggerServerEvent( "onServerCreatePoliceDog", localPlayer, theName )
		end
	end
)

addEventHandler( "onClientGUIClick", CSGDogButton2,
	function ()
		guiSetVisible( CSGDogWindow, false )
		showCursor( false )
	end
)

addEvent( "onClientClosePoliceDogWindow", true )
addEventHandler( "onClientClosePoliceDogWindow", root,
	function ()
		guiSetVisible( CSGDogWindow, false )
		showCursor( false )
	end
)
