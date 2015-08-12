
function Bullut(thePlayer)
	local staff = exports.CSGstaff:isPlayerStaff(thePlayer)
    if ( staff ) then
	outputDebugString(tostring(staff))
	if isElement(Front) then return end
	setTimer(
	function()
	local theVehicle = getPedOccupiedVehicle (thePlayer)
	if getElementModel(getPedOccupiedVehicle(thePlayer)) == 541 then
	local Front = createObject(1155,255,255,255,255,255,255,true)
	local Rear = createObject(1156,0,0,0,0,0,0,true)
	local Sfront = createObject(1179,0,0,0,0,0,0,true)
	local Srear = createObject(1180,0,0,0,0,0,0,true)
	local Srear2 = createObject(1129,0,0,0,0,0,0,true)
    attachElements(Front,theVehicle,-0.98,1.7)
    attachElements(Rear,theVehicle,1.03,-1.4)
    attachElements(Sfront,theVehicle,0.8,2.2,0.1)
    attachElements(Srear,theVehicle,-0.65,-2.25,-0.02)
    attachElements(Srear2,theVehicle,0.50,-1.6,-0.4)
	setObjectScale(Front,0.95)
	setObjectScale(Rear,0.95)
	setObjectScale(Sfront,0.75)
	setObjectScale(Srear,0.70)
	setObjectScale(Srear2,0.80)
	outputChatBox("CSG Bullut Armor Shield",thePlayer,255,255,255)
	end end,3000,1)

end
end
addCommandHandler("bul", Bullut)

function Bullutr(thePlayer)
	local staff = exports.CSGstaff:isPlayerStaff(thePlayer)
    if ( staff ) then
	outputDebugString(tostring(staff))
	if isElement(Front) then	destroyElement(Front) end
	if isElement(Rear) then	destroyElement(Rear) end
	if isElement(Sfront) then	destroyElement(Sfront) end
	if isElement(Srear) then	destroyElement(Srear) end
	if isElement(Srear2) then	destroyElement(Srear2) end
    end
    end
addCommandHandler("rebul", Bullutr)

