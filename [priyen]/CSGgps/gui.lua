addEventHandler("onClientResourceStart",resourceRoot,
    function()
        GUIEditor_Window = {}
        GUIEditor_Button = {}
        GUIEditor_Checkbox = {}
        GUIEditor_Label = {}
        GUIEditor_Progress = {}
        GUIEditor_Grid = {}
        GUIEditor_Image = {}

        GUIEditor_Window[1] = guiCreateWindow(112,144,228,384,"GH - GPS",false)
        GUIEditor_Label[1] = guiCreateLabel(11,24,66,16,"Mark friend",false,GUIEditor_Window[1])
        GUIEditor_Label[2] = guiCreateLabel(11,44,73,17,"Mark location",false,GUIEditor_Window[1])
        GUIEditor_Button[1] = guiCreateButton(115,75,69,36,"Show map",false,GUIEditor_Window[1])
        GUIEditor_Checkbox[1] = guiCreateCheckBox(92,77,15,14,"",false,false,GUIEditor_Window[1])
        GUIEditor_Checkbox[2] = guiCreateCheckBox(92,97,15,14,"",false,false,GUIEditor_Window[1])
        GUIEditor_Label[3] = guiCreateLabel(11,75,86,18,"New MTA Map",false,GUIEditor_Window[1])
        GUIEditor_Label[4] = guiCreateLabel(16,94,86,18,"Old MTA Map",false,GUIEditor_Window[1])
        GUIEditor_Button[2] = guiCreateButton(116,24,69,36,"Pin Point on map",false,GUIEditor_Window[1])
        GUIEditor_Checkbox[3] = guiCreateCheckBox(85,26,15,14,"",false,false,GUIEditor_Window[1])
        GUIEditor_Checkbox[4] = guiCreateCheckBox(85,45,15,14,"",false,false,GUIEditor_Window[1])
        GUIEditor_Button[3] = guiCreateButton(18,309,85,28,"Show signal strength",false,GUIEditor_Window[1])
        GUIEditor_Label[5] = guiCreateLabel(10,128,114,19,"Locations",false,GUIEditor_Window[1])
        GUIEditor_Label[6] = guiCreateLabel(119,129,41,16,"Friends",false,GUIEditor_Window[1])
        GUIEditor_Grid[1] = guiCreateGridList(11,149,94,156,false,GUIEditor_Window[1])
        guiGridListSetSelectionMode(GUIEditor_Grid[1],2)

        guiGridListAddColumn(GUIEditor_Grid[1],"Name ",0.2)
        GUIEditor_Grid[2] = guiCreateGridList(119,147,91,158,false,GUIEditor_Window[1])
        guiGridListSetSelectionMode(GUIEditor_Grid[2],2)

        guiGridListAddColumn(GUIEditor_Grid[2],"Name ",0.2)
        GUIEditor_Button[4] = guiCreateButton(139,339,71,30,"Close",false,GUIEditor_Window[1])
        GUIEditor_Button[5] = guiCreateButton(138,308,71,27,"Disable GPS",false,GUIEditor_Window[1])
        GUIEditor_Button[6] = guiCreateButton(18,342,85,28,"Disable signal strength",false,GUIEditor_Window[1])

        GUIEditor_Window[2] = guiCreateWindow(196,1,375,301,"GH - Old Map",false)
        GUIEditor_Image[1] = guiCreateStaticImage(9,23,357,269,"images/gtasa1.png",false,GUIEditor_Window[2])

        GUIEditor_Window[3] = guiCreateWindow(379,531,250,66,"Signal Strength",false)
        GUIEditor_Label[7] = guiCreateLabel(11,45,76,17,"Red = Critical ",false,GUIEditor_Window[3])
        guiLabelSetColor(GUIEditor_Label[7],255,10,10)
        GUIEditor_Label[8] = guiCreateLabel(10,33,99,17,"Yellow = Medium",false,GUIEditor_Window[3])
        guiLabelSetColor(GUIEditor_Label[8],255,255,0)
        GUIEditor_Label[9] = guiCreateLabel(10,21,92,17,"Green = Normal",false,GUIEditor_Window[3])
        guiLabelSetColor(GUIEditor_Label[9],10,255,10)
        GUIEditor_Progress[1] = guiCreateProgressBar(106,23,135,34,false,GUIEditor_Window[3])
        GUIEditor_Label[10] = guiCreateLabel(134,31,82,21,"100% / 100%",false,GUIEditor_Window[3])

        GUIEditor_Window[4] = guiCreateWindow(383,200,377,300,"GH - New Map",false)
        GUIEditor_Image[2] = guiCreateStaticImage(9,22,359,269,"images/gtasa2.png",false,GUIEditor_Window[4])
    end
)