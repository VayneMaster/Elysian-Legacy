// Skip if paused or menu open
if (global.game_paused || instance_exists(oMenuPause) || instance_exists(oUI_Masteries)) {
    exit;
}

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//-------------------------------------------------- 
// MENU & MASTERIES BUTTONS
if (mouse_check_button_pressed(mb_left)) {
    // Menu button
    if (point_in_rectangle(mx, my, ui_menu_btn_x, ui_menu_btn_y, 
                           ui_menu_btn_x + ui_button_w, ui_menu_btn_y + ui_button_h)) {
        if (!instance_exists(oMenuPause)) {
            instance_create_depth(0, 0, -9999, oMenuPause);
        }
    }
    
    // Masteries button
    if (point_in_rectangle(mx, my, ui_masteries_btn_x, ui_masteries_btn_y, 
                           ui_masteries_btn_x + ui_button_w, ui_masteries_btn_y + ui_button_h)) {
        if (!instance_exists(oUI_Masteries)) {
            instance_create_depth(0, 0, -9999, oUI_Masteries);
        }
    }
}

//-------------------------------------------------- 
// TAB SWITCHING (Units / Turrets)
var tab_w = 120;
var tab_h = 28;
var tab_units_x1 = ui_units_panel_x + 14;
var tab_units_y1 = ui_units_panel_y + 10;
var tab_units_x2 = tab_units_x1 + tab_w;
var tab_units_y2 = tab_units_y1 + tab_h;

var tab_turr_x1 = tab_units_x2 + 8;
var tab_turr_y1 = tab_units_y1;
var tab_turr_x2 = tab_turr_x1 + tab_w;
var tab_turr_y2 = tab_turr_y1 + tab_h;

if (mouse_check_button_pressed(mb_left)) {
    if (mx >= tab_units_x1 && mx <= tab_units_x2 && my >= tab_units_y1 && my <= tab_units_y2) {
        oGame.build_tab = BuildTab.UNITS;
    }
    if (mx >= tab_turr_x1 && mx <= tab_turr_x2 && my >= tab_turr_y1 && my <= tab_turr_y2) {
        oGame.build_tab = BuildTab.TURRETS;
    }
}

//-------------------------------------------------- 
// MOUSE OVER BAR DETECTION
var bar_hit_margin = 12;
var mouse_over_bar = (my >= (ui_bar_y - bar_hit_margin));

//-------------------------------------------------- 
// LANE HOVER DETECTION (for unit preview)
hover_lane = -1;

if (oGame.build_tab == BuildTab.UNITS && !mouse_over_bar) {
    var best_lane = 0;
    var best_d = 1000000;
    
    for (var i = 0; i < oGame.lane_count; i++) {
        var d = abs(my - oGame.lane_y[i]);
        if (d < best_d) {
            best_d = d;
            best_lane = i;
        }
    }
    
    if (best_d <= 80) {
        hover_lane = best_lane;
    }
}

//-------------------------------------------------- 
// UNIT/TURRET BUTTON CLICKS (start drag)
if (!dragging && mouse_check_button_pressed(mb_left) && mouse_over_bar) {
    if (oGame.build_tab == BuildTab.UNITS) {
        // Check unit buttons
        for (var i = 0; i < oGame.unit_count; i++) {
            if (mx >= unit_x1[i] && mx <= unit_x2[i] && my >= unit_y1[i] && my <= unit_y2[i]) {
                oGame.selected_type = oGame.unit_type[i];
                dragging = true;
                drag_type = oGame.selected_type;
                break;
            }
        }
    } else {
        // Check turret buttons
        for (var i = 0; i < oGame.turret_count; i++) {
            if (mx >= unit_x1[i] && mx <= unit_x2[i] && my >= unit_y1[i] && my <= unit_y2[i]) {
                // Skip locked turrets
                if (!oGame.turret_unlocked[i]) continue;
                
                oGame.selected_turret = oGame.turret_type[i];
                dragging = true;
                drag_type = oGame.selected_turret;
                break;
            }
        }
    }
}

//-------------------------------------------------- 
// DROP DRAGGED (spawn unit/turret)
if (dragging && mouse_check_button_released(mb_left)) {
    if (!mouse_over_bar) {
        if (oGame.build_tab == BuildTab.UNITS) {
            if (hover_lane != -1) {
                scr_spawn_player_unit(hover_lane, drag_type);
            }
        } else {
            scr_spawn_player_turret(drag_type);
        }
    }
    dragging = false;
    drag_type = -1;
}

//-------------------------------------------------- 
// CLICK BATTLEFIELD (spawn selected)
if (!dragging && mouse_check_button_pressed(mb_left) && !mouse_over_bar) {
    if (oGame.build_tab == BuildTab.UNITS) {
        if (hover_lane != -1) {
            scr_spawn_player_unit(hover_lane, oGame.selected_type);
        }
    } else {
        scr_spawn_player_turret(oGame.selected_turret);
    }
}