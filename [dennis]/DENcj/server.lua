addEvent( "onChangeClothesCJ", true )
addEventHandler( "onChangeClothesCJ", root,
function ( CJClothesTable, CJClothesString )
	if ( CJClothesTable ) then
		for int, index in pairs( CJClothesTable ) do
			local texture, model = getClothesByTypeIndex ( int, index )
			if ( texture ) then
				addPedClothes ( source, texture, model, int )
			end
		end
		local playerID = exports.server:getPlayerAccountID( source )
		local updateMySQL = exports.DENmysql:exec( "UPDATE accounts SET cjskin=? WHERE id=?",CJClothesString, playerID )
	end
end
)

addEvent( "onPlayerBougtSkin", true )
addEventHandler( "onPlayerBougtSkin", root,
function ( thePrice )
	if ( thePrice ) then
		takePlayerMoney( source, tonumber(thePrice) )
	end
end
)