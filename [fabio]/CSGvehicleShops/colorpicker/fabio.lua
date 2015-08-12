function openColorPicker()

	if (selectedVehicle) then
	
		colorPicker.openSelect(colors)
		
	end
	
end

function closeColorPicker()
	
	colorPicker.closeSelect()
	
end

function closedColorPicker()

	local r1, g1, b1, r2, g2, b2 = getVehicleColor(selectedVehicle, true)
	setVehicleColor(selectedVehicle, r1, g1, b1, r2, g2, b2)
	local r, g, b = getVehicleHeadLightColor(selectedVehicle)
	setVehicleHeadLightColor(selectedVehicle, r, g, b)
	colorPicker.closeSelect()
	cpicker = false
	
end

function updateColor()
	if (not colorPicker.isSelectOpen) then return end
	local r, g, b = colorPicker.updateTempColors()
	if (selectedVehicle and isElement(selectedVehicle)) then
		local r1, g1, b1, r2, g2, b2 = getVehicleColor(selectedVehicle, true)
		if (guiCheckBoxGetSelected(checkColor1)) then
			r1, g1, b1 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor2)) then
			r2, g2, b2 = r, g, b
		end
		if (guiCheckBoxGetSelected(checkColor3)) then
			setVehicleHeadLightColor(selectedVehicle, r, g, b)
		end
		setVehicleColor(selectedVehicle, r1, g1, b1, r2, g2, b2)
	end
end
addEventHandler("onClientRender", root, updateColor)