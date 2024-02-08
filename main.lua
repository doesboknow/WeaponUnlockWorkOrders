if not WeaponUnlockWorkOrders.Config.ModEnabled then return end

-- Adds the proper cosmetic to your arsenal at the start of the game.
ModUtil.Path.Wrap("StartNewGame", function(baseFunc)
    baseFunc()
    if HeroData.DefaultHero.DefaultWeapon == "SwordWeapon" then
        AddCosmetic( "SwordWeaponUnlock" )
        return
    elseif HeroData.DefaultHero.DefaultWeapon == "SpearWeapon" then
        AddCosmetic( "SpearWeaponUnlock" )
        return
    elseif HeroData.DefaultHero.DefaultWeapon == "ShieldWeapon" then
        AddCosmetic( "ShieldWeaponUnlock" )
        return
    elseif HeroData.DefaultHero.DefaultWeapon == "BowWeapon" then
        AddCosmetic( "BowWeaponUnlock" )
        return
    elseif HeroData.DefaultHero.DefaultWeapon == "FistWeapon" then
        AddCosmetic( "FistWeaponUnlock" )
        return
    elseif HeroData.DefaultHero.DefaultWeapon == "GunWeapon" then
        AddCosmetic( "GunWeaponUnlock" )
        return
    end
end, WeaponUnlockWorkOrders)

-- Checks the weapon being unlocked only if the cosmetics are available.
ModUtil.Path.Wrap("IsWeaponUnlocked", function(baseFunc, weaponName)
    if weaponName == "SwordWeapon" and GameState.Cosmetics.SwordWeaponUnlock then
        return true
    elseif weaponName == "SpearWeapon" and GameState.Cosmetics.SpearWeaponUnlock then
        return true
    elseif weaponName == "ShieldWeapon" and GameState.Cosmetics.ShieldWeaponUnlock then
        return true
    elseif weaponName == "BowWeapon" and GameState.Cosmetics.BowWeaponUnlock then
        return true
    elseif weaponName == "FistWeapon" and GameState.Cosmetics.FistWeaponUnlock then
        return true
    elseif weaponName == "GunWeapon" and GameState.Cosmetics.GunWeaponUnlock then
        return true    
    end
    return false
end, WeaponUnlockWorkOrders)

-- Makes it impossible to buy from the Arsenal Room (required since only the Cosmetics unlock the weapons now, so buying them just wastes keys)
ModUtil.Path.Context.Wrap("ModUtil.Hades.Triggers.OnUsed.Interactables.1.Call", function()
    ModUtil.Path.Wrap("HasResource", function(baseFunc, name, amount)
        return false
    end, WeaponUnlockWorkOrders)
end, WeaponUnlockWorkOrders)

-- Debug testing (default false in config.lua)
if WeaponUnlockWorkOrders.Config.DebugTesting then
    ModUtil.Table.NilMerge( DeathLoopData, {
		DeathArea = {
			-- remove min run requirement for House Contractor
			ObstacleData = {
				[210158] = {
					SetupGameStateRequirements = {
						RequiredMinCompletedRuns = true
					}
				},
			-- remove min run requirement for Wretched Broker
				[423390] = {
					SetupGameStateRequirements = {
						RequiredMinCompletedRuns = true
					}
				}
			},
			-- remove min run requirements to unlock the lounge
			DistanceTriggers = {
				[2] = {
					RequiredMinCompletedRuns = true
				},
				[3] = {
					RequiredMinCompletedRuns = true
				},
				[7] = {
					RequiredMinCompletedRuns = true
				},
				[8] = {
					RequiredMinCompletedRuns = true
				},
			},
			-- remove min run requirement for Dusa to show up with the lounge being unlocked
			StartUnthreadedEvents = {
				[19] = {
					GameStateRequirements = {
						RequiredMinCompletedRuns = true
					}
				},
				[20] = {
					GameStateRequirements = {
						RequiredMinCompletedRuns = true
					}
				}
			}
		}
	})
end