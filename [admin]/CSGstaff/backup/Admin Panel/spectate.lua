-- Spectate
local spectating = nil
local sx, sy = guiGetScreenSize ()
local randomButton = guiCreateButton ( sx / 2 - 100, sy - 50, 110, 30, "Random Player", false )
local backButton = guiCreateButton ( sx / 2 + 15,  sy - 50, 110, 30, "Back", false )
guiSetVisible( backButton, false )
guiSetVisible( randomButton, false )

local oldDim = 0
local oldInt = 0

function onStopSpectating ()
	removeEventHandler( "onClientPreRender", root, spectateRender )
	local x, y, z = getElementPosition( localPlayer )
	setElementPosition( localPlayer, x, y, z +1 )
	guiSetVisible( backButton, false )
	guiSetVisible( randomButton, false )
	setElementFrozen ( localPlayer, false )
	setElementInterior(localPlayer, oldInt)
	setElementDimension(localPlayer, oldDim)
	setCameraTarget ( localPlayer )
	spectating = nil
	showCursor( true )
end
addEventHandler ( "onClientGUIClick", backButton, onStopSpectating )

function randomSpectatePlayer ()
	local allPlayers = getElementsByType ( "player" )
	thePlayer = allPlayers[math.random(1,#allPlayers)]
	if not ( thePlayer == localPlayer ) then
		setElementFrozen ( localPlayer, true )
		oldDim = getElementInterior(localPlayer)
		oldInt = getElementDimension(localPlayer)
		spectating = thePlayer
		setCameraTarget ( thePlayer )
		setElementInterior(localPlayer, getElementInterior(thePlayer))
		setElementDimension(localPlayer, getElementDimension(thePlayer))
		showCursor( false )
	else
		randomSpectatePlayer ()
	end
end
addEventHandler ( "onClientGUIClick", randomButton, randomSpectatePlayer )

function onPlayerSpecate ( thePlayer )
	if ( thePlayer ) and not ( spectating ) then
		if ( isElement( thePlayer ) ) then
			if not ( thePlayer == localPlayer ) then
				setElementFrozen ( localPlayer, true )
				oldDim = getElementInterior(localPlayer)
				oldInt = getElementDimension(localPlayer)
				setCameraTarget ( thePlayer )
				guiSetVisible( backButton, true )
				guiSetVisible( randomButton, true )
				setElementInterior(localPlayer, getElementInterior(thePlayer))
				setElementDimension(localPlayer, getElementDimension(thePlayer))
				showCursor( false )
				spectating = thePlayer
				addEventHandler( "onClientPreRender", root, spectateRender )
			else
				exports.DENhelp:createNewHelpMessage("You can't spectate yourself!", 225, 0, 0)
			end
		end
	end
end

addEventHandler( "onClientPlayerQuit", root, 
function ()
	if ( spectating ) then
		if ( spectating == source ) then
			guiSetVisible( backButton, false )
			guiSetVisible( randomButton, false )
			local x, y, z = getElementPosition( localPlayer )
			setElementPosition( localPlayer, x, y, z +1 )
			setElementInterior(localPlayer, oldInt)
			setElementDimension(localPlayer, oldDim)
			setCameraTarget ( localPlayer )
			setElementFrozen ( localPlayer, false )
			spectating = nil
			showCursor( true )
			removeEventHandler( "onClientPreRender", root, spectateRender )
		end
	end
end
)

function spectateRender ()
	if ( spectating ) then
		dxDrawText ( "Spectating: "..getPlayerName ( spectating ), sx - 170, 200, sx - 170, 200, tocolor ( 255, 255, 255, 255 ), 1 )
	end
end