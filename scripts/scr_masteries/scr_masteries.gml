// ========================================
// MASTERY HELPER FUNCTIONS
// ========================================

/// @description Award skill points after mission
/// @param points Number of points to award
function scr_award_skill_points(_points = SKILL_POINTS_PER_MISSION) {
    if (!instance_exists(oGame)) return;
    
    oGame.skill_points_available += _points;
    oGame.skill_points_total += _points;
    
    show_debug_message("Awarded " + string(_points) + " skill points! Total: " + string(oGame.skill_points_total));
}

/// @description Check if a skill can be unlocked (IMPROVED LOGIC)
/// @param skill_id The skill ID to check
function scr_can_unlock_skill(_skill_id) {
    if (!instance_exists(oGame)) return false;
    
    // Already unlocked
    if (oGame.skill_unlocked[_skill_id]) return false;
    
    // No points available
    if (oGame.skill_points_available <= 0) return false;
    
    // Check prerequisites
    var prereq_met = false;
    
    // MELEE BRANCH (M1-M5)
    if (_skill_id >= SkillID.M1 && _skill_id <= SkillID.M5) {
        var index = _skill_id - SkillID.M1;
        // M1 always available, others need previous
        prereq_met = (index == 0) ? true : oGame.skill_unlocked[_skill_id - 1];
    }
    // RANGED BRANCH (R1-R5)
    else if (_skill_id >= SkillID.R1 && _skill_id <= SkillID.R5) {
        var index = _skill_id - SkillID.R1;
        // R1 always available, others need previous
        prereq_met = (index == 0) ? true : oGame.skill_unlocked[_skill_id - 1];
    }
    // ELITE BRANCH (E1-E4) - FIXED LOGIC
    else if (_skill_id >= SkillID.E1 && _skill_id <= SkillID.E4) {
        var index = _skill_id - SkillID.E1;
        
        // Check if ALL melee and ranged are done (required for ANY elite skill)
        var all_melee_done = true;
        var all_ranged_done = true;
        
        for (var i = SkillID.M1; i <= SkillID.M5; i++) {
            if (!oGame.skill_unlocked[i]) all_melee_done = false;
        }
        for (var i = SkillID.R1; i <= SkillID.R5; i++) {
            if (!oGame.skill_unlocked[i]) all_ranged_done = false;
        }
        
        var branches_complete = all_melee_done && all_ranged_done;
        
        // E1: Just needs branches complete
        if (index == 0) {
            prereq_met = branches_complete;
        }
        // E2-E3: Need branches + previous elite
        else if (index > 0 && index < 3) {
            prereq_met = branches_complete && oGame.skill_unlocked[_skill_id - 1];
        }
        // E4: Needs EVERYTHING (all branches + E1-E3)
        else if (index == 3) {
            var all_elite_so_far = true;
            for (var i = SkillID.E1; i <= SkillID.E3; i++) {
                if (!oGame.skill_unlocked[i]) all_elite_so_far = false;
            }
            prereq_met = branches_complete && all_elite_so_far;
        }
    }
    
    return prereq_met;
}

/// @description Unlock a skill (with validation)
/// @param skill_id The skill ID to unlock
function scr_unlock_skill(_skill_id) {
    if (!instance_exists(oGame)) return false;
    
    // Check if can unlock
    if (!scr_can_unlock_skill(_skill_id)) {
        show_debug_message("Cannot unlock skill " + string(_skill_id) + " - prerequisites not met or no points");
        return false;
    }
    
    // Unlock it
    oGame.skill_unlocked[_skill_id] = true;
    oGame.skill_points_available--;
    
    show_debug_message("Unlocked skill: " + oGame.skill_name[_skill_id]);
    
    // TODO: Play sound effect
    // audio_play_sound(snd_skill_unlock, 1, false);
    
    return true;
}

/// @description Get the total bonus multiplier for a stat category
/// @param unit_type Unit type (0-4)
/// @param stat_type "hp", "dmg", "spd", "rng", or "cost"
function scr_get_total_mastery_bonus(_unit_type, _stat_type) {
    if (!instance_exists(oGame)) return 1;
    
    var is_melee = (_unit_type == 0 || _unit_type == 2);
    var is_ranged = (_unit_type == 1 || _unit_type == 3);
    var is_elite = (_unit_type == 4);
    
    var bonus = 1; // Start at 100%
    
    switch (_stat_type) {
        case "hp":
            if (is_melee) {
                if (oGame.skill_unlocked[SkillID.M1]) bonus *= 1.10;
                if (oGame.skill_unlocked[SkillID.M2]) bonus *= 1.20;
                if (oGame.skill_unlocked[SkillID.M3]) bonus *= 1.30;
            }
            if (is_elite) {
                if (oGame.skill_unlocked[SkillID.E1]) bonus *= 1.25;
            }
            break;
            
        case "dmg":
            if (is_melee) {
                if (oGame.skill_unlocked[SkillID.M4]) bonus *= 1.15;
                if (oGame.skill_unlocked[SkillID.M5]) bonus *= 1.30;
            }
            if (is_elite) {
                if (oGame.skill_unlocked[SkillID.E2]) bonus *= 1.25;
            }
            break;
            
        case "spd":
            if (is_ranged) {
                if (oGame.skill_unlocked[SkillID.R4]) bonus *= 1.10;
                if (oGame.skill_unlocked[SkillID.R5]) bonus *= 1.20;
            }
            if (is_elite) {
                if (oGame.skill_unlocked[SkillID.E3]) bonus *= 1.15;
            }
            break;
            
        case "rng":
            if (is_ranged) {
                if (oGame.skill_unlocked[SkillID.R1]) bonus *= 1.15;
                if (oGame.skill_unlocked[SkillID.R2]) bonus *= 1.30;
                if (oGame.skill_unlocked[SkillID.R3]) bonus *= 1.45;
            }
            break;
            
        case "cost":
            if (is_elite) {
                if (oGame.skill_unlocked[SkillID.E4]) bonus *= 0.75;
            }
            break;
    }
    
    return bonus;
}

/// @description Check how many skills are unlocked in a branch
/// @param branch SkillBranch.MELEE, RANGED, or ELITE
function scr_get_branch_progress(_branch) {
    if (!instance_exists(oGame)) return 0;
    
    var count = 0;
    var start_id, end_id;
    
    switch (_branch) {
        case SkillBranch.MELEE:
            start_id = SkillID.M1;
            end_id = SkillID.M5;
            break;
        case SkillBranch.RANGED:
            start_id = SkillID.R1;
            end_id = SkillID.R5;
            break;
        case SkillBranch.ELITE:
            start_id = SkillID.E1;
            end_id = SkillID.E4;
            break;
        default:
            return 0;
    }
    
    for (var i = start_id; i <= end_id; i++) {
        if (oGame.skill_unlocked[i]) count++;
    }
    
    return count;
}

/// @description Reset skill tree (for testing or new game+)
function scr_reset_skill_tree() {
    if (!instance_exists(oGame)) return;
    
    for (var i = 0; i < SKILL_COUNT; i++) {
        oGame.skill_unlocked[i] = false;
    }
    
    oGame.skill_points_available = SKILL_POINTS_START;
    oGame.skill_points_total = SKILL_POINTS_START;
    
    show_debug_message("Skill tree reset!");
}

/// @description Get a string describing what a skill does (for tooltips)
/// @param skill_id The skill ID
function scr_get_skill_description(_skill_id) {
    if (!instance_exists(oGame)) return "Unknown";
    return oGame.skill_desc[_skill_id];
}

/// @description Check if elite branch is available (all melee + ranged complete)
function scr_is_elite_branch_available() {
    if (!instance_exists(oGame)) return false;
    
    for (var i = SkillID.M1; i <= SkillID.M5; i++) {
        if (!oGame.skill_unlocked[i]) return false;
    }
    for (var i = SkillID.R1; i <= SkillID.R5; i++) {
        if (!oGame.skill_unlocked[i]) return false;
    }
    
    return true;
}

function scr_get_unit_stats_with_masteries(_type) {
    // Get base stats from oGame
    var stats = {
        hp: oGame.unit_hp[_type],
        dmg: oGame.unit_dmg[_type],
        spd: oGame.unit_spd[_type],
        rng: oGame.unit_rng[_type],
        cost: oGame.unit_cost[_type]
    };
    
    // Determine unit category
    var is_melee = (_type == 0 || _type == 2); // Basic and H.Melee
    var is_ranged = (_type == 1 || _type == 3); // Ranged and H.Ranged
    var is_elite = (_type == 4); // Elite
    
    // MELEE BONUSES
    if (is_melee) {
        // HP bonuses (STACKING)
        if (oGame.skill_unlocked[SkillID.M1]) stats.hp *= 1.10;
        if (oGame.skill_unlocked[SkillID.M2]) stats.hp *= 1.20;
        if (oGame.skill_unlocked[SkillID.M3]) stats.hp *= 1.30;
        
        // Damage bonuses (STACKING)
        if (oGame.skill_unlocked[SkillID.M4]) stats.dmg *= 1.15;
        if (oGame.skill_unlocked[SkillID.M5]) stats.dmg *= 1.30;
    }
    
    // RANGED BONUSES
    if (is_ranged) {
        // Range bonuses (STACKING)
        if (oGame.skill_unlocked[SkillID.R1]) stats.rng *= 1.15;
        if (oGame.skill_unlocked[SkillID.R2]) stats.rng *= 1.30;
        if (oGame.skill_unlocked[SkillID.R3]) stats.rng *= 1.45;
        
        // Speed bonuses (STACKING)
        if (oGame.skill_unlocked[SkillID.R4]) stats.spd *= 1.10;
        if (oGame.skill_unlocked[SkillID.R5]) stats.spd *= 1.20;
    }
    
    // ELITE BONUSES
    if (is_elite) {
        if (oGame.skill_unlocked[SkillID.E1]) stats.hp *= 1.25;   // +25% HP
        if (oGame.skill_unlocked[SkillID.E2]) stats.dmg *= 1.25;  // +25% damage
        if (oGame.skill_unlocked[SkillID.E3]) stats.spd *= 1.15;  // +15% speed
        if (oGame.skill_unlocked[SkillID.E4]) stats.cost *= 0.75; // -25% cost
    }
    
    // Round values
    stats.hp = round(stats.hp);
    stats.dmg = round(stats.dmg);
    stats.spd = round(stats.spd);
    stats.rng = round(stats.rng);
    stats.cost = round(stats.cost);
    
    return stats;
}