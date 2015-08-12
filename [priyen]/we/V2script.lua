  --<-- 1 joining/leaving marker + markers to millrooms.
	local timetillevent = 0
    joinM = {}
    leaveM = {}
	local data = {}
    nextWP=1
     local teams = {
            {"Team 1",x=276.01921875,y=-1877.94,z=164.75,r=255,g=0,b=0,rz=0},
            {"Team 2",x=276.01921875,y=-1888.04,z=164.75,r=0,g=255,b=0,rz=0},
            {"Team 3",x=266.5, y=-1876.5999755859, z=164.39999389648,r=55,g=221,b=32,rz=0},
            {"Team 4",x=266.5, y=-1876.5999755859, z=164.39999389648,r=250,g=145,b=3,rz=0},
        }

    local enterPos = {
    {2225.86,1838.49,11.81}-- <-- put the x,y,z of the join here
        }

    local exitPos = {
            {262.63,-1910.5471,173.83} -- <-- put the x,y,z of the leave here
        }

    local oldSkinAndColors = {}

    addEventHandler("onPlayerQuit",root,function()
            if oldSkinAndColors[source] then
                    oldSkinAndColors[source] = nil
                end
        end)

    function hitM(p,dim)
            if dim == true then
                    if getElementType(p) == "player" then
                            if joinM[source] then
                                oldSkinAndColors[p] = {getElementModel(p),getPlayerNametagColor(p)}
                                setElementPosition(p,teams[nextWP].x,teams[nextWP].y,teams[nextWP].z)
                                setElementRotation(p,0,0,teams[nextWP].rz)
                                setPlayerNametagColor(p,teams[nextWP].r,teams[nextWP].g,teams[nextWP].b)
								setElementDimension ( p , 3 )
								exports.DENdxmsg.createNewDxMessage(p,"You have automatically joined team "..nextWP..". Please wait here.",0,255,0)
                                nextWP=nextWP+1
								if not(data[nextWP-1]) then data[nextWP-1] = {} end
								table.insert(data[nextWP-1],p)

                                if nextWP > #teams then nextWP=1 end

                            elseif leaveM[source] then
                                setElementPosition(p,2223.9365234375,1837.9185791016,10.8203125) -- put here teh x,y,z to warp them to if they want to leave
                                setPlayerNametagColor(p,oldSkinAndColors[p][2],oldSkinAndColors[p][3],oldSkinAndColors[p][4])
                                setElementModel(p,oldSkinAndColors[p][1])
								setElementDimension ( p , 0 )
								for k,v in pairs(data) do
									for k2,tp in pairs(v) do
										if tp == p then
											table.remove(data[k],k2)
											return
										end
									end
								end
							end
                        end
                end
        end


local checkTimer = 0

 -->-- 2 - priyen do the descriptings big nab
local checkTimer = 0
setTimer(function()
	timetillevent=timetillevent-1
	if timetillevent < 0 then timetillevent=0 end
	if timetillevent <= 0 then
	if started==true then return end
	local temp = {}
	for k,v in pairs(data) do
		temp[k]=#v
	end
	local same = true

	 if temp[1] == temp[2] and temp[2] == temp[3] and temp[3] == temp[4] and temp[1] ~= 0 then
	started=true
	for k,v in pairs(getElementsByType("player")) do
        id = getElementModel(v)
		 if id == 223 then
			setElementDimension(v,3)
		exports.DENdxmsg:createNewDxMessage("Event starting!",v,0,255,0)
		 setElementPosition(v,288.41152954102,-1934.0023193359,152.4218139648)
	 elseif id == 224 then
		setElementDimension(v,3)
          exports.DENdxmsg:createNewDxMessage("Event starting!",v,0,255,0)
		 setElementPosition(v,237.14265441895,-1882.4931640625,155.3046875)
	 elseif id == 225 then
		setElementDimension(v,3)
          exports.DENdxmsg:createNewDxMessage("Event starting!",v,0,255,0)
		 setElementPosition(v,44.41819763184,-1912.9533691406,173.83280944824)
	 elseif id == 226 then
		setElementDimension(v,3)
          exports.DENdxmsg:createNewDxMessage("Event starting!",v,0,255,0)
		 setElementPosition(v,281.81500244141,-1903.2330322266,179.86563110352)
		 end
	end
		else
		timetillevent=30
		 end
	end
end,1000,0)



addCommandHandler("champtime",function(ps)
	exports.DENdxmsg:createNewDxMessage(ps,"Time Until Champion Event start: "..timetillevent.." seconds. You can enter in preparation.",0,255,0)
end)


    function makeMarkers()
            for k,v in pairs(enterPos) do
                    local x,y,z = unpack(v)
                    local m = createMarker(x,y,z,"arrow",2,255,0,0,100)

                    addEventHandler("onMarkerHit",m,hitM)
                    joinM[m]=true
                end
            for k,v in pairs(exitPos) do
                     local x,y,z = unpack(v)
                    local m = createMarker(x,y,z,"arrow",2,255,0,0,100)
                        setElementDimension ( m , 3 )
                    addEventHandler("onMarkerHit",m,hitM)
                    leaveM[m]=true
                end
        end
                    makeMarkers()






    --markers naabs : skin + name color

    local myMarker = createMarker(276.01921875,-1877.94,163.75, 'cylinder', 2.0, 255, 0, 0, 150)
    setElementDimension ( myMarker,3 )
     function   OnMarkerHit( hitElement, matchingDimension )
                local elementType = getElementType( hitElement )
                if elementType == "player" then
                        setPlayerNametagColor(hitElement, 255, 0,0)
                                             setElementModel(hitElement,223)
                end
        end
            addEventHandler( "onMarkerHit", myMarker, OnMarkerHit )




    local myMarker1 = createMarker(276.01921875,-1888.04,163.75, 'cylinder', 2.0, 0, 255, 0, 150)
    setElementDimension ( myMarker1 , 3 )
     function   OnMarkerHit( hitElement, matchingDimension )
                local elementType = getElementType( hitElement )
                if elementType == "player" then
                        setPlayerNametagColor(hitElement, 0, 255, 0)
                                             setElementModel(hitElement,224)
                end
        end
            addEventHandler( "onMarkerHit", myMarker1, OnMarkerHit )


    local myMarker2 = createMarker(265.5, -1888.8000488281, 163.39999389648, 'cylinder', 2.0, 0, 0, 255, 150)
    setElementDimension ( myMarker2 , 3 )
    function   OnMarkerHit( hitElement, matchingDimension )
                local elementType = getElementType( hitElement )
                if elementType == "player" then
                        setPlayerNametagColor(hitElement, 55, 221, 32)
                                            setElementModel(hitElement,225)
            end
            end
            addEventHandler( "onMarkerHit", myMarker2, OnMarkerHit )

    local myMarker3 = createMarker(266.5, -1876.5999755859, 163.39999389648, 'cylinder', 2.0, 250, 145, 3, 150)
    setElementDimension ( myMarker3 , 3 )
    function   OnMarkerHit( hitElement, matchingDimension )
                local elementType = getElementType( hitElement )
                if elementType == "player" then
                        setPlayerNametagColor(hitElement, 250, 145, 3)
                                            setElementModel(hitElement,226)
                end
        end
            addEventHandler( "onMarkerHit", myMarker3, OnMarkerHit )

    --pos to cas





  addEventHandler( "onPlayerWasted", getRootElement( ),
function ()
 local allowedSkins = {[223]=true,[224]=true,[225]=true,[226]=true}
 local id = getElementModel(source)
 if not(allowedSkins[id]) then return end

 local count = 0
 for k,v in pairs(getElementsByType("player")) do
	if getElementModel(v) == id and getElementDimension(v) == 3 then
		if isPedDead(v) == false then
			count=count+1
		end
	end
 end
 if count == 0 then --this team died
	local deadTeamID = id
	warpBack(id)
 end
 end)

 function warpBack(notToWarpID)
	outputDebugString("A team has died! Round Restarting... team "..notToWarpID.." died",root,0,255,0)
	for k,v in pairs(getElementsByType("player")) do
		local id = getElementModel(v)
		if id ~= notToWarpID then
			if getElementDimension(v) == 3 then
				if isPedDead(v) == false then
					if id == 223 then
						setElementPosition (source, 288.41152954102,-1934.0023193359,151.4218139648)
						setElementDimension (source , 3 )
					elseif id == 224 then
  						setElementPosition (source, 237.14265441895,1882.4931640625,155.3046875)
  						setElementDimension (source , 3 )
					elseif id == 225 then
 						 setElementPosition (source, 244.41819763184,-1912.9533691406,173.83280944824)
 						 setElementDimension (source , 3 )
					elseif id == 226 then
  						setElementPosition (source, 281.81500244141,-1903.2330322266,179.86563110352)
						setElementDimension (source , 3 )
					end
				end
			end
		end
	end
 end

 --additional temp maybe we will use.


    local tempCol = createColCuboid (217,-1960, 150, 180 , 120 , 40 )
    setElementDimension ( tempCol , 3 )




     --- money for kills
local counter1 = 0
     addEvent("onPlayerWasted",true)
    addEventHandler("onPlayerWasted",getRootElement(),
    function (_,killer)
    local dim = getElementDimension( source )
    if dim == 3 then
		givePlayerMoney(killer,4000)
		exports.DENdxmsg:createNewDxMessage(killer,"Congratz, you killed a person. Got $4000",0,255,0)
    end end )


--[[
    addEventHandler("onPlayerWasted",getRootElement(),

    function ()
	for k,v in pairs(getElementsByType("player")) do
	local numofp223 = 0
	local numofp224 = 0
	local numofp225 = 0
	local numofp226 = 0
    local dim = getElementDimension( v )
	local id = getElementModel ( v )
	--
    if id == 223 then
	numofp223=numofp223+1
	elseif id == 224 then
	numofp223=numofp224+1
	elseif id == 225 then
	numofp223=numofp225+1
	elseif id == 226 then
	numofp223=numofp226+1 end
	--
	if numofp223 == 0 and numofp224 == 0 and numofp225 == 0
	then
	if id == 226 then
    givePlayerMoney(v,2500) end
	elseif numofp223 == 0 and numofp224 == 0 and numofp226 == 0
	then
	if id == 225 then
    givePlayerMoney(v,2500) end
    elseif numofp223 == 0 and numofp225 == 0 and numofp226 == 0
	then
	if id == 224 then
    givePlayerMoney(v,2500) end
	elseif numofp224 == 0 and numofp225 == 0 and numofp226 == 0
	then
	if id == 223 then
    givePlayerMoney(v,2500) end
	end end end )

--]]

																															-- BY HamzaB
