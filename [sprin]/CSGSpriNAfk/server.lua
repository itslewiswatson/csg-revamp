--[[*************************************************************************
*       |-----------------------------------------------|
* |-------   Multi Theft Auto - AFK system By SpriN'  --------|
*       |-----------------------------------------------|
***************************************************************************]]
addEventHandler("onPlayerLogin",getRootElement(),
function ()
if (getAccountData(getPlayerAccount(source),"afk_state") == "afk") then
	setElementData(source,"afk_state","afk")
	nm = getAccountData(getPlayerAccount(source), "namee")
	intt = getAccountData(getPlayerAccount(source), "intt")
	dim = getAccountData(getPlayerAccount(source), "dim")
	setElementData(source, "namee", nm)
	setElementData(source, "intt",intt)
	setElementData(source, "dim",	dim)
else
	setElementData(source,"afk_state","back")
end
end)

addEventHandler("onPlayerQuit",getRootElement(),
function ()
if (getElementData(source,"afk_state") == "afk") then
	setAccountData(getPlayerAccount(source),"afk_state","afk")
	nm = getElementData(source, "namee")
	intt = getElementData(source, "intt")
	dim = getElementData(source, "dim")
	setAccountData(getPlayerAccount(source), "namee", nm)
	setAccountData(getPlayerAccount(source), "intt",intt)
	setAccountData(getPlayerAccount(source), "dim",	dim)
else
	setAccountData(getPlayerAccount(source),"afk_state","back")
end
end)

 
addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()),
function ()
for i,v in pairs (getElementsByType("player")) do
setElementData(v,"afk_state","back")
setAccountData(getPlayerAccount(v),"afk_state","back")
end
end)

setTimer(function ()
	for k,thePlayer in pairs(getElementsByType("player")) do
		if (getElementData(thePlayer,"afk_state") == "afk") then
			if (exports.server:getPlayerWantedPoints(thePlayer) >= 10) then return end
			if (getTeamName(getPlayerTeam(thePlayer)) == "Staff") then return end
			if (getElementData(thePlayer,"afk_state") ~= "afk") then return end
			outputChatBox("type /back to back to main dimension", thePlayer, 10,50,200)
		end
	end
end,30000,0)
	
setTimer(function ()
	for k,thePlayer in pairs(getElementsByType("player")) do
		if (exports.server:getPlayerWantedPoints(thePlayer) >= 10) then return end
		if (getTeamName(getPlayerTeam(thePlayer)) == "Staff") then return end
		if (getElementData(thePlayer,"afk_state") == "back") and (getPlayerIdleTime(thePlayer) > 300000) then
			outputChatBox("type /back to back to main dimension", thePlayer, 10,50,200)
			setElementData(thePlayer, "namee", getPlayerName (thePlayer))
			setElementData(thePlayer, "intt", getElementInterior (thePlayer))
			setElementData(thePlayer, "dim", getElementDimension (thePlayer))
			setElementDimension (thePlayer, 111)
			setPedFrozen(thePlayer,true)
			setPlayerName(thePlayer,  getPlayerName (thePlayer).. "|AFK")
			setElementData(thePlayer,"afk_state","afk")
			if getPedOccupiedVehicle(thePlayer) then
				setVehicleFrozen(getPedOccupiedVehicle(thePlayer),true)
			end
		end
	end
end,3000,0)

addCommandHandler( "back", function(thePlayer)
	if (getElementData(thePlayer,"afk_state") == "afk") then
		setElementData(thePlayer,"afk_state","back")
        setPedFrozen(thePlayer,false)
		nm = getElementData(thePlayer, "namee")
		intt = getElementData(thePlayer, "intt")
		dim = getElementData(thePlayer, "dim")
        setPlayerName (thePlayer, nm)
		setElementInterior(thePlayer, intt)
		setElementDimension(thePlayer, dim)
        if getPedOccupiedVehicle(thePlayer) then
            setVehicleFrozen(getPedOccupiedVehicle(thePlayer),false)
		end
	end
end)