addEventHandler ("onClientResourceStart",root,
function ()
width, height = 314, 32
rx,ry = guiGetScreenSize()
x = (rx/2) - (width/2) --center the width with rx (resolution of the players monitor)
y = (ry/2) - (height/2) --center the hgith with ry (resolution of the players monitor
bar = guiCreateProgressBar (x, y, width, height, false)
guiSetVisible (bar, false)
end
)


function progress ()
number = guiProgressBarGetProgress (bar)
guiProgressBarSetProgress (bar, number + 1)
end

function hideGUI (element)
guiSetVisible (element, false)
end

function repairing ()
if (source == localPlayer) then
	guiSetVisible (bar, false)
	exports.CSGprogressbar:createProgressBar("Fixing..",52, "CSGhbkcarfix")
	guiProgressBarSetProgress (bar, 0)
	setTimer (progress, 50, 100)
	setTimer (hideGUI, 6300, 1, bar)

else return end
end
addEvent ("onRepair", true)
addEventHandler ("onRepair", root, repairing)
