// oUI_CommandBar - Draw GUI Event (FIXED - Shows mastery-modified costs)
// Renders all UI elements

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//===============================================
// COMMAND BAR BACKGROUND
//===============================================
draw_set_alpha(1);
draw_set_color(c_black);
draw_rectangle(ui_bar_x1, ui_bar_y, ui_bar_x2, gh, false);

draw_set_color(c_white);
draw_line(ui_bar_x1, ui_bar_y, ui_bar_x2, ui_bar_y);

draw_set_alpha(0.25);
draw_set_colour(c_black);
draw_rectangle(ui_bar_x1, ui_bar_y - 6, ui_bar_x2, ui_bar_y, false);
draw_set_alpha(1);

//===============================================
// 1. INFO PANEL (LEFT)
//===============================================
draw_sprite_stretched(sUI_Unit_Tab1, 0, ui_info_x, ui_info_y, ui_info_w, ui_info_h);

// Gold display in top-left of info panel
var gold_x = ui_info_x + 14;
var gold_y = ui_info_y + 12;
draw_sprite(sUI_Gold, 0, gold_x, gold_y);

draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_text(gold_x + 28, gold_y - 4, string(floor(oGame.gold)));

draw_set_alpha(0.65);
draw_text(gold_x + 28, gold_y + 14, "+" + string(oGame.gold_per_second) + "/sec");
draw_set_alpha(1);

// Determine what to show in info panel
var hover_type = -1;
var hover_cost = 0;
var hover_affordable = false;

// Check which unit/turret is hovered
var grid_count = (oGame.build_tab == BuildTab.UNITS) ? oGame.unit_count : oGame.turret_count;
for (var i = 0; i < grid_count; i++) {
    if (mx >= unit_x1[i] && mx <= unit_x2[i] && my >= unit_y1[i] && my <= unit_y2[i]) {
        if (oGame.build_tab == BuildTab.UNITS) {
            hover_type = oGame.unit_type[i];
            var hover_stats = scr_get_unit_stats_with_masteries(hover_type);
            hover_cost = hover_stats.cost;
            hover_affordable = (oGame.gold >= hover_cost);
        } else {
            hover_type = oGame.turret_type[i];
            hover_cost = oGame.turret_cost[i];
            hover_affordable = (oGame.gold >= hover_cost) && oGame.turret_unlocked[i];
        }
        break;
    }
}

// Decide what to show
var show_type;
if (oGame.build_tab == BuildTab.UNITS) {
    show_type = (hover_type != -1) ? hover_type : oGame.selected_type;
} else {
    show_type = (hover_type != -1) ? hover_type : oGame.selected_turret;
}

// Portrait
var preview_w = 96;
var preview_h = 96;
var preview_x = ui_info_x + 16;
var preview_y = ui_info_y + 50;

draw_sprite_stretched(sUI_Portrait_Unit1, 0, preview_x, preview_y, preview_w, preview_h);

if (oGame.build_tab == BuildTab.UNITS) {
    var show_name = oGame.unit_name[show_type];
    
    // Get modified stats with masteries
    var modified_stats = scr_get_unit_stats_with_masteries(show_type);
    var show_cost = modified_stats.cost;
    var affordable = (oGame.gold >= show_cost);
    
    // Lock overlay if not affordable
    if (!affordable) {
        draw_set_alpha(0.55);
        draw_set_colour(c_black);
        draw_rectangle(preview_x + 2, preview_y + 2, preview_x + preview_w - 2, preview_y + preview_h - 2, false);
        draw_set_alpha(1);
    }
    
    // Stats
    var col1_x = preview_x + preview_w + 16;
    var col2_x = col1_x + 140;
    var row_h = 22;
    var row_y0 = preview_y;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_colour(c_white);
    draw_text(col1_x, row_y0 + 0 * row_h, "Name: " + show_name);
    
    if (affordable) draw_set_colour(c_white);
    else draw_set_colour(c_red);
    draw_text(col1_x, row_y0 + 1 * row_h, "Cost: " + string(show_cost));
    
    // Show modified stats (green if buffed)
    var base_hp = oGame.unit_hp[show_type];
    var base_dmg = oGame.unit_dmg[show_type];
    var base_spd = oGame.unit_spd[show_type];
    var base_rng = oGame.unit_rng[show_type];
    
    // HP
    if (modified_stats.hp > base_hp) draw_set_colour(c_lime);
    else draw_set_colour(c_white);
    draw_text(col1_x, row_y0 + 2 * row_h, "HP: " + string(modified_stats.hp));
    
    // SPD
    if (modified_stats.spd > base_spd) draw_set_colour(c_lime);
    else draw_set_colour(c_white);
    draw_text(col2_x, row_y0 + 0 * row_h, "SPD: " + string(modified_stats.spd));
    
    // DMG
    if (modified_stats.dmg > base_dmg) draw_set_colour(c_lime);
    else draw_set_colour(c_white);
    draw_text(col2_x, row_y0 + 1 * row_h, "DMG: " + string(modified_stats.dmg));
    
    // RNG
    if (modified_stats.rng > base_rng) draw_set_colour(c_lime);
    else draw_set_colour(c_white);
    draw_text(col2_x, row_y0 + 2 * row_h, "RNG: " + string(modified_stats.rng));
}
// TURRETS INFO
else {
    var tidx = 0;
    for (var j = 0; j < oGame.turret_count; j++) {
        if (oGame.turret_type[j] == show_type) {
            tidx = j;
            break;
        }
    }
    
    var t_name = oGame.turret_name[tidx];
    var t_cost = oGame.turret_cost[tidx];
    var t_unlocked = oGame.turret_unlocked[tidx];
    var affordable = (oGame.gold >= t_cost) && t_unlocked;
    
    // Lock overlay
    if (!affordable) {
        draw_set_alpha(0.55);
        draw_set_colour(c_black);
        draw_rectangle(preview_x + 2, preview_y + 2, preview_x + preview_w - 2, preview_y + preview_h - 2, false);
        draw_set_alpha(1);
        
        if (!t_unlocked) {
            draw_set_colour(c_white);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text(preview_x + preview_w * 0.5, preview_y + preview_h * 0.5, "LOCKED");
        }
    }
    
    // Text
    var col1_x = preview_x + preview_w + 16;
    var row_h = 22;
    var row_y0 = preview_y;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_colour(c_white);
    draw_text(col1_x, row_y0, "Turret: " + t_name);
    
    // FIXED: Show cost with proper color coding
    if (t_unlocked) {
        if (oGame.gold >= t_cost) draw_set_colour(c_white);
        else draw_set_colour(c_red);
        draw_text(col1_x, row_y0 + row_h, "Cost: " + string(t_cost));
    } else {
        draw_set_colour(c_gray);
        draw_text(col1_x, row_y0 + row_h, "Cost: ---");
    }
    
    // Instructions
    var instr_y = ui_info_y + ui_info_h - 45;
    draw_set_alpha(0.85);
    draw_set_colour(c_white);
    if (!t_unlocked) {
        draw_text(col1_x, instr_y, "Locked (campaign)");
    } else {
        draw_text(col1_x, instr_y, affordable ? "Ready" : "Not enough gold");
        draw_text(col1_x, instr_y + 18, "Click to place turret");
    }
    draw_set_alpha(1);
}

//===============================================
// 2. UNIT/TURRET GRID
//===============================================
draw_sprite_stretched(sUI_Unit_Tab1, 0, ui_units_panel_x, ui_units_panel_y, ui_units_panel_w, ui_units_panel_h);

// Tabs
var tab_w = 120;
var tab_h = 28;
var tab_units_x = ui_units_panel_x + 14;
var tab_units_y = ui_units_panel_y + 10;
var tab_turr_x = tab_units_x + tab_w + 8;
var tab_turr_y = tab_units_y;

draw_set_alpha(0.9);

// Units tab
draw_set_colour(oGame.build_tab == BuildTab.UNITS ? c_white : c_gray);
draw_rectangle(tab_units_x, tab_units_y, tab_units_x + tab_w, tab_units_y + tab_h, true);
draw_set_colour(c_black);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(tab_units_x + tab_w * 0.5, tab_units_y + tab_h * 0.5, "UNITS");

// Turrets tab
draw_set_colour(oGame.build_tab == BuildTab.TURRETS ? c_white : c_gray);
draw_rectangle(tab_turr_x, tab_turr_y, tab_turr_x + tab_w, tab_turr_y + tab_h, true);
draw_set_colour(c_black);
draw_text(tab_turr_x + tab_w * 0.5, tab_turr_y + tab_h * 0.5, "TURRETS");

draw_set_alpha(1);

// Grid buttons
grid_count = (oGame.build_tab == BuildTab.UNITS) ? oGame.unit_count : oGame.turret_count;

for (var i = 0; i < grid_count; i++) {
    var t, cost, unlocked;
    if (oGame.build_tab == BuildTab.UNITS) {
        t = oGame.unit_type[i];
        // FIXED: Get mastery-modified cost for units
        var unit_stats = scr_get_unit_stats_with_masteries(t);
        cost = unit_stats.cost;
        unlocked = true;
    } else {
        t = oGame.turret_type[i];
        cost = oGame.turret_cost[i];
        unlocked = oGame.turret_unlocked[i];
    }
    
    var x1 = unit_x1[i];
    var y1 = unit_y1[i];
    var x2 = unit_x2[i];
    var y2 = unit_y2[i];
    
    var affordable = (oGame.gold >= cost) && unlocked;
    var hovered = (mx >= x1 && mx <= x2 && my >= y1 && my <= y2);
    var selected = (oGame.build_tab == BuildTab.UNITS) ? (oGame.selected_type == t) : (oGame.selected_turret == t);
    
    // Portrait
    draw_sprite_stretched(sUI_Portrait_Unit1, 0, x1, y1, ui_icon_w, ui_icon_h);
    
    // Disabled overlay
    if (!affordable) {
        if (oGame.build_tab == BuildTab.TURRETS && !unlocked) {
            draw_set_alpha(1);
            draw_set_colour(c_white);
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_text((x1 + x2) * 0.5, (y1 + y2) * 0.5, "LOCKED");
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
        }
        
        draw_set_alpha(0.55);
        draw_set_color(c_gray);
        draw_rectangle(x1 + 2, y1 + 2, x2 - 2, y2 - 2, false);
        draw_set_alpha(1);
    }
    
    // Hover outline
    if (hovered) {
        draw_set_color(c_yellow);
        draw_rectangle(x1 - 1, y1 - 1, x2 + 1, y2 + 1, true);
    }
    
    // Selected outline
    if (selected) {
        draw_set_color(c_lime);
        draw_rectangle(x1 - 2, y1 - 2, x2 + 2, y2 + 2, true);
    }
    
    // Cost (now shows modified cost for units!)
    if (affordable) draw_set_color(c_white);
    else draw_set_color(c_red);
    draw_set_halign(fa_center);
    draw_text((x1 + x2) * 0.5, y2 + 10, string(cost));
}

//===============================================
// 3. SPECIAL ABILITY (MMORPG Style - Taller Panel)
//===============================================
draw_sprite_stretched(sUI_Unit_Tab1, 0, ui_special_x, ui_special_y, ui_special_w, ui_special_h);

// Portrait (bigger to fit taller panel)
var portrait_size = 110;
var portrait_x = ui_special_x + (ui_special_w - portrait_size) * 0.5;
var portrait_y = ui_special_y + 20;
draw_sprite_stretched(sUI_Portrait_Unit1, 0, portrait_x, portrait_y, portrait_size, portrait_size);

// Cooldown overlay
if (!oGame.ui_special_ready) {
    var cd_pct = oGame.special_cd_left / oGame.special_cd_steps;
    
    // Dark overlay
    draw_set_alpha(0.7);
    draw_set_color(c_black);
    draw_rectangle(portrait_x + 2, portrait_y + 2, portrait_x + portrait_size - 2, portrait_y + portrait_size - 2, false);
    draw_set_alpha(1);
    
    // Countdown number
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    var cd_seconds = ceil(oGame.special_cd_left / TARGET_FPS);
    draw_text(portrait_x + portrait_size * 0.5, portrait_y + portrait_size * 0.5, string(cd_seconds));
    
    // Progress bar
    draw_set_alpha(0.8);
    draw_set_color(c_yellow);
    var bar_h = 6;
    draw_rectangle(portrait_x + 4, portrait_y + portrait_size - bar_h - 4, 
                   portrait_x + 4 + (portrait_size - 8) * (1 - cd_pct), portrait_y + portrait_size - 4, false);
    draw_set_alpha(1);
}

// Label below portrait
draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text(ui_special_x + ui_special_w * 0.5, portrait_y + portrait_size + 8, "Special");

//===============================================
// 4. GAME LOGO
//===============================================
draw_sprite_stretched(sUI_Unit_Tab1, 0, ui_logo_x, ui_logo_y, ui_logo_w, ui_logo_h);

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(ui_logo_x + ui_logo_w * 0.5, ui_logo_y + ui_logo_h * 0.5, "LEGACY OF ELYSIAN WARFARE");

//===============================================
// 5. MENU & MASTERIES BUTTONS (STACKED VERTICALLY)
//===============================================
// Menu panel background
draw_sprite_stretched(
    sUI_Unit_Tab1,
    0,
    ui_menu_panel_x,
    ui_menu_panel_y,
    ui_menu_panel_w,
    ui_menu_panel_h
);

var menu_hovered = point_in_rectangle(mx, my, ui_menu_btn_x, ui_menu_btn_y, 
                                      ui_menu_btn_x + ui_button_w, ui_menu_btn_y + ui_button_h);

draw_sprite_stretched(sUI_Unit_Tab1, 0, ui_menu_btn_x, ui_menu_btn_y, ui_button_w, ui_button_h);

if (menu_hovered) {
    draw_set_alpha(0.3);
    draw_set_color(c_white);
    draw_rectangle(ui_menu_btn_x, ui_menu_btn_y, ui_menu_btn_x + ui_button_w, ui_menu_btn_y + ui_button_h, false);
    draw_set_alpha(1);
}

draw_set_color(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(ui_menu_btn_x + ui_button_w * 0.5, ui_menu_btn_y + ui_button_h * 0.5, "MENU");

// Masteries button (bottom)
var mast_hovered = point_in_rectangle(mx, my, ui_masteries_btn_x, ui_masteries_btn_y, 
                                      ui_masteries_btn_x + ui_button_w, ui_masteries_btn_y + ui_button_h);

draw_sprite_stretched(sUI_Unit_Tab1, 0, ui_masteries_btn_x, ui_masteries_btn_y, ui_button_w, ui_button_h);

if (mast_hovered) {
    draw_set_alpha(0.3);
    draw_set_color(c_white);
    draw_rectangle(ui_masteries_btn_x, ui_masteries_btn_y, ui_masteries_btn_x + ui_button_w, ui_masteries_btn_y + ui_button_h, false);
    draw_set_alpha(1);
}

draw_set_color(c_white);
draw_text(ui_masteries_btn_x + ui_button_w * 0.5, ui_masteries_btn_y + ui_button_h * 0.5, "MASTERIES");

//===============================================
// DRAG PREVIEW
//===============================================
if (dragging) {
    draw_set_alpha(0.85);
    draw_sprite_stretched(sUI_Portrait_Unit1, 0, mx - 40, my - 40, 80, 80);
    draw_set_alpha(1);
}

//===============================================
// LANE PREVIEW
//===============================================
if (oGame.build_tab == BuildTab.UNITS && hover_lane != -1) {
    var lane_gui_y = oGame.lane_y[hover_lane];
    
    draw_set_alpha(0.15);
    draw_set_color(c_white);
    draw_rectangle(0, lane_gui_y - 28, gw, lane_gui_y + 28, false);
    draw_set_alpha(1);
}

//===============================================
// VICTORY/DEFEAT OVERLAY
//===============================================
if (oGame.game_state == GameState.VICTORY || oGame.game_state == GameState.DEFEAT) {
    draw_set_alpha(0.85);
    draw_set_color(c_black);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);
    
    var msg = (oGame.game_state == GameState.VICTORY) ? "VICTORY" : "DEFEAT";
    draw_set_color(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text(gw * 0.5, gh * 0.5 - 20, msg);
    draw_text(gw * 0.5, gh * 0.5 + 20, "Press P to continue");
}

// Reset draw settings
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_color(c_white);
draw_set_alpha(1);