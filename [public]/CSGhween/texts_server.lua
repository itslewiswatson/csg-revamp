--Text, X, Y, Z, R, G, B, INT, DIM, SCALE
local texts = {
	{text="Ghost Rider", posX=225, posY=-1845.55, posZ=4.41, r=218, g=24, b=24, int=0, dim=0, scale=2},
	{text="Ghost Mask", posX=230, posY=-1845.55, posZ=4.41, r=218, g=24, b=24, int=0, dim=0, scale=2},
	{text="Skeleton", posX=235, posY=-1845.55, posZ=4.41, r=218, g=24, b=24, int=0, dim=0, scale=2},
}

addEvent("3DTexts:getTextTable",true)
addEventHandler("3DTexts:getTextTable",root,
	function ()
		triggerClientEvent("3DTexts:returnTextTable",source,texts)
	end
)