function buyWeapon ( weapon, price )
local playerID = exports.server:getPlayerAccountID( source )
local wepCheck = exports.DENmysql:querySingle( "SELECT * FROM weapons WHERE userid=?",tonumber(playerID))
if ( exports.server:isPlayerPremium( source ) ) then price = tonumber( math.floor( price / 120 * 100 ) ) end
	if wepCheck then
		local money = getPlayerMoney(source)
		if tonumber(wepCheck[weapon]) == 1 then
			triggerClientEvent( source, "warn2", source )
			return
		elseif tonumber(wepCheck[weapon]) == 0 and (money < tonumber(price)) then
			triggerClientEvent( source, "warn4", source )
			return
		else
			setMysql = exports.DENmysql:exec( "UPDATE weapons SET`" .. weapon .. "` = 1 WHERE userid = " .. playerID)
			takePlayerMoney ( source, tonumber(price) )
			triggerClientEvent( source, "warn3", source )
			return
		end
	else
		local createWeaponTable = exports.DENmysql:exec("INSERT INTO weapons SET userid=?",tonumber(playerID))
		outputChatBox("There was something wrong, try again or when this error keeps comming warn a staff member!", source, 225, 0, 0)
	end
end
addEvent( "buyWeapon", true )
addEventHandler( "buyWeapon", root, buyWeapon )

function buyAmmo ( weapon, price )
local playerID = exports.server:getPlayerAccountID( source )
local wepChecks = exports.DENmysql:querySingle( "SELECT * FROM weapons WHERE userid=?",tonumber(playerID))
if ( exports.server:isPlayerPremium( source ) ) then price = tonumber( math.floor( price / 120 * 100 ) ) end
	if wepChecks then
		local money = getPlayerMoney(source)
		if tonumber(wepChecks[weapon]) == 0 then
			triggerClientEvent( source, "warn1", source )
			return
		elseif tonumber(wepChecks[weapon]) == 1 and (money < tonumber(price)) then
			triggerClientEvent( source, "warn4", source )
			return
		else
			if weapon == "22" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 22, 17, true )
			elseif weapon == "23" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 23, 17, true )
			elseif weapon == "24" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 24, 7, true )
			elseif weapon == "25" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 25, 1, true )
			elseif weapon == "26" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 26, 2, true )
			elseif weapon == "27" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 27, 7, true )
			elseif weapon == "28" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 28, 50, true )
			elseif weapon == "29" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 29, 30, true )
			elseif weapon == "30" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 30, 30, true )
			elseif weapon == "31" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 31, 50, true )
			elseif weapon == "32" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 32, 50, true )
			elseif weapon == "33" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 33, 1, true )
			elseif weapon == "34" then
				takePlayerMoney ( source, tonumber(price) )
				giveWeapon ( source, 34, 5, true )
			end
		end
	else
	local createWeaponTable = exports.DENmysql:exec("INSERT INTO weapons SET userid=?",tonumber(playerID))
	outputChatBox("There was something wrong, try again or when this error keeps comming warn a staff member!", source, 225, 0, 0)
	end
end
addEvent( "buyAmmo", true )
addEventHandler( "buyAmmo", getRootElement(), buyAmmo )

function buySpecial ( weapon, price )
local money = getPlayerMoney(source)
	if (money < tonumber(price)) then
		triggerClientEvent( source, "warn4", source )
	else
		takePlayerMoney ( source, tonumber(price) )
		giveWeapon ( source, weapon, 1, true )
	end
end
addEvent( "buySpecial", true )
addEventHandler( "buySpecial", getRootElement(), buySpecial )

function onClientPlayerBoughtArmour (armourType)
	if ( math.floor( getPedArmor ( source ) ) < 100 ) then
		if ( getPlayerMoney( source ) < getArmorPrice ( source, armourType ) ) then
			exports.DENdxmsg:createNewDxMessage(source, "You don't have enough money!", 225, 0, 0)
		else
			local howMuch = tonumber(armourType)
			local price = getArmorPrice ( source, armourType )
			takePlayerMoney( source, tonumber(price) )
			if ( tonumber(armourType) == 50 ) then setPedArmor ( source, getPedArmor(source) +50 ) else setPedArmor ( source, 100 ) end
		end
	else
		exports.DENdxmsg:createNewDxMessage(source, "You don't need anymore armor!", 225, 0, 0)
	end
end
addEvent( "onClientPlayerBoughtArmour", true )
addEventHandler( "onClientPlayerBoughtArmour", getRootElement(), onClientPlayerBoughtArmour )

function getArmorPrice ( thePlayer, armourType )
	if getElementData(thePlayer, "isPlayerPremium") then
		if ( tonumber(armourType) == 50 ) then
			return 250
		else
			return 500
		end
	else
		if ( tonumber(armourType) == 100 ) then
			return 500
		else
			return 1000
		end
	end
end

addEvent("CSGammu.buyLaser",true)
addEventHandler("CSGammu.buyLaser",root,function(cost,r,g,b)
	local m = getPlayerMoney(source)
	if m > cost then
		takePlayerMoney(source,cost)
		exports.CSGlaser:SetLaserEnabled(source,true)
		exports.CSGlaser:SetLaserColor(source,r,g,b)
		exports.DENdxmsg:createNewDxMessage(source,"Bought a laser for $"..cost.."",0,255,0)
		exports.DENdxmsg:createNewDxMessage(source,"Press L or type /laser to equip / unequip it",0,255,0)
		local accountID = exports.server:getPlayerAccountID(source)
		local t = {100,r,g,b,true} --battery percent, r, g, b, enabled

		exports.DENmysql:exec("UPDATE playerstats SET laser=? WHERE userid=?",toJSON(t),accountID)
		triggerEvent("CSGammu.boughtLaser",source,t)
	else
		exports.DENdxmsg:createNewDxMessage(source,"You can't afford this laser. It costs $"..cost..", you only have $"..m.."",255,255,0)
	end
end)
