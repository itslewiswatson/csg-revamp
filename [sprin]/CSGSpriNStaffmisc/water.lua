function waterCheat(source)
	if ( getTeamName(getPlayerTeam(source)) == "Staff" ) then
		setWorldSpecialPropertyEnabled("hovercars", not isWorldSpecialPropertyEnabled("hovercars"))
        outputChatBox("driving in water vehicle cheat is " .. (isWorldSpecialPropertyEnabled("hovercars") and "on" or "off") .. ".", 255, 180, 10, false)
	end
end
addCommandHandler("water", waterCheat)