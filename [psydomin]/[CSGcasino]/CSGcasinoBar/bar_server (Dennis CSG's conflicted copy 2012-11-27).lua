local effectWalk = {}
function walkEffect(bool)
	effectWalk[source]=bool
end
addEvent("CSGcasinoShopEffectChange",true)
addEventHandler("CSGcasinoShopEffectChange",root,walkEffect)

function doEffect()
	for k,v in pairs(effectWalk) do
		if v == true then
			if isElement(k) and isPedInVehicle(k) == false then
				alcLevel = getElementData(k,"bloodAlcoholLevel")
				if tonumber(alcLevel) >= 3 then
					local tim = math.random(1000,3000)
					setPedAnimation(k,"ped","WALK_drunk",tim,true,true,false)
					setTimer(function () setPedAnimation(k,false) end,tim,1)
				end
			end
		else
			--table.remove(effectWalk,tostring(k))
		end
	end
end
setTimer(doEffect,5000,0)

-- Try script script better and more clean, this is my version, looks alot more clear and better though.
-- Scripting well and clean and using the ( ) in your code is better so other people can easy edit it.
-- Also with clean scripting it's much more fun, try it. Use more spaces like I do and use the ( ) in if statements

--[[
local effectWalk = {}

addEvent( "CSGcasinoShopEffectChange", true )
addEventHandler( "CSGcasinoShopEffectChange", root,
	function ( bool )
		effectWalk[source] = bool
	end
)

setTimer(
	function ()
		for thePlayer, state in pairs( effectWalk ) do
			if ( state ) then
				if ( isElement( thePlayer ) ) and not ( isPedInVehicle( thePlayer ) ) then
					if ( getElementData( thePlayer, "bloodAlcoholLevel" ) ) and tonumber( getElementData( thePlayer, "bloodAlcoholLevel" ) ) >= 3 then
						local aTime = math.random(1000,3000)
						setPedAnimation( thePlayer, "ped", "WALK_drunk", aTime, true, true, false )
						setTimer( setPedAnimation, aTime, 1 )
					end
				end
			else
				--table.remove(effectWalk,tostring(k))
			end
		end
	end, 5000,0
)

addEvent( "casino:buyDrink", true )
addEventHandler( "casino:buyDrink", root,
	function ( amount )
		takePlayerMoney( source, amount )
	end
)
) ]]--