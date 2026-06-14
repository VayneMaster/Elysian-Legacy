var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Colors
var c_bg        = make_colour_rgb(14,  12,  8);
var c_panel     = make_colour_rgb(26,  21,  14);
var c_panel_dark = make_colour_rgb(18, 15,  10);
var c_border    = make_colour_rgb(100, 75,  40);
var c_gold      = make_colour_rgb(255, 205, 90);
var c_gold_dim  = make_colour_rgb(170, 120, 50);
var c_bronze    = make_colour_rgb(130, 90,  40);
var c_muted     = make_colour_rgb(155, 138, 108);
var c_rivet     = make_colour_rgb(70,  60,  42);
var c_green_txt     = make_colour_rgb(100, 210, 115);
var c_red_txt   = make_colour_rgb(220, 90,  80);
var c_white_txt     = c_white;

draw_set_alpha(fade_alpha);

// Full background dim
draw_set_colour(c_bg);
draw_rectangle(0, 0, gw, gh, false);

// ---- Main panel ----
draw_set_colour(c_panel);
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, false);
draw_set_colour(c_border);
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, true);


// Gold top accent
draw_set_colour(c_gold);
draw_line(panel_x + 2, panel_y, panel_x + panel_w - 2, panel_y);

// Rivets
var rv = 7;
draw_set_colour(c_rivet);
draw_circle(panel_x + 16,            panel_y + 16,            rv, false);
draw_circle(panel_x + panel_w - 16,  panel_y + 16,            rv, false);
draw_circle(panel_x + 16,            panel_y + panel_h - 16,  rv, false);
draw_circle(panel_x + panel_w - 16,  panel_y + panel_h - 16,  rv, false);
draw_set_colour(c_bg);
draw_circle(panel_x + 16,            panel_y + 16,            rv - 3, false);
draw_circle(panel_x + panel_w - 16,  panel_y + 16,            rv - 3, false);
draw_circle(panel_x + 16,            panel_y + panel_h - 16,  rv - 3, false);
draw_circle(panel_x + panel_w - 16,  panel_y + panel_h - 16,  rv - 3, false);

// ---- Victory / Defeat title ----
var title_txt = victory ? "VICTORY!" : "DEFEAT";
var title_col = victory ? c_gold : c_red_txt;

draw_set_colour(c_panel_dark);
draw_rectangle(panel_x + 2, panel_y + 2, panel_x + panel_w - 2, panel_y + 58, false);
draw_set_colour(title_col);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(panel_x + panel_w * 0.5, panel_y + 30, title_txt, 2.2, 2.2, 0);

// ---- Stat table ----
// Divider below title
draw_set_colour(c_border);
draw_line(panel_x + 40, panel_y + 62, panel_x + panel_w - 40, panel_y + 62);

// Table layout
var table_top   = panel_y + 78;
var row_h       = 44;
var label_cx    = panel_x + panel_w * 0.5; // center label
var value_x     = panel_x + panel_w - 100; // right-aligned value
var value_x_e	= panel_x + 100;

// Column headers
draw_set_colour(c_gold_dim);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text_transformed(label_cx, table_top, "STAT", 1.0, 1.0, 0);
draw_set_halign(fa_right);
draw_text_transformed(value_x, table_top, "YOU", 1.0, 1.0, 0);
draw_set_halign(fa_left);
draw_text_transformed(value_x_e, table_top, "ENEMY", 1.0, 1.0, 0);

// Header underline
draw_set_colour(c_bronze);
draw_set_alpha(fade_alpha * 0.5);
draw_line(panel_x + 80, table_top + 22, panel_x + panel_w - 80, table_top + 22);
draw_set_alpha(fade_alpha);

// Stat rows
for (var i = 0; i < stat_count; i++) {
    var ry = table_top + 30 + i * row_h;

    // Alternate row tint
    if (i mod 2 == 0) {
        draw_set_colour(make_colour_rgb(22, 18, 12));
        draw_set_alpha(fade_alpha * 0.4);
        draw_rectangle(panel_x + 60, ry - 4, panel_x + panel_w - 60, ry + row_h - 8, false);
        draw_set_alpha(fade_alpha);
    }

    // Label — center
    draw_set_colour(c_muted);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(label_cx, ry + (row_h - 8) * 0.5, stat_labels[i]);

    // Value — right side, gold colored
    draw_set_colour(c_gold);
    draw_set_halign(fa_right);
    draw_text_transformed(value_x, ry + (row_h - 8) * 0.5 - 6, stat_values[i], 1.3, 1.3, 0);
}

// ---- Divider ----
var divider_y = table_top + 30 + stat_count * row_h + 10;
draw_set_colour(c_border);
draw_set_alpha(fade_alpha * 0.6);
draw_line(panel_x + 40, divider_y, panel_x + panel_w - 40, divider_y);
draw_set_alpha(fade_alpha);

// ---- Mission time ----
var time_y    = divider_y + 16;
var t_min     = floor(mission_secs / 60);
var t_sec     = floor(mission_secs) mod 60;
var time_str  = string(t_min) + ":" + (t_sec < 10 ? "0" : "") + string(t_sec);

draw_set_colour(c_muted);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(panel_x + panel_w * 0.5, time_y, "MISSION TIME");
draw_set_colour(c_white_txt);
draw_text_transformed(panel_x + panel_w * 0.5, time_y + 18, time_str, 1.8, 1.8, 0);

// ---- Skill points awarded ----
var sp_y = time_y + 72;
draw_set_colour(c_border);
draw_set_alpha(fade_alpha * 0.6);
draw_line(panel_x + 40, sp_y - 10, panel_x + panel_w - 40, sp_y - 10);
draw_set_alpha(fade_alpha);

if (victory && skill_pts > 0) {
    draw_set_colour(c_gold);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_transformed(panel_x + panel_w * 0.5, sp_y,
        "SKILL POINTS AWARDED:  +" + string(skill_pts), 1.4, 1.4, 0);
    draw_set_colour(c_muted);
    draw_text(panel_x + panel_w * 0.5, sp_y + 26, "Spend them in the Campaign Map");
} else if (!victory) {
    draw_set_colour(c_red_txt);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_transformed(panel_x + panel_w * 0.5, sp_y, "NO POINTS AWARDED — MISSION FAILED", 1.1, 1.1, 0);
}

// ---- Continue button ----
var cont_hov = point_in_rectangle(mx, my, cont_x, cont_y, cont_x + cont_w, cont_y + cont_h);

draw_set_colour(cont_hov ? make_colour_rgb(50, 40, 22) : make_colour_rgb(30, 24, 14));
draw_rectangle(cont_x, cont_y, cont_x + cont_w, cont_y + cont_h, false);
draw_set_colour(cont_hov ? c_gold : c_bronze);
draw_rectangle(cont_x, cont_y, cont_x + cont_w, cont_y + cont_h, true);
draw_set_colour(cont_hov ? c_gold : c_muted);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed((cont_x + cont_x + cont_w) * 0.5, (cont_y + cont_y + cont_h) * 0.5,
    "CONTINUE", 1.2, 1.2, 0);

// Reset
draw_set_alpha(1);
draw_set_colour(c_white_txt);
draw_set_halign(fa_left);
draw_set_valign(fa_top);