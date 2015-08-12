-- Version number
--[[
local version = "1.3.7"

-- onClientRender
local sx, sy = guiGetScreenSize()

addEventHandler( "onClientRender", root,
	function ()
		dxDrawText("CSG: V" .. version .. "", sx*(1355.0/1440),sy*(872.0/900),sx*(1430.0/1440),sy*(885.0/900), tocolor(255, 255, 255, 255), 1, "default", "left", "top", false, false, true, false, false)
	end
)
--]]
