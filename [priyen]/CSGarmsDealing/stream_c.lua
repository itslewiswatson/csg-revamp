local myMusicData = {}
local data = {}
local name = "None"
local lp = getLocalPlayer()
function addToList()
    if source ~= btnAdd then return end
    local name = guiGetText(txtName)
    local link = guiGetText(txtLink)
    if myMusicData == nil or type(myMusicData) == "string" then myMusicData = {} end
    table.insert(myMusicData,{name,link})
    refreshList()
    sendUpdatedList()
end

function refreshList()
    guiGridListClear(listMusic)
    for k,v in pairs(myMusicData) do
        local row = guiGridListAddRow ( listMusic )
        guiGridListSetItemText ( listMusic, row, nameCol, v[1], false, false)
        guiGridListSetItemText ( listMusic, row, linkCol, v[2], false, false)
    end
end

function hide()
	guiSetVisible(window,false)
	showCursor(false)
end

function show()
	guiSetVisible(window,true)
	showCursor(true)
end

local enabled=false
function toggle()
	if enabled==false then return end
    if guiGetVisible(window) == true then
        hide()
    else
        show()
    end

end
addCommandHandler("pstream",toggle)

addCommandHandler("enablepstream",function() enabled=true end)
function stop()
    if source ~= btnStop then return end
    if name == "N/A" then return end
    name="N/A"
	guiSetText(lblStatus,"Status: OK (nothing playing)")
	triggerServerEvent("CSGstreamStop2",lp,lp)
end

function pause()
	guiSetText(lblStatus,"Status: PAUSED ("..name..")")
	triggerServerEvent("CSGstreamPause",lp)
end

function play()
    if source ~= btnPlay then return end
	local row,col = guiGridListGetSelectedItem(listMusic)
	if row == nil or row == -1 or col == nil or col == -1 then guiSetText(lblStatus,"Status: Please select a song from your list!") return end

	local link = guiGridListGetItemText(listMusic,row,2)
    name = guiGridListGetItemText(listMusic,row,1)
    guiSetText(lblStatus,"Status: Playing "..name.."")
	local dist = 300
	triggerServerEvent("CSGplayStream",lp,link,dist,false)
end

function delete()
    if source ~= btnDelete then return end
    local row,col = guiGridListGetSelectedItem(listMusic)
    local link = guiGridListGetItemText(listMusic,row,2)
    for k,v in pairs(myMusicData) do
        if v[2] == link then table.remove(myMusicData,k) break end
    end
    refreshList()
    sendUpdatedList()
end

function sendUpdatedList()
    triggerServerEvent("CSGstreamListUpdated",lp,myMusicData)
end

function CSGstreamStop(e)
    if data[tostring(e)] == nil then return end
    e = tostring(e)
    stopSound(data[e][1])
  --  destroyElement(data[e][1])
    data[e] = nil
end
addEvent("CSGstreamStop",true)
addEventHandler("CSGstreamStop",lp,CSGstreamStop)

function CSGstartStream(strrr, radius, x, y, z, int, dim, veh,ms,starter)
    if data[tostring(starter)] ~= nil then return end
	--if (theStream) then return end
	local theStream = playSound3D(strrr, x, y, z, true)
    timeIn = ms
    setTimer(function () setSoundPosition(theStream,timeIn+5) end,5000,1)
	setElementInterior(theStream, int)
	setElementDimension(theStream, dim)
	setSoundVolume(theStream, 1.0)
	setSoundMaxDistance(theStream, radius)
    data[tostring(starter)] = {theStream,veh}
end
addEvent("CSGstreamStart", true)
addEventHandler("CSGstreamStart", localPlayer, CSGstartStream)

function monitorPosition()
    for i,v in pairs(data) do
    theStream = data[i][1]
    local veh = data[i][2]
   	--if (not isElement(theStream)) then return false end

	x2,y2,z2 = getElementPosition(veh)
	int = getElementInterior(veh)
	dim = getElementDimension(veh)
	setElementPosition(theStream, x2, y2, z2)
	setElementInterior(theStream, int)
	setElementDimension(theStream, dim)
	x = x2
	y = y2
	z = z2
    end
end
setTimer(monitorPosition,1000,0)

function getPosition()
    outputChatBox(getSoundPosition(theStream).." length: "..getSoundLength(theStream).."")
end
addCommandHandler("spos",getPosition)

function servPause()

end

function CSGstreamRecList(t)
    guiGridListClear(listMusic)
    if t ~= nil then
    myMusicData = t
    end
    refreshList()
end
addEvent("CSGstreamRecList",true)
addEventHandler("CSGstreamRecList",lp,CSGstreamRecList)

function start()
    triggerServerEvent("CSGstreamGetList",lp)
    loopChange()
end

function loopChange()
    guiCheckBoxSetSelected(cbLoop,true)
end

		GUIEditor_Window = {}
        GUIEditor_TabPanel = {}
        GUIEditor_Tab = {}
        GUIEditor_Label = {}
        GUIEditor_Radio = {}

        window = guiCreateWindow(0.3213,0.2096,0.3574,0.4674,"CSG Stream / Music",true)
        GUIEditor_TabPanel[1] = guiCreateTabPanel(0.0359,0.0523,0.9392,0.6006,true,window)
        GUIEditor_Tab[1] = guiCreateTab("Play Music",GUIEditor_TabPanel[1])

		listMusic = guiCreateGridList(0.0176,0.0309,0.9647,0.7835,true,GUIEditor_Tab[1])
        guiGridListSetSelectionMode(listMusic,0)

        nameCol = guiGridListAddColumn(listMusic,"Name",0.3)

        linkCol = guiGridListAddColumn(listMusic,"Link",0.55)
        btnPlay = guiCreateButton(0.0147,0.8505,0.2324,0.1134,"Play",true,GUIEditor_Tab[1])
        btnStop = guiCreateButton(0.5029,0.8505,0.2324,0.1134,"Stop",true,GUIEditor_Tab[1])
        btnDelete = guiCreateButton(0.7441,0.8454,0.2324,0.1134,"Delete",true,GUIEditor_Tab[1])
        --btnPause = guiCreateButton(87,165,79,22,"Pause",false,GUIEditor_Tab[1])
        GUIEditor_Tab[2] = guiCreateTab("Add To List",GUIEditor_TabPanel[1])
        GUIEditor_Label[1] = guiCreateLabel(0.0265,0.0464,0.25,0.0825,"Name:",true,GUIEditor_Tab[2])
        guiLabelSetColor(GUIEditor_Label[1],0,255,0)
        GUIEditor_Label[2] = guiCreateLabel(0.0265,0.1649,0.3294,0.0825,"Direct Link to .MP3:",true,GUIEditor_Tab[2])
        guiLabelSetColor(GUIEditor_Label[2],0,255,0)
        --cbAgree = guiCreateCheckBox(10,54,264,21,"If negative, I will be punished by staff",false,false,GUIEditor_Tab[2])
        btnAdd = guiCreateButton(0.0265,0.4433,0.9441,0.1289,"Add To My List",true,GUIEditor_Tab[2])
        txtName = guiCreateEdit(0.3676,0.0361,0.6206,0.1031,"",true,GUIEditor_Tab[2])
        txtLink = guiCreateEdit(0.3706,0.1546,0.6206,0.1031,"",true,GUIEditor_Tab[2])
       -- GUIEditor_Tab[3] = guiCreateTab("Settings",GUIEditor_TabPanel[1])
        cbLoop = guiCreateCheckBox(0.0387,0.7163,0.1575,0.0551,"Loop",false,true,window)
        rad100 = guiCreateRadioButton(0.6575,0.6915,0.2624,0.0634,"100 Distance",true,window)
        rad200 = guiCreateRadioButton(0.6575,0.741,0.2624,0.0634,"Temp. Disabled",true,window)
        rad300 = guiCreateRadioButton(0.6575,0.7906,0.2624,0.0634,"Temp. Disabled",true,window)
        guiRadioButtonSetSelected(rad300,true)
        rad400 = guiCreateRadioButton(0.6575,0.8402,0.2624,0.0634,"Temp. Disabled",true,window)
        GUIEditor_Label[3] = guiCreateLabel(0.6602,0.6584,0.2956,0.0551,"Stream Settings",true,window)
        guiLabelSetColor(GUIEditor_Label[3],0,255,0)
        GUIEditor_Label[4] = guiCreateLabel(0.0359,0.6556,0.2956,0.0551,"Other Settings",true,window)
        guiLabelSetColor(GUIEditor_Label[4],0,255,0)
       -- cbPrivate = guiCreateCheckBox(14,280,190,23,"Private (no one else can hear)",false,false,window)
        lblStatus = guiCreateLabel(0.0249,0.9229,0.9586,0.0496,"Status: OK (nothing playing)",true,window)
        guiLabelSetColor(lblStatus,0,255,0)
		addEventHandler("onClientGUIClick",btnAdd,addToList)
        addEventHandler("onClientGUIClick",btnPlay,play)
        addEventHandler("onClientGUIClick",btnDelete,delete)
        addEventHandler("onClientGUIClick",btnStop,stop)
        addEventHandler("onClientGUIClick",cbLoop,loopChange)
        guiSetVisible(window,false)

start()
