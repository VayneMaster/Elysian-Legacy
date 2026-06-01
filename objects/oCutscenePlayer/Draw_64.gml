if (array_length(cutscene_config.scenes) == 0) exit;
if (current_scene_index >= array_length(cutscene_config.scenes)) exit;

var scene = cutscene_config.scenes[current_scene_index];
var gui_w = display_get_gui_width();
var gui_h = display_get_gui_height();

// Background
var bg = scene.background_color;
draw_set_alpha(fade_alpha);
draw_set_colour(bg);
draw_rectangle(0, 0, gui_w, gui_h, false);

// Text
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

draw_text_ext(gui_w / 2, gui_h / 2, scene.text, -1, gui_w * 0.7);

// Skip hint
if (skippable && !fade_in) {
    draw_set_font(-1);
    draw_set_alpha(fade_alpha * 0.5);
    draw_set_halign(fa_right);
    draw_set_valign(fa_bottom);
    draw_text(gui_w - 20, gui_h - 20, "SPACE / CLICK to skip");
}

draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);