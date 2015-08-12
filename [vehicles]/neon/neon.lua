--determine whether color change can be made with a command
cmd = true
--the command to use
thecmd = "neon"
function neon(plr,cmd,r,g,b,a)
if not r then openGui(plr) return true end
if tonumber(tostring(r)) == nil then r,g,b,a = getColorFromString(r)
end
if not a then a = 200 end
veh = getPedOccupiedVehicle(plr)
if veh and r and g and b then
model = getElementModel(veh)
if canHaveNeon(veh) then 
if haveNeon(veh) then
setNeonColor(veh,tonumber(r),tonumber(g),tonumber(b))
end
end
end
end

if cmd then
addCommandHandler(thecmd,neon)
end

function setNeonColor(vehicle,r,g,b)
setElementData(vehicle,"neonlight",tostring(r)..","..tostring(g)..","..tostring(b)..","..tostring(a))
for i,mark in ipairs(getElementsByType("marker")) do
local type = getMarkerType(mark)
if type == "corona" then
local data1 = getElementData(vehicle,"neonMarker1")
local data2 = getElementData(vehicle,"neonMarker2")
if data1 == mark or data2 == mark then
setMarkerColor(mark,r,g,b,80)
end
end
end
return true
end



function haveNeon(vehicle)
local data = getElementData(vehicle,"haveneon")
if data then
return true
else
return false
end
end

function addNeon(vehicle,state)
if getElementType(vehicle) == "vehicle" then
if state then
setElementData(vehicle,"haveneon",true)
x,y,z = getElementPosition(vehicle)
--
local exist = nil
for i,mark in ipairs(getElementsByType("marker")) do
data = getElementData(vehicle,"neonMarker1")
if data == mark then
local exist = mark
end
end
if not exist then
local marker1 = createMarker(x,y,z,"corona",2,0,0,0,0)
attachElements(marker1,vehicle,0,-1,-1.2)
setElementData(vehicle,"neonMarker1",marker1)
local marker2 = createMarker(x,y,z,"corona",2,0,0,0,0)
attachElements(marker2,vehicle,0,1,-1.2)
setElementData(vehicle,"neonMarker2",marker2)
end
--
return true
else
setElementData(vehicle,"haveneon",false)
setElementData(veh,"neonlight","off!!!")
--
for i,mark in ipairs(getElementsByType("marker")) do
local type = getMarkerType(mark)
if type == "corona" then
local data1 = getElementData(vehicle,"neonMarker1")
local data2 = getElementData(vehicle,"neonMarker2")
if data1 == mark or data2 == mark then
setMarkerColor(mark,0,0,0,0)
end
end
end
--
return true
end
else
return false
end
end
function canHaveNeon(veh)
model = getElementModel(veh)
	if veh and getElementType(veh) == "vehicle" then
	x = mayHaveNeon(model)
	return x
	else
	return false
	end
end

function mayHaveNeon(model)
if model ~= 592 and model ~= 511 and model ~= 584 and model ~= 512 and model ~= 593 and model ~= 417 and
model ~= 487 and model ~= 553 and model ~= 488 and model ~= 563 and model ~= 476 and model ~= 519 and
model ~= 460 and model ~= 469 and model ~= 513 and model ~= 472 and model ~= 473 and model ~= 493 and
model ~= 595 and model ~= 484 and model ~= 430 and model ~= 453 and model ~= 452 and model ~= 446 and
model ~= 454 and model ~= 403 and model ~= 514 and model ~= 443 and model ~= 515 and model ~= 455 and
model ~= 406 and model ~= 486 and model ~= 578 and model ~= 532 and model ~= 524 and model ~= 498 and
model ~= 609 and model ~= 568 and model ~= 457 and model ~= 508 and model ~= 571 and model ~= 539 and
model ~= 606 and model ~= 607 and model ~= 485 and model and model ~= 581 and model ~= 509 and 
model ~= 481 and model ~= 462 and model ~= 521 and model ~= 463 and model ~= 510 and model ~= 522 and 
model ~= 461 and model ~= 448 and model ~= 468 and model ~= 586 and model ~= 485 and model ~= 552 and
model ~= 431 and model ~= 438 and model ~= 437 and model ~= 574 and model ~= 525 and model ~= 408 and
model ~= 416 and model ~= 433 and model ~= 427 and model ~= 490 and model ~= 528 and model ~= 407 and 
model ~= 544 and model ~= 523 and model ~= 470 and model ~= 596 and model ~= 597 and model ~= 598 and 
model ~= 599 and model ~= 432 and model ~= 601 and model ~= 428 and model ~= 499 and model ~= 449 and 
model ~= 537 and model ~= 538 and model ~= 570 and model ~= 569 and model ~= 590 and model ~= 441 and 
model ~= 464 and model ~= 501 and model ~= 465 and model ~= 564 and model ~= 594 then
return true
else
return false
end
end


function deactivateNeon(vehicle)
if getElementType(vehicle) == "vehicle" then
setElementData(vehicle,"neonlight","off!!!")
for i,mark in ipairs(getElementsByType("marker")) do
local type = getMarkerType(mark)
if type == "corona" then
local data1 = getElementData(vehicle,"neonMarker1")
local data2 = getElementData(vehicle,"neonMarker2")
if data1 == mark or data2 == mark then
setMarkerColor(mark,0,0,0,0)
end
end
end
return true
else
return false
end
end

function openGui(plr)
local veh = getPedOccupiedVehicle(plr)
if haveNeon(veh) then
triggerClientEvent(plr,"openNeonGui",root)
end
end

addEventHandler("onPlayerJoin",root,function()
for i,veh in ipairs(getElementsByType("vehicle")) do
data = getElementData(veh,"neonlight")
setElementData(veh,"neonlight",data)
end
end)

for i,veh in ipairs(getElementsByType("vehicle")) do
deactivateNeon(veh)
end

addEvent("closeNeonGui",true)
addEventHandler("closeNeonGui",root,function(r,g,b)
local veh = getPedOccupiedVehicle(source)
setNeonColor(veh,r,g,b)
end)