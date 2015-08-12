function cancelJump()
	if (getElementInterior(localPlayer) == 7) or (getElementInterior(localPlayer) == 4) then
		if (getElementDimension(localPlayer) == 1) or (getElementDimension(localPlayer) == 5) then
			setJumpState(false)
		else
			setJumpState(true)
		end
	else
		setJumpState(true)
	end
end
setTimer(cancelJump,500,0)

function setJumpState(state)
	toggleControl("jump",state)
end