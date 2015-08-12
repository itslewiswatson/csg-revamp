addEventHandler("onMarkerHit",root,
function()
	if (isElement(source)) then
		if (getElementData(source,"superman:flying") == true) then
			cancelEvent()
			return false
		else
			return true
		end
	end
	return false
end)