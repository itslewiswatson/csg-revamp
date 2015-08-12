------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithmics/server (server-side)
--  Mics Script
--  [CSG]Smith
------------------------------------------------------------------------------------
function addTextNotification(player,text,r,g,b)
	triggerClientEvent(player,"addTextChat",root,text,r,g,b)
end
