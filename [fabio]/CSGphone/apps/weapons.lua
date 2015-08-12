local weaponsGUI = {}
local weaponTable = { [1]=69, [2]=70, [3]=71, [4]=72, [5]=73, [6]=74, [7]=75, [8]=76, [9]=78, [10]=77, [11]=79 }

function onOpenWeaponsApp ( ) 
	apps[8][7] = true
	
	weaponsGUI[1] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.02*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[2] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.10*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[3] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.18*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[4] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.26*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[5] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.34*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[6] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.42*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[7] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.50*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[8] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.58*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[9] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.66*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[10] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.74*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	weaponsGUI[11] = guiCreateProgressBar( BGX+(0.05*BGWidth),BGY+(0.82*BGHeight), 0.90*BGWidth, 0.060*BGHeight, false, nil )
	
	weaponsGUI[12] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.02*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Pistol", false, nil )
	weaponsGUI[13] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.10*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Silenced Pistol", false, nil )
	weaponsGUI[14] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.18*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Desert Eagle", false, nil )
	weaponsGUI[15] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.26*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Shotgun", false, nil )
	weaponsGUI[16] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.34*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Sawn-Off Shotgun", false, nil )
	weaponsGUI[17] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.42*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "SPAZ-12 Combat Shotgun", false, nil )
	weaponsGUI[18] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.50*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Uzi / TEC-9", false, nil )
	weaponsGUI[19] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.58*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "MP5", false, nil )
	weaponsGUI[20] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.66*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "M4", false, nil )
	weaponsGUI[21] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.74*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "AK-47", false, nil )
	weaponsGUI[22] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.82*BGHeight), 0.90*BGWidth, 0.060*BGHeight, "Country Rifle / Sniper", false, nil )
	weaponsGUI[23] = guiCreateLabel( BGX+(0.05*BGWidth),BGY+(0.85*BGHeight), 0.90*BGWidth, 0.20*BGHeight, "When Pistol, Uzi or TEC-9 reached 100%\ndual guns are unlocked for those weapons.", false, nil )	
	
	for i=1,#weaponsGUI do
		if i > 0 and i < 12 then
			guiSetVisible(weaponsGUI[i],true)
			guiProgressBarSetProgress ( weaponsGUI[i], ( getPedStat( localPlayer, weaponTable[i] ) / 10 ) )
		elseif i > 11 and i < 23 then
			guiSetProperty( weaponsGUI[i], "AlwaysOnTop", "True" )
			guiSetVisible( weaponsGUI[i],true )
			guiBringToFront( weaponsGUI[i] )
			guiLabelSetColor ( weaponsGUI[i], 0, 0, 0 )
			guiLabelSetHorizontalAlign ( weaponsGUI[i], "center" )
			guiLabelSetVerticalAlign ( weaponsGUI[i], "center" )
			guiSetFont ( weaponsGUI[i], "default-bold-small" )
		else
			guiSetProperty( weaponsGUI[i], "AlwaysOnTop", "True" )
			guiSetVisible( weaponsGUI[i],true )
			guiLabelSetHorizontalAlign ( weaponsGUI[i], "center" )
			guiLabelSetVerticalAlign ( weaponsGUI[i], "center" )
			guiSetFont ( weaponsGUI[i], "default-bold-small" )
		end
	end
end 
apps[8][8] = onOpenWeaponsApp

function onCloseWeaponsApp ()
	for i=1,#weaponsGUI do
		guiSetProperty( weaponsGUI[i], "AlwaysOnTop", "True" )
		guiSetVisible(weaponsGUI[i],false)
	end	
	apps[8][7] = false
end

apps[8][9] = onCloseWeaponsApp
