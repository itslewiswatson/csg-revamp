addEvent("skinShop:buySkin",true)
addEventHandler("skinShop:buySkin",root,
	function ( skinID,premium )
		if ( not premium ) or exports.server:isPlayerPremium(source) then
			local pMoney = getPlayerMoney(source)		
			if pMoney >= 250 then
				if not premium then
					takePlayerMoney(source,250)
				end
				local pTeam = getPlayerTeam(source)
				local pTeamName
				if pTeam then pTeamName = getTeamName(pTeam) end			
				local pAccountID = exports.server:getPlayerAccountID(source)
				exports.denmysql:exec("UPDATE accounts SET skin=? WHERE id=?",skinID,pAccountID)			
				if skinID == 0 then
					local cjClothesInfo = exports.denmysql:query("SELECT cjskin FROM accounts WHERE id=?",pAccountID)
					local clothesTable = fromJSON(cjClothesInfo)
					if clothesTable then
						for theType, index in pairs( clothesTable ) do
							local texture, model = getClothesByTypeIndex ( theType, index )
							addPedClothes ( source, texture, model, theType )
						end
					end				
				end
				
				if ( not pTeamName ) or pTeamName == "Criminals" or pTeamName == "Unemployed" or pTeamName == "Unoccupied" then
					setElementModel(source,skinID)
					exports.dendxmsg:createNewDxMessage(source,"Your new skin was bought and set!",0,255,0)
					triggerClientEvent(source,"skinShop:buySkin:callBack",source,true,false)
				else
					exports.dendxmsg:createNewDxMessage(source,"Your new skin was bought, but not set due to your current occupation.",150,255,0)
					triggerClientEvent(source,"skinShop:buySkin:callBack",source,true,true)
				end
				return true
			else
				exports.dendxmsg:createNewDxMessage(source,"This is a premium skin, please donate to use this skin.",255,170,0)		
			end
		else
			exports.dendxmsg:createNewDxMessage(source,"You do not own the $250 needed to buy this skin.",255,0,0)		
		end
		triggerClientEvent(source,"skinShop:buySkin:callBack",source,false,true)
	end
)

