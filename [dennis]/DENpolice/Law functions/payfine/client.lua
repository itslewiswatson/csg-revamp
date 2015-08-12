local fineSpam = {}

addCommandHandler ("payfine",
function ()	
	local wantedPoints = exports.server:getPlayerWantedPoints( localPlayer )
   	local playerMoney = math.random ( 100, 400 )
	if ( fineSpam[localPlayer] ) and ( getTickCount()-fineSpam[localPlayer] < 300000 ) then
	
	elseif ( wantedPoints > 10 ) then
		exports.DENdxmsg:createNewDxMessage( "You can only pay a fine with 10 or less wanted points!", 255, 0, 0 )
	elseif ( getPlayerMoney ( localPlayer ) < playerMoney ) then
		exports.DENdxmsg:createNewDxMessage( "You don't have enough money to pay a fine!", 255, 0, 0 )
	elseif ( getElementData ( localPlayer, "isPlayerArrested" ) ) or ( getElementData ( localPlayer, "isPlayerJailed" ) ) then
		exports.DENdxmsg:createNewDxMessage( "You can't pay a fine while arrested or jailed!", 255, 0, 0 )
	else
		triggerServerEvent ( "onPlayerPayfine", localPlayer, playerMoney ) 
		fineSpam[localPlayer] = getTickCount()
	end
end
)