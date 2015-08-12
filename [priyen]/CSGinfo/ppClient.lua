GUIEditor = {
    tab = {},
    button = {},
    window = {},
    label = {},
    tabpanel = {},
}



window = guiCreateWindow(0.27, 0.17, 0.47, 0.63, "Community of Social Gaming ~ Help Menu", true)
guiWindowSetSizable(window, false)

GUIEditor.label[1] = guiCreateLabel(0.02, 0.06, 0.16, 0.05, "Language", true, window)
guiLabelSetColor(GUIEditor.label[1], 248, 136, 3)
GUIEditor.tabpanel[2] = guiCreateTabPanel(82, 49, 515, 392, false, window)

tabRules = guiCreateTab("Rules", GUIEditor.tabpanel[2])
gridRules = guiCreateGridList(5, 5, 500, 357, false, tabRules)

guiGridListAddColumn(gridRules,"",0.9)
tabCommands = guiCreateTab("Commands", GUIEditor.tabpanel[2])
gridCommands = guiCreateGridList(5, 5, 500, 357, false, tabCommands)
guiGridListAddColumn(gridCommands,"",0.9)
tabJobs = guiCreateTab("Jobs", GUIEditor.tabpanel[2])
gridJobs = guiCreateGridList(5, 5, 500, 357, false, tabJobs)
guiGridListAddColumn(gridJobs,"",0.9)
tabEvents = guiCreateTab("Events", GUIEditor.tabpanel[2])
gridEvents = guiCreateGridList(5, 5, 500, 357, false, tabEvents)
guiGridListAddColumn(gridEvents,"",0.9)
tabMissions = guiCreateTab("Missions", GUIEditor.tabpanel[2])
gridMissions = guiCreateGridList(5, 5, 500, 357, false, tabMissions)
guiGridListAddColumn(gridMissions,"",0.9)
tabSystems = guiCreateTab("Systems", GUIEditor.tabpanel[2])
gridSystems = guiCreateGridList(5, 5, 500, 357, false, tabSystems)
guiGridListAddColumn(gridSystems,"",0.9)
tabiPhone = guiCreateTab("iPhone", GUIEditor.tabpanel[2])
gridiPhone = guiCreateGridList(5, 5, 500, 357, false, tabiPhone)
guiGridListAddColumn(gridiPhone,"",0.9)
GUIEditor.label[2] = guiCreateLabel(292, 27, 96, 23, "Category", false, window)
guiLabelSetColor(GUIEditor.label[2], 249, 142, 3)
english = guiCreateStaticImage(9, 54, 59, 32,"english.png",false,window)
french = guiCreateStaticImage(9,93,59,32,"french.png",false,window)
portuguese = guiCreateStaticImage(9,132,59,32,"portuguese.png",false,window)
arabic = guiCreateStaticImage(9,172,59,32,"arabic.png",false,window)
--GUIEditor.button[1] = guiCreateButton(9,54, 59, 32, "", false, window)
--GUIEditor.button[2] = guiCreateButton(9, 93, 59, 32, "", false, window)
guiGridListSetScrollBars(gridRules,true,true)
guiGridListSetScrollBars(gridCommands,true,true)
guiGridListSetScrollBars(gridJobs,true,true)
guiGridListSetScrollBars(gridEvents,true,true)
guiGridListSetScrollBars(gridMissions,true,true)
guiGridListSetScrollBars(gridSystems,true,true)
guiGridListSetScrollBars(gridiPhone,true,true)
--GUIEditor.button[4] = guiCreateButton(9, 172, 59, 32, "", false, window)
GUIEditor.button[5] = guiCreateButton(9, 210, 59, 32, "", false, window)
GUIEditor.button[6] = guiCreateButton(9, 248, 59, 32, "", false, window)
GUIEditor.button[7] = guiCreateButton(9, 286, 59, 32, "", false, window)
GUIEditor.button[8] = guiCreateButton(9, 324, 59, 32, "", false, window)
GUIEditor.button[9] = guiCreateButton(9, 363, 59, 32, "", false, window)
GUIEditor.button[10] = guiCreateButton(9, 401, 59, 32, "", false, window)
guiSetVisible(window,false)

local engTable = {
	{
		{"Rule 1",
			{
				"Deathmatching is not allowed outside the city of Las Venturas Criminals are",
				"allowed to attack Law agents IF they are wanted and being chased by them.",
				"Also, killing other players in ANY interior is not allowed, even if its in",
				"Las Venturas"
			}
		},
		{"Rule 2",
			{
				"The use of trainers and bugs is strictly forbidden and will result in a ban ",
				"from the server"
			}
		},
		{"Rule 3",
			{
				"Insulting and being racist towards other players will result in a severe",
				"punishment"
			}
		},
		{"Rule 4",
			{
				"Annoying the Server Staff is not allowed and will result in a punishment"
			}
		},
		{"Rule 5",
			{
				"Any attempt to avoid punishment by the server staff will only result in a",
				"larger punishment to be applied"
			}
		},
		{"Rule 6",
			{
				"Advertising about other servers and commercial products is not allowed"
			}
		},
		{"Rule 7",
			{
				"It is not allowed to share hacks, cracks or illegal downloads on the server"
			}
		},
		{"Rule 8",
			{
				"It is not allowed to abuse any kind of bugs that give you an unfair ",
				"advantage or spoil the fun of other players"
			}
		},
		{"Rule 9",
			{
				"Do not force/blackmail other players to do something they dont want to"
			}
		},
		{"Rule 10",
			{
				"Only English allowed in main chats (Main chat, team chat and support).",
				"In the Local chat, Personal Messaging and Group chat, any language ",
				"can be spoken"
			}
		},
		{"Rule 11",
			{
				"Camping at the hospital, Spawn-killing and Spawn arresting are forbidden"
			}
		},
		{"Rule 12",
			{
				"Arresting in a event is not allowed unless the event organizer says",
				"its allowed"
			}
		},
		{"Rule 13",
			{
				"Do not use the mainchat for advertising, use the advert chat instead"
			}
		},
		{"Rule 14",
			{
				"Spamming chats is not allowed. Misusing the Support Channel will",
				"result in a mute"
			}
		},
		{"Rule 15",
			{
				"Selling accounts or other in-game contents is not allowed"
			}
		},
		{"Rule 16",
			{
				"Use normal names, names with spam, adverts, and inappropriate things are not allowed"
			}
		},
		{"Rule 17",
			{
				"Trolling other players is not allowed and can result in serious punishment"
			}
		},
		{"Rule 18",
			{
				"Always listen to server staff"
			}
		},
		{"Rule 19",
			{
				"Do not avoid ingame situations. Eg. running into a interior to avoid death or arrest"
			}
		},
		{"Rule 20",
			{
				"Saying 'Don't Chat Here', 'Stop Misusing' and so on in support chat, will lead to a mute. Staff will do this, not players."
			}
		},
	},
	{
		{"Default Binds",
			{
				"F1 - Help menu / Information",
				"F2 - Job menu - quit job, start / end your shift",
				"F3 - Vehicle system - manage your personal vehicles here",
				"F4 - Drug system - manage your drug inventory here",
				"F5 - Job panel - Specific jobs will have panels with additional info",
				"F6 - Group system - Manage your group here or the group your part of",
				"F7 - Animations menu - Do cool animations through this menu!",
				"N - Press N to use your personal Iphone4S!",
			}
		},
		{"Chat related commands and binds",
			{
				"/local or /localchat or press U - Talk to people near you",
				"/group or /groupchat or /gc - Talk to people in your group",
				"/teamsay or press Y - Talk to people in the same team as you",
				"/advert - Advertise something to the whole server for $500 / msg",
				"	> Appropriate messages only!",
				"/clearchat - Clear your screen of all chat",
				"/sms <name> <text> - Private message / sms someone",
				"You can bind commanes using /bind [KEYBOARD KEY] chatbox [COMMAND NAME]"
			}
		},
		{"Other commands",
			{
				"/cleardx to clear all dx messages on screen",
				"/sellweps to sell weapons",
				"/selldrugs to sell drugs",
				"/lotto number to play CSG Lotto 720.",
				"/housepanel or /hp - Use a housepanel in the house",
				"/rob name - Try to rob a player",
				"/kill - Suicide",
				"/payfine - When you have only 1 wanted star, paying the will remove it",
				"/bribe [COP NAME] [AMOUNT] - When you have 3 wanted stars or less",
				"	you can bribe a cop, if he/she accepts, you will lose the stars",
				"	and the money",
				"/updates - See the latest updates to the server",
				"/punishments - See all your accounts and serial punishments",
				"/showhud 0 or 1 - Disable or enable the MTA HUD",
				"/screenshot or press F12 - Take a screenshot of your screen",
				"	It will be saved in your MTA screenshots folder",
				"/shownametags 0 or 1 - Show or hide player name tags",
				"/showchat 0 or 1 - Show or hide the chatbox"
			}
		},
		{"Event related commands",
			{
				"/eventwarp - Warp to an event",
				"/potclue - See the clue for the latest Pot",
				"For more info see Jobs or Events Tab",
			}
		},
		{"Law Enforcement related commands",
			{
				"/arrtransfer arrestedPersonName copName (/arrt for short) - transfer someone you arrested to another officer",
				"/pchief - police chief panel and more commands",
				"/accbribe name - to accept a bribe",
				"/riotshield - Use or stop using a riotshield (SWAT or MF only)",
				"For more info see Jobs (Law Enforcement)"
			}
		},
		{"Criminal related commands",
			{
				"/holdup or /robstore - Rob a store (must be at cash register)",
				"For more info see Jobs (Criminal)",
			}
		}

	},
	{
		{"Criminal",
			{
				"There are multiple Criminals' in CSG, each with a score requirement.",
				"To see the mutliple criminal classes, go to the criminal job marker and",
				"near it is another marker to specialize into another type of criminal.",
				"Criminals earn money through various ways. The following is criminal income(s)",
				"	> Los Venturas Turfing. Earn money when you take a turf for your group!",
				"	> Capture the Flag and deliver it!",
				"	> Sell weapons or sell drugs! (to sell weapons use /sell)",
				"	> Rob stores! /holdup or /robstore at the cash register!",
				"	> Destroy the armored truck and prevent it from being delivered!",
				"	> Rob the casino or rob the bank!",
				"	> Look for a red circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Police Officer",
			{
				"Here you can join the police service. Police officer job is all about arrestin",
				"wanted players. You can pick one of 8 various skins and 4 different types",
				"of police vehicles. When you get enough arrests you will be able to get promoted",
				"and become one of the special ranks in police job. Also good progress as a ",
				"police officer can lead to joining one of the special government services",
				"Job perk: To arrest players simply hit them with a nighstick.",
				"You can also use tazer to stun them. The player is wanted if he has numbers",
				"(1-6) behind his name.",
				"	> LAW can do Patrol Mission's, do them from Police Department OR SWAT Base",
				"	> Press F5 to use your police computer",
				"	> Type /respond ID to respond to a crime report, /rescancel to cancel",
				"	> Look for a blue circle blip on the map",
				--"	> [Click Here to see Job Location]"
			},
		},
		{"Traffic Officer",
			{
				"A Traffic Officer can do everything a Police Officer can (See Police Officer)",
				"This job is at every Police Department except Las Venturas. In this job you have",
				"to take a picture of the players who is speeding and you get per 150-300$",
				"for it also criminals gets a wanted level when you take a picture of his speeding.",
				"	> Look for a blue circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"K9 Unit Officer",
			{
				"This job is only at Los Santos Police Department garage. With this job you ",
				"can do what Police Officers do but also you can get a dog from this job.",
				"This dog is immortal but if you see a wanted level criminal and taze him",
				"the dog goes and bits the criminal.",
				"	> Look for a blue circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"SWAT Team",
			{
				"Official Law Enforcement Team, please refer to http://csgmta.net, the forum",
				"for detailed information. SWAT Team has access to a special base, advanced",
				"vehicles, barriers, and more. SWAT is able to drive the Armored Truck",
				"	> Look for a blue circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Military Forces",
			{
				"Official Law Enforcement Team, please refer to http://csgmta.net, the forum",
				"for detailed information. Military Forces has access to a special base, advanced",
				"vehicles, and much more. Military Forces are able to drive the Armored Truck",
				"	> Look for a green circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Fisherman",
			{
				"As Fisherman you can get fish and earn money and after that you can sell",
				"your fish in 24/7 shops or near Fisherman job.","Players can catch fish",
				"and a big variety of them. They can also hold records if they catch",
				"the biggest of a specific kind. Press 1 to toggle fishing, and 2",
				"to reel in your net. You can only fish from a refeer or a marquis",
				"Job Perks: You don't need a fishing permit to fish",
				"	> Press F5 for your fisherman panel",
				"	> This job has ranks + bonuses for specific ranks!",
				"	> Look for a yellow circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Hooker",
			{
				"As a hooker you can offer your services to other players. You are able to",
				"pick 1 of 9 different skins. You can find your customer by standing around a ",
				"corner or even advertising your services. When customer pick one of your services",
				"you will receive cash and they will gain HP / Health. Job perk: To offer your",
				"services to a customers you have to enter their car as a passanger.",
				"	> Look for a yellow circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Bus Driver",
			{
				"This job is located in LS and SF, near the centre. Convenion center in LS and",
				"central downtown in SF. As a bus driver you must transport civilians and",
				"people around San Andreas. Use your panel F5 and select a route and start it",
				"You must complete the whole route in order to be paid and proceed to the stops!",
				"slowly. There is a automated voice - next stop announcing system!",
				"You can enable voice and gps and disable via your panel.",
				"Charge people! Type /setfare amount. This is the amount",
				"people must pay to ride your bus (One time enter only!)",
				"	> Press F5 for your bus driver panel",
				"	> This job has ranks + bonuses for specific ranks!",
				"	> Look for a yellow circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Mechanic",
			{
				"As a mechanic your job is to repair vehicles owned by",
				"other players. You can pick 1 of 3 various skins and",
				"1 of 4 vehicles for easier transportation. You are able",
				"to use Towtruck to tow other players vehicles if they run",
				"out of gas or bounce off the road. Job perk: To repair ",
				"a vehicle press right mouse button near it's doors. Use ",
				"num_2 and num_8 keys to adjust Towtruck's cable height.",
				"	> Press F5 for your mechanic panel",
				"	> Look for a yellow circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Paramedic",
			{
				"The Medic / Paramedic Job is available in all cities. As a paramedic your",
				"job is to heal players with your healing spraycan. You can heal player by simply",
				"spraying them, with the spraycan, every time you heal somebody you earn money",
				"for it. Paramedics get access to a ambulance. They are essential in the health",
				"of San Andreas's civilians! Use your panel to track the wounded down!",
				"	> Press F5 for your paramedic panel",
				"	> Look for a blue circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Pilot",
			{
				"Transport cargo and people around! You can get the pilot job ",
				"at 3 Airports of San Andreas. San Fierro, Los Santos and in Las Venturas.",
				"First you have to get in the marker with pilot skin and get the job.",
				"Second you have to get license so you can fly on airplanes or helicopters.",
				"You can get your license from red dragon blip.Then you have to go ",
				"to the yellow marker and get a plane or helicopter.The fastest and ",
				"easiest plane is Shamal and fastest helicopter is Maverick. After you have",
				"to pick up cargo.Cargo is red blip as your destination.When you got ",
				"cargo from red marker at your destination fly to red blip again and ",
				"when you will be at your destination go to the red marker again and ",
				"you will get your money. Players can also pay you to give them a ride!",
				"	> Press F5 for your pilot panel",
				"	> This job has ranks + bonuses for specific ranks!",
				"	> Look for a yellow circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Trucker",
			{
				"Trucker Job is at varius places in San Andreas. First in this job you have to",
				"get a truck from yellow marker.Then you have to go to the green marker and select",
				"a destination.There is a lots of places where you can deliver it and the price is",
				"higher or lower.The closer destinations give you less money and the farther one ",
				"gives more.If you lose back side of your truck then you can fail the delivery!",
				"This job is good paying and have ranks / levels for you to acheive!",
				"	> Press F5 for your trucker panel",
				"	> This job has ranks + bonuses for specific ranks!",
				"	> Look for a yellow circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Firefighter",
			{
				"Firefighter can be found in LS, near AS hospital or in SF at the fire station.",
				"As Firefighter you must attend emergency incidents including fire(s)",
				"and put them out using your fire truck or a fire extinguisher.",
				"Protect the civilians of San Andreas and put them out as soon as possible.",
				"Look for Red Icon Blips on your map, these are active fires you must attend.",
				"	> Look for a red circle blip on the map",
				--"	> [Click Here to see Job Location]"
			}
		},
	},
	{
		{"Drug Shipment :: Targeted for All Players",
			{
				"Drug Shipment happens at LS Docks -> SF. First 5 criminals must be on the",
				"drug ship to start the shipment. Once it starts, you can load drug crates for",
				"drug points. You can also kill LAW for drug points, and LAW can kill the criminals",
				"for drug points. Killing also gets you money for kill. Anytime from the point",
				"the shipment starts, and 30 minutes, you can redeem your drug points at the drug",
				"factory. 1 point == 1 drug at the drug factory!. The drug ship leaves LS in 5 minutes",
				"and gets to SF. Where you get to SF, there is 1 drug van per drug crate loaded",
				"you get 25 more points for delivering the van to the drug factory.",
				"	> Look for D blip on the map!",
				"	> Use /drugtime to get the latest info for the shipment.",
				"	> Get Score per kill and for redeeming your points!",
			}
		},
		{"Casino Rob :: Targeted for All Players",
			{
				"Criminals can rob the LV Casino at specific intervals! Doing so will get them",
				"wanted but the reward is worth it! They can also rob the LV Caligula's Casino",
				"You earn a good sum of the robbed money! If the robbery is a success",
				"Criminals must kill any LAW and run away when the safe is cracked!",
				"Law get 2k per kill for killing a criminal, Criminals get 4k per LAW kill",
				"You will see a GUI that shows the top 5 criminals and law!",
				"	> Use /casinotime to get the latest info for the next planned robbery!",
				"	> Get Score per kill!",
				--"	> [Click Here to see Location]"
			}
		},
		{"Armored Truck Delivery :: Targeted for All Players",
			{
				"Every now and then a facility will request a armored truck transport. Police",
				"from all of San Andreas gather at the armored truck to prepare for it's delivery.",
				"SWAT or MF go in the driver seat, and the delivery starts when there is enough LAW",
				"near the truck. The truck must be delviered to the desired destination and LAW will",
				"be rewarded a good amount of money! Criminals can attempt to destroy the truck",
				"Money bags will drop from the back of the truck if all LAW are killed",
				"The truck blip on your map is usually this armored truck. Only LAW see",
				"the blip for it's destination.",
				"	> LAW will be advised at regular intervals when the delivery is available",
				"	> LAW Refers to any Law Enforcement officer",
				--"	> [Click Here to see Location]"
			}
		},
		{"Bank Robbery :: Targeted for All Players",
			{
				"Criminals can perform bank robs in teams. To successfully rob the bank they",
				"will need to collect two security codes, open the door that leads to the vault,",
				"blow the vault door and run away with the money. Teamwork is the key to success",
				"in this event, however speed is also very important because as soon as the alarm",
				"starts the law enforcers get informed about the rob and will report to the scene.",
				">Robbing a bank is only possible when there are more than 15 players online."
			}
		},
		{"Find the Pot :: Targeted for All Players",
			{
				"Every now and then you will be advisted there is a 'pot' available for pickup.",
				"You will be given a clue and the first person to find it will be given a",
				"good monetary reward! This happens every now and then and there are",
				"multiple locations and clues, so look out for it!",
				--"	> [Click Here to see Location]"
			}
		},
		{"Capture the Flag :: Targeted for All Players",
			{
				"Every few minutes a flag will appear, someone must pick it up and deliver it",
				"to its destination for a good reward. This is often in LV and is very",
				"attractive for the criminals, but generally for all civilians.",
				"After you pick up the flag, you must survive and protect it until you",
				"reach the destination. People might try to kill you for it, so be careful!",
				--"	> [Click Here to see Location]"
			}
		}
	},
	{
		{"Patrol Mission :: Targeted mainly for Law Enforcement",
			{
				"Any LAW can start a patrol mission from any PD or SWAT Base",
				"for SWAT members. Once you start the mission, you will have a Menu",
				"which will show you the information about the latest '911' call. You must",
				"reach the call location before the time runs out and finish the required task.",
				"On top of the peds / criminals, it will say 'neutrailize' meaning hit them",
				"with your night stick until they put their hands up!, each mission will",
				"have different scenerios / info, so check it carefully. You will be paid",
				"after you finish ALL CALLS, and based on distance + time bonus.",
				"If you fail 1 call, you fail the whole mission, so be dedicated!",
				--"	> [Click Here to Preview]"
			}
		},
		{"Store Robbery Mission :: Targeted for All Players",
			{
				"Rob a store if you dare! Walk in and up front to the cash register and then",
				"type /robstore or /holdup to attempt a robbery. Sometimes you will fail",
				"but most of the time you wont. The more criminals in the store, the more",
				"likely you will succed. When the robbery begins, REMAIN inside the red",
				"checkpoint. You will notice the cashier putting money into a money bag.",
				"The cashier will continue to put money as LONG AS YOU REMAIN inside the",
				"robbery checkpoint. You can leave the checkpoint early, or wait until",
				"cashier puts all the money. Once it says -Robbery Complete-, run far",
				"away from the store and you will be able to keep the money you robbed!",
				"Beware, robbing stores does get you a lot of money, but you will get wanted!",
				"	> Use /robstore or /holdup",
				--"	> [Click Here to Preview]"
			}
		},
		{"House Robbery / Warrant for Arrest :: Targeted for All Players",
			{
				"If you are a criminal, you will see a red house blip on your map, going",
				"there will allow you to rob the house and potentially get some money!",
				"If you are a law enforcement officer, that house has a warrant for search",
				"/ arrest and you can go to the house and be rewarded some money. You can",
				"do this as long as there as houses to be robbed or to be searched!",
				--"	> [Click Here to Preview]"
			}
		}
	},
	{
		{"Houses",
			{
				"CSG's House System is one of the most advanced out there. Use /housepanel",
				"in your house to use any of the following features;",
				"	> House Permissions, control who has access to what",
				"	> House Money Storage, with logging.",
				"	> House Drug Storage",
				"	> House Weapon Storage",
				"	> House Music System! Add your own music, have parties!",
				"	> Try to break into a house if you so dare!",
				"	> Market Value, market value goes up and down based on demand.",
				"If you are a criminal, you will see a red house.Go there and rob houses to get some money",
				"If you are in Police Job,you will see green house.Go there and stop robbery to get some money ",

			}
		},
		{"Score",
			{
				"Score can be earned by doing any job or activity that is benifical",
				"Score is lost for the oppisite reason. For example, you earn score when you complete",
				"a bus driver route, but lose when you die or get jailed.",
				"Score helps you unlock certain game features such as Criminal Classes!",
				"The score system is being expanded so it has more use as time passes.",
			}
		},
		{"Lotto 720",
			{
				"Play the lotto! What do you have to lose?",
				"Everyday at 18:00, the Lotto occours and you have a chance to win a lot of money!",
				"Simply type /lotto number (1-100) to play! Ill cost you $1000, but its worth it!",
			}
		},
		{"Game Time",
			{
				"The top right corner shows the weekday currently in game. Special dates and times",
				"have special benifits, eg. midnight ammunation sales! and much more!",
				"Near the end of everyday, and every week, the latest statistics are shown!",
				"	> eg. Top player of the day, the worst, the amount of bullets fired!",
				"	> There are over 50 stats to show so stay tuned!",
				"	> [Going to be added Soon]",
			}
		},
		{"Drugs",
			{
				"If you are a criminal, you can make drugs in Drug Factory which is located in SF",
				"If you wanna Take/Sell/Drop drugs press F4 to open Drug System GUI",
			}
		},
		{"Vehicles",
			{
				"Press F3 to open Vehicle Managment Panel",
				"Here you will find all Vehicles which you bought from Car Shops",
				"You can Spawn Your Vehicle",
				"You can Hide Your Vehicle",
				"You can Mark Your Vehicle",
				"You can Lock/Unlock Your Vehicle",
				"You can Recover Your Vehicle to Parking",
				"You can Spectate Your Vehicle",
			}
		},
		{"Wanted / Crimes",
			{
				"if you will kill somebody in LS or SF you will get Wanted Level",
				"If you will rob House,Bank,Casino or Shop you will get Wanted Level",
			}
		},
		{"Gambling",
			{
				"Casino is located in LV.Entrance is free,but you must pay for a chance to win",
			}
		}
	},
	{
		{"Global Positioning System (GPS)",
			{
				"Global Positioning System system will help you to find players location in MAP",
				"Select from road arrows, vehicle arrows, turn by turn voice guidance!",
			}
		},
		{"Private Messaging",
			{
				"Using this function no one can't see what are you talking with somebody, it's private chat ",
			}
		},
		{"Money Transfer",
			{
				"You can Transfer you money to Bank or to someone,but he must be Online",
			}
		},
		{"Weapon Skills",
			{
				"You can train your Weapon Skills in Ammunations",
				"It's for Running Weps and Fast Shooting",
			}
		},
		{"Music",
			{
				"If you will be bored you can open your Iphone and hear some Music from Radio Stations ",
			}
		},
		{"Mine Sweeper",
			{
				"It's cool game which you can find in your iPhone ",
			}
		},
		{"Puzzle",
			{
				"It's cool game which you can find in your iPhone ",
			}
		},
		{"Notes",
			{
				"Here you can save some Notes for you ",
			}
		},
		{"Settings",
			{
				"You are able to change your Phone background picture ",
				"You are able to change your account Passord ",
				"You are able to change your account EMail ",
				"You are able to turn on/off FPS Meter,Fuel Mater,Heat Haze,Blur,Coulds,Chat Box and etc ",
			}
		},
	}
}

local frenchTable = {
{
{"Regle 1",
{
"Deathmatching n'est pas autorise en dehors de la ville de Las Venturas criminels sont",
"Permis d'attaquer les agents de la loi si elles sont recherchees et pourchasse par eux.",
"En outre, tuant d'autres joueurs dans n'importe quel interieur n'est pas autorise, meme si son in",
"Las Venturas"
}
},
{"Regle 2",
{
"Le recours a des formateurs et des insectes est strictement interdite et donnera lieu a une interdiction",
"À partir du serveur"
}
},
{"Regle 3",
{
"Insulter et etre raciste envers les autres joueurs se traduira par une grave",
"Punition"
}
},
{"Regle 4",
{
"Ennuyeux l'etat-major du serveur n'est pas autorisee et entrainera une punition"
}
},
{"Regle 5",
{
"Toute tentative pour eviter la punition par le personnel du serveur ne permettra d'obtenir un",
"Plus grande peine a etre appliquee"
}
},
{"Regle 6",
{
"La publicite sur d'autres serveurs et de produits commerciaux n'est pas autorise"
}
},
{"Regle 7",
{
"Il n'est pas autorise a publier des hacks, cracks ou de telechargements illicites sur le serveur"
}
},
{"Regle 8",
{
"Il n'est pas permis d'abuser de tout type de bugs qui vous donnent une injuste",
"Avantage ou gâcher le plaisir des autres joueurs"
}
},
{"Regle 9",
{
"Ne forcez pas / chantage autres joueurs de faire quelque chose qu'ils ne veulent pas"
}
},
{"Regle 10",
{
"Seul l'anglais a permis a des conversations (chat principales Main, le chat d'equipe et de soutien).",
"Dans le chat local, Personal Messagerie et Chat en groupe, n'importe quelle langue",
"On peut parler"
}
},
{"Regle 11",
{
"Camping a l'hôpital, Spawn Spawn-tuer et arreter sont interdits"
}
},
{"Regle 12",
{
"L'arrestation d'un evenement n'est pas autorisee a moins que l'organisateur de l'evenement dit",
"Son permis"
}
},
{"Regle 13",
{
"Ne pas utiliser le mainchat pour la publicite, utilisez l'annonce bavarder au lieu"
}
},
{"Regle 14",
{
"Chats spamming n'est pas autorisee. Abuser de la Manche de soutien volonte",
"Aboutir a un muet"
}
},
{"Regle 15",
{
"La vente de comptes ou d'autres contenus dans le jeu n'est pas autorise"
}
},
{"Regle 16",
{
"Utiliser les noms normales, les noms de spam, publicites, et des choses inappropriees ne sont pas autorises"
}
},
{"Regle 17",
{
"Les joueurs de peche a la traine d'autres n'est pas autorisee et peut entrainer des sanctions graves"
}
},
{"Regle 18",
{
"Toujours a l'ecoute du personnel serveur"
}
},
{"Rule 19",
			{
				"Do not avoid ingame situations. Eg. running into a interior to avoid death or arrest"
			}
		},
},

}

local portugueseTable = {
	{"Regras",
		{"Regra 1",
			{
				"Deathmatch nao e permitido fora de Las Venturas. Criminosos podem atacar",
				"Agentes da Lei se estiverem com nivel de procurado e sendo cacado pelos",
				"oficiais. Matar os demais jogadores em QUALQUER interior, mesmo sendo um",
				"interior em Las Venturas, nao e permitido.",
			}
		},
		{"Regra 2",
			{
				"O uso de programas e abuso de bugs e estritamente proibido e resultara ",
				"em um banimento no servidor.",

			}
		},
		{"Regra 3",
			{
				"Insultos e racismo contra os outros jogadores ira resultar em um punimento",
				"no servidor.",

			}
		},
		{"Regra 4",
			{
				"Irritar os Staffs nao e permitido e ira resultar em um punimento no servidor."
			}
		},
		{"Regra 5",
			{
				"Qualquer tentativa de fugir de um punimento dos Staffs (como se desconectar",
					"do servidor) ira resultar em um punimento ainda maior.",

			}
		},
		{"Regra 6",
			{
				"Propagandas sobre outros servidores ou produtos comerciais nao e permitido."
			}
		},
		{"Regra 7",
			{
				"Nao e permitido compartilhar hacks, cracks ou produtos ilegais no servidor."
			}
		},
		{"Regra 8",
			{
				"Nao e permitido abusar, de alguma forma, para obter vantagem ou prejudicar",
					"a diversao dos demais jogadores.",

			}
		},
		{"Regra 9",
			{
				"Jamais obrigue ou ameace algum jogador a fazer algo que ele nao queira."
			}
		},
		{"Regra 10",
			{
				"E permitido apenas INGLÊS nos chats principais (MainChat, TeamChat e Support).",
					"LocalChat, Mensagens Pessoais e GroupChat e permitido qualquer linguagem."
			}
		},
		{"Regra 11",
			{
				"Camperar no hospital, fazer SpawnKill e SpawnArrest e proibido."
			}
		},
		{"Regra 12",
			{
				"Prender nos eventos nao e permitido, a menos que o organizador do evento permita.",

			}
		},
		{"Regra 13",
			{
				"Nao use o MainChat para propagandas. Para isso, use o AdvertChat."
			}
		},
		{"Regra 14",
			{
				"Fazer Spam no chat nao e permitido. O uso inadequado do Support causara um mute."
			}
		},
		{"Regra 15",
			{
				"Vender contas ou qualquer outro objeto no jogo e proibido (para evitar furtos)."
			}
		},
		{"Regra 16",
			{
				"Use nomes normais. Nomes com propagandas, insultos ou caracteres aleatorios e repetitivos nao serao permitidos."
			}
		},
		{"Regra 17",
			{
				"Trollar outro jogador e totalmente proibido e resultara em uma severa punicao."
			}
		},
		{"Regra 18",
			{
				"Sempre ouca os Staffs."
			}
		},
		{"Rule 19",
			{
				"Do not avoid ingame situations. Eg. running into a interior to avoid death or arrest"
			}
		},

	},
	{"Comandos",
		{"Binds padroes",
			{
				"F1 - Menu de Ajuda / Informacoes",
				"F2 - Menu de Empregos - Deixar emprego, terminar emprego",
				"F3 - Sistema de Veiculos - Gerencie seus veiculos",
				"F4 - Sistema de Drogas - Gerencie suas drogas",
				"F5 - Painel de Empregos - Paineis de alguns empregos especificos",
				"F6 - Sistema de Grupos - Gerencie seus grupos ou o grupo no qual voce faz parte",
				"F7 - Menu de Animacoes - Faca animacoes divertidas",
				"N - Aperte N para usar seu iPhone pessoal!",
			}
		},
		{"Comandos e binds relacionados ao Chat",
			{
				"/local ou /locahcat ou aperte U - converse com pessoas proximas a voce",
				"/group ou /groupchat ou /gc- converse com pessoas de seu grupo",
				"/teamsay ou aperte Y - Converse com pessoas do mesmo time que voce",
	"/advert - Divulgue alguma coisa no server por $500/mensagem",
	"> Apenas mensagens apropriadas!",
	"/clearchat - Limpa todo o chat da sua tela",
	"/sms <nome> <texto> - Mensagem/SMS privada para alguem",
	"Voce pode criar novos binds usando /bind <tecla> chatbox <comando>",
			}
		},
		{"Outros comandos",
			{
				"/sellweps to sell weapons",
				"/selldrugs to sell drugs",
				"/lotto <numero> para jogar na CSG Lotto 720",
	"/housepanel ou /hp - Use um painel na sua casa",
	"/rob <name> - Tentar roubar um jogador",
	"/kill - Suicidio",
	"/payfine - Quando voce tiver apenas 1 estrela de procurado, pague e perdera a estrela",
	"/bribe <nome_policial> <quantidade> - Quando voce tiver 3 estrelas ou menos, podera subornar os policiais",
	"/updates - Veja as ultimas atualizacoes do servidor",
	"/punishments - Veja todas as punicoes da sua conta e do seu serial",
	"/showhud 0 ou 1 - Disabilita ou habilita o MTA HUD",
	"/screenshot ou aperte F12 - Tira um screenshot da sua tela",
	"/shownametags 0 ou 1 - Mostra ou esconde as tags dos nomes dos jogadores",
	"/showchat 0 ou 1 - Mostra ou esconde o chatbox",
			}
		},
		{"Comandos relacionados a eventos",
			{
				"/eventwarp - Teletransporta para um evento",
	"/potclue - Veja a pista do ultimo pote",
	"Para maiores informacoes veja a aba de Empregos ou Eventos",
			}
		},
		{"Comandos relacionados aos Oficiais da Lei",
			{
			"/accbribe <nome> - Aceita o suborno",
	"/riotshield - Usar/pausar o escudo (SWAT ou MF apenas)",
	"Para maiores informacoes veja a aba Oficiais da Lei"
			}
		},
		{"Comandos relacionados a Criminosos",
			{
				"/holdup ou /robstore - Roubar uma loja (precisa ter uma caixa registradora)",
	"Para maiores informacoes veja a aba Criminosos"
			}
		}

	},
	{"Empregos",
		{"Criminoso",
			{
				"Existem diversos tipos de criminosos no CSG, cada um com um numero minimo de pontos exigido.",
"Para ver os diversos tipos de criminoso, va à marca do emprego de criminoso e proximo à ela tera outra marca,",
"onde voce podera escolher o tipo de criminoso que pretende ser.",
"Criminosos ganham dinheiro de varias formas. Abaixo, as fontes de renda dos criminosos:",
"> Turfar em Las Venturas. Ganhe dinheiro quando tomar uma area (turf) para seu grupo!",
"> Capture a bandeira e entregue-a!",
"> Venda armas ou drogas! (para vender armas use /sell)",
"> Roube estabelecimentos! /holdup ou /robstore proximo à caixa registradora!",
"> Destrua o carro blindado e evite que ele seja entregue!",
"> Roube o casino ou o banco!",
"> Procure por um circulo vermelho no mapa!",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Oficial de Policia",
			{
			"Aqui voce pode se juntar à policia. Oficiais da policia, em resumo, prendem bandidos. Voce pode escolher um de 8 ",
"skins e 4 tipos diferentes de veiculos policiais. Quando voce adquire prisoes suficiente, estara apto a ser ",
"promovido e se tornar um oficial com um cargo especial na policia. Obtendo tambem um bom progresso na policia, ",
"voce podera entrar em um dos servicos governamentais especiais.",
"Dica: para prender os criminosos, apenas acerte-os com o seu cacetete. Voce tambem pode usar o taser para desorienta-los.",
"Os criminosos procurados possuem um numero de [1-6] apos seus nomes.",
"> Oficiais podem fazer Missoes de Patrulha. Faca isso a partir do Departamento de Policia ou a base da SWAT.",
"> Aperte F5 para usar o computador da policia",
"> Digite /responde <ID> para responder uma denuncia, /rescancel para cancelar",
"> Procure por um circulo azul no mapa",
				--"	> [Click Here to see Job Location]"
			},
		},
		{"Oficial de Trafego",
			{
				"Um Oficial de Trafego pode fazer tudo que um Oficial de Policia pode. O emprego pode ser encontrado em todos os ",
"departamentos de policia (exceto em Las Venturas). Nesse trabalho, voce precisa fotografar os jogadores que estao acima ",
"da velocidade maxima permitida, obtendo cerca de $150-300 por cada um. Os criminosos ganharao uma estrela de procurado ",
"quando voce os fotografar.",
"> Procure por um circulo azul no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Oficial da Unidade K9",
			{
				"Este emprego pode ser encontrado apenas no departamento de Los Santos (na garagem). Com este emprego voce pode fazer o que",
"os Oficiais de Trafego fazem, mas pode tambem ter um cachorro neste emprego.",
"Esse cachorro e imortal mas se voce ver um criminoso procurado e atirar nele com um taser, o cachorro ira atacar o criminoso.",
"> Procure por um circulo azul no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"SWAT Team",
			{
				"Para se tornar um SWAT, visite http://csgmta.net para maiores informacoes. O time da SWAT tem acesso a uma base especial,",
"veiculos avancados, barreiras, e muito mais. SWATs tem permissao para dirigir o Caminhao Blindado.",
"> Procure por um circulo azul no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Forcas Militares",
			{
				"Para entrar nas Forcas Militares, visite http://csgmta.net para maiores informacoes. O time das Forcas Miliates tem acesso ",
"a uma base especial, veiculos avancados e muito mais. Forcas Militares tem permissao para dirigir o Caminhao Blindado.",
"> Procure por um circulo verde no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Pescador",
			{
				"Como pescador voce pode pescar peixes e ganhar dinheiro depois de vende-los nas lojas 24/7 ou proximo ao emprego de pescador.",
"Jogadores podem pescar uma grande variedade de peixes. Eles tambem podem quebrar recordes pescando o maior de um tipo especifico.",
"Aperte 1 para pescar e 2 para puxar a rede. Voce so pode pescar estando em um Reefer ou em um Marquis.",
"Dica: voce nao precisa de uma licenca de pescador para pescar",
"> Aperte F5 para abrir seu painel de pescador",
"> Este emprego tem ranks + bônus para ranks especificos",
"> Procure por um circulo amarelo no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Prostituta",
			{
				"Como uma prostituta voce pode oferecer seus servicos para os outros jogadores. Voce estara apto a escolher 1 entre 9 skins. ",
"Voce pode encontrar seus clientes esperando nas calcadas nos arredores da cidade, ou simplesmente divulgando seus servicos.",
"Quando voce encontrar um cliente, ira ganhar o dinheiro do servico e tera seu sangue curado. ",
"Dica: para oferecer seus servicos, entre no carro do cliente como passageiro.",
"> Procure por um circulo amarelo no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Motorista de Ônibus",
			{
				"O emprego esta localizado em Los Santos e San Fierro, proximo ao centro. Centro de Convenion (em LS) e centro de Downtown (SF).",
"Como um motorista de ônibus voce deve transportar civis e pessoas em toda San Andreas. Use seu painel do F5 e selecione ",
"uma rota para comecar.",
"Voce deve completar a rota completa para ser pago. Existe um sistema de voz automatico anunciando a proxima parada! ",
"Voce pode habilitar/desabilitar as vozes e o GPS no seu painel.",
"Passageiros! Digite /setfare <valor>. Este sera o valor que as pessoas deverao pagar para andar em seu ônibus (o valor e pago apenas ",
"uma vez, quando eles entram).",
"> Aperte F5 para abrir seu painel de motorista",
"> Esse emprego tem ranks + bônus para ranks especificos!",
"> Procure por um circulo amarelo no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Mecânico",
			{
				"Como um mecânico seu trabalho e reparar os veiculos danificados dos outros jogadores. Voce pode escolher 1 entre 3 skins ",
"e 1 de 4 veiculos para facil transporte. Voce pode tambem usar o Guindaste para guinchar os veiculos dos outros jogadores, ",
"caso eles tenham ficado sem gasolina no meio da estrada.",
"Dica: para reparar um veiculo, aperte o botao direito do mouse proximo à porta. Use num_2 e num_8 para controlar o guindaste.",
"> Aperte F5 parar abrir seu painel de mecânico",
"> Procure por um circulo amarelo no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Paramedico",
			{
				"O emprego de medico/paramedico esta disponivel em todas as cidades. Como paramedico voce pode curar os jogadores com sua lata",
"de spray. Voce pode curar simplesmente atirando spray neles. Cada vez que voce curar um jogador, ira ganhar por isso. ",
"Paramedicos tem acesso às ambulâncias. Eles sao essenciais na vida das pessoas de San Andreas! Use seu painel para ver quem precisa ",
"dos seus servicos.",
"> Aperte F5 para abrir seu painel de medico",
"> Procure por um circulo azul no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Piloto",
			{
				"Transporte cargas e pessoas por ai! Voce pode pegar o emprego de piloto nos 3 aeroportos de San Andreas (San Fierro, Los Santos e ",
"Las Venturas). Primeiro, voce deve ir ate à marca com o skin de piloto e entao obter o emprego. Depois, voce precisa obter uma licenca ",
"para poder voar com avioes e helicopteros. Voce pode obter sua licenca indo ate o simbolo do dragao vermelho (no aeroporto). Logo apos, ",
"voce precisa ir ate a marca amarela para pegar um aviao/helicoptero. O aviao mais rapido e o Shamal e o helicoptero mais rapido e o Maverick. ",
"Depois voce precisa pegar a carga (marca vermelha). Quando pegar, voe ate a outra marca vermelha e entao voce ganhara o dinheiro.",
"Jogadores tambem podem pagar voce por uma viagem.",
"> Aperte F5 para abrir seu painel de piloto",
"> Esse emprego tem ranks + bônus para ranks especificos!",
"> Procure por um circulo amarelo no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Caminhoneiro",
			{
				"O emprego de caminhoneiro esta presente em varios lugares em San Andreas. A primeira coisa a fazer nesse emprego e pegar um caminhao na marca ",
"amarela. Entao voce vai ate a marca verde, que indica seu destino. Existem muitos lugares onde voce pode entregar as cargas e o preco e alto ",
"ou baixo. Os destinos mais proximos te dao menos dinheiro e os mais distantes te dao mais dinheiro. Se voce perder a parte traseira do caminhao, ",
"voce ira falhar na entrega. Esse emprego tem um bom pagamento e possui ranks e niveis para desbloquear.",
"> Aperte F5 para abrir seu painel de caminhoneiro",
"> Esse emprego tem ranks + bônus para ranks especificos!",
"> Procure por uma marca amarela no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
		{"Bombeiro",
			{
				"Bombeiros podem ser encontrados em Los Santos, proximo ao All Saints Hospital, ou em San Fierro no Departamento. Como bombeiro voce deve atender ",
"às emergencias de incendio e apaga-los usando seu extintor de incendios ou a mangueira do caminhao.",
"Proteja os civis de San Andreas e ajude-os o mais rapido possivel.",
"Procure pelos icones vermelhos no seu mapa, eles representam incendios que precisam ser apagados.",
"> Procure por uma marca vermelha no mapa",
				--"	> [Click Here to see Job Location]"
			}
		},
	},
	{"Eventos",
		{"Embarque de Drogas :: Presente para todos os jogadores",
			{
			"Embarque das Drogas ocorre nas Docas de Los Santos e segue para San Fierro. Para comecar, e preciso 5 criminosos ",
"no navio. Apos iniciar, voce pode levar as caixas de drogas para o navio usando o veiculo. Voce tambem pode matar ",
"os agentes da lei que aparecerem (eles tambem tentarao matar os criminosos) e ganhar dinheiro por isso.",
"Quando o navio partir, ele ira ate Bayside (pequena ilha acima de San Fierro). Quando o navio embarcar la, voce ",
"deve pegar uma van e leva-la ate a Fabrica de Drogas (marcada por um copo rosa). Havera uma van para cada caixa ",
"carregada no navio.",
"Quando chegar na fabrica, voce ganhara 25 pontos (cada ponto equivale a uma droga).",
"> Procure pelo icone 'D' no mapa.",
"> Use /drugtime para saber quando tempo resta ate o navio embarcar.",
"> Obtenha mais pontos matando policiais.",
			}
		},
		{"Roubo no Cassino :: Presente para todos os jogadores",
			{
				"Criminals can rob the LV Casino at specific intervals! Doing so will get them",
				"wanted but the reward is worth it! They can also rob the LV Caligula's Casino",
				"You earn a good sum of the robbed money! If the robbery is a success",
				"Criminals must kill any LAW and run away when the safe is cracked!",
				"Law get 2k per kill for killing a criminal, Criminals get 4k per LAW kill",
				"You will see a GUI that shows the top 5 criminals and law!",
				"	> Use /casinotime to get the latest info for the next planned robbery!",
				"	> Get Score per kill!",
				--"	> [Click Here to see Location]"
			}
		},
		{"Caminhao Blindado :: Presente para todos os jogadores",
			{
				"Every now and then a facility will request a armored truck transport. Police",
				"from all of San Andreas gather at the armored truck to prepare for it's delivery.",
				"SWAT or MF go in the driver seat, and the delivery starts when there is enough LAW",
				"near the truck. The truck must be delviered to the desired destination and LAW will",
				"be rewarded a good amount of money! Criminals can attempt to destroy the truck",
				"Money bags will drop from the back of the truck if all LAW are killed",
				"The truck blip on your map is usually this armored truck. Only LAW see",
				"the blip for it's destination.",
				"	> LAW will be advised at regular intervals when the delivery is available",
				"	> LAW Refers to any Law Enforcement officer",
				--"	> [Click Here to see Location]"
			}
		},
		--[[{"Bank Robbery :: Targeted for All Players",
			{
				"Criminals can perform bank robs in teams. To successfully rob the bank they",
				"will need to collect two security codes, open the door that leads to the vault,",
				"blow the vault door and run away with the money. Teamwork is the key to success",
				"in this event, however speed is also very important because as soon as the alarm",
				"starts the law enforcers get informed about the rob and will report to the scene.",
				">Robbing a bank is only possible when there are more than 15 players online."
			}
		},--]]
		{"Capture a Bandeira :: Presente para todos os jogadores",
			{

"Em um certo intervalo, uma bandeira ira aparecer e alguem precisara pega-la e entrega-la, ganhando assim uma ",
"boa recompensa em dinheiro. Ela surge em Las Venturas e e muito disputada pelos criminosos.",
"Depois que voce pegar a bandeira, voce deve sobreviver e protege-la ate chegar ao destino de entrega.",
"Os demais criminosos tentarao matar voce, entao tenha cuidado!",
				--"	> [Click Here to see Location]"
			}
		},
		{"Encontre o Pote :: Presente para todos os jogadores",
			{

"Voce sera avisado quando houver um 'pote' disponivel para ser capturado. Voce recebera uma dica e a primeira ",
"pessoa que encontrar o pote ganhara uma boa quantia em dinheiro. Isso acontece toda vez e existem varios lugares ",
"e dicas, entao procure por isso.",
			}
		}
	},
	{"Missoes",
		{"Missoes de Patrulha :: Disponivel para Oficiais da Lei",
			{
			"Qualquer Oficial da Lei pode iniciar uma missao de patrulha a partir de qualquer Departamento Policial ou ",
"a base da SWAT (disponivel para soldados da SWAT). Assim que voce iniciar, voce tera um menu que ira te mostrar ",
"as informacoes sobre a ultima denuncia. Voce deve ir ate o local antes que os criminosos fujam e precisa neutraliza-los.",
"Acima da cabeca dos pedestres/criminosos, ira aparecer uma mensagem dizendo 'neutralize', onde voce precisara ",
"atingi-los com seu cacetete (ate que eles levantem as maos). Cada missao tera um cenario diferente, entao fique ",
"atento. Voce sera pago depois de terminar TODAS AS DENÚNCIAS, e o pagamento sera baseado na distância + bônus ",
"de tempo. Se voce falhar em uma denuncia, voce falhara em toda a missao, entao dedique-se.",
				--"	> [Click Here to Preview]"
			}
		},
		{"Roubo de Lojas :: Disponivel para todos os jogadores",
			{
				"Roube uma loja se voce tiver coragem! Va ate à caixa registradora e digite /robstore ou /holdup para tentar um ",
"roubo. Algumas vezes voce ira falhar, mas nao e sempre. Quanto mais criminosos na loja, mais provavel de voce ",
"conseguir. Quando o roubo comecar, PERMANEÇA dentro da marca vermelha (nao se mova). Voce sera notificado sobre ",
"quanto esta roubando.",
"O dinheiro continuara subindo enquanto voce continuar na marca, ate chegar ao seu limite maximo. Voce podera ",
"deixar a loja a qualquer momento (mas lembre-se: continue na marca para roubar o maximo que puder).",
"Quando aparecer a mensagem 'Robbery Complete', corra o mais longe possivel da loja para ganhar o dinheiro ",
"roubado. Os roubos podem te dar um bom dinheiro, mas te dara niveis de procurado tambem.",
"> Use /robstore ou /holdup",
				--"	> [Click Here to Preview]"
			}
		},
		{"Roubo de Casas / Mandado de Prisao :: Disponivel para Criminosos / Policiais",
			{

"Se voce for um criminoso, vera um icone de uma casa vermelha no mapa. Indo ate la voce estara apto a roubar a ",
"casa e ganhar algum dinheiro. Se voce for um policial, a casa tera um mandado de prisao e voce podera ir ate ela ",
"para ganhar algum dinheiro.",
				--"	> [Click Here to Preview]"
			}
		}
	},
	{"Sistemas",
		{"Casas",
			{
				"O Sistema de Casas CSG e um dos mais avancados existentes. Use /housepanel dentro da sua casa para usar qualquer",
				"um dos recursos listados abaixo:",
				"	> Permissoes de acesso, para controlar quem pode acessar sua residencia.",
				"	> Armazenamento de dinheiro, com registro",
				"	> Armazenamento de drogas",
				"	> Armazenamento de armas.",
				"	> Sistema de musicas na casa. Adicione suas proprias musicas, faca festas!",
				"	> Tente arrombar uma casa se voce tiver coragem!",
				"	> Valor de Mercado, que varia de acordo com a demanda.",
				"Se voce e um criminoso, vera uma casa vermelha (no radar). Va ate ela para rouba-la e obter pontos.",
				"Se voce e um policial, vera uma casa verde (no radar). Va ate ela e impeca o roubo para obter pontos.",

			}
		},
		{"Pontos",
			{
				"Pontos podem ser ganhos realizando qualquer atividade de um determinado emprego.",
				"Pontos sao perdidos por motivos opostos. Por exemplo, voce ganha pontos de motorista quando termina uma rota com",
				"seu ônibus, mas perde pontos se for morto ou preso.",
				"Pontos ajudam voce a desbloquear certos recursos do jogo, como os diferentes tipos de criminosos.",
				"O sistema de pontos esta se expandindo, se tornando mais util a cada dia.",
			}
		},
		{"Lotto 720",
			{
				"Jogue na loteria! O que voce tem a perder?",
				"Todos os dias às 18:00, a loteria sorteia seu premio e voce tem a chance de ganhar uma boa quantia em dinheiro.",
				"Simplesmente digite /lotto <numero_aposta> (1-50) para jogar! A aposta vai te custar apenas $500.",
			}
		},
		{"Tempo no Jogo",
			{
				"Na direita de sua tela, na parte superior, voce pode ver o dia da semana em que o jogo se encontra. Datas especiais ",
				"possuem beneficios especiais, como por exemplo, Vendas da Ammunation na meia-noite e muito mais!",
				"Proximo ao fim de cada dia, em todas as semanas, as ultimas estatisticas sao mostradas.",
				"	> Exemplo: melhor jogador do dia, o valor, a quantidade de balas disparadas.",
				"	> Existem mais de 50 status para ser mostrados, entao fique atento",
				"	> [Sera adicionado em breve]",
			}
		},
		{"Drogas",
			{
				"Se voce e um criminoso, voce pode fazer drogas na Fabrica de Drogas localizada em San Fierro.",
				"Se voce deseja usar/vender/largar drogas, pressione F4 para abrir o Painel de Drogas.",
			}
		},
		{"Veiculos",
			{
				"Pressione F3 para abrir o Painel de Gerenciamento de Veiculos.",
				"La voce pode encontrar todos os seus veiculos que comprou nas concessionarias.",
				"> Voce pode Aparecer seus veiculos.",
				"> Voce pode Esconder seus veiculos.",
				"> Voce pode Marcar seus veiculos.",
				"> Voce pode Trancar/Destrancar seus veiculos.",
				"> Voce pode Recuperar seus veiculos.",
				"> Voce pode Visualizar seus veiculos.",
			}
		},
		{"Nivel de Procurado / Crimes",
			{
				"Se voce matar alguem em Los Santos ou San Fierro, ira obter Niveis de Procurado.",
	"Se voce roubar casas, bancos, cassinos ou lojas, ira obter Niveis de Procurado."
			}
		},
		{"Jogos de Azar",
			{
				"O Cassino esta localizado em Las Venturas. A entrada e gratuita, mas voce deve pagar para jogar nas maquinas.",
			}
		}
	},
	{"iPhone",
		{"Sistema de Posicao Global (GPS)",
			{
				"O Sistema de Posicao Global (GPS) ira ajuda-lo a encontrar os jogadores no mapa.",
"Selecione com setas na estrada, setas no veiculo ou guias de voz.",
			}
		},
		{"Mensagem Privada",
			{
				"Usando essa funcao ninguem podera ler o que voce conversa com outro jogador. E totalmente privado.",
			}
		},
		{"Transferencia Financeira",
			{
				"Voce pode transferir seu dinheiro para o banco ou para outro jogador, mas ele precisa estar online.",
			}
		},
		{"Habilidades com Armas",
			{
				"Voce pode treinar suas habilidades com armas nas Ammunations.",
"Isso ajudara voce a atirar mais rapidamente e a andar enquanto mira/atira.",
			}
		},
		{"Music",
			{
				"Se voce esta entediado, abra seu iPhone e ouca alguma musica usando o Radio",
			}
		},
		{"Musica",
			{
				"Um belo jogo que voce pode encontrar no seu iPhone.",
			}
		},
		{"Puzzle",
			{
				"Um belo jogo que voce pode encontrar no seu iPhone.",
			}
		},
		{"Notes",
			{
				"Aqui voce pode fazer algumas anotacoes.",
			}
		},
		{"Configuracoes",
			{
				"Voce pode alterar o plano de fundo do seu iPhone",
"Voce pode alterar a senha da sua conta",
"Voce pode alterar o email da sua conta",
"Voce pode habilitar/desabilitar o Sinalizador de FPS, Sinalizador de Gasolina, Neblina, Nevoa, Nuvens, Chat, etc.",
			}
		},
	}
}



local arabicTable = {
	{
{"??????? 1",
{
"LV ??? ????? ?????? ???? ????? ",
"????? ??? ???? ?????? ???????? ?? ????? ??????? ????? ???? ?????",
"????? ,?? ???? LV ?????? ??? ?? ??  ???? ????? ???? ??? ?????",
"Las Venturas [LV]",
}
},
},
}
















local kToTab = {
	tabRules,tabCommands,tabJobs,tabEvents,tabMissions,tabSystems,tabiPhone
}

function setLangs(t)
	for k,v in pairs(t) do



		if k == 1 then gridToUse = gridRules guiSetText(kToTab[k],"Rules") end
		if k == 2 then gridToUse = gridCommands guiSetText(kToTab[k],"Commands")end
		if k == 3 then gridToUse = gridJobs  guiSetText(kToTab[k],"Jobs") end
		if k == 4 then gridToUse = gridEvents  guiSetText(kToTab[k],"Events") end
		if k == 5 then gridToUse = gridMissions guiSetText(kToTab[k],"Missions") end
		if k == 6 then gridToUse = gridSystems guiSetText(kToTab[k],"Systems") end
		if k == 7 then gridToUse = gridiPhone guiSetText(kToTab[k],"iPhone") end

		guiGridListClear(gridToUse)
		for k2,v2 in pairs(v) do
			if type(v2) == "string" then
				guiSetText(kToTab[k],v[1])
			else
			local catRow = guiGridListAddRow( gridToUse )
			guiGridListSetItemText( gridToUse, catRow, 1,""..v2[1].."", true, false )
			for index,text in pairs(v2[2]) do
				local theRow = guiGridListAddRow( gridToUse )
				guiGridListSetItemText( gridToUse, theRow, 1, text, false, false)
			end
			end
		end

	end
end

function click()
	if source == english then
		setLangs(engTable)
	elseif source == french then
		setLangs(frenchTable)
	elseif source == portuguese then
		setLangs(portugueseTable)
	elseif source == arabic then
		setLangs(arabicTable)
	end
end
addEventHandler("onClientGUIClick",root,click)


function toggle()
	if guiGetVisible(window) == true then
		guiSetVisible(window,false)
		showCursor(false)
	else
		guiSetVisible(window,true)
		showCursor(true)
	end
end

	bindKey("F1","down",toggle)
setLangs(engTable)
setLangs(engTable)
setLangs(engTable)
