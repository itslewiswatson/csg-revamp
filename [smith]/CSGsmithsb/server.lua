------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithmics/server (server-side)
--  Mics Script
--  [CSG]Smith
------------------------------------------------------------------------------------
function addTextNotification(player,text,r,g,b)
	exports.CSGsmithsDx:addTextNotification(player,text,r,g,b)
end

bot1 = {}
bot2 = {}
bot3 = {}
bot4 = {}
bot5 = {}
bot6 = {}
bot7 = {}
bot8 = {}
bot9 = {}
bot10 = {}
bot11 = {}
bot12 = {}
bot13 = {}
bot14 = {}
bot15 = {}

function creating_bots_in_game (thePlayer,cmd,action,id)
if (("smith" == exports.server:getPlayerAccountName(thePlayer)) or ("priyen" == exports.server:getPlayerAccountName(thePlayer))) then
	local px,py,pz = getElementPosition(thePlayer)
	local rx,ry,rz = getElementRotation(thePlayer)
	local dim = getElementDimension(thePlayer)
	local int = getElementInterior(thePlayer)
	local PlayerTeam = getPlayerTeam(thePlayer)
	if action then
		if (action == "guarding" or action == "follow") then
			if id then
				if (tonumber(id) == 1) then
					if isElement(bot1[thePlayer]) then destroyElement(bot1[thePlayer]) end
					bot1[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot1 added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 2) then
					if isElement(bot2[thePlayer]) then destroyElement(bot2[thePlayer]) end
					bot2[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot2 added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 3) then
					if isElement(bot3[thePlayer]) then destroyElement(bot3[thePlayer]) end
					bot3[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot3 added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 4) then
					if isElement(bot4[thePlayer]) then destroyElement(bot4[thePlayer]) end
					bot4[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 5) then
					if isElement(bot5[thePlayer]) then destroyElement(bot5[thePlayer]) end
					bot5[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 6) then
					if isElement(bot6[thePlayer]) then destroyElement(bot6[thePlayer]) end
					bot6[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 7) then
					if isElement(bot7[thePlayer]) then destroyElement(bot7[thePlayer]) end
					bot7[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 8) then
					if isElement(bot8[thePlayer]) then destroyElement(bot8[thePlayer]) end
					bot8[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 9) then
					if isElement(bot9[thePlayer]) then destroyElement(bot9[thePlayer]) end
					bot9[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 10) then
					if isElement(bot10[thePlayer]) then destroyElement(bot10[thePlayer]) end
					bot10[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 11) then
					if isElement(bot11[thePlayer]) then destroyElement(bot11[thePlayer]) end
					bot11[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 12) then
					if isElement(bot12[thePlayer]) then destroyElement(bot12[thePlayer]) end
					bot12[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 13) then
					if isElement(bot13[thePlayer]) then destroyElement(bot13[thePlayer]) end
					bot13[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 14) then
					if isElement(bot14[thePlayer]) then destroyElement(bot14[thePlayer]) end
					bot14[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif (tonumber(id) == 15) then
					if isElement(bot15[thePlayer]) then destroyElement(bot15[thePlayer]) end
					bot15[thePlayer] = exports.slothbot:spawnBot( px+1, py+1, pz, rz, 312, tonumber(int), tonumber(dim),PlayerTeam, 31, action, nil)
					addTextNotification(thePlayer,"Successful!",0,250,0)
					addTextNotification(thePlayer,"Bot added. Function '"..tostring(action).."'!",0,250,0)
				elseif ((tonumber(id) ~= 1) or (tonumber(id) ~= 2) or (tonumber(id) ~= 3) or (tonumber(id) ~= 4) or (tonumber(id) ~= 5) or (tonumber(id) ~= 6) or (tonumber(id) ~= 7) or (tonumber(id) ~= 8) or (tonumber(id) ~= 9) or (tonumber(id) ~= 10) or (tonumber(id) ~= 11) or (tonumber(id) ~= 12) or (tonumber(id) ~= 13) or (tonumber(id) ~= 14) or (tonumber(id) ~= 15)) then
					addTextNotification(thePlayer,"ID should be between 1-9! ("..tostring(id)..")",255,0,0)
				end
			else
				addTextNotification(thePlayer,"Syntax: /cb follow/guarding ID",255,0,0)
			end
		else
			addTextNotification(thePlayer,"Syntax: /cb follow/guarding ID",255,0,0)
		end
	else
		addTextNotification(thePlayer,"Syntax: /cb follow/guarding ID",255,0,0)
	end
end
end
addCommandHandler("cb",creating_bots_in_game)

function force_to_attack(thePlayer,cmd,id)
if (("smith" == exports.server:getPlayerAccountName(thePlayer)) or ("priyen" == exports.server:getPlayerAccountName(thePlayer))) then
	if id then
		if (tonumber(id) == 1) then
			if isElement(bot1[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot1[thePlayer], not exports.slothbot:getBotAttackEnabled(bot1[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot1[thePlayer])
				addTextNotification(thePlayer,"* Bot1 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot1 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 2) then
			if isElement(bot2[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot2[thePlayer], not exports.slothbot:getBotAttackEnabled(bot2[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot2[thePlayer])
				addTextNotification(thePlayer,"* Bot2 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot2 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 3) then
			if isElement(bot3[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot3[thePlayer], not exports.slothbot:getBotAttackEnabled(bot3[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot3[thePlayer])
				addTextNotification(thePlayer,"* Bot3 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot3 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 4) then
			if isElement(bot4[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot4[thePlayer], not exports.slothbot:getBotAttackEnabled(bot4[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot4[thePlayer])
				addTextNotification(thePlayer,"* Bot4 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot4 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 5) then
			if isElement(bot5[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot5[thePlayer], not exports.slothbot:getBotAttackEnabled(bot5[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot5[thePlayer])
				addTextNotification(thePlayer,"* Bot5 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot5 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 6) then
			if isElement(bot6[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot6[thePlayer], not exports.slothbot:getBotAttackEnabled(bot6[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot6[thePlayer])
				addTextNotification(thePlayer,"* Bot6 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot6 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 7) then
			if isElement(bot7[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot7[thePlayer], not exports.slothbot:getBotAttackEnabled(bot7[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot7[thePlayer])
				addTextNotification(thePlayer,"* Bot7 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot7 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 8) then
			if isElement(bot8[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot8[thePlayer], not exports.slothbot:getBotAttackEnabled(bot8[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot8[thePlayer])
				addTextNotification(thePlayer,"* Bot8 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot8 does not exist!",255,0,0)
			end
		elseif (tonumber(id) == 9) then
			if isElement(bot9[thePlayer]) then
				exports.slothbot:setBotAttackEnabled( bot9[thePlayer], not exports.slothbot:getBotAttackEnabled(bot9[thePlayer]) )
				test = exports.slothbot:getBotAttackEnabled( bot9[thePlayer])
				addTextNotification(thePlayer,"* Bot9 Attacking has been set to '"..tostring(test).."' !",255,255,0)
			else
				addTextNotification(thePlayer,"* Bot9 does not exist!",255,0,0)
			end
		elseif ((tonumber(id) ~= 1) or (tonumber(id) ~= 2) or (tonumber(id) ~= 3) or (tonumber(id) ~= 4) or (tonumber(id) ~= 5) or (tonumber(id) ~= 6) or (tonumber(id) ~= 7) or (tonumber(id) ~= 8) or (tonumber(id) ~= 9)) then
			addTextNotification(thePlayer,"ID should be between 1-9! ("..tostring(id)..")",255,0,0)
		end
	else
		addTextNotification(thePlayer,"Syntax: /ba ID.",255,0,0)
	end
end
end
addCommandHandler("ba",force_to_attack)


function force_to_destroy(thePlayer,cmd,id)
if (("smith" == exports.server:getPlayerAccountName(thePlayer)) or ("priyen" == exports.server:getPlayerAccountName(thePlayer))) then
	if id then
		if (tonumber(id) == 1) then
			if isElement(bot1[thePlayer]) then destroyElement(bot1[thePlayer]) 
				addTextNotification(thePlayer,"* Your Bot1 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot1' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 2) then
			if isElement(bot2[thePlayer]) then destroyElement(bot2[thePlayer])
				addTextNotification(thePlayer,"* Your Bot2 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot2' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 3) then
			if isElement(bot3[thePlayer]) then destroyElement(bot3[thePlayer])
				addTextNotification(thePlayer,"* Your Bot3 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot3' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 4) then
			if isElement(bot4[thePlayer]) then destroyElement(bot4[thePlayer]) 
				addTextNotification(thePlayer,"* Your Bot4 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot4' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 5) then
			if isElement(bot5[thePlayer]) then destroyElement(bot5[thePlayer]) 
				addTextNotification(thePlayer,"* Your Bot5 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot5' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 6) then
			if isElement(bot6[thePlayer]) then destroyElement(bot6[thePlayer]) 
				addTextNotification(thePlayer,"* Your Bot6 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot6' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 7) then
			if isElement(bot7[thePlayer]) then destroyElement(bot7[thePlayer]) 
				addTextNotification(thePlayer,"* Your Bot7 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot7' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 8) then
			if isElement(bot8[thePlayer]) then destroyElement(bot8[thePlayer]) 
				addTextNotification(thePlayer,"* Your Bot8 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot8' in-game!",255,0,0)
			end
		elseif (tonumber(id) == 9) then
			if isElement(bot9[thePlayer]) then destroyElement(bot9[thePlayer]) 
				addTextNotification(thePlayer,"* Your Bot9 has been destroyed!",0,255,0)
			else
				addTextNotification(thePlayer,"* There is no 'Bot9' in-game!",255,0,0)
			end
		elseif (id == "all") then
			if isElement(bot1[thePlayer]) then destroyElement(bot1[thePlayer]) end
			if isElement(bot2[thePlayer]) then destroyElement(bot2[thePlayer]) end
			if isElement(bot3[thePlayer]) then destroyElement(bot3[thePlayer]) end
			if isElement(bot4[thePlayer]) then destroyElement(bot4[thePlayer]) end
			if isElement(bot5[thePlayer]) then destroyElement(bot5[thePlayer]) end
			if isElement(bot6[thePlayer]) then destroyElement(bot6[thePlayer]) end
			if isElement(bot7[thePlayer]) then destroyElement(bot7[thePlayer]) end
			if isElement(bot8[thePlayer]) then destroyElement(bot8[thePlayer]) end
			if isElement(bot9[thePlayer]) then destroyElement(bot9[thePlayer]) end
				addTextNotification(thePlayer,"* All your Bots have been destroyed!",0,255,0)
		else
				addTextNotification(thePlayer,"Allowed ID's are (1-9 or 'all')!",0,255,0)
		end
	else
		addTextNotification(thePlayer,"Syntax: /ba ID.",255,0,0)
	end
end
end
addCommandHandler("db",force_to_destroy)



addEventHandler( "onPlayerQuit", getRootElement(),
function()		
	if isElement(bot1[source]) then destroyElement(bot1[source]) end
	if isElement(bot2[source]) then destroyElement(bot2[source]) end
	if isElement(bot3[source]) then destroyElement(bot3[source]) end
	if isElement(bot4[source]) then destroyElement(bot4[source]) end
	if isElement(bot5[source]) then destroyElement(bot5[source]) end
	if isElement(bot6[source]) then destroyElement(bot6[source]) end
	if isElement(bot7[source]) then destroyElement(bot7[source]) end
	if isElement(bot8[source]) then destroyElement(bot8[source]) end
	if isElement(bot9[source]) then destroyElement(bot9[source]) end
end
)

function displayStopedRes ( res )	
for _,v in ipairs(getElementsByType("player")) do	
 	if isElement(bot1[v]) then destroyElement(bot1[v]) end
	if isElement(bot2[v]) then destroyElement(bot2[v]) end
	if isElement(bot3[v]) then destroyElement(bot3[v]) end
	if isElement(bot4[v]) then destroyElement(bot4[v]) end
	if isElement(bot5[v]) then destroyElement(bot5[v]) end
	if isElement(bot6[v]) then destroyElement(bot6[v]) end
	if isElement(bot7[v]) then destroyElement(bot7[v]) end
	if isElement(bot8[v]) then destroyElement(bot8[v]) end
	if isElement(bot9[v]) then destroyElement(bot9[v]) end
end
end
addEventHandler ( "onResourceStop", getResourceRootElement(getThisResource()), displayStopedRes )
