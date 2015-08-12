
function cleanupOldGame (source)
	local staff = exports.CSGstaff:isPlayerStaff(source)
    if ( staff ) then
	outputDebugString(tostring(staff))

	stopResource(getResourceFromName("CSGFallout"))
	startResource(getResourceFromName("CSGFallout"))
	outputChatBox("Boards Removed", source, 255, 0, 0)
--	winnerCount = 0 --Reset tournament winners each newGame if no tourney winner
--	count = 1
--	for i = 1,rows do
--	for j = 1, columns do
 --   count = count + 1
  --  if isElement(board[count]) then destroyElement(board[count])-
--	end
--	end
--	end
--gameTimers = getTimers ()
--for timerKey, timerNameData in ipairs(gameTimers) do
 --  	killTimer ( timerNameData )
  --  end
--	winnersList = nil

end
end

addCommandHandler("rfo", cleanupOldGame)
