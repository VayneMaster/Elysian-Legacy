function scr_spawn_enemy_turret(_turret_type) {
    // Find turret index by type
    var tidx = -1;
    for (var i = 0; i < oGame.turret_count; i++) {
        if (oGame.turret_type[i] == _turret_type) { 
            tidx = i; 
            break; 
        }
    }
    
    // Validate
    if (tidx == -1) return noone;
    
    var cost = oGame.turret_cost[tidx];
    if (oGame.cpu_gold < cost) return noone;
    
    // Pay cost
    oGame.cpu_gold -= cost;
    
    // Spawn turret at enemy base
    var t = instance_create_layer(
        oGame.enemy_base.x,
        oGame.enemy_base.y,
        "Instances",
        oTurret_enemy
    );
    t.owner_base = oGame.enemy_base;
    t.slot_index = -1;
    t.turret_type = _turret_type;
    
    // Apply stats
    scr_turret_stats(t);
    
    return t;
}
