local SkaMarker1 = createMarker(332.55084228516, -1810.1304931641, 3.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarker2 = createMarker(1684.6495361328, -2247, 12.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarker3 = createMarker(2500.1921386719, -1683, 12.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarker4 = createMarker(1472.4396972656, -1673, 12.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarker5 = createMarker(1868.4124755859, -1392, 12.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarker6 = createMarker( 2806.75, -1866.99, 8.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarkerSF1 = createMarker(-2033.4265136719, 173, 27.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarkerSF2 = createMarker(-2366.0651855469, -105, 34, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarkerSF3 = createMarker(-2649.1220703125, 618.5, 13.5, "cylinder", 1.5, 255, 255, 255, 255)
local SkaMarkerLV1 = createMarker(1737.4014892578, 1932, 10, "cylinder", 1.5, 255, 255, 255, 255)

local skblip1 = exports.customblips:createCustomBlip ( 332,-1810,20, 20, "skicon.png",255 )
local skblip2 = exports.customblips:createCustomBlip ( 1684,-2247,20, 20, "skicon.png",255 )
local skblip3 = exports.customblips:createCustomBlip ( 2500,-1683,20, 20, "skicon.png",255 )
local skblip4 = exports.customblips:createCustomBlip ( 1472,-1673,20, 20, "skicon.png",255 )
local skblip5 = exports.customblips:createCustomBlip ( 1868,-1392,20, 20, "skicon.png",255 )
local skblip6 = exports.customblips:createCustomBlip ( -2033,173,20, 20, "skicon.png",255 )
local skblip7 = exports.customblips:createCustomBlip ( -2366,-105,20, 20, "skicon.png",255 )
local skblip8 = exports.customblips:createCustomBlip ( -2649,618,20, 20, "skicon.png",255 )
local skblip9 = exports.customblips:createCustomBlip ( 1737,1932,20, 20, "skicon.png",255 )
local skblip10 = exports.customblips:createCustomBlip ( 2806.75,-1866.99,20, 20, "skicon.png",255 )





function skatemantis ()

local Skaob1 = createObject(2410, 332.55084228516, -1810.1304931641, 4.5, 90, 90, 100)
local Skaob2 = createObject(2410, 1684.6495361328, -2247, 13.5, 90, 90, 260)
local Skaob3 = createObject(2410, 2500.5, -1683, 13.5, 90, 90, 90)
local Skaob4 = createObject(2410, 1472.7, -1673, 14.5, 90, 90, 280)
local Skaob5 = createObject(2410, 1868.4124755859, -1392, 14.5, 90, 90, -280)
local Skaob6 = createObject(2410,  2806.75, -1866.99, 10.9, 90, 90, 90)
local SkaobSF1 = createObject(2410, -2033.4265136719, 173, 28.5, 90, 90, 0)
local SkaobSF2 = createObject(2410, -2366.0651855469, -105.23902893066, 35, 90, 90, 190)
local SkaobSF3 = createObject(2410, -2649.1220703125, 618.5, 14.5, 90, 90, 90)
local SkaobLV1 = createObject(2410, 1737.4014892578, 1932, 12, 90, 90, 0)

setElementCollisionsEnabled(Skaob1, false)
setElementCollisionsEnabled(Skaob2, false)
setElementCollisionsEnabled(Skaob3, false)
setElementCollisionsEnabled(Skaob4, false)
setElementCollisionsEnabled(Skaob5, false)
setElementCollisionsEnabled(Skaob6, false)
setElementCollisionsEnabled(SkaobSF1, false)
setElementCollisionsEnabled(SkaobSF2, false)
setElementCollisionsEnabled(SkaobSF3, false)
setElementCollisionsEnabled(SkaobLV1, false)
end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), skatemantis)

local sktext1 = exports.CSGSpriNJobdx:add(332.55084228516, -1810.1304931641, 4.5,"SkateBoard",0,255,0)
local sktext2 = exports.CSGSpriNJobdx:add(1684.6495361328, -2247, 13.5,"SkateBoard",0,255,0)
local sktext3 = exports.CSGSpriNJobdx:add(2500.5, -1683, 13.5,"SkateBoard",0,255,0)
local sktext4 = exports.CSGSpriNJobdx:add(1472.7, -1673, 14.5,"SkateBoard",0,255,0)
local sktext5 = exports.CSGSpriNJobdx:add(1868.4124755859, -1392, 14.5,"SkateBoard",0,255,0)
local sktext6 = exports.CSGSpriNJobdx:add(2806.75, -1866.99, 10.9,"SkateBoard",0,255,0)
local sktext7 = exports.CSGSpriNJobdx:add(-2033.4265136719, 173, 28.5,"SkateBoard",0,255,0)
local sktext8 = exports.CSGSpriNJobdx:add(-2366.0651855469, -105.23902893066, 35,"SkateBoard",0,255,0)
local sktext9 = exports.CSGSpriNJobdx:add(-2649.1220703125, 618.5, 14.5,"SkateBoard",0,255,0)
local sktext10 = exports.CSGSpriNJobdx:add(1737.4014892578, 1932, 12,"SkateBoard",0,255,0)




function skateGUI ()

skatewindow = guiCreateWindow(272, 123, 210, 397, "CSG~SkateSystem", false)
guiWindowSetSizable(skatewindow, false)
guiSetAlpha(skatewindow, 0.78)
guiSetVisible( skatewindow, false )
showCursor ( false )
skatelabel = guiCreateLabel(8, 24, 195, 285, "           Skate Board system \n  \nYou can Spawn skateboard for 100$ \nYou'r allowed to use it 10min's then it will be destroyed \n \n \n-Lshift to jump \n-Num2 , Num8, Num4, Num6 to doing some moves \n\n\n/delskate  to remove skateboard", false, skatewindow)
guiLabelSetHorizontalAlign(skatelabel, "left", true)
SkateButton1 = guiCreateButton(9, 330, 63, 37, "Spawn Skate", false, skatewindow)
guiSetFont(SkateButton1, "default-bold-small")
guiSetProperty(SkateButton1, "NormalTextColour", "FFE1D11D")
SkateButton2 = guiCreateButton(130, 330, 63, 37, "Close", false, skatewindow)
guiSetProperty(SkateButton2, "NormalTextColour", "FF4DDC21")

end
addEventHandler("onClientResourceStart", getResourceRootElement(getThisResource()), skateGUI)



addEventHandler ( "onClientGUIClick", root,
	function ( )

			player=localPlayer
				if ( source == SkateButton1 ) then
                local Skae = getPlayerMoney(player)
               	if (Skae > 100) then
				triggerServerEvent ( "onFxSkate", getLocalPlayer(), getLocalPlayer() )
				exports.dendxmsg:createNewDxMessage("You Spawned a SkateBoard", 255, 255, 255)

				else
				exports.dendxmsg:createNewDxMessage("You don't have enough money to use Skateboard", 255, 0, 0)
				end
				guiSetVisible( skatewindow, false )
				showCursor ( false )

		end


		end )

addEventHandler ( "onClientGUIClick", root,
	function ()
		if ( source == SkateButton2 ) then
					guiSetVisible( skatewindow, false )
	                showCursor ( false )
		end


		end )


function fxSkate(p)
if p ~= localPlayer then return end
if isPedInVehicle(p) then return end
        local mx,my,mz = getElementPosition(source) -- marker
        local hx,hy,hz = getElementPosition(p) -- hitelement ( player/vehicle etc. )
        if hz < mz+2 then -- check if hitelementZ is below markerZ+2, +2 because markers are positioned a bit
    guiSetVisible( skatewindow, true )
	showCursor ( true )
end
end
addEventHandler("onClientMarkerHit", SkaMarker1, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarker2, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarker3, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarker4, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarker5, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarker6, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarkerSF1, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarkerSF2, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarkerSF3, fxSkate)
addEventHandler("onClientMarkerHit", SkaMarkerLV1, fxSkate)






addEvent("SKcreated", true )
function fixboard(Skateboard)
	setElementCollisionsEnabled(Skateboard, false)
end
addEventHandler("SKcreated", getRootElement(), fixboard)


function Skateenter(thePlayer, seat)
	if thePlayer == getLocalPlayer() then
		if (getElementData( source, "purpose" ) == "Skateboard") then
			setVehicleOverrideLights ( source, 1 )
			showPlayerHudComponent ( "vehicle_name", false )
			setWorldSpecialPropertyEnabled ( "hovercars", false )-- LETS SkateBOARDS GO ON WATER
			setWorldSpecialPropertyEnabled ( "aircars", false ) -- LETS SkateBOARDS FLY
		else
			setVehicleOverrideLights ( source, 1 )
			showPlayerHudComponent ( "vehicle_name", true )
			setWorldSpecialPropertyEnabled ( "hovercars", false )
			setWorldSpecialPropertyEnabled ( "aircars", false )
		end
	end
end
addEventHandler("onClientVehicleEnter", getRootElement(), Skateenter)

function Skateexit(thePlayer, seat)
	if thePlayer == getLocalPlayer() and (getElementData( source, "purpose" ) == "Skateboard") then
		setWorldSpecialPropertyEnabled ( "hovercars", false )
		setWorldSpecialPropertyEnabled ( "aircars", false )
		setVehicleOverrideLights ( source, 0 )
		showPlayerHudComponent ( "vehicle_name", true )
	end
end
addEventHandler("onClientVehicleExit", getRootElement(), Skateexit)

addEvent("SKw", true )
function fixboard(theplayer)
	if thePlayer == getLocalPlayer() then
		setWorldSpecialPropertyEnabled ( "hovercars", false )
		setWorldSpecialPropertyEnabled ( "aircars", false )
		showPlayerHudComponent ( "vehicle_name", true )
	end
end
addEventHandler("SKw", getRootElement(), fixboard)

addEvent("SKm", true)
addEventHandler("SKm", getLocalPlayer(), function()
  if (getElementData( source, "purpose" ) == "Skateboard") then
  setCameraViewMode(3)
  end
end)



function replaceModel()
  txd = engineLoadTXD("Skateboarding.txd", 2 )
  engineImportTXD(txd, 2410)
  dff = engineLoadDFF("Skateboarding.dff", 2410 )
  engineReplaceModel(dff, 2410)
end
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), replaceModel)
