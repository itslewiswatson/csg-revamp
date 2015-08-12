-- Cancel the damage
addEventHandler ( "onClientPedDamage", root,
	function ()
		if ( getElementData( source, "showModelPed" ) ) then
			cancelEvent()
		end
	end
)
