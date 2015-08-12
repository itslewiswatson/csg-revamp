-- Anti compiller
local CSGSecurity = {{{{{ {}, {}, {} }}}}}

local isPlayerMuted = false
local muteTime = nil

-- Event when a player gets muted
addEvent( "onSetPlayerMuted", true )
addEventHandler( "onSetPlayerMuted", root,
	function ( theTime )
		if ( theTime ) then
			if not ( isPlayerMuted ) then
				setTimer ( onCheckPlayerMute, 1000, 1 ) muteTime = theTime isPlayerMuted = true
				exports.DENdxmsg:createNewDxMessage("You are muted for " .. theTime .. " seconds!", 225, 0, 0)
			else
				muteTime = theTime
			end
		end
	end
)

-- Mute check function
function onCheckPlayerMute ()
	if ( muteTime <= 0 ) or not ( isPlayerMuted ) then
		triggerServerEvent( "onAdminUnmutePlayer", localPlayer, localPlayer ) isPlayerMuted = false
		exports.DENdxmsg:createNewDxMessage("You are no longer muted! Behave and read the rules (F1).", 225, 0, 0)
	else
		muteTime = muteTime -1
		setElementData( localPlayer, "muteTimeRemaining", muteTime )
		setTimer ( onCheckPlayerMute, 1000, 1 )
	end
end

-- Event to unmute
addEvent( "onRemovePlayerMute", true )
addEventHandler( "onRemovePlayerMute", root,
	function ()
		isPlayerMuted = false
	end
)