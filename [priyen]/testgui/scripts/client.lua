window = guiCreateWindow(0,0,1,1,"Test GUI",true)
guiSetAlpha( window, 1 )
--rules in different languages stuff
text = guiCreateMemo(0.2792,0.4000,0.6692,0.536,"",true,window)
grid = guiCreateGridList(0.0363,0.1022,0.2141,0.836,true,window)
guiGridListSetSelectionMode(grid,2)
guiMemoSetReadOnly(text, true)
guiGridListAddColumn(grid,"Different language rules",0.85)
guiWindowSetMovable(window,false)
guiWindowSetSizable(window,false)
guiSetVisible(window,false)
showCursor(false)

for i = 1, 10 do
    guiGridListAddRow(grid)
end

guiGridListSetItemText(grid,0,1,"English",false,false)

guiGridListSetItemText(grid,1,1,"Arabic",false,false)

guiGridListSetItemText(grid,2,1,"Portugues",false,false)

guiGridListSetItemText(grid,3,1,"Espanol",false,false)

guiGridListSetItemText(grid,4,1,"Italiano",false,false)

guiGridListSetItemText(grid,5,1,"Latvijas",false,false)

guiGridListSetItemText(grid,6,1,"Polski",false,false)

local englishF = fileOpen("texts/english.txt", true)
local arabicF = fileOpen("texts/arabic.txt", true)
local portugeseF = fileOpen("texts/portugese.txt", true)
local spanishF = fileOpen("texts/spanish.txt", true)
local italianF = fileOpen("texts/italian.txt", true)
local latvianF = fileOpen("texts/latvian.txt", true)
local polishF = fileOpen("texts/polish.txt", true)
        local english = fileRead(englishF, 50000)
		local arabic = fileRead(arabicF, 50000) 
		local portugese = fileRead(portugeseF, 50000)
		local spanish = fileRead(spanishF, 50000)
		local italian = fileRead(italianF, 50000)
		local latvian = fileRead(latvianF, 50000) 
		local polish = fileRead(polishF, 50000) 
--ending

--other grid list stuff
grid2 = guiCreateGridList(0.2792,0.1022,0.6692,0.25,true,window)

guiGridListAddColumn(grid2,"Other",0.95)

for i = 1, 10 do
    guiGridListAddRow(grid2)
end

guiGridListSetItemText(grid2,0,1,"Commands",false,false)
guiGridListSetItemText(grid2,1,1,"Website",false,false)
guiGridListSetItemText(grid2,2,1,"Updates",false,false)
guiGridListSetItemText(grid2,3,1,"Staff members",false,false)

local commandsF = fileOpen("texts2/commands.txt", true)
local websiteF = fileOpen("texts2/website.txt", true)
local updatesF = fileOpen("texts2/updates.txt", true)
local staffF = fileOpen("texts2/staff.txt", true)
        local commands = fileRead(commandsF, 50000)
		local website = fileRead(websiteF, 50000) 
		local updates = fileRead(updatesF, 50000)
		local staff = fileRead(staffF, 50000)
--ending

--Binding to set window visible
--bindKey('f1','down',
addCommandHandler("panel", panelgui)
function panelgui()
guiSetVisible(window, not guiGetVisible(window))
showCursor(not isCursorShowing())
end

--Ending

function click1()
local row,col = guiGridListGetSelectedItem ( grid )
local row2,col2 = guiGridListGetSelectedItem ( grid2 )
   if source == grid then
   if ( row == 0 ) and ( col == 1 ) then
       guiSetText(text,english)
   elseif ( row == 1 ) and ( col == 1 ) then
       guiSetText(text,lithuanian)
   elseif ( row == 2 ) and ( col == 1 ) then
       guiSetText(text,portugese)
   elseif ( row == 3 ) and ( col == 1 ) then
       guiSetText(text,spanish)
   elseif ( row == 4 ) and ( col == 1 ) then
       guiSetText(text,italian)
   elseif ( row == 5 ) and ( col == 1 ) then
       guiSetText(text,latvian)
   elseif ( row == 6 ) and ( col == 1 ) then
       guiSetText(text,polish)
    end
  elseif source == grid2 then
   if ( row2 == 0 ) and ( col2 == 1 ) then
       guiSetText(text,commands)
   elseif ( row2 == 1 ) and ( col2 == 1 ) then
       guiSetText(text,website)
   elseif ( row2 == 2 ) and ( col2 == 1 ) then
       guiSetText(text,updates)
   elseif ( row2 == 3 ) and ( col2 == 1 ) then
       guiSetText(text,staff)
      end
   end
end
addEventHandler('onClientGUIClick',root, click1)

--font changes
fontas = guiCreateFont( 'fonts/font.ttf', 10 )
guiSetFont( text, fontas )
guiSetFont( grid, fontas )
guiSetFont( grid2, fontas )
--ending
