addEventHandler ( "onResourceStart", getResourceRootElement(getThisResource()),
	function ()
		for _,weaponSkill in ipairs({"poor","std","pro"}) do
			-- MP5 move, aim and fire at the same time and crouching when aim
			setWeaponProperty ( 29, weaponSkill, "flags", 0x002000 )
			setWeaponProperty ( 29, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 29, weaponSkill, "flags", 0x000010 )
			-- AK47 move, aim and fire at the same time and crouching when aim
			setWeaponProperty ( 30, weaponSkill, "flags", 0x002000 )
			setWeaponProperty ( 30, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 30, weaponSkill, "flags", 0x000010 )
			-- SHOTGUN move, aim and fire at the same time
			setWeaponProperty ( 25, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 25, weaponSkill, "flags", 0x000010 )
			-- UZI move, aim and fire at the same time
			setWeaponProperty ( 28, weaponSkill, "flags", 0x002000 )
			setWeaponProperty ( 28, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 28, weaponSkill, "flags", 0x000010 )
			-- TEC9 move, aim and fire at the same time
			setWeaponProperty ( 32, weaponSkill, "flags", 0x002000 )
			setWeaponProperty ( 32, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 32, weaponSkill, "flags", 0x000010 )
			-- DESSERT EAGLE move, aim and fire at the same time
			setWeaponProperty ( 24, weaponSkill, "flags", 0x002000 )
			setWeaponProperty ( 24, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 24, weaponSkill, "flags", 0x000010 )
			-- SPAS move, aim and fire at the same time
			setWeaponProperty (27, weaponSkill, "flags", 0x000020 )
			setWeaponProperty (27, weaponSkill, "flags", 0x000010 )
			-- SAWNOFF move, aim and fire at the same time
			setWeaponProperty ( 26, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 26, weaponSkill, "flags", 0x000010 )
			-- PISTOL move, aim and fire at the same time and crouching when aim
			setWeaponProperty ( 22, weaponSkill, "flags", 0x002000 )
			setWeaponProperty ( 22, weaponSkill, "flags", 0x000020 )
			setWeaponProperty ( 22, weaponSkill, "flags", 0x000010 )
			-- SILENCED move, aim and fire at the same time and crouching when aim
			setWeaponProperty ( 23, weaponSkill, "flags", 0x002000 )
		end
	end
)
