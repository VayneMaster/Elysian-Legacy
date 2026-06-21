// @description Get mission configuration
/// @param mission_id The mission ID to get config for
function scr_get_mission_config(_mission_id) {
	if (variable_global_exists("mission_cfg_cache") && _mission_id >= 0 && _mission_id < array_length(global.mission_cfg_cache)) {
        return global.mission_cfg_cache[_mission_id];
		}
    var config = {};
    
    switch (_mission_id) {
        case MissionID.M1_STONE_VS_GREEK:
            config.name = "The First Assendence";
            config.description = "The Greek warriors have found a way to travel to the Stone Age. Defeat them and claim their knowledge";
            config.objective_type = ObjectiveType.DESTROY_ENEMY_BASE;
            config.tech_era = TechEra.STONE_AGE;
            config.enemy_tech_era = TechEra.GREEK_CLASSICAL;
			config.cpu_special = SpecialID.SPEARS;
            config.starting_gold = 500;
            config.gold_per_second = 30;
            config.enemy_gold_multiplier = 0.9; // Make mission 1 bit easier
            config.time_limit = -1; // No limit
            config.skill_points_reward = 3; // ← INCREASED (was 2)
            config.units_unlocked = [0, 1]; // Basic melee, ranged
            config.turrets_unlocked = [0]; // MG Turret only
            config.next_cutscene = CutsceneID.GREEK_KNOWLEDGE;
            break;
        
        case MissionID.M2_IRON_AGE:
            config.name = "The Iron Age";
            config.description = "With the newly gained knowledge, you've managed to prosper to the next age.";
            config.objective_type = ObjectiveType.DESTROY_ENEMY_BASE;
            config.tech_era = TechEra.IRON_AGE;
            config.enemy_tech_era = TechEra.IRON_AGE;
			config.cpu_special = SpecialID.IRON;
            config.starting_gold = 600;
            config.gold_per_second = 35;
            config.enemy_gold_multiplier = 1.0;
            config.time_limit = -1;
            config.skill_points_reward = 3; // ← INCREASED (was 2)
            config.units_unlocked = [0, 1, 2]; // + Heavy melee
            config.turrets_unlocked = [0, 1]; // + Cannon
            config.next_cutscene = CutsceneID.MODERN_DISCOVERY;
            break;
        
        case MissionID.M3_GREEK_VS_MODERN:
            config.name = "Invasion from the Future";
            config.description = "The 21st Century army managed to create a unstable portal. Seems like they are after the true knowledge. Hold your grounds!";
            config.objective_type = ObjectiveType.LOSE_INTENTIONALLY;
            config.tech_era = TechEra.GREEK_CLASSICAL;
            config.enemy_tech_era = TechEra.MODERN;
			config.cpu_special = SpecialID.MODERN;
            config.starting_gold = 800;
            config.gold_per_second = 40;
            config.enemy_gold_multiplier = 1.8; // Overwhelming force
            config.time_limit = 180; // 3 minutes
            config.skill_points_reward = 2; // ← INCREASED (was 1)
            config.units_unlocked = [0, 1, 2, 3]; // + Heavy ranged
            config.turrets_unlocked = [0, 1]; // Still only basic turrets
            config.next_cutscene = CutsceneID.LEARN_MODERN_TECH;
            break;
            
        case MissionID.M4_MODERN_VS_MODERN:
            config.name = "Equality prevails";
            config.description = "After learning modern technology thanks to our fallen brothers, we can stand on equal footing. Prevail!";
            config.objective_type = ObjectiveType.DESTROY_ENEMY_BASE;
            config.tech_era = TechEra.MODERN;
            config.enemy_tech_era = TechEra.MODERN;
			config.cpu_special = SpecialID.MODERN;
            config.starting_gold = 1000;
            config.gold_per_second = 45;
            config.enemy_gold_multiplier = 1.1;
            config.time_limit = -1;
            config.skill_points_reward = 3; // ← INCREASED (was 2)
            config.units_unlocked = [0, 1, 2, 3, 4]; // All units
            config.turrets_unlocked = [0, 1, 2]; // + Flak
            config.next_cutscene = CutsceneID.PORTAL_ENTRY;
            break;
            
        case MissionID.M5_PORTAL_DEFENSE:
            config.name = "The Portal";
            config.description = "With the unstable Portal and the true Ancient Greek knowledge, we have managed to create a functioning portal. We must defend the Portal from enemy forces!";
            config.objective_type = ObjectiveType.SURVIVE_TIME;
            config.tech_era = TechEra.MODERN;
            config.enemy_tech_era = TechEra.MODERN;
			config.cpu_special = SpecialID.LASER;
            config.starting_gold = 1200;
            config.gold_per_second = 50;
            config.enemy_gold_multiplier = 1.3;
            config.time_limit = 240; // 4 minutes
            config.skill_points_reward = 3; // ← KEPT at 3
            config.units_unlocked = [0, 1, 2, 3, 4];
            config.turrets_unlocked = [0, 1, 2, 3]; // All turrets unlocked
            config.next_cutscene = -1; // No cutscene, just return to lobby
            break;
            
        case MissionID.M6_ZEUS_FINAL_BATTLE:
            config.name = "The Wrath of Zeus";
            config.description = "Zeus heard about us creating a functioning Portal. This was not intended for human use, therefore he seeks destruction of the portal. Defend and Prevail for the future of Humanity!";
            config.objective_type = ObjectiveType.DEFEAT_BOSS;
            config.tech_era = TechEra.ADVANCED;
            config.enemy_tech_era = TechEra.MYTHOLOGICAL;
			config.cpu_special = SpecialID.LIGHTNING;
            config.starting_gold = 1500;
            config.gold_per_second = 60;
            config.enemy_gold_multiplier = 1.5;
            config.time_limit = -1;
            config.skill_points_reward = 0; // ← CHANGED: No reward (campaign complete)
            config.units_unlocked = [0, 1, 2, 3, 4];
            config.turrets_unlocked = [0, 1, 2, 3]; // All turrets
            config.next_cutscene = CutsceneID.ZEUS_WARNING;
            config.is_final_mission = true;
            // ← REMOVED: requires_all_masteries (not needed, economy is balanced)
            break;
            
        default:
            config.name = "Unknown Mission";
            config.description = "ERROR: Mission not found";
            config.objective_type = ObjectiveType.DESTROY_ENEMY_BASE;
            config.tech_era = TechEra.MODERN;
            config.enemy_tech_era = TechEra.MODERN;
            config.starting_gold = 500;
            config.gold_per_second = 30;
            config.enemy_gold_multiplier = 1.0;
            config.time_limit = -1;
            config.skill_points_reward = 1;
            config.units_unlocked = [0, 1, 2, 3, 4];
            config.turrets_unlocked = [0, 1, 2, 3];
            config.next_cutscene = -1;
            break;
    }
    
    return config;
}

/// @description Check if mission is unlocked
/// @param mission_id The mission to check
function scr_is_mission_unlocked(_mission_id) {
    if (!instance_exists(oCampaignManager)) return false;
    
    // First mission always unlocked
    if (_mission_id == 0) return true;
    
    // Check if previous mission is complete
    if (_mission_id > 0 && _mission_id < array_length(oCampaignManager.mission_completed)) {
        return oCampaignManager.mission_completed[_mission_id - 1];
    }
    
    return false;
}

/// @description Get mission display status
/// @param mission_id The mission to check
function scr_get_mission_status(_mission_id) {
    if (!instance_exists(oCampaignManager)) return "LOCKED";
    
    if (oCampaignManager.mission_completed[_mission_id]) {
        return "COMPLETE";
    } else if (scr_is_mission_unlocked(_mission_id)) {
        return "AVAILABLE";
    } else {
        return "LOCKED";
    }
}
