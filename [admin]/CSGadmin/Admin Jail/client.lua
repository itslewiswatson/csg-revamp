-- Anti compiller
local CSGSecurity = {{{{{ {}, {}, {} }}}}}

local scx, scy = guiGetScreenSize()
local isPlayerJailed = false
local jailTime = nil

-- Event when a player gets jailed
addEvent( "onSetPlayerJailed", true )
addEventHandler( "onSetPlayerJailed", root,
	function ( theTime )
		if ( theTime ) then
			if not ( isPlayerJailed ) then
				setTimer ( onCheckPlayerJail, 1000, 1 ) jailTime = theTime isPlayerJailed = true
				exports.DENdxmsg:createNewDxMessage("You are jailed for " .. theTime .. " seconds!", 225, 0, 0)
				setElementData(localPlayer,"isPlayerJailed",true,true)
				triggerServerEvent("onPlayerJailed",localPlayer,theTime)
				isPlayerJailed=true
			else
				jailTime = theTime
			end
		end
	end
)

-- Jail check function
function onCheckPlayerJail ()
	if ( jailTime <= 0 ) or not ( isPlayerJailed ) then
		triggerServerEvent("onAdminUnjailPlayer", localPlayer, localPlayer )
		isPlayerJailed = false
		exports.DENdxmsg:createNewDxMessage("You are released from the jail!", 225, 0, 0)
		triggerServerEvent("onPlayerJailReleased",localPlayer)

	else
		jailTime = jailTime -1
		setElementData( localPlayer, "jailTimeRemaining", jailTime )
		setTimer ( onCheckPlayerJail, 1000, 1 )
	end
end

-- Event to unjail
addEvent( "onRemovePlayerJail", true )
addEventHandler( "onRemovePlayerJail", root,
	function ()
		isPlayerJailed = false
	end
)

-- Jail timer
addEventHandler( "onClientRender", root,
	function ()
		if ( isPlayerJailed ) then
			dxDrawText( getElementData( localPlayer, "jailTimeRemaining" ) .. " Seconds Remaining  ", scx - 125,scy - 70,scx,scx,tocolor(255,255,255,255),0.9, "bankgothic","right","top",false,false,false )

		end
	end
)

setTimer(function()
	if isPlayerJailed == false then
		local jx,jy,jz = getElementPosition(localPlayer)
		local jx2,jy2,jz2 = 1561.75, -822.47, 350.84
		local jailDim = getElementDimension(localPlayer)
		if jailDim == 2 then
			if getDistanceBetweenPoints3D(jx,jy,jz,jx2,jy2,jz2) < 100 then
				triggerServerEvent("onAdminUnjailPlayer", localPlayer, localPlayer )
				isPlayerJailed = false
				exports.DENdxmsg:createNewDxMessage("You are released from the jail!", 225, 0, 0)
				triggerServerEvent("onPlayerJailReleased",localPlayer)
				setElementData(localPlayer,"jailTimeRemaining",0,true)
				return
			end
		end
	end
	if getElementData(localPlayer,"jailTimeRemaining") == false then setElementData(localPlayer,"jailTimeRemaining",0,true) end
		if isPlayerJailed == false and getElementData(localPlayer,"jailTimeRemaining") > 0 then
			triggerServerEvent("onAdminUnjailPlayer", localPlayer, localPlayer )
			isPlayerJailed = false
			exports.DENdxmsg:createNewDxMessage("You are released from the jail!", 225, 0, 0)
			triggerServerEvent("onPlayerJailReleased",localPlayer)

			setElementData(localPlayer,"jailTimeRemaining",0,true)
		end
end,1000,0)
