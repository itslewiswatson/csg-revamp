local weaponTable = { [22]=69, [23]=70, [24]=71, [25]=72, [26]=73, [27]=74, [28]=75, [29]=76, [32]=75, [30]=77, [31]=78, [34]=79, [33]=79 }

addEvent("takePlayerTrainingMoney",true)
addEventHandler("takePlayerTrainingMoney", root,
function()
	if ( source ) then
		takePlayerMoney( source, 250 )
	end
end
)

addEvent("onFinishWeaponTraining",true)
addEventHandler("onFinishWeaponTraining", root,
function( theWeapon )
	if ( source ) and ( theWeapon ) then
		if ( getPedStat ( source, weaponTable[tonumber(theWeapon)] ) <= 950 ) then
			if ( tonumber(theWeapon) == 28 ) and ( tonumber(theWeapon) == 32 ) and ( getPedStat ( source, weaponTable[tonumber(theWeapon)] ) +50 == 1000 ) then
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), 995 )
			else
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), getPedStat ( source, weaponTable[tonumber(theWeapon)] ) +50 )
			end
			exports.csgscore:givePlayerScore(source,1)
			exports.DENdxmsg:createNewDxMessage(source,"Earned +1 Score for Successfull weapons training!",0,255,0)
		elseif ( getPedStat ( source, weaponTable[tonumber(theWeapon)] ) +50 == 1000 ) then
			if not ( tonumber(theWeapon) == 28 ) and not ( tonumber(theWeapon) == 32 ) then
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), 1000 )
			else
				onUpdatePlayerWeaponSkills ( source, tonumber(theWeapon), 995 )
			end
			exports.csgscore:givePlayerScore(source,1)
			exports.DENdxmsg:createNewDxMessage(source,"Earned +1 Score for Successfull weapons training!",0,255,0)
		end


	end
end
)

function getWeaponSkillsJSON( thePlayer )
	local weaponSkills = {}
	local vaildSkill = false

	for i=69,79 do
		local theSkill = getPedStat ( thePlayer, i )
		if ( theSkill ) then
			weaponSkills[i] = theSkill
			vaildSkill = true
		end
	end

	if ( vaildSkill ) then
		return toJSON( weaponSkills )
	else
		return nil
	end
end

function onUpdatePlayerWeaponSkills ( thePlayer, theWeapon, theLevel )
	theLevel = tonumber(theLevel)
	theWeapon = tonumber(theWeapon)
	local playerID = exports.server:getPlayerAccountID( thePlayer )
	local theStat = getPedStat ( thePlayer, theWeapon )
	if ( weaponTable[theWeapon] ) then
		if ( weaponTable[theWeapon] >= 69 ) or ( weaponTable[theWeapon] <= 79 ) then

			if theWeapon == 28 or theWeapon == 26 or theWeapon == 32 then
				if theLevel == 1000 then
					theLevel = 995
				end
			end
			if ( setPedStat( thePlayer, weaponTable[theWeapon], theLevel ) ) then
				local theSkills = getWeaponSkillsJSON( thePlayer )
				exports.DENstats:setPlayerAccountData ( thePlayer, "weaponskills", theSkills, true )
				exports.DENdxmsg:createNewDxMessage( thePlayer, getWeaponNameFromID ( theWeapon ).." weapon skill is now upgraded by 5%!", 0, 225, 0 )
				return true
			end
		end
	end
end
