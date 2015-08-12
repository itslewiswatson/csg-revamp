addEvent("onIRCResourceStart")
addEventHandler("onIRCResourceStart",root,
	function ()
	
		addIRCCommandHandler("!sup",
			function (server,channel,user,command,...)
				local message = table.concat({...}," ")
				if message == "" then ircNotice(user,"syntax is !sup <message>") return end
				
				local ircName = ircGetUserNick(user)
				triggerEvent ( "OnEchoSupportChat", root, ircName, message )
				ircSay(channel,"(SUPPORT)[IRC] "..ircName..": "..message)
			end
		)
		
		addIRCCommandHandler("!occupation",
			function (server,channel,user,command,name)
				if not name then ircNotice(user,"syntax is !occupation <name>") return end
				local player = getPlayerFromPartialName(name)
				if player then
					local occupation = getElementData( player, "Occupation" )
					local rank = getElementData( player, "Rank" )
					local message = table.concat({occupation,rank}," - ")
					if occupation or rank then
						ircSay(channel,getPlayerName(player).."'s occupation info: "..message)
					else
						ircSay(channel,getPlayerName(player).." has no occupation.")
					end
				else
					ircSay(channel,"'"..name.."' no such player")
				end
			end
		)		
		
		addIRCCommandHandler("!group",
			function (server,channel,user,command,name)
				if not name then ircNotice(user,"syntax is !group <name>") return end
				local player = getPlayerFromPartialName(name)
				if player then
					local group = getElementData( player, "Group" )
					if group then
						ircSay(channel,getPlayerName(player).."'s group: "..group)
					else
						ircSay(channel,getPlayerName(player).." has no group.")
					end
				else
					ircSay(channel,"'"..name.."' no such player")
				end
			end
		)			
		
		addIRCCommandHandler("!score",
			function (server,channel,user,command,name)
				if not name then ircNotice(user,"syntax is !score <name>") return end

				local player = getPlayerFromPartialName(name)
				if player then
					local score = getElementData( player, "playerScore" )
					if score then
						ircSay(channel,getPlayerName(player).."'s score: "..score)

					else
						ircSay(channel,getPlayerName(player).." has no score?")

					end
				else
					ircSay(channel,"'"..name.."' no such player")
				end
			end
		)		
		
		addIRCCommandHandler("!hours",
			function (server,channel,user,command,name)
				if not name then ircNotice(user,"syntax is !hours <name>") return end

				local player = getPlayerFromPartialName(name)
				if player then
					local hours = getElementData( player, "playTime" )
					if hours and hours/60 >= 1 then
						ircSay(channel,getPlayerName(player).." has "..math.floor((hours/60)-0.5).." hours.")

					else
						ircSay(channel,getPlayerName(player).." has no hours.")

					end
				else
					ircSay(channel,"'"..name.."' no such player")
				end
			end
		)

		addIRCCommandHandler("!staff",
			function (server,channel,user,command,arg)
				local admins = {}
				if getResourceState(getResourceFromName("CSGstaff")) == "running" then
					admins = exports.CSGstaff:getOnlineAdmins() or {}
				end
				if #admins > 0 then
					for i=1,#admins do
						admins[i] = getPlayerName(admins[i])
					end
					ircSay(channel,"Online staff: "..table.concat(admins,", "))
				else
					ircSay(channel,"No staff currently online!")
				end
			end
		)
	end
)