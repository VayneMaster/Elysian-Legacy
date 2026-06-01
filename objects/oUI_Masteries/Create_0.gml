// oUI_Masteries - Create Event (HORIZONTAL LAYOUT)

// Pause game
scr_set_pause(true);
global.ui_menu_open = true;

// Get GUI dimensions
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Panel dimensions (wider, shorter)
panel_w = 1300;
panel_h = 700;
panel_x = (gw - panel_w) * 0.5;
panel_y = (gh - panel_h) * 0.5;

// Exit button (top right)
exit_w = sprite_get_width(sUI_EXIT);
exit_h = sprite_get_height(sUI_EXIT);
exit_x1 = panel_x + panel_w - exit_w - 20;
exit_y1 = panel_y + 20;
exit_x2 = exit_x1 + exit_w;
exit_y2 = exit_y1 + exit_h;

// Node size
node_size = 80;
node_gap_x = 20;
node_gap_y = 20;

// Layout areas
var section_y_top = panel_y + 140; // Top row
var section_y_bottom = section_y_top + node_size + node_gap_y + 20; // Bottom row
var melee_x_start = panel_x + 100;
var ranged_x_start = panel_x + panel_w - 380;

// MELEE SECTION - HORIZONTAL layout
melee_x_arr = array_create(5, 0);
melee_y_arr = array_create(5, 0);

// Top row: M1, M2, M3 (horizontal)
melee_x_arr[0] = melee_x_start;
melee_y_arr[0] = section_y_top;

melee_x_arr[1] = melee_x_start + node_size + node_gap_x;
melee_y_arr[1] = section_y_top;

melee_x_arr[2] = melee_x_start + 2 * (node_size + node_gap_x);
melee_y_arr[2] = section_y_top;

// Bottom row: M4, M5 (horizontal, centered under top row)
var melee_row2_offset = (node_size + node_gap_x) * 0.5;
melee_x_arr[3] = melee_x_start + melee_row2_offset;
melee_y_arr[3] = section_y_bottom;

melee_x_arr[4] = melee_x_start + melee_row2_offset + node_size + node_gap_x;
melee_y_arr[4] = section_y_bottom;

// RANGED SECTION - HORIZONTAL layout
ranged_x_arr = array_create(5, 0);
ranged_y_arr = array_create(5, 0);

// Top row: R1, R2, R3 (horizontal)
ranged_x_arr[0] = ranged_x_start;
ranged_y_arr[0] = section_y_top;

ranged_x_arr[1] = ranged_x_start + node_size + node_gap_x;
ranged_y_arr[1] = section_y_top;

ranged_x_arr[2] = ranged_x_start + 2 * (node_size + node_gap_x);
ranged_y_arr[2] = section_y_top;

// Bottom row: R4, R5 (horizontal, centered under top row)
var ranged_row2_offset = (node_size + node_gap_x) * 0.5;
ranged_x_arr[3] = ranged_x_start + ranged_row2_offset;
ranged_y_arr[3] = section_y_bottom;

ranged_x_arr[4] = ranged_x_start + ranged_row2_offset + node_size + node_gap_x;
ranged_y_arr[4] = section_y_bottom;

// ELITE SECTION - HORIZONTAL layout (center bottom)
elite_x_arr = array_create(4, 0);
elite_y_arr = array_create(4, 0);

var elite_y_top = section_y_bottom + node_size + 60;
var elite_y_bottom = elite_y_top + node_size + node_gap_y + 20;
var elite_x_start = panel_x + (panel_w - (3 * node_size + 2 * node_gap_x)) * 0.5;

// Top row: E1, E2, E3 (horizontal)
elite_x_arr[0] = elite_x_start;
elite_y_arr[0] = elite_y_top;

elite_x_arr[1] = elite_x_start + node_size + node_gap_x;
elite_y_arr[1] = elite_y_top;

elite_x_arr[2] = elite_x_start + 2 * (node_size + node_gap_x);
elite_y_arr[2] = elite_y_top;

// Bottom: E4 (centered under E2)
elite_x_arr[3] = elite_x_start + node_size + node_gap_x;
elite_y_arr[3] = elite_y_bottom;

// Hovered skill
hovered_skill = -1;

// Snapshot for background
snap_surf = -1;
if (!surface_exists(snap_surf) || 
    surface_get_width(snap_surf) != gw || 
    surface_get_height(snap_surf) != gh) {
    
    if (surface_exists(snap_surf)) {
        surface_free(snap_surf);
    }
    snap_surf = surface_create(gw, gh);
}

// Copy current frame
if (surface_exists(snap_surf) && surface_exists(application_surface)) {
    surface_set_target(snap_surf);
    draw_clear_alpha(c_black, 1);
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_surface_stretched(application_surface, 0, 0, gw, gh);
    surface_reset_target();
}