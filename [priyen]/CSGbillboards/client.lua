shader = dxCreateShader ( "texreplace.fx" )
shader2 = dxCreateShader ( "texreplace.fx" )
shader3 = dxCreateShader ( "texreplace.fx" )
update = dxCreateTexture("update2.png")
lspdArmy1 = dxCreateTexture("crims.jpg")
dxSetShaderValue(shader,"gTexture",lspdArmy1)
dxSetShaderValue(shader2,"gTexture",lspdArmy1)
dxSetShaderValue(shader3,"gTexture",lspdArmy1)
engineApplyShaderToWorldTexture(shader,"heat_02")
engineApplyShaderToWorldTexture(shader3,"heat_03")
local christmas1 = dxCreateTexture("christmas1.png")
local cols = {}
local colPlaces = {
	["fish1"] = {989.4,-2101},
	["lspd1"] = {1537.72, -1608.08},
	--["lspd2"] = {1537.72, -1608.08},
	--["lspd3"] = {1537.72, -1608.08},
	["lvcomealot1a"] = {2102.86, 1718.87},
	["lvcomealot2a"] = {2102.86, 1718.87},
	--["christmasAllSaints"] = {1172.9000244141,-1323.0999755859}


}
local order = {
	{"heat_02",3,shader,"fish1","fish2","fish3"},
	{"heat_02",3,shader2,"lspd4","lspd1","lspd2","lspd3"},
	{"heat_03",9,shader3,"lvcomealot1a","lvcomealot1b","lvcomealot2c","lvcomealot1c","lvcomealot2c","lvcomealot2a","lvcomealot2c","lvcomealot2b","lvcomealot2c"},
	--{"heat_02",1,shader3,"christmasAllSaints"},
}
local orderCount = {
	[1] = 0,--will be updated on resource start,
	[2] = 0,
	[3] = 0,
	--[4] = 0
}


local boardsTextures = {
	["fish1"] = "",
	["fish2"] = "",
	["fish3"] = "",
	["lspd1"] = "",
	["lspd2"] = "",
	["lspd3"] = "",
	["lspd4"] = "",
	["lvcomealot1a"] = "",
	["lvcomealot1b"] = "",
	["lvcomealot1c"] = "",
	["lvcomealot2a"] = "",
	["lvcomealot2b"] = "",
	["lvcomealot2c"] = "",
	--["christmasAllSaints"] = christmas1
}
boardsTextures["lspd4"] = lspdArmy1

function orderHasName(i,name)
	for k,v in pairs(order) do
		for i2 = 3,v[2]+3 do
			if order[i][i2] == name then
				return true,i2
			end
		end
	end
	return false
end

addEvent( "onClientGotImage", true )
addEventHandler( "onClientGotImage", resourceRoot,

    function( pixels, name )
			boardsTextures[name]=dxCreateTexture( pixels )
			for k,v in pairs(order) do
				local bool,index = orderHasName(k,name)
				if bool == true then
					if orderCount[k] == index-3 then
						dxSetShaderValue(order[k][3],"gTexture",boardsTextures[name])
						engineApplyShaderToWorldTexture(order[k][3],order[k][1])
					end
				end
			end
			--alternate()
    end
)


--crun for k,v in pairs(engineGetVisibleTextureNames("*",4238)) do outputChatBox(v) end

function alternate()
	for k,v in pairs(order) do
		local col = cols[v[4]]
			local i = orderCount[k]
			i=i+1
			if i > v[2] then i = 1 end
			orderCount[k]=i
			i=i+3 -- to corrent for positions in table
			if isElementWithinColShape(localPlayer,col) == true then
				if boardsTextures[v[i]] ~= "" then
					dxSetShaderValue(v[3],"gTexture",boardsTextures[v[i]])
					engineApplyShaderToWorldTexture(v[3],v[1])
				end
			end
	end
end
setTimer(alternate,10000,0)

for k,v in pairs(colPlaces) do
	local col = createColCircle(v[1],v[2],175)
	cols[k] = col
end

alternate()




