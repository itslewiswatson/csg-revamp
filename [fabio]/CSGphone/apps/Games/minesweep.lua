local SIZE
local POS
--local sW, sH = guiGetScreenSize()

local GAME_VAR = {}
local OneSecondTick = getTickCount()

local BlockColours = {
	["*"] = tocolor(50,50,50,255),
	["0"] = tocolor(200,200,200,255),
	["1"] = tocolor(135,135,135,255),
	["2"] = tocolor(135,135,135,255),
	["3"] = tocolor(135,135,135,255),
	["4"] = tocolor(135,135,135,255),
	["5"] = tocolor(135,135,135,255)
}
local SelectedLevel = 1
--Name,Grid,Mines
local Levels = {
	{"Beginner",12,15},
	{"Intermediate",16,40},
	{"Advanced",20,50},
}

local showSmiley = 1
local Smileys = { 
	"apps/Games/Images/smiley1.png",
	"apps/Games/Images/smiley2.png",
	"apps/Games/Images/smiley3.png",
	"apps/Games/Images/smiley4.png",
	"apps/Games/Images/smiley5.png"
}
local Numbers = { 
	"apps/Games/Images/no1.png",
	"apps/Games/Images/no2.png",
	"apps/Games/Images/no3.png",
	"apps/Games/Images/no4.png",
	"apps/Games/Images/no5.png"
}

function openMineSweeper()

	if not (apps[11][7]) then
		addEventHandler("onClientRender",getRootElement(),onRender)
		startGame(Levels[SelectedLevel][2],Levels[SelectedLevel][3])
	end

end


function closeMineSweeper()

	if(apps[11][7]) then
		finishGame()
	end

end


addEventHandler ( "onClientResourceStart", resourceRoot, 
function ()

	apps[11][8] = openMineSweeper
	apps[11][9] = closeMineSweeper
	SIZE = {W=BGWidth,H=BGHeight}
	POS = {X=BGX,Y=BGY}
	
end
)

function startGame(grids,mines)
	apps[11][7] = true
	showSmiley = 1
	GAME_VAR.boxH = math.floor(SIZE.W / grids)
	GAME_VAR.boxW = math.floor(SIZE.W / grids)
	GAME_VAR.gridOffSexX = SIZE.W - GAME_VAR.boxW*grids
	outputDebugString("Box: "..GAME_VAR.boxH)
	GAME_VAR.mines = mines
	GAME_VAR.grid = {}
	GAME_VAR.covergrid = {}
	GAME_VAR.flags = { }
	GAME_VAR.time = 0
	GAME_VAR.gameOver = false
	for i = 1,grids do
		GAME_VAR.grid[i] = { }
		GAME_VAR.covergrid[i] = { }
		for i2 = 1,grids do
			GAME_VAR.grid[i][i2] = "0"
			GAME_VAR.covergrid[i][i2] = "0"
		end
	end
	local mines = GAME_VAR.mines
	repeat
		local r = math.random(1,grids)
		local c = math.random(1,grids)
		if(GAME_VAR.grid[r][c] and GAME_VAR.grid[r][c] == "0") then
			GAME_VAR.grid[r][c] = "*"
			mines = mines - 1
		end
	until mines == 0
	for k,v in pairs(GAME_VAR.grid) do
		for k2,v2 in pairs(v) do
			if(v2 == "0") then
				local VarTab =  {} 
				VarTab[1] = CheckGrid(k-1,k2+1,{"*"})
				VarTab[2] = CheckGrid(k-1,k2,{"*"})
				VarTab[3] = CheckGrid(k-1,k2-1,{"*"})
				VarTab[4] = CheckGrid(k+1,k2+1,{"*"})
				VarTab[5] = CheckGrid(k+1,k2,{"*"})
				VarTab[6] = CheckGrid(k+1,k2-1,{"*"})
				VarTab[7] = CheckGrid(k,k2+1,{"*"})
				VarTab[8] = CheckGrid(k,k2-1,{"*"})
				local newNum = 0
				for p,b in pairs(VarTab) do
					if(b) then
						newNum = newNum + 1
					end
				end
				GAME_VAR.grid[k][k2] = tostring(newNum)
			end
		end
	end
end

function CheckGrid(r,c,s)
	if(GAME_VAR.grid[r]) then
		if(GAME_VAR.grid[r][c]) then
			for k,v in pairs(s) do
				if(GAME_VAR.grid[r][c] == v) then
					return true
				end
			end
		end
	end
	return false
end

function finishGame()
	removeEventHandler("onClientRender",getRootElement(),onRender)
	apps[11][7] = false
end



function onRender()
	if(getTickCount() - OneSecondTick > 1000) then
		if(not GAME_VAR.gameOver) then
			GAME_VAR.time = GAME_VAR.time + 1
		end
		OneSecondTick = getTickCount()
	end
	dxDrawRectangle(POS.X,POS.Y,SIZE.W,SIZE.H,tocolor(120,120,120,255), true)
	dxDrawLine(POS.X,POS.Y,POS.X+SIZE.W,POS.Y,tocolor(10,10,10,255),1, true)
	dxDrawLine(POS.X,POS.Y,POS.X,POS.Y+SIZE.H,tocolor(10,10,10,255),1, true)
	
	dxDrawLine(POS.X,POS.Y,POS.X+SIZE.W,POS.Y,tocolor(10,10,10,255),1, true)
	dxDrawLine(POS.X,POS.Y,POS.X,POS.Y+SIZE.H,tocolor(10,10,10,255),1, true)
	dxDrawRectangle(POS.X,POS.Y+1,(GAME_VAR.gridOffSexX/2),SIZE.W-GAME_VAR.gridOffSexX,tocolor(0,0,0,255), true)
	dxDrawRectangle(POS.X+SIZE.W-(GAME_VAR.gridOffSexX/2),POS.Y+1,(GAME_VAR.gridOffSexX/2),SIZE.W-GAME_VAR.gridOffSexX,tocolor(0,0,0,255), true)
	POS.X = POS.X + (GAME_VAR.gridOffSexX/2)
	for k,v in pairs(GAME_VAR.grid) do
		for k2,v2 in pairs(v) do
			if(v2 ~= "*") then
				dxDrawRectangle(POS.X+(k2*GAME_VAR.boxW)-GAME_VAR.boxW+1,POS.Y+(k*GAME_VAR.boxH)-GAME_VAR.boxH+1,GAME_VAR.boxH-1,GAME_VAR.boxW-1,BlockColours[v2], true)
				if(Numbers[tonumber(v2)]) then
					dxDrawImage(POS.X+(k2*GAME_VAR.boxW)-GAME_VAR.boxW+1,POS.Y+(k*GAME_VAR.boxH)-GAME_VAR.boxH+1,GAME_VAR.boxH-1,GAME_VAR.boxW-1,Numbers[tonumber(v2)], 0, 0, 0, tocolor(255,255,255), true)
				end
			else
				dxDrawRectangle(POS.X+(k2*GAME_VAR.boxW)-GAME_VAR.boxW+1,POS.Y+(k*GAME_VAR.boxH)-GAME_VAR.boxH+1,GAME_VAR.boxH-1,GAME_VAR.boxW-1,BlockColours[v2],true)
				dxDrawImage(POS.X+(k2*GAME_VAR.boxW)-GAME_VAR.boxW+1,POS.Y+(k*GAME_VAR.boxH)-GAME_VAR.boxH+1,GAME_VAR.boxH-1,GAME_VAR.boxW-1,"apps/Games/Images/mine.png", 0, 0, 0, tocolor(255,255,255), true)
			end
			if(GAME_VAR.covergrid[k][k2] == "0") then
				dxDrawRectangle(POS.X+(k2*GAME_VAR.boxW)-GAME_VAR.boxW+1,POS.Y+(k*GAME_VAR.boxH)-GAME_VAR.boxH+1,GAME_VAR.boxH-1,GAME_VAR.boxW-1,tocolor(120,120,120,255), true)
			elseif(GAME_VAR.covergrid[k][k2] == "1") then	
				dxDrawRectangle(POS.X+(k2*GAME_VAR.boxW)-GAME_VAR.boxW+1,POS.Y+(k*GAME_VAR.boxH)-GAME_VAR.boxH+1,GAME_VAR.boxH-1,GAME_VAR.boxW-1,tocolor(200,200,200,255), true)
			end
			if(GAME_VAR.flags[tostring(k..","..k2)]) then
				dxDrawImage(POS.X+(k2*GAME_VAR.boxW)-GAME_VAR.boxW+1,POS.Y+(k*GAME_VAR.boxH)-GAME_VAR.boxH+1,GAME_VAR.boxH-1,GAME_VAR.boxW-1,"apps/Games/Images/flag.png", 0, 0, 0, tocolor(255,255,255), true)
			end
			dxDrawLine(POS.X+(k2*GAME_VAR.boxW),POS.Y,POS.X+(k2*GAME_VAR.boxW),POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid),tocolor(0,0,0,255),1,true)
		end
		dxDrawLine(POS.X,POS.Y+(k*GAME_VAR.boxH),POS.X+SIZE.W-GAME_VAR.gridOffSexX,POS.Y+(k*GAME_VAR.boxH),tocolor(0,0,0,255),1,true)
	end
	
	local x,y = getCursorPosition()
	x = x * sW - POS.X - GAME_VAR.boxW
	y = y * sH - POS.Y - GAME_VAR.boxH
	local col = math.floor((x/GAME_VAR.boxW))+2
	local row = math.floor((y/GAME_VAR.boxH))+2
	if(not GAME_VAR.gameOver) then
		if(GAME_VAR.grid[row] and GAME_VAR.grid[row][col]) then
			HandleClick(row,col)
		end
	end
	POS.X = POS.X - (GAME_VAR.gridOffSexX/2)
	--dxDrawText("Row: "..row.." Col: "..col.."\n X: "..x.." Y: "..y,0,300)
	drawBox(""..GAME_VAR.time,POS.X+10,POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+10,50,"apps/Games/Images/clock.png")
	drawBox(""..GAME_VAR.mines,POS.X+SIZE.W-70,POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+10,50,"apps/Games/Images/mine.png")
	dxDrawImage(POS.X+(SIZE.W/2)-10,POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+10,20,20,Smileys[showSmiley], 0, 0, 0, tocolor(255,255,255), true)
	x,y = getCursorPosition()
	x = x * sW
	y = y * sH
	
	local tw = dxGetTextWidth(Levels[SelectedLevel][1],1,"default-bold")
	dxDrawText(Levels[SelectedLevel][1],POS.X+(SIZE.W/2)-(tw/2),POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+50,sW, sH, tocolor(255,255,255,255),1, "default-bold", "left","top",false,false,true)
	local str = ""..Levels[SelectedLevel][2].."x"..Levels[SelectedLevel][2]..","..Levels[SelectedLevel][3]
	dxDrawText(str,POS.X+(SIZE.W/2)-(dxGetTextWidth(str)/2),POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+65,sW, sH, tocolor(255,255,255,255),1, "default", "left","top",false,false,true)
	if(SelectedLevel ~= 1) then
		dxDrawImage(POS.X+(SIZE.W/2)-(dxGetTextWidth(str)/2)-(tw/2),POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+52,14,24,"apps/Games/Images/al.png", 0, 0, 0, tocolor(255,255,255), true)
	end
	if(SelectedLevel ~= #Levels) then
		dxDrawImage(POS.X+(SIZE.W/2)-(dxGetTextWidth(str)/2)+tw+5,POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+52,14,24,"apps/Games/Images/ar.png", 0, 0, 0, tocolor(255,255,255), true)
	end
	if(getKeyState("mouse1")) then
		MouseLWasDown = true
		if(x > POS.X+(SIZE.W/2)-10 and x < POS.X+(SIZE.W/2)+10 and y > POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+10 and y < POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+30) then
			showSmiley = 2
		end
	elseif(MouseLWasDown) then
		if(x > POS.X+(SIZE.W/2)-10 and x < POS.X+(SIZE.W/2)+10 and y > POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+10 and y < POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+30) then
			startGame(Levels[SelectedLevel][2],Levels[SelectedLevel][3])
			showSmiley = 1
		end
		if(SelectedLevel ~= #Levels and x > POS.X+(SIZE.W/2)-(dxGetTextWidth(str)/2)+tw and x < POS.X+(SIZE.W/2)-(dxGetTextWidth(str)/2)+tw+15 and y > POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+52 and y < POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+77) then
			SelectedLevel = SelectedLevel + 1
			startGame(Levels[SelectedLevel][2],Levels[SelectedLevel][3])
		end
		if(SelectedLevel ~= 1 and x > POS.X+(SIZE.W/2)-(dxGetTextWidth(str)/2)-(tw/2) and x < POS.X+(SIZE.W/2)-(dxGetTextWidth(str)/2)-(tw/2)+15 and y > POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+52 and y < POS.Y+(GAME_VAR.boxH*#GAME_VAR.grid)+77) then
			SelectedLevel = SelectedLevel - 1
			startGame(Levels[SelectedLevel][2],Levels[SelectedLevel][3])
		end
		MouseLWasDown = false
	end
end

local MouseLWasDown = false
local MouseRWasDown = false
local LastRow = 0
local LastCol = 0
function HandleClick(row,col)
	if(GAME_VAR.covergrid[row] and GAME_VAR.covergrid[row][col]) then
		if(getKeyState("mouse1")) then
			if(GAME_VAR.covergrid[row][col] ~= "2") then
				MouseLWasDown = true
				showSmiley = 3
				GAME_VAR.covergrid[row][col] = "1"
			end
		elseif(MouseLWasDown) then
			MouseLWasDown = false
			showSmiley = 1
			unCoverBox(row,col)
		elseif(GAME_VAR.covergrid[row][col] == "1") then
			GAME_VAR.covergrid[row][col] = "0"
		end
	end
	if(GAME_VAR.covergrid[LastRow] and GAME_VAR.covergrid[LastRow][LastCol]) then
		if(row ~= LastRow or col ~= LastCol) then
			if(GAME_VAR.covergrid[LastRow][LastCol] == "1") then
				GAME_VAR.covergrid[LastRow][LastCol] = "0"
			end
		end
	end
	LastRow = row
	LastCol = col
	if(getKeyState("mouse2")) then
		if(GAME_VAR.covergrid[row][col] == "0") then
			MouseRWasDown = true
		end
	elseif(MouseRWasDown) then
		MouseRWasDown = false
		if(GAME_VAR.covergrid[row][col] == "0") then
			GAME_VAR.flags[tostring(row..","..col)] = not GAME_VAR.flags[tostring(row..","..col)]
		end
	end
end


function unCoverBox(row,col)
	if(not GAME_VAR.flags[tostring(row..","..col)]) then
		if(GAME_VAR.grid[row][col] == "0") then
			local q = { }
			table.insert(q,{row,col})
			repeat
				for qk,kv in ipairs(q) do
					local row,col = kv[1],kv[2]
					if(GAME_VAR.grid[row][col] ~= "*") then
						if(not GAME_VAR.flags[tostring(row..","..col)]) then
							GAME_VAR.covergrid[row][col] = "2"
						end
						local VarTab = { }
						if(GAME_VAR.grid[row][col] == "0") then
							table.insert(VarTab,{CheckGrid(row-1,col,{"0","1","2","3","4","5"}),row-1,col})
							table.insert(VarTab,{CheckGrid(row+1,col,{"0","1","2","3","4","5"}),row+1,col})
							table.insert(VarTab,{CheckGrid(row,col+1,{"0","1","2","3","4","5"}),row,col+1})
							table.insert(VarTab,{CheckGrid(row,col-1,{"0","1","2","3","4","5"}),row,col-1})
						end
						for k,v in pairs(VarTab) do
							if(v[1] == true) then
								if(GAME_VAR.covergrid[v[2]][v[3]] ~= "2") then
									table.insert(q,{v[2],v[3]})
								end
							end
						end
					end
					table.remove(q,qk)
				end
			until #q == 0
		elseif(GAME_VAR.grid[row][col] == "*") then
			GAME_VAR.gameOver = true
			showAllMines()
			showSmiley = 4
		else
			GAME_VAR.covergrid[row][col] = "2"
		end
	end
	if(CheckWin() == true) then
		showSmiley = 5
		GAME_VAR.gameOver = true
	end
end

function showAllMines()
	for k,v in pairs(GAME_VAR.grid) do
		for k2,v2 in pairs(v) do
			if(v2 == "*") then
				GAME_VAR.covergrid[k][k2] = "2"
			end
		end
	end
end

function CheckWin()
	local hasWon = true
	for k,v in pairs(GAME_VAR.grid) do
		for k2,v2 in pairs(v) do
			if(v2 ~= "*") then
				if(GAME_VAR.covergrid[k][k2] == "0") then
					hasWon = false
				end
			else 
				if(GAME_VAR.covergrid[k][k2] == "2") then
					hasWon = false
				end
			end
		end
	end
	return hasWon
end



function drawBox(text,x,y,w,image)
	local tw = w
	local th = dxGetFontHeight(1,"default")
	dxDrawRectangle(x,y,tw+10,th+10,tocolor(10,10,10,255), true)
	dxDrawRectangle(x+1,y+1,tw+8,th+8,tocolor(255,255,255,255),true)
	dxDrawRectangle(x+5,y+5,tw,th,tocolor(0,0,0,255),true)
	if(image ~= nil) then
		dxDrawImage(x+6,y+5,15,15,image, 0, 0, 0, tocolor(255,255,255), true)
	end
	dxDrawText(text,x+w-dxGetTextWidth(text,1,"default"),y+5, x+w-dxGetTextWidth(text,1,"default"),y+5, tocolor(255,255,255), 1,"default","left","top",false,false,true )
end



