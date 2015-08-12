local resX, resY = guiGetScreenSize()

local isDrawing  = false
local theEvent   = false
local theText    = false
local barProcent = false
local theTimers  = {}

local R1, G1, B1, R2, G2, B2 = false, false, false, false, false, false

function createProgressBar ( dText, dTime, dEvent, DR1, DG1, DB1, DR2, DG2, DB2 )
	if not ( isDrawing ) then
		if ( dTime < 50 ) then return false end
		if not ( DR1 ) then R1 = 225 else R1 = DR1 end
		if not ( DG1 ) then G1 = 100 else G1 = DG1 end
		if not ( DB1 ) then B1 = 0   else B1 = DB1 end
		if not ( DR2 ) then R2 = 225 else R2 = DR2 end
		if not ( DG2 ) then G2 = 225 else G2 = DG2 end
		if not ( DB2 ) then B2 = 225 else B2 = DB2 end
		
		isDrawing  = true
		theEvent   = dEvent
		theText    = dText
		barProcent = 0
		
		theTimers[1] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[2] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[3] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[4] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		theTimers[5] = setTimer(function() barProcent = barProcent + 1 end, dTime, 0)
		return true
	else
		return false
	end
end

function cancelProgressBar ()
	if ( isDrawing ) then
		isDrawing = false
		for i, k in ipairs ( theTimers ) do
			if ( isTimer ( k ) ) then
				killTimer ( k )
			end
		end
		theTimers = {}
		return true
	else
		return false
	end
end

addEventHandler( "onClientRender", root, 
	function ()
		if ( isDrawing ) then
			if ( barProcent == 520 ) then triggerEvent( theEvent, localPlayer ) cancelProgressBar() return end
			dxDrawRectangle((resX / 2) - 270, (resY / 2) - 22, 540, 44, tocolor(0, 0, 0, 150), false)
			dxDrawRectangle((resX / 2) - 265, (resY / 2) - 16, 530, 33, tocolor(0, 0, 0, 250), false)
			dxDrawRectangle((resX / 2) - 261, (resY / 2) - 12, barProcent, 25, tocolor(R1, G1, B1, 255), false)
			dxDrawText( tostring( theText ).." " .. math.floor( barProcent / 5.2 ).."%", (resX / 2) - 145, (resY / 2)-15, (resY / 2) - 1, (resX / 2) - 5, tocolor(R2, G2, B2, 255), 1, "bankgothic", "left", "top", false, false, false)
		end
	end
)
