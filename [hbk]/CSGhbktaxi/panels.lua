
function ride ()
	taxipick(source)
end
addEvent("ride", true)
addEventHandler("ride", getRootElement(), ride)


function close ()
   quitJob(source)
end
addEvent("close", true)
addEventHandler("close", getRootElement(), close)

