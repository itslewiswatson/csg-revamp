function buyHTG()
setElementHealth (source, getElementHealth(source) + 50)
takePlayerMoney (source, 100)
end
addEvent("onHGBuy", true)
addEventHandler("onHGBuy", getRootElement(), buyHTG)