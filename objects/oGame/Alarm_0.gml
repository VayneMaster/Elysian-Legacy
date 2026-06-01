// Spawn one player unit on each lane
for (var i = 0; i < lane_count; i++) {
    var u = instance_create_layer(200, lane_y[i], "Instances", oUnit_player);
    u.lane_index = i;
    u.y = lane_y[i];
}

// Spawn one enemy unit on each lane
for (var i = 0; i < lane_count; i++) {
    var u2 = instance_create_layer(room_width - 200, lane_y[i], "Instances", oUnit_enemy);
    u2.lane_index = i;
    u2.y = lane_y[i];
}
