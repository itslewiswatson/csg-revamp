local htgMarkers = {
[1]={1188.9000244141, -1377.9000244141, 12.5},
[2]={1543.4000244141, -1697.4000244141, 12.5},
[3]={2019.1999511719, -1410.6999511719, 16},
[4]={1986.4000244141, -1093.8000488281, 24.200000762939},
[5]={1230.5, 336.5, 18.89999961853},
[6]={1591.8000488281, 1821.9000244141, 9.8000001907349},
[7]={-7.8000001907349, 1209.9000244141, 18.39999961853},
[8]={-231.60000610352, 992.5, 18.60000038147},
[9]={-1543.5, 704.40002441406, 6},
[10]={-1913.1999511719, 875.40002441406, 34.299999237061},
[11]={1423.9000244141, -1249.1999511719, 12.5},
}
 
       
--creating markers
function createMarkers()
      for ID in pairs(htgMarkers) do
        local x, y, z = htgMarkers[ID][1], htgMarkers[ID][2], htgMarkers[ID][3]
        local marker = createMarker(x,y,z,"cylinder",1.4, 225, 165, 0, 225)
                addEventHandler("onClientMarkerHit",marker,showIT)
      end
    end
 
addEventHandler("onClientResourceStart",resourceRoot,createMarkers)
 
--GUI
function showIT(hitElement,dimensions)
        if hitElement ~= localPlayer or not dimensions then return end
        GUIEditor = {
                staticimage = {},
                label = {},
        }
        wndw = guiCreateWindow(426, 311, 586, 203, "CSG ~ HotDog Services", false)
        guiWindowSetSizable(wndw, false)
 
        buy = guiCreateButton(9, 126, 219, 55, "Buy ( 100 $ ) 50 HP !", false, wndw)
        guiSetProperty(buy, "NormalTextColour", "FFAAAAAA")
        close = guiCreateButton(342, 128, 219, 55, "No , changed my mind.", false, wndw)
        guiSetProperty(close, "NormalTextColour", "FFAAAAAA")
        GUIEditor.label[1] = guiCreateLabel(17, 39, 556, 70, "Welcome to HotDog Monger", false, wndw)
        guiSetFont(GUIEditor.label[1], "sa-header")
        guiLabelSetColor(GUIEditor.label[1], 255, 0, 0)
 
        local screenW,screenH=guiGetScreenSize()
        local windowW,windowH=guiGetSize(wndw,false)
        local x,y = (screenW-windowW)/2,(screenH-windowH)/2
        guiSetPosition(wndw,x,y,false)
        guiSetVisible(wndw, true)
        showCursor(true)
        setElementFrozen(hitElement, true)
end
 
--Close GUI
function closeIT(hitElement)
        if (source == close ) then
                guiSetVisible(wndw, false)
                showCursor(false)
                setElementFrozen(hitElement, false)
        end
end
addEventHandler("onClientGUIClick", getRootElement(), closeIT)
 
--Health thing
function setHealth()
        if(source == buy) then
                local money = getPlayerMoney(getLocalPlayer())
                local health = getElementHealth(getLocalPlayer())
                if ( money >= 100 and health < 100 ) then
                triggerServerEvent("onHGBuy", getLocalPlayer())
                exports.dendxmsg:createNewDxMessage("You bought a HotDog Menu , You've been given 50 Health !", 0, 225, 0)
                else
                        exports.dendxmsg:createNewDxMessage("You dont need health or you dont have engouh money !", 225, 0, 0, true)
                end
        end
end
addEventHandler("onClientGUIClick", getRootElement(), setHealth)