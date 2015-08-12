local screenWidth, screenHeight = guiGetScreenSize ( )
mouseOver=false

function createText()
	isOnDxDrawElement(screenWidth*0.5,screenHeight*0.5,(screenWidth*0.5)+100,(screenHeight*0.5)+50)
	local str = "Move mouse over me!"
	if mouseOver == true then str = "Your mouse is over me. Detected!" end
	dxDrawText(str,screenWidth*0.5,screenHeight*0.5,screenWidth*0.5,screenHeight*0.5)
end
addEventHandler("onClientRender",root,createText)
showCursor(true)

function isOnDxDrawElement(minX,minY,maxX,maxY)
	local x,y = getCursorPosition()
	x=screenWidth*x
	y=screenHeight*y
	if x >= minX and x <= maxX then
		if y >= minY and y <= maxY then
			mouseOver=true
		else
			mouseOver=false
		end
	else
		mouseOver = false
	end
end
