-- Some variables
local theQuestion = false
local theTimer = false

-- Table with the questions
local questionTable = {
	"When was Elvis' first ever concert?",
	"What year did Elvis Presley die?",
	"How long is a round in boxing?",
	"How many months have 31 days?",
	"In what language does obrigado mean thank you?",
	"In which city is Hollywood?",
	"How many people went onto Noah's Ark?",
	"Who painted the Mona Lisa?",
	"Who cut Van Gogh's ear?",
	"What's the highest mountain in Africa?",
	"What's the capital of Finland?",
	"What's the capital of The Netherlands?",
	"What is the capital of Australia?",
	"What's the largest city in India?",
	"Which is Britain's second largest city?",
	"Who is the best DJ in the world? (djmag 100)",
	"Who is the second best DJ in the world? (djmag 100)",
	"What's the capital of Denmark?",
	"What's the capital of Brazil?",
	"Which river goes through London?",
	"How many states are there in the United States of America?",
	"What's the highest mountain in the world?",
	"Where are the Luxembourg Gardens?",
	"Which mountains are between Spain and France?",
	"When did the first man go into space?",
	"What does UFO mean?",
	"Name the largest fresh water lake in the world?",
	"Who was the legendary Benedictine monk who invented champagne?",
	"Where would you find the Sea of Tranquility?",
	"What is someone who shoes horses called?",
	"What item of clothing was named after its Scottish inventor?",
	"What kind of weapon is a falchion?",
	"Which word goes before vest, beans and quartet?",
	"What is another word for lexicon?",
	"Name the seventh planet from the sun",
	"Who invented the rabies vaccination?",
	"Which is the only American state to begin with the letter 'p'?",
	"Name the world's biggest island.",
	"What is the world's longest river?",
	"Name the world's largest ocean.",
	"What is the diameter of Earth? (in miles?",
	"Which sport does Constantino Rocca play?",
	"Which chess piece can only move diagonally?",
	"In football, who was nicknamed 'The Divine Ponytail'?",
	"In needlework, what does UFO refer to?",
	"When was William Shakespeare born? (year)",
	"When did the Cold War end?",
	"In publishing, what does POD mean?",
	"Who invented TV?",
	"What colour is Absynth?",
	"How many colours are there in a rainbow?",
	"How many degrees are found in a circle?",
	"What is the Scottish drink made from whisky and heather honey called?",
	"The word 'bible' comes from the Greek 'biblion' - what does biblion mean?",
	"In Japanese, what is the word for goodbye?",
	"Which book featured the eloi and the morlocks?",
	"Name the Chinese game played with small tiles.",
	"What are espadrilles?",
	"What is the average temperature of the human body, in degrees centigrade?",
	"What is rum distilled from?",
	"Who invented Kodak cameras?",
	"What nationality of soldiers wear a white kilt?",
	"Which fictional character was also known as Lord Greystoke?",
	"What was Che Guevara's nationality?",
	"In British mythology, who were Gog and Magog?",
	"How many symphonies did Beethoven compose?",
	"Which fictional character lived at 221b Baker Street?",
	"What sort of creature did St George allegedly slay?",
	"Having already experienced something which is now happening again is known as what?",
	"What does CIA mean?",
	"What does FBI mean?",
	"What does SWAT mean?",
	"What is the Italian word for pie?",
	"How many bones are there on a Skull & Crossbones flag?",
	"Name the port of Rome",
                "Who is the father of Luke Skywalker?",
                "Name the dog in a traditional the Punch and Judy show",
                "Who is Norma Jean Baker more usually known as?",
                "Who wrote a series of novels about orcs, hobbits, goblins and elves?",
                "When did the world celebrate its most recent millennium?",
                "What was John Wayne's original name?",
                "Name the French blue cheese made from ewe's milk",
                "How many sets of petals does a Tudor rose have?",
                "Name the Celtic language spoken in Brittany",
                "What sort of animals feature in the children's book, Watership Down?",
                "How many legs does the Legs of Man have?",
                "Which sea creature has three hearts?",
}

-- Table with the answers				
local answerTable = { 
	"1954",
	"1977",
	"3 minutes",
	"7",
	"Portuguese",
	"Los Angeles",
	"8",
	"Da Vinci",
	"He did",
	"Kilimanjaro",
	"Helsinki",
	"Amsterdam",
	"Canberra",
	"Bombay",
	"Birmingham",
	"Armin Van Buuren",
	"Tiesto",
	"Copenhagen",
	"Brasilia",
	"Thames",
	"50",
	"Mount Everest",
	"Paris",
	"Pyrenees",
	"1961",
	"Unidentified Flying Object",
	"Lake Superior",
	"Dom Perignon",
	"The Moon",
	"Farrier",
	"Machintosh",
	"Sword",
	"String",
	"Dictionary",
	"Uranus",
	"Louis Pasteur",
	"Pennsylvania",
	"Greenland",
	"Amazon",
	"Pacific",
	"8000",
	"Golf",
	"bishop",
	"Roberto Baggio",
	"An unfinished object",
	"1564",
	"1989",
	"Print on demand",
	"John Logie Baird",
	"Green",
	"7",
	"360",
	"Drambuie",
	"Book",
	"Sayonara",
	"The Time Machine",
	"Mah-jong",
	"Sandals",
	"37",
	"Sugar cane",
	"George Eastman",
	"Greek",
	"Tarzan",
	"Argentinian",
	"Giants",
	"9",
	"Sherlock Holmes",
	"Dragon",
	"Deja vu",
	"Central Intelligence Agency",
	"Federal Bureau of Investigation",
	"Special Weapons and Tactics",
	"Pizza",
	"3",
	"Ostia";
                "Darth Vader";
                "Toby",
                "Marilyn Monroe",
                "JR Tolkien",
                "Year 2000",
                "Marion Morrison",
                "Roquefort",
                "5",
                "Breton",
                "Rabbits",
                "Three",
                "Octopus",
}

-- Function that creates a new question		
function createNewTriviaQuestion ()
	theQuestion = math.random( #questionTable )
	outputChatBox ( "#FFA500[TRIVIA]#FFFFFF " ..questionTable[ theQuestion ].. "#FFA500 Use /trivia to answer!", root, 255, 255, 255, true )
	theTimer = setTimer( stopTriviaQuestion, 30000, 1 )
end

-- Stop the question
function stopTriviaQuestion ()
	outputChatBox ( "#FFA500[TRIVIA]#FFFFFF Nobody answered! #FFA500Answer: #FFFFFF"..answerTable[ theQuestion ], root, 255, 255, 255, true )
	setTimer( createNewTriviaQuestion, 300000, 1 ) theQuestion = false
end		

-- To answer the question
addCommandHandler( "trivia",
	function ( thePlayer, cmd, ... ) 
		if ( theQuestion ) then
			local theMessage = table.concat( {...}, " " )
			if ( string.lower( theMessage ) == string.lower( answerTable[ theQuestion] ) ) then
				if ( exports.CSGstaff:isPlayerStaff( thePlayer ) ) then outputChatBox ( "#FFA500[TRIVIA]#FFFFFF Your answer is good but staff is excluded from this game!", thePlayer, 255, 255, 255, true ) return end
				outputChatBox ( "#FFA500[TRIVIA]#FFFFFF ".. getPlayerName( thePlayer ) .." answerd correctly: #FFA500".. answerTable[ theQuestion ] .." #FFFFFFReward: $500", root, 255, 255, 255, true )
				setTimer( createNewTriviaQuestion, 300000, 1 ) givePlayerMoney ( thePlayer, 500 ) theQuestion = false
				if ( theTimer ) and ( isTimer( theTimer ) ) then killTimer( theTimer ) end
			else
				outputChatBox ( "#FFA500[TRIVIA]#FFFFFF Sorry but that answer is wrong!", thePlayer, 255, 255, 255, true )
			end
		end		
	end
)

-- Create a trivia when resource starts
createNewTriviaQuestion ()