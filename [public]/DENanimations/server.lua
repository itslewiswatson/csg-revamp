function setAnimation(animationBlock,animationID)
	if not (getElementData(p,"tazed") == true) then
		setPedAnimation(source,animationBlock,animationID)
	else
		outputChatBox("You are not allowed to stop animations while tazed!",source,255,0,0)
	end
end
addEvent("setAnimation",true)
addEventHandler ("setAnimation",getRootElement(),setAnimation)