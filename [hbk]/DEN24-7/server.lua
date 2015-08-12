-- The buy function
function buyShopItem (itemid, ammo, itemprice)
	--if ( exports.CSGgift:getChristmasDay() == "Day25" ) then itemprice = 0 end
	local playerMoney = getPlayerMoney(source)
	if (playerMoney < tonumber(itemprice)) then
		exports.DENdxmsg:createNewDxMessage(source, "You dont have enough money for this item!", 200, 0, 0)
	else
		takePlayerMoney ( source, tonumber(itemprice) )
		giveWeapon ( source, tonumber(itemid), tonumber(ammo), true )
	end
end
addEvent ("buyShopItem", true)
addEventHandler ("buyShopItem", getRootElement(), buyShopItem)
