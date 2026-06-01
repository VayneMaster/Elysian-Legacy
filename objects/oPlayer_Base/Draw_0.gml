//placeholder base
var w = 64;
var h = 128;

draw_set_colour(c_dkgray);
draw_rectangle(x - w/2, y -h, x + w/2, y, false);

//hp bar
var bar_width = 80;
var bar_height = 8;
var hp_ratio = hp / max_hp;

var bar_x1 = x - bar_width / 2;
var bar_y1 = y - h -16;
var bar_x2 = bar_x1 + bar_width * hp_ratio;
var bar_y2 = bar_y1 + bar_height;

//background
draw_set_colour(c_aqua);
draw_rectangle(bar_x1, bar_y1, bar_x1 + bar_width, bar_y2, false);

//Hp fill
draw_set_color(c_lime);
draw_rectangle(bar_x1, bar_y1, bar_x2, bar_y2, false);