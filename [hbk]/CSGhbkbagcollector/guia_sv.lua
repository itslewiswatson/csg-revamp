-----------------------------------------------------------------------------------------------------------------------------
--CREATE Tug trailer
local trailers = {}
addEvent ( "CSGairportbag.trailer", true )
    addEventHandler ( "CSGairportbag.trailer", root,
    function()
    if trailers[source] ~= nil and isElement(trailers[source]) then destroyElement(trailers[source]) end
    local theVehicle = getPedOccupiedVehicle(source)
    local trailer = createVehicle(607,getElementPosition(source))
    attachTrailerToVehicle(theVehicle,trailer)
    trailers[source]=trailer
    end )
----------------------------------------------------------------------------------------------------------------------------------
--GIVE MONEY
----------------------------------------------------------------------------------------------------------------------------------
addEvent("onShowMoney",true)
addEventHandler("onShowMoney",root,
    function ()
        money = math.random (200,300)
        givePlayerMoney(source,money)
		exports.dendxmsg:createNewDxMessage(source,"Paid $"..money..". Get another assignment by going to the job location marker",0,255,0)
        end
)
addEventHandler("onPlayerQuit",root,function()
    if trailers[source] ~= nil and isElement(trailers[source]) then destroyElement(trailers[source]) trailers[source]=nil end
end)

addEventHandler("onPlayerQuit",root,function()
	if isElement(trailers[source]) then destroyElement(trailers[source]) end
end)

 addEvent("onPlayerJobChange",true)
function jobChange(nJob,oldJob)
    if oldJob == "Airport Attendant" then
        if isElement(trailers[source]) then destroyElement(trailers[source]) end
	elseif nJob == "Airport Attendant" then

	end
end
addEventHandler("onPlayerJobChange",root,jobChange)
