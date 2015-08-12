------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGjobcmds/server (server-side)
--  Job Commands Script
--  [CSG]Smith
------------------------------------------------------------------------------------

------------ Mf allowed accounts ------------
local mfPermission1 = "gusolina"
local mfPermission2 = "spirit"
local mfPermission3 = "vi-docks"
local mfPermission4 = "hashytk"

------------ FBI allowed accounts ------------
local fbiPermission1 = "gusolina"

------------ SWAT allowed accounts -----------
local swatPermission2 = "gusolina"
local swatPermission6 = "maxil1"
local swatPermission7 = "matrix95"
local swatPermission8 = "abdogangs"
local swatPermission9 = "darkmoon99"


------------ SWAT rabbit accounts -----------
local swatrPermission2 = "gusolina"
-----------------------------------------------
-----------------------------------------------

function getPlayerFromParticalName(thePlayerName)
	local thePlayer = getPlayerFromName(thePlayerName)
	if thePlayer then
		return thePlayer
	end
	for _,thePlayer in ipairs(getElementsByType("player")) do
		if string.find(string.gsub(getPlayerName(thePlayer):lower(),"#%x%x%x%x%x%x", ""), thePlayerName:lower(), 1, true) then
			return thePlayer
		end
	end
	return false
end


function setSwatRabbitJob(thePlayer,cmd,target, ...)
	local account = exports.server:getPlayerAccountName(thePlayer)
	if ((account == swatrPermission1) or (account == swatrPermission2) or (account==swatrPermission3)) then
		if (getPlayerWantedLevel(thePlayer) <= 3) then
			local occupation = table.concat( {...}, " " )
			if target then
				if (string.len(target) >= 3) then
					chosenPlayer = getPlayerFromParticalName(target)
					if chosenPlayer then
						setPlayerTeam ( chosenPlayer, getTeamFromName("SWAT") )
						setElementModel ( chosenPlayer, 229 )
						setElementData( chosenPlayer, "Rank", occupation, true )
						setTimer (giveWeapon, 1500, 1, chosenPlayer, 3, 1, false)
						outputChatBox ("Successful !",thePlayer,0,255,0)
						local playerID = exports.server:getPlayerAccountID( chosenPlayer )
						local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", 183, playerID)
						outputChatBox (getPlayerName(thePlayer).." has thrust you into SWAT as [ " ..  occupation.." ]!",chosenPlayer,20,20,200)
					else
						outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
					end
				else
					outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
				end
			else
				outputChatBox ("Syntax is /setswatjob <PlayerName> <Rank> ! ",thePlayer ,255,0,0)
			end
		else
			outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
		end
	end
end
addCommandHandler("setrabbitjob",setSwatRabbitJob)

function setSwatGirlJob(thePlayer,cmd,target, ...)
 local account = exports.server:getPlayerAccountName(thePlayer)
 if ((account == swatrPermission1) or (account == swatrPermission2)) then
  if (getPlayerWantedLevel(thePlayer) <= 3) then
   local occupation = table.concat( {...}, " " )
   if target then
    if (string.len(target) >= 3) then
     chosenPlayer = getPlayerFromParticalName(target)
     if chosenPlayer then
      setPlayerTeam ( chosenPlayer, getTeamFromName("SWAT") )
      setElementModel ( chosenPlayer, 93 )
      setElementData( chosenPlayer, "Rank", occupation, true )
      setTimer (giveWeapon, 1500, 1, chosenPlayer, 3, 1, false)
      outputChatBox ("Successful !",thePlayer,0,255,0)
      local playerID = exports.server:getPlayerAccountID( chosenPlayer )
      local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", 93, playerID)
      outputChatBox (getPlayerName(thePlayer).." has thrust you into SWAT as [ " ..  occupation.." ]!",chosenPlayer,20,20,200)
     else
      outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
     end
    else
     outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
    end
   else
    outputChatBox ("Syntax is /setswatjob <PlayerName> <Rank> ! ",thePlayer ,255,0,0)
   end
  else
   outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
  end
 end
end
addCommandHandler("setlilyajob",setSwatGirlJob)

------------------------------------------------------------
---------------------- MF Command Job ----------------------
------------------------------------------------------------
function setMilitaryJob(thePlayer,cmd,target, ...)
	local account = exports.server:getPlayerAccountName(thePlayer)
	if ((account == mfPermission1) or (account == mfPermission2) or (account == mfPermission3) or (account == mfPermission4) or (account == mfPermission5) or (account == mfPermission6) or (account == mfPermission7) or (account == mfPermission8)) then
		if (getPlayerWantedLevel(thePlayer) <= 3) then
			local occupation = table.concat( {...}, " " )
			if target then
				if (string.len(target) >= 3) then
					chosenPlayer = getPlayerFromParticalName(target)
					if chosenPlayer then
						setPlayerTeam ( chosenPlayer, getTeamFromName("Military Forces") )
						setElementModel ( chosenPlayer, 97 )
						setElementData( chosenPlayer, "Rank", occupation, true )
						setTimer (giveWeapon, 1500, 1, chosenPlayer, 3, 1, false)
						outputChatBox ("Successful !",thePlayer,0,255,0)
						local playerID = exports.server:getPlayerAccountID( chosenPlayer )
						local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", 97, playerID)
						outputChatBox (getPlayerName(thePlayer).." has thrust you into Military Forces as [ " ..  occupation.." ]!",chosenPlayer,0,200,0)
					else
						outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
					end
				else
					outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
				end
			else
				outputChatBox ("Syntax is /setmfjob <PlayerName> <Rank> ! ",thePlayer ,255,0,0)
			end
		else
			outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
		end
	end
end
addCommandHandler("setmfjob",setMilitaryJob)

function revMilitaryJob(thePlayer,cmd,target)
	local account = exports.server:getPlayerAccountName(thePlayer)
	if ((account == mfPermission1) or (account == mfPermission2) or (account == mfPermission3) or (account == mfPermission4) or (account == mfPermission5) or (account == mfPermission6) or (account == mfPermission7)) then
		if (getPlayerWantedLevel(thePlayer) <= 3) then
			if target then
				if (string.len(target) >= 3) then
					chosenPlayer = getPlayerFromParticalName(target)
					if chosenPlayer then
						if (getTeamName(getPlayerTeam(chosenPlayer)) == "Military Forces") then
							local thePlyerSkinID = exports.csgaccounts:getElementModel(chosenPlayer)
							setPlayerTeam ( chosenPlayer, getTeamFromName("Unemployed") )
							setElementModel ( chosenPlayer, tonumber(thePlyerSkinID) )
							setElementData( chosenPlayer, "Rank", "Unemployed", true )
							outputChatBox ("Successful!",thePlayer,0,255,0)
							outputChatBox (getPlayerName(thePlayer).." has removed you from 'Military Forces' Job!",chosenPlayer,200,20,20)
						else
							outputChatBox ("You're not allowed to remove the player who is not in 'Military Forces' team!",thePlayer ,255,0,0)
						end
					else
						outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
					end
				else
					outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
				end
			else
				outputChatBox ("Syntax is /revmfjob <PlayerName> ! ",thePlayer ,255,0,0)
			end
		else
			outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
		end
	end
end
addCommandHandler("revmfjob",revMilitaryJob)



------------------------------------------------------------
--------------------- SWAT Command Job ---------------------
------------------------------------------------------------
function setSwatJob(thePlayer,cmd,target, ...)
	local account = exports.server:getPlayerAccountName(thePlayer)
	if ((account == swatPermission1) or (account == swatPermission2) or (account == swatPermission3) or (account == swatPermission4) or (account == swatPermission5) or (account == swatPermission6) or (account == swatPermission7)) then
		if (getPlayerWantedLevel(thePlayer) <= 3) then
			local occupation = table.concat( {...}, " " )
			if target then
				if (string.len(target) >= 3) then
					chosenPlayer = getPlayerFromParticalName(target)
					if chosenPlayer then
						setPlayerTeam ( chosenPlayer, getTeamFromName("SWAT") )
						setElementModel ( chosenPlayer, 285 )
						setElementData( chosenPlayer, "Rank", occupation, true )
						setTimer (giveWeapon, 1500, 1, chosenPlayer, 3, 1, false)
						outputChatBox ("Successful !",thePlayer,0,255,0)
						local playerID = exports.server:getPlayerAccountID( chosenPlayer )
						local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", 285, playerID)
						outputChatBox (getPlayerName(thePlayer).." has thrust you into SWAT as [ " ..  occupation.." ]!",chosenPlayer,20,20,200)
					else
						outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
					end
				else
					outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
				end
			else
				outputChatBox ("Syntax is /setswatjob <PlayerName> <Rank> ! ",thePlayer ,255,0,0)
			end
		else
			outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
		end
	end
end
addCommandHandler("setswatjob",setSwatJob)

function revSwatJob(thePlayer,cmd,target)
	local account = exports.server:getPlayerAccountName(thePlayer)
	if ((account == swatPermission1) or (account == swatPermission2) or (account == swatPermission3) or (account == swatPermission4) or (account == swatPermission5) or (account == swatPermission6) or (account == swatPermission7)) then
	if (getPlayerWantedLevel(thePlayer) <= 3) then
			if target then
				if (string.len(target) >= 3) then
					chosenPlayer = getPlayerFromParticalName(target)
					if chosenPlayer then
						if (getTeamName(getPlayerTeam(chosenPlayer)) == "SWAT") then
							local thePlyerSkinID = exports.csgaccounts:getElementModel(chosenPlayer)
							setPlayerTeam ( chosenPlayer, getTeamFromName("Unemployed") )
							setElementModel ( chosenPlayer, tonumber(thePlyerSkinID) )
							setElementData( chosenPlayer, "Rank", "Unemployed", true )
							outputChatBox ("Successful!",thePlayer,0,255,0)
							outputChatBox (getPlayerName(thePlayer).." has removed you from 'SWAT' Job!",chosenPlayer,200,20,20)
						else
							outputChatBox ("You're not allowed to remove the player who is not in 'SWAT' team!",thePlayer ,255,0,0)
						end
					else
						outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
					end
				else
					outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
				end
			else
				outputChatBox ("Syntax is /revswatjob <PlayerName> ! ",thePlayer ,255,0,0)
			end
		else
			outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
		end
	end
end
addCommandHandler("revswatjob",revSwatJob)



------------------------------------------------------------
--------------------- FBI Command Job ----------------------
------------------------------------------------------------
function setFbiJob(thePlayer,cmd,target, ...)
	local account = exports.server:getPlayerAccountName(thePlayer)
	if ((account == fbiPermission1) or (account == fbiPermission2) or (account == fbiPermission3) or (account == fbiPermission4) or (account == fbiPermission5)) then
		if (getPlayerWantedLevel(thePlayer) <= 3) then
			local occupation = table.concat( {...}, " " )
			if target then
				if (string.len(target) >= 3) then
					chosenPlayer = getPlayerFromParticalName(target)
					if chosenPlayer then
						setPlayerTeam ( chosenPlayer, getTeamFromName("Government Agency") )
						setElementModel ( chosenPlayer, 51 )
						triggerClientEvent(chosenPlayer,"reloadFreeVehicleMarkers",chosenPlayer)
						setElementData( chosenPlayer, "Rank", occupation, true )
						setTimer (giveWeapon, 1500, 1, chosenPlayer, 3, 1, false)
						outputChatBox ("Successful !",thePlayer,0,255,0)
						local playerID = exports.server:getPlayerAccountID( chosenPlayer )
						local updateDatabase = exports.DENmysql:exec( "UPDATE accounts SET jobskin=? WHERE id=?", 51, playerID)
						outputChatBox (getPlayerName(thePlayer).." has thrust you into Government Agency as [ " ..  occupation.." ]!",chosenPlayer,200,200,200)
					else
						outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
					end
				else
					outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
				end
			else
				outputChatBox ("Syntax is /setfbijob <PlayerName> <Rank> ! ",thePlayer ,255,0,0)
			end
		else
			outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
		end
	end
end
addCommandHandler("setfbijob",setFbiJob)

function revFbiJob(thePlayer,cmd,target)
	local account = exports.server:getPlayerAccountName(thePlayer)
	if ((account == fbiPermission1) or (account == fbiPermission2) or (account == fbiPermission3) or (account == fbiPermission4) or (account == fbiPermission5)) then
		if (getPlayerWantedLevel(thePlayer) <= 3) then
			if target then
				if (string.len(target) >= 3) then
					chosenPlayer = getPlayerFromParticalName(target)
					if chosenPlayer then
						if (getTeamName(getPlayerTeam(chosenPlayer)) == "Government Agency") then
							local thePlyerSkinID = exports.csgaccounts:getElementModel(chosenPlayer)
							setPlayerTeam ( chosenPlayer, getTeamFromName("Unemployed") )
							setElementModel ( chosenPlayer, tonumber(thePlyerSkinID) )
							setElementData( chosenPlayer, "Rank", "Unemployed", true )
							outputChatBox ("Successful!",thePlayer,0,255,0)
							outputChatBox (getPlayerName(thePlayer).." has removed you from 'Government Agency' Job!",chosenPlayer,200,20,20)
						else
							outputChatBox ("You're not allowed to remove the player who is not in 'Government Agency' team",thePlayer ,255,0,0)
						end
					else
						outputChatBox ("Player with name ( "..target.." ) does not Exist !",thePlayer,255,0,0)
					end
				else
					outputChatBox ("You have to type more than 3 words of PlayerName!",thePlayer ,255,0,0)
				end
			else
				outputChatBox ("Syntax is /revfbijob <PlayerName> ! ",thePlayer ,255,0,0)
			end
		else
			outputChatBox ("You can not use this command while you have more than 3 stars!",thePlayer ,255,0,0)
		end
	end
end
addCommandHandler("revfbijob",revFbiJob)
------------------------------------------------------------
