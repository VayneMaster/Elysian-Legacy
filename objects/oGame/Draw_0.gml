//placeholder zone rendering (obj lateR)
for (var i = 0; i < array_length(lane_zones); i++) {
	var z = lane_zones[i];
	var zy = lane_y[z.lane];
	
	draw_set_alpha(0.18);
	draw_set_colour(c_yellow);
	draw_rectangle(z.x1, zy - 45, z.x2, zy + 45, false);
	draw_set_alpha(0.6);
	draw_rectangle(z.x1, zy - 45, z.x2, zy + 45, true);
	
	draw_set_alpha(1);
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_colour(c_yellow);
	draw_text((z.x1 + z.x2) * 0.5, zy - 50, z.name);
}
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);

