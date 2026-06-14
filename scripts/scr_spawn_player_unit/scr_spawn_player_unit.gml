function scr_spawn_player_unit(_lane, _type) {
    // Get unit object type
    var unit_obj;
    switch (_type) {
        case 0: unit_obj = oUnit_player;              break;
        case 1: unit_obj = oUnit_player_ranged;       break;
        case 2: unit_obj = oUnit_player_heavy_melee;  break;
        case 3: unit_obj = oUnit_player_heavy_ranged; break;
        case 4: unit_obj = oUnit_player_elite;        break;
        default: return noone;
    }
    
    // Get modified stats with masteries
    var stats = scr_get_unit_stats_with_masteries(_type);
    
    // Check if can afford (uses modified cost!)
    if (oGame.gold < stats.cost) return noone;
    
    // Pay cost
    oGame.gold -= stats.cost;
    
    // Spawn unit
    var lane_y_pos = oGame.lane_y[_lane];
    var u = instance_create_layer(200, lane_y_pos, "Instances", unit_obj);
    u.lane_index = _lane;
    u.y = lane_y_pos;
    
    // Apply modified stats to the unit
    u.max_hp = stats.hp;
    u.hp = stats.hp;
    u.damage = stats.dmg;
    u.move_speed = stats.spd * 0.1; // Convert to pixels per step (15 spd = 1.5 pixels/step)
    u.attack_range = stats.rng;
    
	
	//stats tracking
	oGame.stat_units_deployed++;
	
    return u;
}