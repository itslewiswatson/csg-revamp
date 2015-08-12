local scoreCD = {}

addEventHandler("onPlayerQuit",root,function() scoreCD[source]=nil end)

function healedPlayer ( money, healedplayer, healVal )
	local x, y, z = getElementPosition(source)
	local x2, y2, z2 = getElementPosition(healedplayer)
	local health = getElementHealth(healedplayer)
	if getDistanceBetweenPoints3D(x, y, z, x2, y2, z2) < 10 then
		if getPedWeapon ( source ) == 41 then
			if ( money ) then
				if getPlayerMoney(healedplayer) > money then
					setElementHealth ( healedplayer, health + healVal )
					triggerClientEvent(source,"CSGmedicAddStat",source,"Healed Health",healVal)
					triggerClientEvent(source,"CSGmedicAddStat",source,"Money earned from healing",money)
					givePlayerMoney ( healedplayer, money*-1 )
					givePlayerMoney ( source, money )
					if scoreCD[source] == nil then scoreCD[source]={} end
					if scoreCD[source][healedplayer] == nil then scoreCD[source][healedplayer] = 0 end
						if scoreCD[source][healedplayer] > 1 then
							--exports.CSGscore:givePlayerScore(attacker,0.1)

						elseif scoreCD[source][healedplayer] == 1 then
							setTimer(function() if isElement(source) then scoreCD[source][healedplayer]=0 end end,180000,1)
							scoreCD[source][healedplayer]=1.1

						else
							triggerClientEvent(source,"CSGmedicAddStat",source,"Unique person heals",1)
							exports.CSGscore:givePlayerScore(source,0.1)
							scoreCD[source][healedplayer]=scoreCD[source][healedplayer]+0.1
							exports.CSGtopjobs:didWork(source,"paramedic",0.1)
							triggerClientEvent(source,"CSGmedicAddStat",source,"Score earned from healing",0.1)

							--[[local data = exports.Denstats:getPlayerAccountData(source,"paramedic2")

							if data == nil or data == false then
								data = {}
							else
								data = fromJSON(data)
							end
							if type(data) ~= "table" then
								data = {["healedscore"]=0,["rankPTS"]=0,0,0,0,0,0,0,0}
								for i=1,10 do data[i]=0 end
							end
							if data["healscore"] == nil then data["healscore"] = 0 end
							data["healscore"] = data["healscore"] + 0.1
							data = toJSON(data)
							exports.Denstats:setPlayerAccountData(source,"paramedic2",data)--]]

						end
				else
					exports.DENdxmsg:createNewDxMessage ( source, "The player you want heal doesn't have enough money!", 225,0,0)
					triggerClientEvent(source,"CSGmedicAddStat",source,"Poor person healing incidents",1)
				end
			else
				setElementHealth ( healedplayer, health + healVal )
				triggerClientEvent(source,"CSGmedicAddStat",source,"Healed Health",healVal)

				exports.DENdxmsg:createNewDxMessage( source, "No money for you! You attacked the patient before healing.", 225,0,0)
			end
		end
	end
end
addEvent ( "healedPlayer", true )
addEventHandler ( "healedPlayer", root, healedPlayer )

addEventHandler("onPlayerWasted",root,function()
	if getTeamName(getPlayerTeam(source)) == "Paramedics" then
		triggerClientEvent(source,"CSGmedicAddStat",source,"Death on Job",1)
	end
end)

addEventHandler ( "onVehicleEnter", root,
function ( thePlayer, seat, jacked )
	local theMedic = getVehicleController ( source )
	if ( theMedic ) then
		if ( getTeamName ( getPlayerTeam ( theMedic ) ) == "Paramedics" ) and ( getElementModel(source) == 416 ) then
			local getPlayerHealth = getElementHealth (thePlayer)
			local theHealthFormule = ( 100 / getPlayerHealth )
			local healPrice = ( theHealthFormule * 40 / 10 )
			if ( getPlayerMoney( thePlayer ) < healPrice ) then
				exports.DENdxmsg:createNewDxMessage ( thePlayer, "You don't have enough money for a heal!", 225,0,0)
			else
				if ( math.floor(getPlayerHealth) < 100 ) then
					givePlayerMoney (theMedic, math.floor(healPrice))
					takePlayerMoney (thePlayer, math.floor(healPrice))
					setElementHealth (thePlayer, 100)
				end
			end
		end
	end
end
)

addEvent("onServerPlayerLogin",true)
addEventHandler("onServerPlayerLogin",root,function()
	local p = source
	triggerClientEvent(p,"CSGmedicRecData",p,nil)
end)

addEvent("CSGmedic.setDefault",true)
addEventHandler("CSGmedic.setDefault",root,function()
		local t = {["healedscore"]=0,["rankPTS"]=0,0,0,0,0,0,0,0}
		for i=1,10 do t[i]=0 end
		exports.DENstats:setPlayerAccountData(source,"paramedic2",toJSON(t),true)
end)

setTimer(function()
	for k,source in pairs(getElementsByType("player")) do
		if exports.server:isPlayerLoggedIn(source) then
			triggerClientEvent(source,"CSGmedicRecData",source,nil)
		end
	end
end,5000,1)

 local nameToI = {
	["Healed Health"] = 1,
	["Score earned from healing"] = "healedscore",
	["Death on Job"] = 3,
	["Unique person heals"] = 4,
	["Poor person healing incidents"] = 5,
	["Money earned from healing"] = 6,
	["Money earned from daily pay"] = 7,
}

function CSGmedicSetStat(stat,value,p,bool,_,rankPTS)
	--[[if (source) then p=source end
	if (p) then
		if isElement(p) == false then
			if isElement(source) then p = source end
		end
	end
	if (bool) then
		if bool == true then
			if isElement(p) then
				if getElementType(p) == "player" then
					triggerClientEvent(p,"CSGmedicAddStat",p,stat,value)
					return
				end
			end
		end
	end
	local t = exports.DENstats:getPlayerAccountData(p,"paramedic2")

	tt = fromJSON(t)
	if tt==nil or tt["healedscore"] == nil or tt[1] == nil then
		tt = {["healedscore"]=0,["rankPTS"]=0,0,0,0,0,0,0,0}
		for i=1,10 do tt[i]=0 end
		exports.DENstats:setPlayerAccountData(p,"paramedic2",toJSON(tt))

	end
	--]]
	exports.DENstats:setPlayerAccountData(source,"paramedic2",stat)
end
addEvent("CSGmedicSetStat",true)
addEventHandler("CSGmedicSetStat",root,CSGmedicSetStat)
