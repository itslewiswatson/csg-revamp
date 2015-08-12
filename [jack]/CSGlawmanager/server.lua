--ACCOUNT RESTRICTION--

--MILITARY FORCES--
local mfAccess = {
	{"smith"},
	{"demo"},
	{"swat10"},
	{"priyen"},
	{"dustin"},
	{"mashcof"},
	{"soap"},
}

--FBI--
local fbiAccess = {
	{"smith"},
	{"maxcamelot"},
	{"sensei"},
	{"priyen"},
	{"fiveseven"},
}

--SWAT--
local swatAccess = {
	{"smith"},
	{"gusolina"},
	{"abdogangs"},
	{"darkmoon99"},
	{"priyen"},
	{"maxil1"},
	{"matrix95"},
}
--END OF ACCOUNT RESTRICTION--

--OCCUPATION RESTRICTIONS--
local occupations = {
	{"Supporter"},
	{"Trial Staff"},
	{"New Staff"},
	{"Loyal Staff"},
	{"Experienced Staff"},
	{"Important Staff"},
	{"Leading Staff"},
}
--END OF OCCUPATION RESTRICTIONS--

--SWITCH HANDLER--
local handler = {}
--END OF SWITCH HANDLER--

function _getPlayerFromPartName(playerName)
	local player = getPlayerFromPartName(playerName)
	if (player) then
		return player
	end
	for _,player in ipairs(getElementsByType("player")) do
		if string.find(string.gsub(getPlayerName(player):lower(),"#%x%x%x%x%x%x",""), playerName:lower(), 1, true) then
			return player
		end
	end
	return false
end

function setLawJob(player,cmd,target,...)
	local cmdUsed --define which command was used (setswatjob, etc..)
	local account = exports.server:getPlayerAccountName(player) --define account name
	local table --define the table to grab accounts from that specific table.
	local access --define the access
	
	if (cmd == "setswatjob") then
		table = swatAccess
		cmdUsed = cmd
	elseif (cmd == "setmfjob") then
		table = mfAccess
		cmdUsed = cmd
	elseif (cmd == "setfbijob") then
		table = fbiAccess
		cmdUsed = cmd
	else
		return --something fucked up.
	end
	
	if (table) then
		--check for account in the table see if he has access
		for k,v in ipairs(table) do
			if (account:lower() == v:lower()) then --make sure we have access
				access = true --grant him access
				break
			else
				access = false --no access for u!
				--break
			end
		end
	end
	
	if (access == true) then
		local target = _getPlayerFromPartName(target)
		if (target) then
			if (getPlayerWantedLevel(target) >= 4) then
				outputChatBox("You cannot set this player due to him being highly wanted!",player,255,0,0)
				return false
			end
			--Check for the restricted occupation
			continue = true
			local occupation == table.concat({...}, " ") --split the ... arg
			for k,v in ipairs(occupations) do
				if (occupation:lower() == v:lower()) then --string lower everything for easy access
					outputChatBox("You cannot use this occupation!",player,255,0,0)
					continue = false --stop the resource after the loop
					break
				end
			end
			
			if (continue ~= false) then
				--Now that all the checks was done, set that target!
				if (cmdUsed == "setswatjob") then --swat
					team = getTeamFromName("SWAT")
					model = 229
				elseif (cmdUsed == "setmfjob") then --military forces
					team = getTeamFromName("Military Forces")
					model = 97
				elseif (cmdUsed == "setfbijob") then --swat
					team = getTeamFromName("Government Agency")
					model = 51
				else
					return false --Unknown command
				end
				
				setPlayerTeam(target,team)
				setElementModel(target,model)
				setElementData(target,"Occupation",occupation,true)
				setElementData(target,"Rank",occupation,true)
				setTimer(giveWeapon,1500,1,target,3,1,false)
				outputChatBox(getPlayerName(target).." was set to "..occupation,player,0,255,0)
				local id = exports.server:getPlayerAccountID(target)
				exports.DENmysql:exec("UPDATE accounts SET jobskin=? WHERE id=?",model,id)
				handler[target] = true --define this for easy removal later.
			end
		else
			outputChatBox("Player "..target.." not found!",player,255,0,0)
			return
		end
	else
		return false --player doesn't have access
	end
end
addCommandHandler("setswatjob",setLawJob)
addCommandHandler("setfbijob",setLawJob)
addCommandHandler("setmfjob",setLawJob)

function removeLawJob(player,cmd,target,...)
	local cmdUsed
	local account = exports.server:getPlayerAccountName(player)
	local table
	local access
	
	if (cmd == "revswatjob") then
		table = swatAccess
		cmdUsed = cmd
	elseif (cmd == "revmfjob") then
		table = mfAccess
		cmdUsed = cmd
	elseif (cmd == "revfbijob") then
		table = fbiAccess
		cmdUsed = cmd
	else
		return
	end
	
	if (table) then
		for k,v in ipairs(table) do
			if (account:lower() == v:lower()) then
				access = true
				break
			else
				access = false
			end