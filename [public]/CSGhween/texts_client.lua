local texts = {}

addEventHandler("onClientResourceStart",resourceRoot,
	function ()
		triggerServerEvent("3DTexts:getTextTable",localPlayer)
	end
)

addEvent("3DTexts:returnTextTable",true)
addEventHandler("3DTexts:returnTextTable",root,
	function (textsTable)
		for index, text in ipairs(textsTable) do
			table.insert(texts,{text=text.text, posX=text.posX, posY=text.posY, posZ=text.posZ, r=text.r, g=text.g, b=text.b, int=text.int, dim=text.dim, scale=text.scale})
		end
	end
)

addEventHandler("onClientRender",root,
	function ()
		for index, text in ipairs(texts) do
			if getElementDimension(localPlayer) ~= tonumber(text.dim) then return end
			if getElementInterior(localPlayer) ~= tonumber(text.int) then return end
			local x, y, z = text.posX, text.posY, text.posZ
			local cx, cy, cz = getCameraMatrix()
			if (getDistanceBetweenPoints3D(cx,cy,cz,x,y,z) <= 15) then
				local px,py = getScreenFromWorldPosition(x,y,z,0.06)
				if (px) then
					dxDrawText(text.text, px, py, px, py, tocolor(tonumber(text.r), tonumber(text.g), tonumber(text.b), 255), tonumber(text.scale), "sans", "center", "center", false, false)
				end
			end
		end
	end
)