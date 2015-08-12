GUIEditor_Label = {}
-- Version number
local _version = "2.3"
local revision = "0" --set as 0 til they get the data.

window = guiCreateWindow(0.268,0.263,0.4578,0.3854,"~ Welcome to Community of Social Gaming ~",true)
guiWindowSetSizable(window,false)
theGrid = guiCreateGridList(0.0188,0.2736,0.9625,0.5946,true,window)
guiGridListSetSelectionMode(theGrid,2)

guiGridListAddColumn(theGrid,"Entry",0.75)

--guiGridListAddColumn(theGrid,"Date",0.2)

guiGridListAddColumn(theGrid,"Developer",0.2)

for i = 1, 1 do
    guiGridListAddRow(theGrid)
end
GUIEditor_Label[1] = guiCreateLabel(0.3891,0.0912,0.1195,0.0574,"CSG: ".._version,true,window)
guiLabelSetColor(GUIEditor_Label[1],255,165,0)
lblVersion = guiCreateLabel(0.5119,0.0912,0.2048,0.0574,"V 1.0.3",true,window)
guiLabelSetColor(lblVersion,255,255,0)
btnClose = guiCreateButton(0.0188,0.8851,0.9608,0.0845,"Close",true,window)
lblMessage = guiCreateLabel(0.0222,0.1588,0.9573,0.1081,""..getPlayerName(localPlayer)..", since your last visit (November 27th, 2012 at 5:03 pm), CSG was updated. Please see below for the latest changes. The green indicates changes you might not be aware of.",true,window)
guiLabelSetColor(lblMessage,255,250,255)
guiLabelSetHorizontalAlign(lblMessage,"left",true)
guiSetVisible(window,false)
guiGridListSetSelectionMode(theGrid,1)

somethingNew = false
function show()
	guiSetVisible(window,true)
	if somethingNew == true then
		guiSetEnabled(btnClose,false)
		enableTime = 6
		guiSetText(btnClose,"Close("..enableTime..")")
		setTimer(function() enableTime=enableTime-1 guiSetText(btnClose,"Close("..enableTime..")") if enableTime == 0 then guiSetEnabled(btnClose,true) guiSetText(btnClose,"Close") somethingNew = false end end,1000,6)
	end
	showCursor(true)
end

function check()
	if tonumber(myVersion) ~= theLatestVersion then
		xmlNodeSetValue(xmlFindChild(xmlHudBranch,"myVersion",0),tostring(theLatestVersion))
		xmlSaveFile(xmlRootTree)
		show()
	end
end
addEvent("CSGupdates.loggedIn",true)
addEventHandler("CSGupdates.loggedIn",localPlayer,check)

function hide()
	guiSetVisible(window,false)
	showCursor(false)
end


addCommandHandler("updates",show)

function click()
	if source == btnClose then
		hide()
	end
end
addEventHandler("onClientGUIClick",root,click)

function rec(theTable,myVersion,latestVersion,lastVisit)
	guiSetText(lblMessage,""..getPlayerName(localPlayer)..", you were last on CSG, "..lastVisit..". Please see below for the latest changes. The green indicates changes you might not be aware of.",true,window)
	for cat,v in ipairs(theTable) do
		local catRow = guiGridListAddRow( theGrid )
		guiGridListSetItemText( theGrid, catRow, 1, ""..v[2].." ("..v[3]..")", true, false )
		if myVersion < v[1] then
			somethingNew = true
			guiGridListSetItemColor(theGrid,catRow,1,0,255,0)
		end
		if v[1] == latestVersion then
			guiSetText(lblVersion,tostring(v[2]))
		end
		for k,data in pairs(v[4]) do
			local desc = data[1]
			local dev = data[2]
			local theRow = guiGridListAddRow( theGrid )
			guiGridListSetItemText( theGrid, theRow, 1, desc, false, false)
			guiGridListSetItemText( theGrid, theRow, 2, dev, false, false)
			if myVersion < v[1] then
				guiGridListSetItemColor(theGrid,theRow,1,0,255,0)
				guiGridListSetItemColor(theGrid,theRow,2,0,255,0)
			end
		end
	end
end

local months = {
	"January","February","March","April","May","June","July","August","September","October","November","December"
}

function getFormattedDate(stamp)
	local month = ""
	local year = ""
	local day = ""
	stamp=tostring(stamp)
	for i = 1, #stamp do
		local c = stamp:sub(i,i)
		if i > 0 and i < 5 then
			year = year..""..c..""
		end
		if i == 5 or i == 6 then
			month=month..""..c..""
		end
		if i > 6 then
			day=day..""..c..""
		end
	end
	local mName=months[tonumber(month)]
	local formatted = mName.." "..day..", "..year..""
	return formatted
end
--[[
function ClientResourceStart ()
	if source ~= getResourceRootElement() then return end --This event will happen with any resource start, isolate it to this resource
	xmlStart()
end
addEventHandler ( "onClientResourceStart", root, ClientResourceStart )
--]]
function xmlStart()
	xmlRootTree = xmlLoadFile ( "userSettings.xml" ) --Attempt to load the xml file
	if xmlRootTree then -- If the xml loaded then...
		xmlHudBranch = xmlFindChild(xmlRootTree,"data",0) -- Find the hud sub-node
	else -- If the xml does not exist then...
		xmlRootTree = xmlCreateFile ( "userSettings.xml", "root" ) -- Create the xml file
		xmlHudBranch = xmlCreateChild ( xmlRootTree, "data" ) -- Create the hud sub-node under the root node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "myVersion"), "60" ) --Create sub-node values under the hud sub-node
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "lastDate"), "Never" )
		xmlNodeSetValue (xmlCreateChild ( xmlHudBranch, "lastTime"), "Never" )
		xmlSaveFile ( xmlRootTree )
		xmlStart()
		return
	end

	myVersion = tonumber(xmlNodeGetValue (xmlFindChild(xmlHudBranch,"myVersion",0)))
	  myDate = xmlNodeGetValue (xmlFindChild(xmlHudBranch,"lastDate",0))
	  myTime = xmlNodeGetValue (xmlFindChild(xmlHudBranch,"lastTime",0))
	theMainData = {

	}


	--theLatestVersion = 210
	--rec(theMainData,myVersion,theLatestVersion,""..myDate.." at "..myTime.."")
	local newDate = getFormattedDate(exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
	local theTim = getRealTime()
	local newTime = ""..(theTim.hour)..":"..(theTim.minute)..""
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastDate",0),newDate)
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastTime",0),newTime)
end

function ClientResourceStop ()
	if source ~= getResourceRootElement() then return end --This event will happen with any resource stop, isolate it to this resource
	local newDate = getFormattedDate(exports.CSGpriyenmisc:getTimeStampYYYYMMDD())
	local theTim = getRealTime()
	local newTime = ""..(theTim.hour)..":"..(theTim.minute)..""
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastDate",0),newDate)
	xmlNodeSetValue(xmlFindChild(xmlHudBranch,"lastTime",0),newTime)
	xmlSaveFile ( xmlRootTree ) --Save the xml from memory for use next time
	xmlUnloadFile ( xmlRootTree ) --Unload the xml from memory
end
addEventHandler ( "onClientResourceStop", root, ClientResourceStop )


-- onClientRender
local sx, sy = guiGetScreenSize()

addEventHandler( "onClientRender", root,
	function ()
		local text = "CSG: ".._version.." Revision: #"..revision..""
		local size = dxGetTextWidth(text)
		dxDrawText(text, sx*(1315.0/1440)-size+10,sy*(872.0/900)+10,sx*(1430.0/1440),sy*(885.0/900), tocolor(255, 255, 255, 100), 1, "default", "left", "top", false, false, true, true, false)
	end
)

addEvent("recUpdatedList",true)
addEventHandler("recUpdatedList",localPlayer,function(list,version)
	xmlStart()
	guiGridListClear(theGrid)
	list = table.reverse(list)
	local tabsMade = {}
	local indexs = {}
	for k,v in ipairs(list) do
		if not(tabsMade[tonumber(v.version)]) then
			tabsMade[tonumber(v.version)] = true
			table.insert(theMainData,1,{tonumber(v.version),"Revision "..tonumber(v.version).."",v.date,{}})
			indexs[tonumber(v.version)] = 0
			for k,v in pairs(indexs) do
				indexs[k] = v+1
			end
		end
		table.insert(theMainData[indexs[tonumber(v.version)]][4],1,{v.text,v.fixedBy})
	end
	revision = theMainData[1][1]
	--theMainData = table.reverse(theMainData)

	--outputDebugString(tostring(_version))
	rec(theMainData,myVersion,theMainData[1][1],""..myDate.." at "..myTime.."")
	xmlSaveFile(xmlRootTree)
	show()
end)

addEvent("recVersion",true)
addEventHandler("recVersion",root,
function(version)
	if (version) then
		_version = version
		guiSetText(GUIEditor_Label[1],_version)
	else
		_version = "#FF0000ERROR - Can't find version!#FF0000"
	end

end)

function table.reverse ( tab )
    local size = #tab
    local newTable = {}

    for i,v in ipairs ( tab ) do
        newTable[size-i] = v
    end

    return newTable
end
