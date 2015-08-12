-- Create Col in LV
local LVcol = createColRectangle(866,656,2100,2300)

-- Check if player is in LV
addEventHandler( "onColShapeHit", LVcol, -- Root is alle cols he
function (hitElement)
	setElementData ( hitElement, "isPlayerInLvCol", true )
end
) -- Denk dat dit het al oplost

addEventHandler( "onColShapeLeave", LVcol,
function (hitElement)
	setElementData ( hitElement, "isPlayerInLvCol", true )
end
)

addEvent ("isPlayerInLvCol", true)
function isPlayerInLvCol ()
	setElementData ( source, "isPlayerInLvCol", false )
	if isElementWithinColShape ( source, LVcol ) then
		setElementData ( source, "isPlayerInLvCol", true )
	end
end
addEventHandler ("onPlayerConnect", root, isPlayerInLvCol )
addEventHandler ("isPlayerInLvCol", root, isPlayerInLvCol)
