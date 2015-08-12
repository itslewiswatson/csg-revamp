local theClockFont = "Tahoma bold"

function onResStart ()
local dxStatus = dxGetStatus()
	if tonumber(dxStatus['VideoMemoryFreeForMTA']) > 250 then
		local testFont = guiCreateFont( "tutano_cc_v2.ttf", 0.07*BGWidth )
		if testFont then
			theClockFont = testFont
		end		
	end
end	
addEventHandler ( "onClientResourceStart", getResourceRootElement(getThisResource()), onResStart )


local clockGUI = {}

function convertToWeekDay(day)

	if day == 0 then return "Sunday"
	elseif day == 1 then return "Monday"
	elseif day == 2 then return "Tuesday"
	elseif day == 3 then return "Wednesday"
	elseif day == 4 then return "Thursday"
	elseif day == 5 then return "Friday"
	elseif day == 6 then return "Saturday"
	end

end

function openClockApp()

	local timesTable = getRealTime()
	
	if timesTable["year"] then timesTable["year"] = tonumber(timesTable["year"]) + 1900 end	
	if timesTable["month"] < 10 then timesTable["month"] = 0 .. (tonumber(timesTable["month"])+1) end	
	if timesTable["monthday"] < 10 then timesTable["monthday"] = 0 .. timesTable["monthday"] end	
	if timesTable["weekday"] then timesTable["weekday"] = convertToWeekDay(timesTable["weekday"]) end	
	if timesTable["hour"] < 10 then timesTable["hour"] = 0 .. timesTable["hour"] end	
	if timesTable["minute"] < 10 then timesTable["minute"] = 0 .. timesTable["minute"] end	
	if timesTable["second"] < 10 then timesTable["second"] = 0 .. timesTable["second"] end	
	if not clockGUI[4] then
		clockGUI[1] = guiCreateLabel ( BGX, BGY+(BGHeight*0.1), BGWidth, BGHeight*0.2,timesTable["year"], false )
		clockGUI[2] = guiCreateLabel ( BGX, BGY+(BGHeight*0.3), BGWidth, BGHeight*0.2,timesTable["month"].."/"..timesTable["monthday"], false)
		clockGUI[3] = guiCreateLabel ( BGX, BGY+(BGHeight*0.5), BGWidth, BGHeight*0.2,timesTable["weekday"], false )
		clockGUI[4] = guiCreateLabel ( BGX, BGY+(BGHeight*0.7), BGWidth, BGHeight*0.2,timesTable["hour"]..":"..timesTable["minute"]..":"..timesTable["second"], false)
			for i=1, #clockGUI do
	
				guiLabelSetHorizontalAlign ( clockGUI[i], "center" )
				guiLabelSetVerticalAlign ( clockGUI[i], "center" )
				guiSetFont ( clockGUI[i], theClockFont )
				guiLabelSetColor ( clockGUI[i], math.random(200,255),math.random(200,255),math.random(200,255) )
				
		
			end
			
	end
	
	for i=1, #clockGUI do
	
		guiSetProperty ( clockGUI[i], "AlwaysOnTop", "True" )
		guiSetVisible ( clockGUI[i], true )
		
	end

	updateTimeTimer = setTimer ( updateTime, 1000, 0 )
	apps[6][7] = true
	
end

apps[6][8] = openClockApp

function updateTime()

local timesTable = getRealTime()
	
if timesTable["year"] then timesTable["year"] = tonumber(timesTable["year"]) + 1900 end	
if timesTable["month"] < 10 then timesTable["month"] = 0 .. (tonumber(timesTable["month"])+1) end	
if timesTable["monthday"] < 10 then timesTable["monthday"] = 0 .. timesTable["monthday"] end	
if timesTable["weekday"] then timesTable["weekday"] = convertToWeekDay(timesTable["weekday"]) end	
if timesTable["hour"] < 10 then timesTable["hour"] = 0 .. timesTable["hour"] end	
if timesTable["minute"] < 10 then timesTable["minute"] = 0 .. timesTable["minute"] end	
if timesTable["second"] < 10 then timesTable["second"] = 0 .. timesTable["second"] end	

	guiSetText ( clockGUI[1], timesTable["year"] )
	guiSetText ( clockGUI[2], timesTable["month"].."/"..timesTable["monthday"] )
	guiSetText ( clockGUI[3], timesTable["weekday"] )
	guiSetText ( clockGUI[4], timesTable["hour"]..":"..timesTable["minute"]..":"..timesTable["second"] )



end

function closeClockApp()

	for i=1, #clockGUI do
	
		if isElement(clockGUI[i]) then
		
			guiSetProperty ( clockGUI[i], "AlwaysOnTop", "False" )
			guiSetVisible ( clockGUI[i], false )	
			
		end
		
	end

	killTimer ( updateTimeTimer )
	apps[6][7] = false

end

apps[6][9] = closeClockApp
