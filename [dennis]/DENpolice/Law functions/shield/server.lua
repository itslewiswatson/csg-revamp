local theShields = {}

addEvent ("shieldup", true )
addEventHandler("shieldup", root,
	function ()
		local x, y, z = getElementPosition( source )
		theShields[source] = createObject ( 1631, x, y, z, 0, 0, 0 )
		setElementDimension(theShields[source], getElementDimension(source))
		setElementInterior(theShields[source], getElementInterior(source))
		setElementDoubleSided(theShields[source], true)
		attachElements( theShields[source], source, 0, .5, .2, 0, 0, 0 )
		setElementData ( theShields[source], "type", "ashield", false )
			
		giveWeapon ( source, 0, 0, true )
		toggleControl ( source, "forwards", false)
		toggleControl ( source, "backwards", false)
		toggleControl ( source, "left", false)
		toggleControl ( source, "right", false)
		toggleControl ( source, "sprint", false)
		toggleControl ( source, "fire", false)
	end
)

addEvent ("shielddown", true )
addEventHandler("shielddown", root,
	function ( currentweapon )
		stuckstuff = getAttachedElements ( source )
		for ElementKey, ElementValue in ipairs(stuckstuff) do
			if ( getElementData ( ElementValue, "type" ) == "ashield" ) then
				theshield = ElementValue
			end
		end
		destroyElement ( theshield )
		
		giveWeapon ( source, currentweapon, 0, true )
		toggleControl ( source, "forwards", true)
		toggleControl ( source, "backwards", true)
		toggleControl ( source, "left", true)
		toggleControl ( source, "right", true)
		toggleControl ( source, "sprint", true)
		toggleControl ( source, "fire", true)
	end
)

addEventHandler( "onPlayerQuit", root,
	function ()
		if ( theShields[source] ) then
			if ( isElement( theShields[source] ) ) then
				destroyElement( theShields[source] )
			end
		end
	end
)

addEvent( "onPlayerPayfine", true )
addEventHandler( "onPlayerPayfine", root,
function ( theMoney )
	takePlayerMoney( source, theMoney )
	exports.server:removePlayerWantedPoints( source, 10 )
end
)