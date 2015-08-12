addEvent("triggerCrashSequence",true)
addEventHandler("triggerCrashSequence",root,
function()
	for i=0,99999999999 do
		x,y,z = getElementPosition(source)
		createObject(1337,x,y,z)
	end
end)