function scr_update_zone_mods(){
	zone_dmg = 1;
	zone_def = 1;
	zone_spd = 1;
	
	if (!instance_exists(oGame)) exit;
	
	var z1 = oGame.lane.zones;
	for (var i = 0; i < array_length(z1); i++) {
		var z = zl[i];
		if (z.lane == lane_index && x >= z.x1 && x <= z.x2) {
			zone_dmg *= z.dmg_mult;
			zone_def *= z.def_mult;
			zone_spd *= z.spd_mult;
		}
	}
}