if (!instance_exists(owner_base)) { instance_destroy(); exit; }

// Stick to base slot if available, otherwise just base position
if (slot_index != -1 && variable_instance_exists(owner_base, "turret_slot_dx")) {
    x = owner_base.x + owner_base.turret_slot_dx[slot_index];
    y = owner_base.y + owner_base.turret_slot_dy[slot_index];
} else {
    x = owner_base.x;
    y = owner_base.y;
}

// smaller depth draws later (on top)
depth = owner_base.depth - 10;

//cd
cooldown--;
if (cooldown > 0) exit;

//decide targ based on team
var target_obj = (owner_team == Team.PLAYER) ? oUnit_enemy: oUnit_player;

var best = noone;
var best_d = 100000;

with (target_obj) {
	var d = point_distance(other.x, other.y, x, y);
	if (d < other.range && d < best_d) {
		best_d = d;
		best = id;
	}
}

if (best != noone) {
	with (best) {
		hp -= other.damage;
	}
	cooldown = rof_steps;
}