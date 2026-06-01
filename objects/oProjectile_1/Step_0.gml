// Move forward
if (team == Team.PLAYER) {
    x += move_speed;
} else {
    x -= move_speed;
}

// kill if over life
life_steps--;
if (life_steps <= 0) {
    instance_destroy();
    exit;
}

// Determine what we can hit, must be same uni on same lane
var enemy_obj = (team == Team.PLAYER) ? oUnit_enemy : oUnit_player;

// Check for a hit on same lane (simple x-distance hitbox)
var hit_id = noone;

with (enemy_obj) {
    if (lane_index == other.lane_index) {
        if (abs(x - other.x) <= 8) {
            hit_id = id;
        }
    }
}

if (hit_id != noone) {
	hit_id.last_hit_team = team;
    hit_id.hp -= damage;
    instance_destroy();
}
