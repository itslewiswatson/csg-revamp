------------------------------------------------------------------------------------
--  For CSG Server
--  Verson 1.0.0
--  CSGsmithsMathsQuiz/server (server-side)
--  Maths Quiz Script
--  [CSG]Smith
------------------------------------------------------------------------------------
local MathQuiz = false

addCommandHandler("math", 
function(player)
    if "smith" == exports.server:getPlayerAccountName(player) then
		reward = math.random(900, 1300)
		qn1 = math.random(5, 10)
		qn2 = math.random(2, 10)
		qn3 = math.random(10, 130)
		theQuestion = (qn1*qn2)-qn3
		outputChatBox("#FF961A[Math Task] #FFFFFFFirst one who answer this #ffff00("..qn1.." * "..qn2..") - "..qn3.."#FFFFFF will win #00ff00$" ..reward, root, 0, 255, 0, true)
		outputChatBox("#FF961A[Math Task] #FFFFFFFor answer use #ffff00/result <theresult>.#FFFFFF Example #ffff00/result 23", root, 0, 255, 0, true)
    	MathQuiz = true
		for k, v in ipairs(getElementsByType("player")) do
			setElementData(v,"MathQuizStatus",true)
		end
	else
		outputChatBox("You can't use this command", player, 255, 0, 0, false)
    end
end
)

function start ()	

	reward = math.random(800, 1200)
    qn1 = math.random(5, 9)
    qn2 = math.random(5, 11)
    qn3 = math.random(40, 80)
    theQuestion = qn1 * qn2 - qn3
    outputChatBox("#00FF00[Math Task] #FFFFFFFirst one who answer this #ffff00("..qn1.." * "..qn2..") - "..qn3.."#FFFFFF will win #00ff00$" ..reward, root, 0, 255, 0, true)
    outputChatBox("#00FF00[Math Task] #FFFFFFFor answer use #ffff00/result <theresult>.#FFFFFF Example #ffff00/result 23", root, 0, 255, 0, true)
    MathQuiz = true
	for k, v in ipairs(getElementsByType("player")) do
			setElementData(v,"MathQuizStatus",true)
	end
	setTimer( function()
			reward = math.random(600, 1200)
			qn1 = math.random(5, 9)
			qn2 = math.random(5, 11)
			qn3 = math.random(40, 80)
			theQuestion = qn1 * qn2 - qn3
			outputChatBox("#00FF00[Math Task] #FFFFFFFirst one who answer this #ffff00("..qn1.." * "..qn2..") - "..qn3.."#FFFFFF will win #00ff00$" ..reward, root, 0, 255, 0, true)
			outputChatBox("#00FF00[Math Task] #FFFFFFFor answer use #ffff00/result <theresult>.#FFFFFF Example #ffff00/result 23", root, 0, 255, 0, true)
			MathQuiz = true
			for k, v in ipairs(getElementsByType("player")) do
			setElementData(v,"MathQuizStatus",true)
			end
			end, 600000,0)
end
addEventHandler( "onResourceStart", getResourceRootElement(getThisResource()), start)



addCommandHandler("result", 
function(player,cmd,answer)
	if MathQuiz == true then
		if getElementData(player,"MathQuizStatus") == true then
			if answer then 
				if theQuestion and tonumber(answer) == theQuestion then
					outputChatBox("#00FF00[Math Task] #FFFFFF'#00FF00"..getPlayerName(player).."#FFFFFF' answered correctly #00ff00"..answer.."#FFFFFF and won #00ff00$"..reward.." & #00ff00+0.5 s.", root, 0, 255, 0, true)
					exports.csgscore:givePlayerScore(player,0.5)
					givePlayerMoney(player, reward)
					MathQuiz = false
					setElementData(player,"MathQuizStatus",false)
				else
					outputChatBox("#00FF00[Math Task] #FFFFFFResult you have typed #ff0000"..answer.."#FFFFFF is wrong!", player, 200, 155, 0, true)
					takePlayerMoney(player,100)
					exports.csgscore:givePlayerScore(player,-0.10)
					setElementData(player,"MathQuizStatus",false)
				end
			else
				outputChatBox("#00FF00[Math Task] #FFFFFF Syntax is:  /result <number>", player, 200, 155, 0, true)
				outputChatBox("#00FF00[Math Task] #FFFFFF Example #ffff00/result 23", player, 200, 155, 0, true)
			end
		else
			outputChatBox("#00FF00[Math Task] #FF0000 You can type only one result for a task!", player, 200, 155, 0, true)
		end
	end
end)