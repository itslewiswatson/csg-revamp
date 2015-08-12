--[[
winningAmount=0

addEvent("CSGlottory.advert",true)
addEventHandler("CSGlottory.advert",localPlayer,function(jackpot)
	alpha1=0
	alpha2=0
	alpha3=0
	final=false
	winningAmount = jackpot
end)

local screenWidth, screenHeight = guiGetScreenSize()

 alpha1=0
 alpha2=0
 alpha3=0
 final=true
function createText()
	if alpha3 ~= 255 and final == false then
		if (alpha1<255) and alpha3==0 and alpha2==0 then alpha1=alpha1+1 end
		if (alpha1==255) then if alpha2 < 255 then alpha2=alpha2+1 end end
		if alpha2 == 255 or (alpha3>0 and alpha3<256)  then alpha1=alpha1-1 alpha2=alpha2-1 alpha3=alpha3+1 end
	else
		if alpha3>0 then alpha3=alpha3-0.5 final = true end
	end


	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Imagine The Possibilities", screenWidth*0.3, screenHeight*0.3, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha3 ), 1.4, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Imagine The Possibilities", screenWidth*0.3, screenHeight*0.3, screenHeight, tocolor ( 255, 255, 255, alpha3 ), 1, "pricedown" )

	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Use /lotto Number to play today.", screenWidth*0.35, screenHeight*0.35, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha3), 1.4, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Use /lotto Number to play today.", screenWidth*0.35, screenHeight*0.35, screenHeight, tocolor ( 255, 255, 255, alpha3 ), 1, "pricedown" )


	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Welcome to the Cloud - The Next Draw is at 18:00", screenWidth*0.3, screenHeight*0.3, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha1 ), 1.4, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99Welcome to the Cloud - The Next Draw is at 18:00", screenWidth*0.3, screenHeight*0.3, screenHeight, tocolor ( 255, 255, 255, alpha1 ), 1, "pricedown" )

	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99CSG Lotto 720. The next jackpot is an estimated", screenWidth*0.35, screenHeight*0.35, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha2 ), 1.4, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#00CC99CSG Lotto 720. The next jackpot is an estimated", screenWidth*0.35, screenHeight*0.35, screenHeight, tocolor ( 255, 255, 255, alpha2 ), 1, "pricedown" )

	exports.CSGpriyenmisc:dxDrawColorText ( "#7cfc00$"..winningAmount.." ", screenWidth*0.4, screenHeight*0.4, screenWidth, screenHeight, tocolor ( 0, 0, 0, alpha2 ), 1.4, "pricedown" )
	exports.CSGpriyenmisc:dxDrawColorText ( "#7cfc00$"..winningAmount.." ", screenWidth*0.4, screenHeight*0.4, screenHeight, tocolor ( 255, 255, 255, alpha2 ), 1, "pricedown" )
end
addEventHandler("onClientRender",root,createText)
--]]
