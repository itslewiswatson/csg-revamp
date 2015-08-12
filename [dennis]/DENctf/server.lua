local CTFData = {}
local theFlagOwner = false

-- On resrouce start create a new flag
addEventHandler( "onResourceStart", resourceRoot,
	function ()
		setTimer(function() onCreateNewFlag () end,600000,1)
	end
)

-- Create a new flag and destroy the others if any
function onCreateNewFlag ()
	onDestroyOldFlag ()

	local xa, ya, za = getRandomFlagPosition ()
	local xb, yb, zb = getRandomDeliverPosition ()

	-- Delivery points
	CTFData["theMarker"]  = createMarker ( xb, yb, zb, "checkpoint", 2, 225, 0, 0 )
	CTFData["markerBlip"] = createBlip ( xb, yb, zb, 33, 3, 225, 0, 0, 225 )

	-- The flag and colshape
	CTFData["theFlag"]    = createPickup ( xa, ya, za, 3, 2993 )
	CTFData["flagBlip"]   = createBlip ( xa, ya, za, 19, 3, 225, 0, 0, 225 )
	attachElements ( CTFData["flagBlip"], CTFData["theFlag"] )

	addEventHandler( "onMarkerHit", CTFData["theMarker"], onServerDeliveryPointHit )
	addEventHandler( "onPickupHit", CTFData["theFlag"], onServerFlagPickupHit )

	exports.DENdxmsg:createNewDxMessage ( root, "A new flag appeared! Capture and deliver it for a nice sum of money and score!", 0, 225, 0 )
end

-- When the player hits the flag
function onDestroyOldFlag ( resetTimer )
	if ( isElement( CTFData["theMarker"] ) ) then destroyElement( CTFData["theMarker"] ) end
	if ( isElement( CTFData["markerBlip"] ) ) then destroyElement( CTFData["markerBlip"] ) end
	if ( isElement( CTFData["theFlag"] ) ) then destroyElement( CTFData["theFlag"] ) end
	if ( isElement( CTFData["flagBlip"] ) ) then destroyElement( CTFData["flagBlip"] ) end
	if ( isElement( CTFData["theObject"] ) ) then destroyElement( CTFData["theObject"] ) end

	CTFData["theMarker"] = nil
	CTFData["markerBlip"] = nil
	CTFData["theFlag"] = nil
	CTFData["flagBlip"] = nil
	CTFData["theObject"] = nil

	CTFData = {}
	theFlagOwner = false
	if ( resetTimer ) then setTimer( onCreateNewFlag, 600000, 1 ) end

end

-- When the player hits the flag
function onServerFlagPickupHit ( thePlayer )
	if ( thePlayer ) and ( getElementDimension( thePlayer ) == 0 ) and ( getElementDimension ( thePlayer ) == 0 ) and not ( doesPedHaveJetPack ( thePlayer ) ) and ( getElementType( thePlayer ) == "player" ) then
		if getElementData(thePlayer,"isPlayerArrested") == true then
			exports.DENdxmsg:createNewDxMessage(thePlayer,"You can't pickup the flag while arrested",255,255,0)
			return
		end
		CTFData["theObject"]  = createObject ( 2993, 0, 0, 0 )

		attachElements ( CTFData["theObject"], thePlayer, 0, 0, 0, 0, 0, -90 )
		attachElements ( CTFData["flagBlip"], CTFData["theObject"] )
		triggerClientEvent( thePlayer, "onClientCheckFlagStatus", thePlayer, true )
		theFlagOwner = thePlayer

		removeEventHandler( "onPickupHit", CTFData["theFlag"], onServerFlagPickupHit )
		destroyElement( CTFData["theFlag"] )

		exports.DENdxmsg:createNewDxMessage ( thePlayer, "You captured the flag! Deliver it quick before you lose it again.", 0, 225, 0 )
	else
		cancelEvent()
	end
end

-- When the player hits the flag deliver point
function onServerDeliveryPointHit ( hitElement, matchingDimension )
	if ( hitElement == theFlagOwner ) then
		givePlayerMoney( theFlagOwner, 5000 )
		exports.CSGscore:givePlayerScore(theFlagOwner,2)
		exports.DENdxmsg:createNewDxMessage ( root, getPlayerName( hitElement ).." captured and deliverd the flag! A new flag will appear within 10 minutes.", 0, 225, 0 )
		triggerClientEvent( hitElement, "onClientCheckFlagStatus", hitElement, false )
		onDestroyOldFlag ( true )
		startResource(getResourceFromName("CSGarmo"),true)
		stopResource(getResourceFromName("DENctf"))
	end
end

-- Reset the flag
addEvent( "onRemoveFlagAttached", true )
function removeFlagAttached  ( x, y, z, state, thePlayer )
	local thePlayer = source or thePlayer
	if not ( state ) and ( thePlayer == theFlagOwner ) then
		destroyElement( CTFData["theObject"] )
		destroyElement( CTFData["flagBlip"] )

		CTFData["theFlag"] 	= createPickup ( x, y, z, 3, 2993 )
		CTFData["flagBlip"] = createBlip ( x, y, z, 19, 3, 225, 0, 0, 225 )
		attachElements ( CTFData["flagBlip"], CTFData["theFlag"] )

		addEventHandler( "onPickupHit", CTFData["theFlag"], onServerFlagPickupHit )
	elseif ( thePlayer == theFlagOwner ) then
		onDestroyOldFlag ( true )
	end
end
addEventHandler( "onRemoveFlagAttached", root, removeFlagAttached )

-- When a player disconnects
addEventHandler( "onPlayerQuit", root,
	function ()
		if ( source == theFlagOwner ) then
			local x, y, z = getElementPosition ( source )
			removeFlagAttached  ( x, y, z, false, source )
		end
	end
)
