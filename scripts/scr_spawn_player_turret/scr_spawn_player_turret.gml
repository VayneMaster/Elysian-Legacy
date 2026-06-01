function scr_spawn_player_turret(_turret_type) {
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
    if (!oGame.turret_unlocked[tidx]) return noone;
    
    var cost = oGame.turret_cost[tidx];
    if (oGame.gold < cost) return noone;
    
    // Pay cost
    oGame.gold -= cost;
    
    // Use scr_buy_turret if you have the slot system
    if (instance_exists(oGame.player_base)) {
        return scr_buy_turret(oGame.player_base, _turret_type);
    }
    
    // OR: Simple spawn at base (if no slot system)
    var t = instance_create_layer(
        oGame.player_base.x,
        oGame.player_base.y,
        "Instances",
        oTurret_player
    );
    t.owner_base = oGame.player_base;
    t.turret_type = _turret_type;
    
    // Apply stats
    scr_turret_stats(t);
    
    return t;
}