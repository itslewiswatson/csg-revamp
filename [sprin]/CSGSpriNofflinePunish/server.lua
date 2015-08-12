--jail
function jail(thePlayer, cmd, acc, timee, reason)
	if exports.csgstaff:isPlayerStaff(thePlayer) then
		if acc then
			data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username= ?", tostring(acc) )
			if data then
				id = tostring(data.id)
				theStaff = getPlayerName(thePlayer)
				if type(timee) == "string" then
					if type(reason) == "string" then
						if reason == "DM" then
							reason = "#01 - Deathmatching"
						elseif reason == "camp" then
							reason = "#11 - Camping"
						elseif reason == "avoide" then
							reason = "#09 - Avoiding ingame situations"
						elseif reason == "troll" then
							reason = "#17 - Trolling/griefing"
						elseif reason == "abuse" then
							reason = "#02 - Abusing bug(s)"
						else reason = reason end
					
						text = "[OFFLINE-PUNISH] " ..theStaff.. " jailed account name:" ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")"
						exports.DENmysql:exec("INSERT INTO jail (userid,jailtime,jailplace) VALUES (?,?,?)",tostring(id), tostring(timee),"LS1")
						exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?", tostring(id), text )
						exports.CSGlogging:createAdminLogRow (thePlayer,text)
						outputChatBox("You have jailed account name:" ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")", thePlayer, 30, 250, 30)
					else
						outputChatBox("You didn't enter reason", thePlayer, 255, 20, 30)
					end	
				else
					outputChatBox("You didn't enter correct time", thePlayer, 255, 20, 30)
				end	
			else
				outputChatBox("Account name not found", thePlayer, 255, 20, 30)
			end
		end
	end
end	
addCommandHandler("ajail", jail)

--mute
function mute(thePlayer, cmd, acc, timee, reason)
	if exports.csgstaff:isPlayerStaff(thePlayer) then
		if acc then
			data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username= ?", tostring(acc) )
			if data then
				correctName = exports.DENmysql:querySingle( "SELECT * FROM logins WHERE accountname = ?",tostring(acc))
				id = tostring(data.id)
				theStaff = getPlayerName(thePlayer)
				if type(timee) == "string" then
					if type(reason) == "string" then
						if reason == "flam" then
							reason = "#03 - Insulting/flaming"
						elseif reason == "advert" then
							reason = "#05 - Advertising for other servers"
						elseif reason == "sup" then
							reason = "#08 - Support channel misuse"
						elseif reason == "troll" then
							reason = "#17 - Trolling/griefing"
						elseif reason == "spam" then
							reason = "#14 - Spamming/flooding"
						else reason = reason end
						text = "[OFFLINE-PUNISH] " ..theStaff.. " muted account name:" ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")"
						exports.DENmysql:exec("INSERT INTO mutes (userid,mutetime,mutetype) VALUES (?,?,?)",tostring(id), tostring(timee),"Main")
						exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?", tostring(id), text )
						exports.CSGlogging:createAdminLogRow (thePlayer,text)
						outputChatBox("You have muted account name:" ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")", thePlayer, 30, 250, 30)
					else
						outputChatBox("You didn't enter reason", thePlayer, 255, 20, 30)
					end	
				else
					outputChatBox("You didn't enter correct time", thePlayer, 255, 20, 30)
				end	
			else
				outputChatBox("Account name not found", thePlayer, 255, 20, 30)
			end
		end
	end
end	
addCommandHandler("amute", mute)

--global mute
function mutee(thePlayer, cmd, acc, timee, reason)
	if exports.csgstaff:isPlayerStaff(thePlayer) then
		if acc then
			if data then
				data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username= ?", tostring(acc) )
				correctName = exports.DENmysql:querySingle( "SELECT * FROM logins WHERE accountname = ?",tostring(acc))
				id = tostring(data.id)
				theStaff = getPlayerName(thePlayer)
				if type(timee) == "string" then
					if type(reason) == "string" then
						if reason == "flam" then
							reason = "#03 - Insulting/flaming"
						elseif reason == "advert" then
							reason = "#05 - Advertising for other servers"
						elseif reason == "sup" then
							reason = "#08 - Support channel misuse"
						elseif reason == "troll" then
							reason = "#17 - Trolling/griefing"
						elseif reason == "spam" then
							reason = "#14 - Spamming/flooding"
						else reason = reason end
						text = "[OFFLINE-PUNISH] " ..theStaff.. " global muted account name:" ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")"
						exports.DENmysql:exec("INSERT INTO mutes (userid,mutetime,mutetype) VALUES (?,?,?)", tostring(id),tostring(timee),"Global")
						exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?", tostring(id), text )
						exports.CSGlogging:createAdminLogRow (thePlayer,text)
						outputChatBox("You have global muted account name: " ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")", thePlayer, 30, 250, 30)
					else
						outputChatBox("You didn't enter reason", thePlayer, 255, 20, 30)
					end	
				else
					outputChatBox("You didn't enter correct time", thePlayer, 255, 20, 30)
				end	
			else
				outputChatBox("Account name not found", thePlayer, 255, 20, 30)
			end
		end
	end
end	
addCommandHandler("agmute", mutee)

--test
function mutge(thePlayer, cmd, acc, timee, reason)
	if exports.csgstaff:isPlayerStaff(thePlayer) then
		if acc then
			data = exports.DENmysql:querySingle( "SELECT * FROM accounts WHERE username= ?", tostring(acc) )
			if data then
				correctName = exports.DENmysql:querySingle( "SELECT * FROM logins WHERE accountname = ?",tostring(acc))
				id = tostring(data.id)
				theStaff = getPlayerName(thePlayer)
				if type(timee) == "string" then
					if type(reason) == "string" then
						if reason == "flam" then
							reason = "#03 - Insulting/flaming"
						elseif reason == "advert" then
							reason = "#05 - Advertising for other servers"
						elseif reason == "sup" then
							reason = "#08 - Support channel misuse"
						elseif reason == "troll" then
							reason = "#17 - Trolling/griefing"
						elseif reason == "spam" then
							reason = "#14 - Spamming/flooding"
						else reason = reason end
						text = "[OFFLINE-PUNISH] " ..theStaff.. " global muted account name:" ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")"
						--exports.DENmysql:exec("INSERT INTO mutes (userid,mutetime,mutetype) VALUES (?,?,?)", tostring(id),tostring(timee),"Global")
						--exports.DENmysql:exec("INSERT INTO punishlog SET userid=?, punishment=?", tostring(id), text )
						--exports.CSGlogging:createAdminLogRow (thePlayer,text)
						outputChatBox("You have global muted account name: " ..tostring(acc).. " for " ..tostring(timee).. " secs (" ..tostring(reason).. ")", thePlayer, 30, 250, 30)
					else
						outputChatBox("You didn't enter reason", thePlayer, 255, 20, 30)
					end	
				else
					outputChatBox("You didn't enter correct time", thePlayer, 255, 20, 30)
				end	
			else
				outputChatBox("Name not found", thePlayer, 255, 20, 30)
			end
		end
	end
end
addCommandHandler("atest", mutge)

