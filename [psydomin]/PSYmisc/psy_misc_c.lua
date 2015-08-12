function wantedpoints()
local wantedPoints = exports.server:getPlayerWantedPoints()
	if wantedPoints and wantedPoints >= 10 then 
		exports.DENdxmsg:createNewDxMessage( "You have".. wantedpoints.."wanted points!", 231, 0, 0)
	elseif wantedPoints and wantedPoints == 0 then
		exports.DENdxmsg:createNewDxMessage("You are not wanted.", 0, 217, 0)
	elseif wantedpoints and wantedpoints < 10 then
		exports.DENdxmsg:createNewDxMessage( "You have".. wantedpoints.."wanted points!",255, 215,0 )
	end
end
addCommandHandler("wantedpoints", wantedpoints)
-----------------------------------------------------------
