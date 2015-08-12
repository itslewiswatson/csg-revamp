 local window = guiCreateWindow(539,385,256,112,"Price of the bus fare",false)
 local lblPrice = guiCreateLabel(15,29,229,20,"Fare price: $0",false,window)
 guiLabelSetColor(lblPrice,0,225,0)
 guiLabelSetHorizontalAlign(lblPrice,"center",false)
 guiSetFont(lblPrice,"default-bold-small")
 guiSetVisible(window,false)
 local btnPay = guiCreateButton(9,53,238,21,"Accept and pay the fare",false,window)
 local btnRefuse = guiCreateButton(9,79,238,21,"This is to expensive, refuse",false,window)
 local driver = ""
 local fare = ""
 local timer = ""
 local count = 10
function show(dr,far)
	if isTimer(timer) then killTimer(timer) end
	count = 10
	timer = setTimer(update,1000,11)
	fare = far
	driver = dr
	local name = getPlayerName(driver)
	guiSetText(lblPrice,"Fare Price: $"..fare.."")
	guiSetText(window,""..name.."'s Bus Fare")
	guiSetVisible(window,true)
	showCursor(true)
end
addEvent("CSGbusFareMenu",true)
addEventHandler("CSGbusFareMenu",localPlayer,show)

function update()
	count=count-1
	guiSetText(btnPay,"Accept and pay the fare ("..count..")")
	if count < 0 then
		triggerServerEvent("CSGbusPayFare",localPlayer,driver,fare)
		hide()
	end
end

function hide()
	if isTimer(timer) then killTimer(timer) end
	guiSetVisible(window,false)
	showCursor(false)
end

function pay()
	triggerServerEvent("CSGbusPayFare",localPlayer,driver,fare)
	hide()
end
addEventHandler("onClientGUIClick",btnPay,pay)

function refuse()
	triggerServerEvent("CSGbusRefuseFare",localPlayer,driver,localPlayer)
	hide()
end
addEventHandler("onClientGUIClick",btnRefuse,refuse)

if fileExists("faregui_c.lua") == true then
	fileDelete("faregui_c.lua")
end


