addEvent( "onServerCreatePoliceDog", true )
addEventHandler( "onServerCreatePoliceDog", root,
	function ( theName )
		if ( exports.CSGanimals:onCreatePlayerAnimal ( source, theName ) ) then
			exports.DENdxmsg:createNewDxMessage( source, "A police dog spawned next to you!", 0, 225, 0 )
			triggerClientEvent( source, "onClientClosePoliceDogWindow", source )
		else
			exports.DENdxmsg:createNewDxMessage( source, "Something went wrong, maybe you already have a dog?", 225, 0, 0 )
			triggerClientEvent( source, "onClientClosePoliceDogWindow", source )
		end
	end
)