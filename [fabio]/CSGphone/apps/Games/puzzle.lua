local SizeH
local SizeW
local POS = {}
local PuzzleDiff = "easy"

local Moves
local MainTexture
local PuzzleCut
local LastMouseDown

local puzzles = {
	["easy"] = {
		moves = 150,
		"apps/Games/Images/puzzle_e1.jpg",
		"apps/Games/Images/puzzle_e2.jpg",
	},
}

local puzzleDiffs = {"easy","hard"}

function openImagePuzzle()

	if(not PuzzleCut) then
		getImageSections("easy")
	end
	addEventHandler("onClientRender",getRootElement(),onClientRender)
	apps[12][7] = true

end

addEventHandler ( "onClientResourceStart", resourceRoot, 
function ()

	apps[12][8] = openImagePuzzle
	apps[12][9] = closeImagePuzzle

	POS = { X = BGX+5, Y = BGY+5 }
	SizeH = (BGHeight-40)/5
	SizeW = (BGWidth-30)/5
	
end
)

function closeImagePuzzle()

	removeEventHandler("onClientRender",getRootElement(),onClientRender)
	apps[12][7] = false

end

function getImageSections(diff)
	local Image = puzzles[diff][math.random(1,#puzzles[diff])]
	local TempTable = { }
	Moves = 0
	
	MainTexture = dxCreateTexture(Image)
	local w, h = dxGetPixelsSize(dxGetTexturePixels(MainTexture))
	local k = 1
	for r=0,4 do
		TempTable[r] = { }
		for c=0,4 do
			TempTable[r][c] = dxCreateTexture(dxGetTexturePixels(MainTexture,0+((w/5)*c),0+((h/5)*r),(w/5),(h/5)))
			setElementData(TempTable[r][c],"pos",k)
			k = k + 1
		end
	end
	destroyElement(TempTable[4][4])
	TempTable[4][4] = "empty"
	PuzzleCut = TempTable
	ShuffleSecs()
end

function checkWin()
	local WinCheck = "1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25"
	local TempTable = { }
	for r=0,4 do
		for c=0,4 do
			if(PuzzleCut[r][c] == "empty") then
				table.insert(TempTable,25)
			else
				table.insert(TempTable,getElementData(PuzzleCut[r][c],"pos"))
			end
		end
	end
	
	if(table.concat(TempTable,",") == WinCheck) then
		-- When a player wins
	end
end

function ShuffleSecs()
	local LastMoved = {0,0}
	for i=0,puzzles[PuzzleDiff].moves do
		local Next = false
		repeat
			local MoveR,MoveC,Dir = 0,0,0
			for k,v in pairs(PuzzleCut) do
				for k2,v2 in pairs(v) do
					if(v2 == "empty") then
						MoveR = k
						MoveC = k2
						Dir = math.random(0,4)
						break
					end
				end
			end
			
			if(Dir == 1 and MoveR-1 >= 0 and not (LastMoved[1] == MoveR-1 and LastMoved[2] == MoveC)) then
				PuzzleCut[MoveR][MoveC] = PuzzleCut[MoveR-1][MoveC]
				PuzzleCut[MoveR-1][MoveC] = "empty"
				Next = true
			elseif(Dir == 2 and MoveR+1 <= 4 and not (LastMoved[1] == MoveR+1 and LastMoved[2] == MoveC)) then
				PuzzleCut[MoveR][MoveC] = PuzzleCut[MoveR+1][MoveC]
				PuzzleCut[MoveR+1][MoveC] = "empty"
				Next = true
			elseif(Dir == 3 and MoveC-1 >= 0 and not (LastMoved[1] == MoveR and LastMoved[2] == MoveC-1)) then
				PuzzleCut[MoveR][MoveC] = PuzzleCut[MoveR][MoveC-1]
				PuzzleCut[MoveR][MoveC-1] = "empty"
				Next = true
			elseif(Dir == 4 and MoveC+1 <= 4 and not (LastMoved[1] == MoveR and LastMoved[2] == MoveC+1)) then
				PuzzleCut[MoveR][MoveC] = PuzzleCut[MoveR][MoveC+1]
				PuzzleCut[MoveR][MoveC+1] = "empty"
				Next = true
			end
			LastMoved = {MoveR,MoveC}
		until Next
	end
end

function getMousePos()
	if(isCursorShowing()) then
		local x,y = getCursorPosition()
		x = x*sW
		y = y*sH
		return x,y
	end
	return 0,0
end

function ClickOnSec(row,col)
	if(row == "reset") then
		return getImageSections(PuzzleDiff)
	end
	local Check1 = ((row+1 <= 4) and PuzzleCut[row+1][col] == "empty")
	local Check2 = ((col+1 <= 4) and PuzzleCut[row][col+1] == "empty")
	local Check3 = ((row-1 >= 0) and PuzzleCut[row-1][col] == "empty")
	local Check4 = ((col-1 >= 0) and PuzzleCut[row][col-1] == "empty")
	if(Check1) then
		PuzzleCut[row+1][col] = PuzzleCut[row][col]
		PuzzleCut[row][col] = "empty"
	elseif(Check2) then
		PuzzleCut[row][col+1] = PuzzleCut[row][col]
		PuzzleCut[row][col] = "empty"
	elseif(Check3) then
		PuzzleCut[row-1][col] = PuzzleCut[row][col]
		PuzzleCut[row][col] = "empty"
	elseif(Check4) then
		PuzzleCut[row][col-1] = PuzzleCut[row][col]
		PuzzleCut[row][col] = "empty"
	else
		return
	end
	Moves = Moves +1
	checkWin()
end

function onClientRender()
	if(PuzzleCut)then
		dxDrawRectangle(POS.X-5,POS.Y-5,(SizeW+5)*5+5,(SizeH+5)*5+15,tocolor(40,40,40),true)
		local mx,my = getMousePos()
		for k,v in pairs(PuzzleCut) do
			for k2,v2 in pairs(v) do
				if(v2 ~= "empty") then
					dxDrawImage(POS.X+((SizeW+5)*k2),POS.Y+((SizeH+5)*k),SizeW,SizeH,v2, 0, 0, 0, tocolor(255,255,255),true)
					if(mx > POS.X+((SizeW+5)*k2) and mx < POS.X+((SizeW+5)*k2) + SizeW
						and my > POS.Y+((SizeH+5)*k) and my < POS.Y+((SizeH+5)*k) + SizeH) then
						if(getKeyState("mouse1")) then
							if(not LastMouseDown or LastMouseDown and getTickCount() - LastMouseDown > 200) then
								LastMouseDown = getTickCount()
								ClickOnSec(k,k2)
							end
						end
						dxDrawRectangle(POS.X+((SizeW+5)*k2),POS.Y+((SizeH+5)*k),SizeW,SizeH,tocolor(140,140,140,60), true)
					end
				else 
					dxDrawRectangle(POS.X+((SizeW+5)*k2),POS.Y+((SizeH+5)*k),SizeW,SizeH,tocolor(0,0,0), true)
				end
			end
		end
		
		dxDrawText("Moves: "..Moves,POS.X+((SizeW+5)*5/2)-20,POS.Y+(SizeH+5)*5-5,POS.X+((SizeW+5)*5/2)-20,POS.Y+(SizeH+5)*5-5,tocolor(255,255,255),1,"default","left","top",false,false,true)
		
		dxDrawText("Hint?",POS.X,POS.Y+(SizeH+5)*5-5,POS.X,POS.Y+(SizeH+5)*5-5,tocolor(255,255,255),1,"default","left","top",false,false,true)
		if(mx > POS.X and mx < POS.X + 25 and my > POS.Y+(SizeH+5)*5-5 and my < POS.Y+(SizeH+5)*5+15) then
			dxDrawImage(POS.X,POS.Y,(SizeW+5)*5-5,(SizeH+5)*5-5,MainTexture, 0, 0, 0, tocolor(255,255,255),true)
		end
		
		dxDrawText("Reset?",POS.X+(SizeW+5)*5-40,POS.Y+(SizeH+5)*5-5,POS.X+(SizeW+5)*5-40,POS.Y+(SizeH+5)*5-5,tocolor(255,255,255),1,"default","left","top", false,false,true )
		if(mx > POS.X+(SizeW+5)*5-40 and mx < POS.X +(SizeW+5)*5 and my > POS.Y+(SizeH+5)*5-5 and my < POS.Y+(SizeH+5)*5+15) then
			if(getKeyState("mouse1")) then
				if(not LastMouseDown or LastMouseDown and getTickCount() - LastMouseDown > 700) then
					LastMouseDown = getTickCount()
					ClickOnSec("reset",nil)
				end
			end
		end
	end
end