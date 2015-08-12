--HOSPITAL AND CR AND CRIM JOB
createObject ( 1267, 1831, 793.40002441406, 25.89999961853, 0, 0, 231 )

createObject ( 1260, 1607.0999755859, 1882.8000488281, 18.700000762939, 0, 0, 90.984375 )
LVhos=createObject ( 4729, 1607.9000244141, 1883.0999755859, 23.89999961853, 0, 0, 290.74768066406 )

createObject ( 1260,  1219.09, -1325.03, 18.700000762939, 0, 0, 90.984375-90 )
LShos=createObject ( 4729,  1219.09, -1325.03, 23.89999961853, 0, 0, 290.74768066406-90 )

lspd1=createObject ( 4729, 1491.69, -1593.26, 23.89999961853, 0, 0, 290.74768066406-90 )
lspd2=createObject ( 4729, 1493.69, -1593.26, 23.89999961853, 0, 0, 290.74768066406-270 )
createObject ( 1260, 1491.69, -1592.26, 18.700000762939, 0, 0, 90.984375-90 )

createObject ( 7904, 1828.5999755859, 790.90002441406, 31.89999961853, 0, 0, 337.5 )
createObject ( 9191, 2097.3999023438, 1634.5999755859, 13.10000038147 )
createObject ( 1260, 2090.8000488281, 1682.8000488281, 23.10000038147, 0, 0, 171 )
createObject ( 4729, 2090.3999023438, 1682.0999755859, 28.700000762939, 0, 0, 11 )
createObject ( 1260, 2069.3000488281, 2345.8999023438, 23.10000038147, 0, 0, 91 )
createObject ( 4729, 2069.5, 2346.1999511719, 28.299999237061, 0, 0, 291 )
--mapped by ryder (below)

local t = {
{createObject ( 4239, 2452.69995, -1674.69995, 34, 0, 359.75, 36.25),"didersachs01","homies_2"},

{createObject ( 4730, 1183.90002, -1364.09998, 34, 0, 0, 138.75 ),"homies_2","prolaps01"},
{createObject ( 4730, 1258.80005, 370.79999, 39.4, 0, 0, 122 ),"homies_2","prolaps01"},

{createObject ( 4730, 2095.1001, 1713.80005, 31.3, 0, 0, 40.5 ),"homies_2","prolaps01"},
{createObject ( 4730, 2200.80005, 2359.6001, 31.7, 0, 0, 130 ),"homies_2","prolaps01"},

{createObject ( 4730, -329.20001, 1088.09998, 40.2, 0, 0, 216 ),"homies_2","prolaps01"},
{createObject ( 4730, -1516.59998, 2570.3999, 76.3, 0, 0, 12.5 ),"homies_2","prolaps01"},

{createObject ( 4730, -2719.3999, 2339.80005, 92.8, 0, 0, 170.25 ),"homies_2","prolaps01"},
{createObject ( 4730, -2554.69995, 579, 36, 0, 0, 59 ),"homies_2","prolaps01"},

{createObject ( 4730, -2190.30005, -2274.30005, 51.1, 0, 0, 356.5 ),"homies_2","prolaps01"},
{createObject ( 4730, -2351.6001, -1648, 505.60001, 0, 0, 164.5 ),"homies_2","prolaps01"},

}
createObject ( 1267, 1183.59998, -1365, 28.5, 0, 0, 228.5 )
createObject ( 1233, 1190.09998, -1303.59998, 14.1 )
createObject ( 1267, 2200.30005, 2358.69995, 26.3, 0, 0, 220 )
createObject ( 1267, -328.39999, 1087.5, 34.8, 0, 0, 306 )
createObject ( 1267, -1516.90002, 2570.8999, 70.9, 0, 0, 102 )
createObject ( 1267, -2719.30005, 2339.19995, 87.4, 0, 0, 260 )
createObject ( 1267, 1258.09998, 370.10001, 34, 0, 0, 212 )
createObject ( 1267, 2094.30005, 1714.40002, 25.9, 0, 0, 130 )
--
createObject ( 1267, -2555.69995, 579.29999, 30.7, 0, 0, 149 )
createObject ( 1267, -2190.5, -2273.69995, 45.7, 0, 0, 86 )
createObject ( 1267, -2351.6001, -1649, 499.89999, 0, 0, 254 )
createObject ( 1267, 2453.3999, -1673.90002, 28.6, 0, 0, 36 )
shader=false
addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		if getPlayerSerial() == "6DE7FFFD2D08B5423DEC04D14A6FBE42" then return end
		shader = dxCreateShader ("texrep.fx")
		shader2 = dxCreateShader ("texrep.fx")
		jailShader = dxCreateShader ("texrep.fx")
		prisonBB = createObject ( 7901,  926.07, -2455.71, 5704.91, 0, 0, 180)
		setObjectScale(prisonBB,0.6)
		if not shader then
			outputChatBox ("Could not create shader.")
		else
			texture = dxCreateRenderTarget (400, 200, true)
			dxSetShaderValue (shader, "gTexture", texture)
			engineApplyShaderToWorldTexture(shader,"bobo_2",LVhos)
			engineApplyShaderToWorldTexture(shader,"bobo_2",LShos)
			engineApplyShaderToWorldTexture(shader,"bobo_2",lspd2)
			engineApplyShaderToWorldTexture(shader,"bobo_2",lspd1)
			for k,v in pairs(t) do
				engineApplyShaderToWorldTexture(shader,v[2],v[1])
				engineApplyShaderToWorldTexture(shader,v[3],v[1])
			end
	--[[
			engineApplyShaderToWorldTexture(shader,"homies1")
			engineApplyShaderToWorldTexture(shader,"heat_04")
			engineApplyShaderToWorldTexture(shader,"homies1")
			engineApplyShaderToWorldTexture(shader,"cokopops1")
			engineApplyShaderToWorldTexture(shader,"ads003 copy")
			engineApplyShaderToWorldTexture(shader,"sunbillb03")
			engineApplyShaderToWorldTexture(shader,"eris_4")
			engineApplyShaderToWorldTexture(shader,"base5_1")
			engineApplyShaderToWorldTexture(shader,"cokopops_2")
			engineApplyShaderToWorldTexture(shader,"prolaps02")
			engineApplyShaderToWorldTexture(shader,"victim_bboard")
			engineApplyShaderToWorldTexture(shader,"dirtringtex1_256")
	--]]
			jailTexture = dxCreateRenderTarget (400, 200, true)
			dxSetShaderValue (jailShader, "gTexture", jailTexture)
			engineApplyShaderToWorldTexture (jailShader, "bobobillboard1",prisonBB)

			addEventHandler ("onClientHUDRender", getRootElement(), rs)

		end
	end
)

-- Function decToHex (renamed, updated): http://lua-users.org/lists/lua-l/2004-09/msg00054.html
local function decToHex(IN)
        local B,K,OUT,I,D=16,"0123456789ABCDEF","",0
        while IN>0 do
                I=I+1
                IN,D=math.floor(IN/B),math.fmod(IN,B)+1
                OUT=string.sub(K,D,D)..OUT
        end
        return OUT
end

-- Function rgbToHex: http://gameon365.net/index.php
local function rgbToHex(c)
        local output = decToHex(c["r"]) .. decToHex(c["g"]) .. decToHex(c["b"]);
        return output
end
zoomInterval=0.01
zoom=1
r,g,b=0,0,0

local blipStats = {
	[54] = "crim", --se
	[65] = "crim", --sw
	[69] = "crim", --ne
	[68] = "crim", --nw
}

local ads = {
	"sas.png","dio.png","fbi.png","mf.jpg","mf2.jpg","army.jpg","swat.jpg","swat2.jpg","truckers.jpg", "traffic.jpg","fisherman.jpg"
}

adsX=-400
pauseAds=false
prisonAdsX=-400
pauseprisonAds=false
function rs ()
	dxSetRenderTarget (texture, true)
	--LV ENTRANCE

	local x,y,z = getElementPosition(localPlayer)

		r,g,b = r+1,g+1,b+1
		if pauseAds==false then
			adsX=adsX+1
			if adsX > 4400 then adsX=-4400 end
		end
		for i=0,(#ads+2) do
			if i*400 == adsX then
				pauseAds=true
				setTimer(function() pauseAds=false end,4000,1)
			end
		end

		if r == 255 then r,g,b = 1,1,1 end
		dxDrawImage(adsX,0,400,200,"anything.jpg")
		if adsX+400>400 then
			dxDrawImage(adsX-400,0,400,200,"stats.jpg")

			dxDrawText("All Time kills",adsX-400+240,20,400,200,tocolor(255,0,255,255),1,"pricedown")
			dxDrawText("1. Stay tuned!",adsX-400+270,50,400,200,tocolor(255,0,0,255),1,"arial")
			dxDrawText("2. Stay tuned!",adsX-400+270,70,400,200,tocolor(255,0,0,255),1,"arial")
			dxDrawText("3. Stay tuned!",adsX-400+270,90,400,200,tocolor(255,0,0,255),1,"arial")
			dxDrawText("4. Stay tuned!",adsX-400+270,110,400,200,tocolor(255,0,0,255),1,"arial")

		else
			dxDrawImage(adsX+400,0,400,200,"stats.jpg")


			dxDrawText("All Time kills",adsX+400+240,20,400,200,tocolor(255,0,255,255),1,"pricedown")
			dxDrawText("1. Stay tuned!",adsX+400+270,50,400,200,tocolor(255,0,0,255),1,"arial")
			dxDrawText("2. Stay tuned!",adsX+400+270,70,400,200,tocolor(255,0,0,255),1,"arial")
			dxDrawText("3. Stay tuned!",adsX+400+270,90,400,200,tocolor(255,0,0,255),1,"arial")
			dxDrawText("4. Stay tuned!",adsX+400+270,110,400,200,tocolor(255,0,0,255),1,"arial")

		end
		for k,v in pairs(ads) do
			local var = (k+1)*400
			if adsX+var > 400 then
				dxDrawImage(adsX-var,0,400,200,v)
			else
				dxDrawImage(adsX+var,0,400,200,v)
			end
		end

		--dxDrawText("CSG Advert Testing",adsX,60,400,200,tocolor(255,0,0,255),2,"arial")
		--dxDrawText("	> Ignore",adsX,100,400,200,tocolor(r,g,b,255),1.5,"arial")
		--dxDrawText("	> Casino Robbery",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		--dxDrawText("	> Death Matching",0,160,400,200,tocolor(r,g,b,255),1.5,"arial")
	dxSetRenderTarget(jailTexture,true)

		if pauseprisonAds==false then
			prisonAdsX=prisonAdsX+1
			if prisonAdsX > 400 then prisonAdsX=-400 end
		end

		if (prisonAdsX == 0) then
			pauseprisonAds=true
			--prisonAdsX=1
			setTimer(function() pauseprisonAds=false end,4000,1)
		end
		dxDrawImage(prisonAdsX,0,400,200,"busted.jpg")
		dxDrawText("	"..getPlayerName(localPlayer)..", ",prisonAdsX,50,400,200,tocolor(255,0,0,255),1.5,"arial")
		dxSetRenderTarget ()
		dxSetRenderTarget ()
	--dxDrawImage(0,0,333,333,texture2)
end

addEvent("CSGturfing.towerUpdates",true)
addEventHandler("CSGturfing.towerUpdates",localPlayer,function(t) blipStats=t end)

--MAPPING
createObject ( 1259, 1789.8000488281, 815.09997558594, 20, 0, 0, 110 )
createObject ( 7900, 1792, 816, 26.85, 0, 0, 18 )


