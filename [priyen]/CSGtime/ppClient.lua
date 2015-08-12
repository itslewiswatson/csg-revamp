local text = "Sunday"
days = {
	"Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"
}

addEvent("CSGtime.newDay",true)
addEventHandler("CSGtime.newDay",localPlayer,function(day) text=days[day] end)

local screenWidth, screenHeight = guiGetScreenSize()
addEventHandler("onClientRender",getRootElement(),function()
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99"..text.."", screenWidth*0.85, screenHeight*0.0181, screenWidth, screenHeight, tocolor ( 0, 0, 0, 255 ), 1.02, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99"..text.."", screenWidth*0.85, screenHeight*0.0181, screenHeight, tocolor ( 255, 255, 255, 255 ), 1, "pricedown" )
end)

function getDay()
	return text
end
