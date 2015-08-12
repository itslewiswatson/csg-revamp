		-- syntax: fX, fY, fWidth, fHeight (used for createColRectangle())
local 	AmmunColShape = {}
		AmmunColShape = {
			["ammun_5"] = {272.7890625, -144.33737182617, 26.5, 18},
			["ammun_2"] = {303.9015625, -71.954582214355, 25, 15}
		}

		-- syntax: posX, posY, posZ
local	WarpPoint = {}
		WarpPoint = {
			["ammun_5"] = {303.12762451172, -133.52711486816, 1004.0625},
			["ammun_2"] = {299.54675292969, -63.890609741211, 1001.515625}
		}

local	FenceObject = {}
		FenceObject = {
			["ammun_5"] = {299.60000610352, -134.69999694824, 1007.299987793, 0, 0, 0},
			["ammun_2"] = {303.5, -62.700000762939, 1004.700012207, 0, 0, 0}
		}

-- OBS: Set this var as "TRUE" if you want create some fences on the fire range. It will give you an extra level of security. :D | Otherwise, set "false"
-- Recommended: true
local fencesEnabled = true


function createAmmunationColShapes()
	colRectangleAmmo5 = createColRectangle(AmmunColShape["ammun_5"][1], AmmunColShape["ammun_5"][2], AmmunColShape["ammun_5"][3], AmmunColShape["ammun_5"][4])
	colRectangleAmmo2 = createColRectangle(AmmunColShape["ammun_2"][1], AmmunColShape["ammun_2"][2], AmmunColShape["ammun_2"][3], AmmunColShape["ammun_2"][4])
	setElementInterior(colRectangleAmmo5, 7)
	setElementInterior(colRectangleAmmo2, 4)
	setElementDimension(colRectangleAmmo5, 5)
	setElementDimension(colRectangleAmmo2, 5)
	createFencesObjects()

	addEventHandler("onColShapeHit", colRectangleAmmo5, preventAbusing)
	addEventHandler("onColShapeHit", colRectangleAmmo2, preventAbusing)
end
addEventHandler("onResourceStart", resourceRoot, createAmmunationColShapes)

function createFencesObjects()
	if (fencesEnabled == true) then
		fenceAmmun5 = createObject(7191, FenceObject["ammun_5"][1], FenceObject["ammun_5"][2], FenceObject["ammun_5"][3], FenceObject["ammun_5"][4], FenceObject["ammun_5"][5], FenceObject["ammun_5"][6])
		fenceAmmun2 = createObject(7191, FenceObject["ammun_2"][1], FenceObject["ammun_2"][2], FenceObject["ammun_2"][3], FenceObject["ammun_2"][4], FenceObject["ammun_2"][5], FenceObject["ammun_2"][6])
		setElementInterior(fenceAmmun5, 7)
		setElementInterior(fenceAmmun2, 4)
		setElementDimension(fenceAmmun5, 5)
	setElementDimension(fenceAmmun2, 5)
	end
end

function preventAbusing(hitElement, matchingDimension)
	if (getElementType(hitElement) == "player") and (matchingDimension == true) then

		if (source == colRectangleAmmo5) then
			ammunation = "ammun_5"
		elseif (source == colRectangleAmmo2) then
			ammunation = "ammun_2"
		end

		local x = WarpPoint[ammunation][1]
		local y = WarpPoint[ammunation][2]
		local z = WarpPoint[ammunation][3]
		setElementPosition(hitElement, x, y, z, true)
		setElementFrozen(hitElement, true)
		setTimer(setElementFrozen, 1000, 1, hitElement, false)
		exports.dendxmsg:createNewDxMessage(hitElement, "Do not try abuse of this. Stay behind the fire range.", 200, 25, 25)
		--outputChatBox("Do not try abuse of this. Stay behind the fire range.", hitElement, 200, 25, 25)
	end
end
