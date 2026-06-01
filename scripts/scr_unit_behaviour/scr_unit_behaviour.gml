/// @description Move unit forward along lane
function unit_step_moving() {
    // Determine direction based on team
    var move_dir = (team == Team.PLAYER) ? 1 : -1; // Player moves right, enemy moves left
    
    // Move along x-axis (move_speed is actual pixels per step)
    x += move_speed * move_dir;
    
    // Keep aligned to lane Y position
    y = oGame.lane_y[lane_index];
    
    // Check for targets in range
    var nearest_enemy = noone;
    var nearest_dist = attack_range;
    
    // Find enemy to attack
    if (team == Team.PLAYER) {
        // Player unit looks for enemy units
        with (oParent_unit) {
            if (team == Team.ENEMY && lane_index == other.lane_index) {
                var dist = point_distance(x, y, other.x, other.y);
                if (dist < nearest_dist) {
                    nearest_dist = dist;
                    nearest_enemy = id;
                }
            }
        }
        
        // Also check for enemy base
        if (instance_exists(oGame.enemy_base)) {
            var dist = point_distance(x, y, oGame.enemy_base.x, oGame.enemy_base.y);
            if (dist < nearest_dist) {
                nearest_dist = dist;
                nearest_enemy = oGame.enemy_base;
            }
        }
    } else {
        // Enemy unit looks for player units
        with (oParent_unit) {
            if (team == Team.PLAYER && lane_index == other.lane_index) {
                var dist = point_distance(x, y, other.x, other.y);
                if (dist < nearest_dist) {
                    nearest_dist = dist;
                    nearest_enemy = id;
                }
            }
        }
        
        // Also check for player base
        if (instance_exists(oGame.player_base)) {
            var dist = point_distance(x, y, oGame.player_base.x, oGame.player_base.y);
            if (dist < nearest_dist) {
                nearest_dist = dist;
                nearest_enemy = oGame.player_base;
            }
        }
    }
    
    // Switch to attacking if target found
    if (nearest_enemy != noone) {
        target = nearest_enemy;
        state = UnitState.ATTACKING;
        attack_timer = 0;
    }
    
    // Units die when they reach enemy base, not when off screen
    // Base will handle destroying units that get too close
}

/// @description Attack current target
function unit_step_attacking() {
    // Check if target still exists
    if (!instance_exists(target)) {
        target = noone;
        state = UnitState.MOVING;
        exit;
    }
    
    // Check if target died
    if (variable_instance_exists(target, "hp") && target.hp <= 0) {
        target = noone;
        state = UnitState.MOVING;
        exit;
    }
    
    // Keep aligned to lane
    y = oGame.lane_y[lane_index];
    
    // Check if still in range
    var dist = point_distance(x, y, target.x, target.y);
    
    if (dist > attack_range) {
        // Out of range, move back to moving state
        state = UnitState.MOVING;
        target = noone;
        exit;
    }
    
    // Attack cooldown
    attack_timer++;
    
    if (attack_timer >= attack_cooldown) {
        attack_timer = 0;
        
        // Deal damage
        if (instance_exists(target) && variable_instance_exists(target, "hp")) {
            target.hp -= damage;
            target.last_hit_team = team; // Track who hit for gold reward
            
            // TODO: Play attack sound/animation
            // audio_play_sound(snd_attack, 1, false);
        }
    }
}