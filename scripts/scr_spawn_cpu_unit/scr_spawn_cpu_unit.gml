function scr_spawn_cpu_unit(_lane, _type) {
    // Get unit object type
    var unit_obj;
    var cost;
    switch (_type) {
        case 0: unit_obj = oUnit_enemy;              cost = 75;  break;
        case 1: unit_obj = oUnit_enemy_ranged;       cost = 120; break;
        case 2: unit_obj = oUnit_enemy_heavy_melee;  cost = 250; break;
        case 3: unit_obj = oUnit_enemy_heavy_ranged; cost = 220; break;
        case 4: unit_obj = oUnit_enemy_elite;        cost = 375; break;
        default: return noone;
    }
    
    // Check if can afford and game is playing
    if (oGame.cpu_gold < cost || oGame.game_state != GameState.PLAYING) {
        return noone;
    }
    
    // Pay cost
    oGame.cpu_gold -= cost;
    
    // Spawn enemy unit
    var lane_y_pos = oGame.lane_y[_lane];
    var u = instance_create_layer(room_width - 200, lane_y_pos, "Instances", unit_obj);
    u.lane_index = _lane;
    u.y = lane_y_pos;
    
	oGame.stat_e_unit_deployed++;
    return u;
}