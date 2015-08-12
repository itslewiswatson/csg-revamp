local vendingTimers = {}

-- Event when player bought a product
addEvent ("onServerBuyVendingProduct", true)
function onServerBuyVendingProduct ()
	takePlayerMoney( source, 5 )
	setPedAnimation( source, "VENDING", "VEND_Use")
	vendingTimers[source] = setTimer( onServerVendingAnimation, 3000, 1, source )
end
addEventHandler ("onServerBuyVendingProduct", root, onServerBuyVendingProduct)

-- Set the next animation for a nice effect
function onServerVendingAnimation ( thePlayer )
	setPedAnimation( thePlayer, "VENDING", "VEND_Drink2_P")
	vendingTimers[thePlayer] = setTimer( onVendingPlayerGiveHealth, 3000, 1, thePlayer )
end

-- Event that gives the player the health after the animation is done
function onVendingPlayerGiveHealth ( thePlayer )
	if ( isElement( thePlayer ) ) then
		vendingTimers[thePlayer] = nil
		setPedAnimation( thePlayer, false )
		setElementHealth( thePlayer, getElementHealth( thePlayer ) +5 )
		triggerClientEvent( thePlayer, "onResetVendingMachineBind", thePlayer )
	end
end