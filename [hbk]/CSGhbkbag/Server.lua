    spawnBagC = {}
spawnBagC[1] = {-394.46, 2214.62, 43}
spawnBagC[2] = {2494, -1463.4732666016, 25}
spawnBagC[3] = {1522.3254394531, -2392.6799316406, 14}
spawnBagC[4] = {885, -651.28021240234, 111}
spawnBagC[5] = {2324.7416992188, 61, 26}
spawnBagC[6] = {94, -164.48936462402, 4}
spawnBagC[7] = {-2706.1940917969, 375, 5}
spawnBagC[8] = {-1343.7061767578, 440, 8}
spawnBagC[9] = {-2661.9990234375, 1507, 58}
spawnBagC[10] = {-2172.1987304688, -2407, 36}

	local drugs = {
		"Ecstasy",
		"Ritalin",
		"LSD",
		"Weed",
		"Cocaine"
	}


    function TimerOfSpawn ()
        setTimer ( spawnBag, 1000, 1 )
    end
     addEventHandler("onResourceStart",resourceRoot, TimerOfSpawn)

    function spawnBag ()
        area = math.random ( 1, #spawnBagC )
        x,y,z = unpack ( spawnBagC[area] )
        bag = createPickup ( x, y, z, 3, 1550 )
		blips = createBlipAttachedTo(bag,37)
		for k,v in pairs(getElementsByType("player")) do
			exports.dendxmsg:createNewDxMessage(v,"A Mystery bag has been placed on the map, find it to get some interesting goods!",0,255,0)
		end
	end

    function enterBag (player)
        if (source == bag) then
            money = math.random (2000,5000)
            givePlayerMoney ( player, money )
			local p = getPlayerName(player)

			for k,v in pairs(getElementsByType("player")) do
				exports.dendxmsg:createNewDxMessage (v,""..p.." has found the Mystery Bag!", 0, 200, 0)
			end
			exports.dendxmsg:createNewDxMessage(player,"Found $"..money.."",0,255,0)
			local drug = drugs[math.random(#drugs)]
			local hits = math.random(5,12)
			exports.CSGdrugs:giveDrug(player,drug,hits)
			exports.dendxmsg:createNewDxMessage(player,"Found "..hits.." of "..drug.."",0,255,0)
            if isElement( bag ) then
         	destroyElement( bag )
			end
            if isElement( blips ) then
	        destroyElement( blips )
            end
			setTimer ( TimerOfSpawn, 850000, 1 )
    end
	end
    addEventHandler ("onPickupUse", getResourceRootElement(getThisResource()), enterBag)
