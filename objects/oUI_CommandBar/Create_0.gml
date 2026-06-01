// oUI_CommandBar - Create Event
// Handles all bottom command bar UI

//-------------------------------------------------- 
// GUI setup
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

ui_bar_h = 190;
ui_bar_y = gui_h - ui_bar_h;

ui_icon_w = 80;
ui_icon_h = 90;
ui_icon_gap = 12;

// Gutters (space on left/right edges)
ui_gutter = 160;
ui_bar_x1 = ui_gutter;
ui_bar_x2 = gui_w - ui_gutter;

//-------------------------------------------------- 
// NEW LAYOUT - Left to Right:
// 1. Info Panel
// 2. Unit/Turret Grid
// 3. Special Ability
// 4. Game Logo
// 5. Menu & Masteries Buttons

var current_x = ui_bar_x1;
var panel_gap = 24; // Increased spacing

// 1. INFO PANEL (left) - moved right a bit
current_x += 20; // Extra margin from left edge
ui_info_w = 400; // Slightly narrower
ui_info_h = ui_bar_h - 28;
ui_info_x = current_x;
ui_info_y = ui_bar_y + 14;
current_x += ui_info_w + panel_gap;

// 2. UNIT/TURRET GRID
var unit_grid_w = oGame.unit_count * ui_icon_w + (oGame.unit_count - 1) * ui_icon_gap;
var units_panel_padding = 48;
ui_units_panel_w = unit_grid_w + units_panel_padding;
ui_units_panel_h = ui_bar_h - 28;
ui_units_panel_x = current_x;
ui_units_panel_y = ui_bar_y + 14;

ui_units_x = ui_units_panel_x + (units_panel_padding / 2);
ui_units_y = ui_bar_y + 58;
current_x += ui_units_panel_w + panel_gap + 12; // Extra space after units

// Calculate unit button positions
unit_x1 = array_create(oGame.unit_count, 0);
unit_y1 = array_create(oGame.unit_count, 0);
unit_x2 = array_create(oGame.unit_count, 0);
unit_y2 = array_create(oGame.unit_count, 0);

for (var i = 0; i < oGame.unit_count; i++) {
    unit_x1[i] = ui_units_x + i * (ui_icon_w + ui_icon_gap);
    unit_y1[i] = ui_units_y;
    unit_x2[i] = unit_x1[i] + ui_icon_w;
    unit_y2[i] = unit_y1[i] + ui_icon_h;
}

// 3. SPECIAL ABILITY (portrait style - same height as units panel)
ui_special_w = 140;
ui_special_h = ui_bar_h - 28; // Match units panel height
ui_special_x = current_x;
ui_special_y = ui_bar_y + 14; // Match units panel Y
current_x += ui_special_w + panel_gap + 8; // Extra space after special

//  MENU & MASTERIES (from the right, work backwards - STACKED VERTICALLY)
ui_button_w = 140;
ui_button_h = 62;

// MENU PANEL (container for MENU + MASTERIES)
ui_menu_panel_w = ui_button_w + 32;
ui_menu_panel_h = (ui_button_h * 2) + 12 + 28; // buttons + gap + padding

ui_menu_panel_x = ui_bar_x2 - ui_menu_panel_w - 8;
ui_menu_panel_y = ui_bar_y + 14;

// Reposition buttons INSIDE panel
ui_menu_btn_x = ui_menu_panel_x + 18;
ui_menu_btn_y = ui_menu_panel_y + 14;

ui_masteries_btn_x = ui_menu_btn_x;
ui_masteries_btn_y = ui_menu_btn_y + ui_button_h + 12;

// Calculate from right edge with margin
var button_stack_w = ui_button_w;
var buttons_x = ui_bar_x2 - button_stack_w - 20; // 20px margin from right

// MENU on top
ui_menu_btn_x = buttons_x;
ui_menu_btn_y = ui_bar_y + 24;

// MASTERIES below MENU (with gap)
ui_masteries_btn_x = buttons_x;
ui_masteries_btn_y = ui_menu_btn_y + ui_button_h + 12; // 12px gap between

// 4. GAME LOGO (fills remaining space between special and menu)
ui_logo_x = current_x;
ui_logo_y = ui_bar_y + 24;
ui_logo_w = ui_menu_btn_x - current_x - panel_gap; // Fills gap
ui_logo_h = 62;

//-------------------------------------------------- 
// UI State
dragging = false;
drag_type = -1;
hover_lane = -1;