local deck1 = createObject (9586, 1186.9794921875, 3777, 19.299999237061) -- Main Deck
local container1 = createObject(9587, 1187.2470703125, 3767.0283203125, 25.899) -- Containers On The Deck
local container2 = createObject(9588, 1187.6552734375, 3771, 9.497802734375) -- Containers On The Under Deck
local deck2 = createObject(9590, 1187.21875, 3770.1708984375, 10.75) -- Under Deck
local hull = createObject(9585, 1186.974609375, 3774.7158203125, 9.25) -- Ship Hull
local siderails = createObject(9761, 1187.099609375, 3776.3056640625, 29.299999237061) -- Side Rails
local bridge = createObject(9584, 1186.9794921875, 3849.9599609375, 28.445) -- Bridge 
local bridge2 = createObject(9698, 1185.8000488281, 3838, 31.347984313965) -- Bridge Interior
local eletronics1 = createObject(9819, 1193.0834960938, 3834.9606933594, 35.35) -- Eletronics In The Bridge
local eletronics2 = createObject(9818, 1184.9853515625, 3834.869140625, 38.14) -- Eletronics In The Bridge

-- Attachments Of The Parts
attachElements(deck1, hull, -2.28, 0, 10.1)
attachElements(deck2, hull, 6.35, 0, 1.8)
attachElements(container1, hull, 8, 0, 16.6)
attachElements(container2, hull, 5.7, 0, 0.6)
attachElements(siderails, hull, -1.4, 0, 20)
attachElements(bridge, hull, -75.2, 0.01, 19.2)
attachElements(bridge2, hull, -63.7, -1.15, 22.1)
attachElements(eletronics1, hull, -60.5, 6.2, 26)
attachElements(eletronics2, hull, -60.3, 0, 26.7)

function GUIness(source)
         local taccount = getPlayerAccount ( source )
           if isAdminAccount(taccount) then
		triggerClientEvent(source, "makeGUI", root)
	end
end
addCommandHandler("cargo", GUIness)  -- Command for opening GUI

function goToCargo(source)
         local taccount = getPlayerAccount ( source )
          if isAdminAccount(taccount) then 
		local x,y,z = getElementPosition(hull)
		setElementPosition(source, x, y, z + 25)
	end
end
addCommandHandler("gotocargo", goToCargo)  -- Command for warping to the ship

function setCargoHeightFunc(playerSource, commandName, height)
	if (height) then
             local taccount = getPlayerAccount ( source )
                if isAdminAccount(taccount) then
			local x,y,z = getElementPosition(hull)
			setElementPosition(hull, x, y, tonumber(height))
		end
	end
end
addCommandHandler("cargoheight", setCargoHeightFunc)

function isAdminAccount(account)
  local nick = ""
  local group = aclGetGroup("Sr.Admin")
  if (account and group) then
    nick = string.lower(getAccountName(account) or "")
    for _, object in ipairs(aclGroupListObjects(group) or {}) do
      if (gettok(object, 1, string.byte('.')) == "user") then
        if (nick == string.lower(gettok(object, 2, string.byte('.')))) then
          return true
        end
      end
    end
  end
  return false
end

function stopCargoFunc()
	stopObject(hull)
end
addEvent("stopCargo", true)
addEventHandler("stopCargo", root, stopCargoFunc)



-- Cargo Ship Raise/Lower/Reset
function cargoHeightFunc(theValue)
	local x,y,z = getElementPosition(hull)
	if theValue == 5.5 then
		moveObject(hull, 0, x, y, 5.5)
	else
		moveObject(hull, 5000, x, y, z + theValue)
	end
end
addEvent("cargoHeight", true)
addEventHandler("cargoHeight", root, cargoHeightFunc)

-- Cargo Ship Warper
function cargoWarper(x, y, z)
	moveObject(hull, 0, x, y, z)
end
addEvent("moveToBut", true)
addEventHandler("moveToBut", root, cargoWarper)

-- Directional Movement Controls
function cargoMove(xD, yD, zD)
	local x,y,z = getElementPosition(hull)
	moveObject(hull, 20000, x + xD, y + yD, z + zD)
end
addEvent("cargoMoveEvent", true)
addEventHandler("cargoMoveEvent", root, cargoMove)

-- Rotational Movement Controls
function cargoRotateFunc(rX, rY, rZ)
	local x,y,z = getElementPosition(hull)
	moveObject(hull, 5000, x, y, z, rX, rY, rZ)
end
addEvent("cargoRotate", true)
addEventHandler("cargoRotate", root, cargoRotateFunc)