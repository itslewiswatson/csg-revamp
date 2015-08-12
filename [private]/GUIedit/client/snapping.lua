--[[--------------------------------------------------
	GUI Editor
	client
	snapping.lua
	
	manages element snapping while being moved
--]]--------------------------------------------------


Snapping = {
	active = Settings.default.snapping.value,
	precision = Settings.default.snapping_precision.value,
	offset = Settings.default.snapping_recommended.value,
	influence = Settings.default.snapping_influence.value,

	colour = tocolor(unpack(gColours.secondary)),
	lineWidth = 1,	

	updateValues = 
		function()
			Snapping.active = Settings.loaded.snapping.value
			Snapping.precision = Settings.loaded.snapping_precision.value
			Snapping.offset = Settings.loaded.snapping_recommended.value
			Snapping.influence = Settings.loaded.snapping_influence.value		
		end
}


addEventHandler("onClientPreRender", root,
	function()
		if not gEnabled then
			return
		end
	
		if Snapping.active and Mover.state == "down" and not getKeyState("lalt") then
			for _,item in ipairs(Mover.items) do
				local eX, eY = guiGetPosition(item.element, false)
				local eW, eH = guiGetSize(item.element, false)
				
				local x, y = eX, eY
				local parent = guiGetParent(item.element)
				
				--[[--------------------------------------------------
					-1 when negative to account for an mta bug
					
					negative coords are returned by guiGetPosition as +1 from what they are set as in guiSetPosition
					ie: guiSetPosition(e, -10, -10, false) gives -9, -9 from guiGetPosition(e, false)
				--]]--------------------------------------------------
				if x < 0 then
					x = x - 1
				end
				
				if y < 0 then
					y = y - 1
				end				
				
				
				local siblings = guiGetSiblings(item.element)	
				local distances = {}
				
				for _,sibling in ipairs(siblings) do
					distances[sibling] = Snapping.getDistance(item.element, sibling)
				end				
				
				table.sort(siblings, 
					function(a, b) 
						if item.element == a then return 99999 end 
						--return Snapping.getDistance(item.element, a) < Snapping.getDistance(item.element, b) 
						return distances[a] < distances[b]
					end
				)
				
				local breakpoint = (#siblings > 2 and ( 2 + math.floor((#siblings * 0.2) + 0.5)) or #siblings)
				
				for i,sibling in ipairs(siblings) do
					if i > breakpoint then
						break
					end
					
					if distances[sibling] > (Snapping.influence * Snapping.influence) then
						break
					end
					
					if sibling ~= item.element and relevant(sibling) then
						local sX, sY = guiGetPosition(sibling, false)
						local sW, sH = guiGetSize(sibling, false)
						
						x, y = Snapping.calculateSnaps(x, y, eX, eY, eW, eH, sX, sY, sW, sH, nil, parent)
						x, y = Snapping.calculateSnaps(x, y, eX, eY, eW, eH, sX, sY, sW, sH, Snapping.offset, parent)
						x, y = Snapping.calculateSnaps(x, y, eX, eY, eW, eH, sX, sY, sW, sH, -Snapping.offset, parent)
					end
				end
				
				local pW, pH = gScreen.x, gScreen.y
				
				if parent then
					pW, pH = guiGetSize(guiGetParent(item.element), false)
				end
				
				x, y = Snapping.calculateSnaps(x, y, eX, eY, eW, eH, 0, 0, pW, pH, nil, parent)
				x, y = Snapping.calculateSnaps(x, y, eX, eY, eW, eH, 0, 0, pW, pH, -Snapping.offset, parent)				

				guiSetPosition(item.element, x, y, false)
			end
		end
	end
)


function Snapping.calculateSnaps(x, y, eX, eY, eW, eH, sX, sY, sW, sH, offset, parent)
	local originals = {sX = sX, sY = sY, sW = sW, sH = sH, sW2 = sW / 2, sH2 = sH / 2}
	
	if offset then
		sW = sW + (offset * 2)
		sH = sH + (offset * 2)
		sX = sX - offset
		sY = sY - offset
	end
	
	local sH2, sW2 = originals.sH / 2, originals.sW / 2
	local eH2, eW2 = eH / 2, eW / 2

	local pX, pY = 0, 0
	if parent then
		pX, pY = guiGetAbsolutePosition(parent)
	end
	
	-- sibling / item
						
	-- left / left
	if math.abs(eX - sX) <= Snapping.precision then
		x = sX

		if offset then			
			dxDrawLine(pX + originals.sX, pY + math.min(eY + eH2, originals.sY + originals.sH2), pX + originals.sX, pY + math.max(eY + eH2, originals.sY + originals.sH2), Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + originals.sX, pY + eY + eH2, pX + sX, pY + eY + eH2, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + sX, pY + math.min(eY + eH2, sY + sH2), pX + sX, pY + math.max(eY + eH2, sY + sH2), Snapping.colour, Snapping.lineWidth, true)
		end
	-- left / right
	elseif math.abs((eX + eW) - sX) <= Snapping.precision then
		x = sX - eW
		
		if offset then			
			dxDrawLine(pX + originals.sX, pY + math.min(eY + eH2, originals.sY + originals.sH2), pX + originals.sX, pY + math.max(eY + eH2, originals.sY + originals.sH2), Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + originals.sX, pY + eY + eH2, pX + sX, pY + eY + eH2, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + sX, pY + math.min(eY + eH2, sY + sH2), pX + sX, pY + math.max(eY + eH2, sY + sH2), Snapping.colour, Snapping.lineWidth, true)
		end	
	-- right / right
	elseif math.abs((eX + eW) - (sX + sW)) <= Snapping.precision then
		x = sX + sW - eW
		
		if offset then			
			dxDrawLine(pX + originals.sX + originals.sW, pY + math.min(eY + eH2, originals.sY + originals.sH2), pX + originals.sX + originals.sW, pY + math.max(eY + eH2, originals.sY + originals.sH2), Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + originals.sX + originals.sW, pY + eY + eH2, pX + sX + sW, pY + eY + eH2, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + sX + sW, pY + math.min(eY + eH2, sY + sH2), pX + sX + sW, pY + math.max(eY + eH2, sY + sH2), Snapping.colour, Snapping.lineWidth, true)
		end		
	-- right / left
	elseif math.abs(eX - (sX + sW)) <= Snapping.precision then
		x = sX + sW
		
		if offset then			
			dxDrawLine(pX + originals.sX + originals.sW, pY + math.min(eY + eH2, originals.sY + originals.sH2), pX + originals.sX + originals.sW, pY + math.max(eY + eH2, originals.sY + originals.sH2), Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + originals.sX + originals.sW, pY + eY + eH2, pX + sX + sW, pY + eY + eH2, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + sX + sW, pY + math.min(eY + eH2, sY + sH2), pX + sX + sW, pY + math.max(eY + eH2, sY + sH2), Snapping.colour, Snapping.lineWidth, true)
		end	
	end

	-- top / top
	if math.abs(eY - sY) <= Snapping.precision then
		y = sY
		
		if offset then			
			dxDrawLine(pX + math.min(eX + eW2, originals.sX + originals.sW2), pY + originals.sY, pX + math.max(eX + eW2, originals.sX + originals.sW2), pY + originals.sY, Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + eX + eW2, pY + originals.sY, pX + eX + eW2, pY + sY, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + math.min(eX + eW2, sX + sW2), pY + sY, pX + math.max(eX + eW2, sX + sW2), pY + sY, Snapping.colour, Snapping.lineWidth, true)
		end		
	-- top / bottom
	elseif math.abs((eY + eH) - sY) <= Snapping.precision then
		y = sY - eH
		
		if offset then			
			dxDrawLine(pX + math.min(eX + eW2, originals.sX + originals.sW2), pY + originals.sY, pX + math.max(eX + eW2, originals.sX + originals.sW2), pY + originals.sY, Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + eX + eW2, pY + originals.sY, pX + eX + eW2, pY + sY, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + math.min(eX + eW2, sX + sW2), pY + sY, pX + math.max(eX + eW2, sX + sW2), pY + sY, Snapping.colour, Snapping.lineWidth, true)
		end				
	-- bottom / bottom
	elseif math.abs((eY + eH) - (sY + sH)) <= Snapping.precision then
		y = sY + sH - eH
		
		if offset then			
			dxDrawLine(pX + math.min(eX + eW2, originals.sX + originals.sW2), pY + originals.sY + originals.sH, pX + math.max(eX + eW2, originals.sX + originals.sW2), pY + originals.sY + originals.sH, Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + eX + eW2, pY + originals.sY + originals.sH, pX + eX + eW2, pY + sY + sH, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + math.min(eX + eW2, sX + sW2), pY + sY + sH, pX + math.max(eX + eW2, sX + sW2), pY + sY + sH, Snapping.colour, Snapping.lineWidth, true)
		end				
	-- bottom / top
	elseif math.abs(eY - (sY + sH)) <= Snapping.precision then
		y = sY + sH
		
		if offset then			
			dxDrawLine(pX + math.min(eX + eW2, originals.sX + originals.sW2), pY + originals.sY + originals.sH, pX + math.max(eX + eW2, originals.sX + originals.sW2), pY + originals.sY + originals.sH, Snapping.colour, Snapping.lineWidth, true)
			dxDrawLine(pX + eX + eW2, pY + originals.sY + originals.sH, pX + eX + eW2, pY + sY + sH, Snapping.colour, Snapping.lineWidth, true)
		else
			dxDrawLine(pX + math.min(eX + eW2, sX + sW2), pY + sY + sH, pX + math.max(eX + eW2, sX + sW2), pY + sY + sH, Snapping.colour, Snapping.lineWidth, true)
		end			
	end	

	return x, y, w, h
end


function Snapping.getDistance(a, b)
	if not exists(a) or not exists(b) then
		return 99999
	end
	
	local aX, aY = guiGetPosition(a, false)
	local aW, aH = guiGetSize(a, false)
	
	local bX, bY = guiGetPosition(b, false)
	local bW, bH = guiGetSize(b, false)
	
	local xOverlap, yOverlap = elementOverlap(a, b)
	
	if xOverlap and yOverlap then
		return 0
	else
		local xDist, yDist = 0, 0
		
		if yOverlap then
			yDist = 0
		elseif aY <= bY then
			yDist = (aY + aH) - bY
		else
			yDist = (bY + bH) - aY
		end
		
		if xOverlap then
			xDist = 0
		elseif aX <= bX then
			xDist = (aX + aW) - bX
		else
			xDist = (bX + bW) - aX
		end	
		
		return (xDist * xDist) + (yDist * yDist)
	end
end