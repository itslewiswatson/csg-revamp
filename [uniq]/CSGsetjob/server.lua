addEvent ("changeJob", true)
function changeJob (thePlayer, occupation, team, skin)
	if ( thePlayer ) and ( occupation ) and ( team ) and ( skin ) then
		setPlayerTeam ( thePlayer, getTeamFromName(team) )
		setElementModel ( thePlayer, skin )
		setElementData( thePlayer, "Occupation", occupation, true )
		setElementData( thePlayer, "Rank", occupation, true )
	end
end
addEventHandler ( "changeJob", root, changeJob )