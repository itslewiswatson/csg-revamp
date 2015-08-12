
function checkWep(ps,_,arg1)
	if getTeamName(getPlayerTeam(ps)) ~= "Staff" then return end
	if arg1 == nil then return end
	if arg1 == "" then return end
	if type(tostring(arg1)) ~= "string" then return end
	local p = exports.server:getPlayerFromNamePart(arg1)
	if isElement(p) then
		local str = exports.csgaccounts:getPlayerWeaponString(p)
		local t = fromJSON(str)
		outputChatBox("--------"..getPlayerName(p).."'s current weapons--------",ps,0,255,0)
		for k,v in pairs(t) do
			if v > 0 then
				outputChatBox(""..getWeaponNameFromID(k).." ("..v.." Ammo)",ps,255,255,0)
			end
		end
		outputChatBox("----------------Done Loading All Weapons----------------",ps,0,255,0)
	else
		exports.dendxmsg:createNewDxMessage(ps,"No player with name "..arg1.." found",255,255,0)
	end
end
addCommandHandler("viewwep",checkWep)
