local sigs = {}
  function myped ( thePlayer )
   if isPedInVehicle(thePlayer) then return end
        setElementData ( thePlayer, "smoking", not getElementData ( thePlayer, "smoking" ) )
        if sigs[thePlayer] == nil then
        setPedAnimation ( thePlayer, "SMOKING", "M_smk_drag" )
			local x, y, z = getElementPosition ( thePlayer )
            local sigarette = createObject ( 1485, 0, 0, 0 )
			sigs[thePlayer]=sigarette
            exports.bone_attach:attachElementToBone(sigarette,thePlayer,12,0.05,0.08,0.10,0,179,60)
		else
			setPedAnimation ( thePlayer )
			if isElement(sigs[thePlayer]) then
			destroyElement (sigs[thePlayer])
			sigs[thePlayer]=nil
		end

	end
	end
    addCommandHandler ( "smoke", myped )
