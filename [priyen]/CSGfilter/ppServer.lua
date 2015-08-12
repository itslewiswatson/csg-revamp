local lets = {
	"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z"
}

local allowedWords = {

accite="",
accited="",
accites="",
acciting="",
aduncity="",
analcite="",
anticity="",
ascites="",
ascitic="",
astucity="",
atrocity="",
audacity="",
basicity="",
boracite="",
brucite="",
brucites="",
caducity="",
caecitis="",
calcite="",
calcites="",
calcitic="",
capacity="",
cecities="",
cecitis="",
cecity="",
circiter="",

citable="",
citadel="",
citadels="",
cital="",
citals="",
citation="",
citator="",
citators="",
citatory="",
cite="",
citeable="",
cited="",
citer="",
citers="",
cites="",
citess="",
citesses="",
cithara="",
citharas="",
cither="",
cithern="",
citherns="",
cithers="",
cithren="",
cithrens="",
citied="",
cities="",
citified="",
citifies="",
citify="",
citing="",
citizen="",
citizens="",
cito="",
citola="",
citolas="",
citole="",
citoles="",
citral="",
citrals="",
citrange="",
citrate="",
citrated="",
citrates="",
citreous="",
citric="",
citrin="",
citrine="",
citrines="",
citrinin="",
citrins="",
citron="",
citrons="",
citrous="",
citrus="",
citruses="",
citrusy="",
cits="",
cittern="",
citterns="",
city="",
cityfied="",
cityfies="",
cityfy="",
citylike="",
cityward="",
citywide="",
conicity="",
cubicity="",
dacite="",
dacites="",
deficit="",
deficits="",
dicacity="",
dulcite="",
dulcites="",
dulcitol="",
edacity="",
elicit="",
elicited="",
elicitor="",
elicits="",
excitant="",
excite="",
excited="",
exciter="",
exciters="",
excites="",
exciting="",
exciton="",
excitons="",
excitor="",
excitors="",
explicit="",
fecit="",
felicity="",
feracity="",
ferocity="",
fugacity="",
furacity="",
helicity="",
illicit="",
implicit="",
incitant="",
incite="",
incited="",
inciter="",
inciters="",
incites="",
inciting="",
ionicity="",
kamacite="",
laicity="",
lecithal="",
lecithic="",
lecithin="",
leucite="",
leucites="",
leucitic="",
licit="",
licitly="",
lucite="",
lucites="",
megacity="",
minacity="",
miscite="",
miscited="",
miscites="",
opacity="",
oscitant="",
oscitate="",
outcity="",
paucity="",
placit="",
placita="",
placits="",
placitum="",
precited="",
pudicity="",
pumicite="",
rapacity="",
raucity="",
recit="",
recital="",
recitals="",
recite="",
recited="",
reciter="",
reciters="",
recites="",
reciting="",
recits="",
reincite="",
sagacity="",
salacity="",
scarcity="",
sericite="",
siccity="",
solicit="",
solicits="",
solicityv="",
tacit="",
tacitly="",
taciturn="",
tenacity="",
tonicity="",
toxicity="",
uncited="",
unicity="",
velocity="",
veracity="",
vivacity="",
voracity="",
xericity="",
zincite="",
zincites="",
}

local randomWords = {
	"hamza",
	"abibliophobia",
	"canoodle",
	"collop",
	"doozy",
	"fard",
	"firkin",
	"flummox",
	"cantankerous",
	"im a fail",
	"your a fail",
	"we are all fails",
}

function contains(str)
	local orig=str
	for k,v in pairs(allowedWords) do
		if string.find(str,k) then return "no" end
	end
	local building=""
	str=string.lower(str)
	local citstarti=0
	local citendi=0
	local tfound=false
	for i = 1, #str do
		local c = str:sub(i,i)
		for k,v in pairs(lets) do
			if c==v and building:sub(#building,#building) ~= c then
				building=building..""..c..""
				if tfound==false then if c == "c" then citstarti=i end end
				if c == "t" then if tfound==false then if string.find(building,"cit") then citendi=i tfound=true end end end
			end

		end
	end
	outputDebugString("start "..citstarti.." end "..citendi.."")
	if string.find(building,"cit") then
		local buildingtoprint=""
		local chars={}
		for i = 1, #orig do
			local c = orig:sub(i,i)
			table.insert(chars,c)
		end
		for i=citstarti,citendi do
			table.remove(chars,citstarti)
		end
		local word=randomWords[math.random(#randomWords)]
		local size = #word
		for i=1,size do
			local c = word:sub(i,i)
			table.insert(chars,citstarti+i-1,c)
		end
		for k,v in pairs(chars) do
			buildingtoprint=buildingtoprint..""..v..""
		end
		outputDebugString("Filtered String : "..buildingtoprint.."")
		return "yes"
	end
	return "no"
end

addCommandHandler("citfiltertest",function(ps,cmdName, ... )
	local arg = {...}

	local stringWithAllParameters = table.concat( arg, " " )
	outputChatBox(contains(stringWithAllParameters),ps)
end)

addCommandHandler("argtest",function(ps,cmdName, ... )
	local arg = {...}
	outputDebugString(arg[1])
end)
