      local resroot = getResourceRootElement(getThisResource())

      local root = getRootElement()

      addEventHandler("onResourceStart", resroot,
      function()
      a = createPickup (1177.6279296875, -1327.8449707031, 14.080068588257, 0, 0, 0)
      b = createPickup (2024.2919921875, -1407.0745849609, 17, 0, 0, 0)
      c = createPickup (1254.0422363281, 333, 19.8, 0, 0, 0)
	  d = createPickup (1610, 1819.4621582031, 10.8 , 0, 0, 0)
	  e = createPickup (-311.62896728516, 1054.9, 19.8 , 0, 0, 0)
	  f = createPickup (-2647.5534667969, 631, 14.8 , 0, 0, 0)
	  g = createPickup (-1521.7846679688, 2521, 55.8 , 0, 0, 0)
	  h = createPickup (-2199.390625, -2291.1560058594, 30.8 , 0, 0, 0)

	 end)
local canUse = {}
          addEventHandler("onPickupUse", root,
            function( thePlayer )
            if (source == a or source == b or source == c or source == d or source == e or source == f or source == g or source == h) then
			if canUse[thePlayer] == nil then canUse[thePlayer]=true end
			if canUse[thePlayer] == false then
				exports.DENdxmsg:createNewDxMessage(thePlayer,"The hospital cannot provide you assistance, come back later!",255,255,0)
			return
			end
			canUse[thePlayer]=false
			setTimer(function() if isElement(thePlayer) then else return end canUse[thePlayer]=true end,60000,1)
            local health = getElementHealth(thePlayer)
               if (health >=1 and health <= 40)  then
               local money = getPlayerMoney(thePlayer)
                    if (money >= 700) then
                  takePlayerMoney(thePlayer, 700)
				  setTimer(function() if isElement(thePlayer) then
					setElementHealth(thePlayer,getElementHealth(thePlayer)+((100-health)/5))
				  end
				  end,1000,5)
				   setElementHealth (thePlayer, 100 )
                   exports.DENdxmsg:createNewDxMessage(thePlayer,"* Received medical assitance! (Cost: $700)", 0, 255, 0)
				   return
                    else
				  exports.DENdxmsg:createNewDxMessage(thePlayer,"* You dont have enough money! (Cost: $700)", 255, 0, 0 )
				  return
                  end
               else
               if (health >=40 and health <= 70)  then
               local money = getPlayerMoney(thePlayer)
                    if (money >= 350) then
                  takePlayerMoney(thePlayer, 350)
				  setTimer(function() if isElement(thePlayer) then
					setElementHealth(thePlayer,getElementHealth(thePlayer)+((100-health)/5))
				  end
				  end,1000,5)
                   exports.DENdxmsg:createNewDxMessage(thePlayer,"* Received medical assitance! (Cost: $350)", 0, 255, 0)
				   return
				  else
				   exports.DENdxmsg:createNewDxMessage(thePlayer,"* You dont have enough money! (Cost: $350)", 255, 0, 0 )
				   return
				  end
else
               if (health >=70 and health <= 100)  then
               local money = getPlayerMoney(thePlayer)
                    if (money >= 250) then
                  takePlayerMoney(thePlayer, 250)
				  setTimer(function() if isElement(thePlayer) then
					setElementHealth(thePlayer,getElementHealth(thePlayer)+((100-health)/5))
				  end
				  end,1000,5)
                   exports.DENdxmsg:createNewDxMessage(thePlayer,"* Received medical assitance! (Cost: $250)", 0, 255, 0)
				   return
              else
			   exports.DENdxmsg:createNewDxMessage(thePlayer,"* You dont have enough money! (Cost: $250)", 255, 0, 0 )
			   return
				 end
end
			end
end

end
end


		 )
