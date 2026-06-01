function scr_buy_turret(_base, _turret_type) {
    if (!instance_exists(_base)) return noone;
    
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
    
    // Check wallet
    if (_base.team == Team.PLAYER) {
        if (oGame.gold < cost) return noone;
    } else {
        if (oGame.cpu_gold < cost) return noone;
    }
    
    // Find empty slot
    var slot = -1;
    for (var s = 0; s < _base.turret_slot_count; s++) {
        if (_base.turret_slots[s] == -1) { 
            slot = s; 
            break;
        }
    }
    if (slot == -1) return noone; // No empty slots
    
    // Pay cost
    if (_base.team == Team.PLAYER) {
        oGame.gold -= cost;
    } else {
        oGame.cpu_gold -= cost;
    }
    
    // Store in slot
    _base.turret_slots[slot] = _turret_type;
    
    // Spawn turret at slot position
    var tx = _base.x + _base.turret_slot_dx[slot];
    var ty = _base.y + _base.turret_slot_dy[slot];
    
    var t = instance_create_layer(tx, ty, "Instances", oParent_turret);
    t.owner_base = _base;
    t.owner_team = _base.team;
    t.slot_index = slot;
    t.turret_type = _turret_type;
    
    // Apply stats
    scr_turret_stats(t);
    
    return t;
}