shader=false
addEventHandler("onClientResourceStart", resourceRoot,
	function ()
		shader = dxCreateShader ("texrep.fx")
		shader2 = dxCreateShader ("fuel.fx")
		if not shader then
			outputChatBox ("Could not create shader.")
		else
			texture = dxCreateRenderTarget (400, 200, true)
			dxSetShaderValue (shader, "gTexture", texture)
			engineApplyShaderToWorldTexture (shader, "semi3dirty")
			texture2 = dxCreateRenderTarget (400, 400, true)
			dxSetShaderValue (shader2, "gTexture", texture2)
			dxSetShaderValue (shader2, "gHScale", 1)
			dxSetShaderValue (shader2, "gVScale", 1)
			engineApplyShaderToWorldTexture (shader2, "ws_xenon_3")
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

fuelPrice=1
local blipStats = {
	[54] = "crim", --se
	[65] = "crim", --sw
	[69] = "crim", --ne
	[68] = "crim", --nw
}

fuelX=1
function rs ()
	dxSetRenderTarget (texture, true)
	--LV ENTRANCE
	local x,y,z = getElementPosition(localPlayer)
	if getDistanceBetweenPoints3D(x,y,z, 1795.78, 782.23, 12.51) < 70 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		dxDrawText("Welcome to CSG's LV",0,60,400,200,tocolor(255,0,0,255),2,"arial")
		dxDrawText("	> Turf Wars",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
		dxDrawText("	> Casino Robbery",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		dxDrawText("	> Death Matching",0,160,400,200,tocolor(r,g,b,255),1.5,"arial")
	end
	if getDistanceBetweenPoints3D(x,y,z, -2428.15, 2220.76, 5.49 ) < 70 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		dxDrawText("Drug Shipment",0,60,400,200,tocolor(255,0,0,255),2,"arial")
		dxDrawText("	> If your boat had drug crates,",0,100,400,200,tocolor(255,0,0,255),1.5,"arial")
		dxDrawText("	> Take these vans to DF for 25 points!",0,130,400,200,tocolor(255,0,0,255),1.5,"arial")
		dxDrawText("	> Use your drug points for drugs at DF",0,160,400,200,tocolor(255,0,0,255),1.5,"arial")
	end
	if getDistanceBetweenPoints3D(x,y,z, -1826.57, 39.37, 15.12 ) < 70 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		dxDrawText("CSG's Drug Factory",0,60,400,200,tocolor(255,0,0,255),2,"arial")
		dxDrawText("	> High Quality Production of Drugs!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
		dxDrawText("	> Talk to Bob outside to Convert your!",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		dxDrawText("	  Drug Points to Drugs!",0,160,400,200,tocolor(r,g,b,255),1.5,"arial")
	end
	if getDistanceBetweenPoints3D(x,y,z, 1113.36, 746.01, 10.82 ) < 140 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		zoom = zoom+zoomInterval
		if zoom > 1.5 then zoomInterval=-0.005 end
		if zoom <= 1 then zoomInterval=0.005 end
		if blipStats[65] == "crim" then
			dxDrawImage(0,0,400*zoom,200*zoom,"criminal.jpg")
			dxDrawText("	> Disabled >> All crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> South West LV :: #FF0000Criminal Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[65] == "law" then
			dxDrawImage(0,0,400*zoom,200*zoom,"law.jpg")
			dxDrawText("	> Enabled >> All crimes are being reported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> South West LV :: #0000FFLaw Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[65] == "noone" then
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633	> Neutral >> Some crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633> South West LV :: #FF6633Neutral Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		end
		dxDrawText("Law Enforcement Radio Station",0,60,400,200,tocolor(0,0,255,255),2,"arial")
	end
	if getDistanceBetweenPoints3D(x,y,z, 2833.63, 933.13, 10.97 ) < 140 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		zoom = zoom+zoomInterval
		if zoom > 1.5 then zoomInterval=-0.005 end
		if zoom <= 1 then zoomInterval=0.005 end
		if blipStats[54] == "crim" then
			dxDrawImage(0,0,400*zoom,200*zoom,"criminal.jpg")
			dxDrawText("	> Disabled >> All crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> South East LV :: #FF0000Criminal Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[54] == "law" then
			dxDrawImage(0,0,400*zoom,200*zoom,"law.jpg")
			dxDrawText("	> Enabled >> All crimes are being reported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> South East LV :: #0000FFLaw Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[54] == "noone" then
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633	> Neutral >> Some crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633> South East LV :: #FF6633Neutral Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		end
		dxDrawText("Law Enforcement Radio Station",0,60,400,200,tocolor(0,0,255,255),2,"arial")
	end
	if getDistanceBetweenPoints3D(x,y,z, 2776.64, 2627.27, 10.82) < 140 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		zoom = zoom+zoomInterval
		if zoom > 1.5 then zoomInterval=-0.005 end
		if zoom <= 1 then zoomInterval=0.005 end
		if blipStats[69] == "crim" then
			dxDrawImage(0,0,400*zoom,200*zoom,"criminal.jpg")
			dxDrawText("	> Disabled >> All crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> North East LV :: #FF0000Criminal Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[69] == "law" then
			dxDrawImage(0,0,400*zoom,200*zoom,"law.jpg")
			dxDrawText("	> Enabled >> All crimes are being reported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> North East LV :: #0000FFLaw Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[69] == "noone" then
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633	> Neutral >> Some crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633> North East LV :: #FF6633Neutral Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		end
		dxDrawText("Law Enforcement Radio Station",0,60,400,200,tocolor(0,0,255,255),2,"arial")
	end
	if getDistanceBetweenPoints3D(x,y,z, 1447.03, 2834.11, 10.82) < 140 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		zoom = zoom+zoomInterval
		if zoom > 1.5 then zoomInterval=-0.005 end
		if zoom <= 1 then zoomInterval=0.005 end

		if blipStats[68] == "crim" then
			dxDrawImage(0,0,400*zoom,200*zoom,"criminal.jpg")
			dxDrawText("	> Disabled >> All crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> North West LV :: #FF0000Criminal Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[68] == "law" then
			dxDrawImage(0,0,400*zoom,200*zoom,"law.jpg")
			dxDrawText("	> Enabled >> All crimes are being reported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FFFFFF> North West LV :: #0000FFLaw Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		elseif blipStats[68] == "noone" then
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633	> Neutral >> Some crimes going unreported!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
			exports.CSGpriyenmisc:dxDrawColorText("#FF6633> North West LV :: #FF6633Neutral Territory",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		end
		dxDrawText("Law Enforcement Radio Station",0,60,400,200,tocolor(0,0,255,255),2,"arial")
	end
	dxSetRenderTarget (texture2, true)
	--dxSetRenderTarget ()
	if getDistanceBetweenPoints3D(x,y,z,2139.66, 944.33, 10.81) < 70 then
		r,g,b = r+1,g+1,b+1
		if r == 255 then r,g,b = 1,1,1 end
		dxDrawText("Rishu's",0,1,400,400,tocolor(0,255,0,255),10)
		--dxDrawText(" ",0,70,400,400,tocolor(255,255,0,255),10)
		dxDrawText("Fuel Station",fuelX,150,400,400,tocolor(0,255,0,255),6)
		dxDrawText("Feature in Development",1,300,400,400,tocolor(255,255,0,255),2)
		local h,m = getTime()
		dxDrawText("Current Time: "..h..":"..m.."",1,325,400,400,tocolor(255,255,0,255),2)
		--[[local toAdd=(math.random(1,100)/1000)
		if math.random(1,100) > 50 then toAdd=toAdd*-1 end
		fuelPrice=fuelPrice+toAdd
		--]]fuelX=fuelX+1
		if fuelX > 400 then fuelX=-400 end
		--dxDrawText("	> High Quality Production of Drugs!",0,100,400,200,tocolor(r,g,b,255),1.5,"arial")
		--dxDrawText("	> Talk to Bob outside to Convert your!",0,130,400,200,tocolor(r,g,b,255),1.5,"arial")
		--dxDrawText("	  Drug Points to Drugs!",0,160,400,200,tocolor(r,g,b,255),1.5,"arial")
	end
	dxSetRenderTarget ()
	--dxDrawImage(0,0,333,333,texture2)
end

addEvent("CSGturfing.towerUpdates",true)
addEventHandler("CSGturfing.towerUpdates",localPlayer,function(t) blipStats=t end)

--MAPPING
createObject ( 1259, 1789.8000488281, 815.09997558594, 20, 0, 0, 110 )
createObject ( 7900, 1792, 816, 26.85, 0, 0, 18 )
