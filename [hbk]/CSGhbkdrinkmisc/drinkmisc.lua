local drin = {}
  function myped ( thePlayer )
  if isPedInVehicle(thePlayer) then return end
        setElementData ( thePlayer, "drinking", not getElementData ( thePlayer, "drinking" ) )
        if drin[thePlayer] == nil then
           setPedAnimation ( thePlayer, "Bar", "dnk_stndF_loop" )
			local x, y, z = getElementPosition ( thePlayer )
            local beer = createObject ( 1509, 0, 0, 0 )
			drin[thePlayer]=beer
            exports.bone_attach:attachElementToBone(beer,thePlayer,12,0.081,0.05,0.01,0,-70,0)
            setTimer(myped,5000,1,thePlayer)
			setElementHealth(thePlayer,getElementHealth(thePlayer)-0.5)



		else
			setPedAnimation ( thePlayer )
			if isElement(drin[thePlayer]) then
			destroyElement (drin[thePlayer])
			drin[thePlayer]=nil
			 setPedAnimation ( thePlayer, "ped", "WALK_drunk",5000,true,true,true,true)

		end
	end
	end
    addCommandHandler ( "drink", myped )
