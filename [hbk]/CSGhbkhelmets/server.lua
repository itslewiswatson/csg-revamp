local helmets = {}

function HelmetsMod ( theVehicle, seat, jacked )
 --if ( getVehicleID ( theVehicle ) == 581 or 522 or 461 or 448 or 521 or 468 or 463 or 523 ) then
   if (getVehicleType(theVehicle) == "Bike") then
   local helmet = createObject(2050,0,0,0)
	helmets[source]=helmet
	exports.bone_attach:attachElementToBone(helmet,source,1,0.02,-0.01,-0.850,-0.50,0,100)
	setObjectScale ( helmet, 1.4 )
	exports.DENdxmsg:createNewDxMessage (source,"You can remove bike helmet by /helmetoff", 255, 255, 0)
	setTimer(
	function()
	if isElement(helmet) then destroyElement(helmet)
	end end,(60000*3),1)
  end
end
addEventHandler ( "onPlayerVehicleEnter", getRootElement(), HelmetsMod )


function onExitHelmetsMod ( theVehicle, seat, jacked )
  if isElement(helmets[source]) then
			destroyElement (helmets[source])
			helmets[source]=nil
  end
end

addEventHandler ( "onPlayerVehicleExit", getRootElement(), onExitHelmetsMod )
addEventHandler ( "onVehicleExit", getRootElement(), onExitHelmetsMod )
addEventHandler ( "onVehicleStartExit", getRootElement(), onExitHelmetsMod )
addEventHandler ( "onPlayerQuit", getRootElement(), onExitHelmetsMod )
addEventHandler ( "onVehicleRespawn", getRootElement(), onExitHelmetsMod )

function helof(thePlayer)
  if isElement(helmets[thePlayer]) then
			destroyElement (helmets[thePlayer])
			helmets[thePlayer]=nil
  end
end
addCommandHandler("helmetoff", helof)
