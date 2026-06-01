// oMenuPause - Step Event
// Handles all pause menu input and logic

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Update panel position (in case window was resized)
pause_menu_x = (gw - ui_menu_w) * 0.5;
pause_menu_y = (gh - ui_menu_h) * 0.5;

// ESC key handling
if (keyboard_check_pressed(vk_escape)) {
    if (pause_page != PausePage.MAIN) {
        // ESC from sub-pages goes back to MAIN
        pause_page = PausePage.MAIN;
    } else {
        // ESC from MAIN closes menu
        scr_set_pause(false);
        global.ui_menu_open = false;
        instance_destroy();
        exit;
    }
}

// Exit button rect
var exit_w = sprite_get_width(sUI_EXIT);
var exit_h = sprite_get_height(sUI_EXIT);
pause_exit_x1 = pause_menu_x + ui_menu_w - exit_w - 12;
pause_exit_y1 = pause_menu_y + 12;
pause_exit_x2 = pause_exit_x1 + exit_w;
pause_exit_y2 = pause_exit_y1 + exit_h;

// Reset all button bounds
pause_btn_x1 = pause_btn_y1 = pause_btn_x2 = pause_btn_y2 = 0;
pause_btn2_x1 = pause_btn2_y1 = pause_btn2_x2 = pause_btn2_y2 = 0;
pause_btn3_x1 = pause_btn3_y1 = pause_btn3_x2 = pause_btn3_y2 = 0;
pause_btn4_x1 = pause_btn4_y1 = pause_btn4_x2 = pause_btn4_y2 = 0;

// Button layout variables
var btn_x = pause_menu_x + (ui_menu_w - ui_button_w) * 0.5;
var btn_y0 = pause_menu_y + 120;
var btn_gap = 18;
var btn_step = ui_button_h + btn_gap;

// Layout buttons per page
if (pause_page == PausePage.MAIN) {
    // 4 vertical buttons
    pause_btn_x1 = btn_x;
    pause_btn_y1 = btn_y0;
    pause_btn_x2 = btn_x + ui_button_w;
    pause_btn_y2 = btn_y0 + ui_button_h;
    
    pause_btn2_x1 = btn_x;
    pause_btn2_y1 = btn_y0 + 1 * btn_step;
    pause_btn2_x2 = btn_x + ui_button_w;
    pause_btn2_y2 = pause_btn2_y1 + ui_button_h;
    
    pause_btn3_x1 = btn_x;
    pause_btn3_y1 = btn_y0 + 2 * btn_step;
    pause_btn3_x2 = btn_x + ui_button_w;
    pause_btn3_y2 = pause_btn3_y1 + ui_button_h;
    
    pause_btn4_x1 = btn_x;
    pause_btn4_y1 = btn_y0 + 3 * btn_step;
    pause_btn4_x2 = btn_x + ui_button_w;
    pause_btn4_y2 = pause_btn4_y1 + ui_button_h;
}
else if (pause_page == PausePage.SETTINGS) {
    // Bottom-aligned buttons
    var back_y = pause_menu_y + ui_menu_h - 32 - ui_button_h;
    var reset_y = back_y - btn_gap - ui_button_h;
    
    // RESET DEFAULTS
    pause_btn_x1 = btn_x;
    pause_btn_y1 = reset_y;
    pause_btn_x2 = btn_x + ui_button_w;
    pause_btn_y2 = reset_y + ui_button_h;
    
    // BACK
    pause_btn2_x1 = btn_x;
    pause_btn2_y1 = back_y;
    pause_btn2_x2 = btn_x + ui_button_w;
    pause_btn2_y2 = back_y + ui_button_h;
}
else if (pause_page == PausePage.QUIT) {
    // 3 vertical buttons
    pause_btn_x1 = btn_x;
    pause_btn_y1 = btn_y0;
    pause_btn_x2 = btn_x + ui_button_w;
    pause_btn_y2 = btn_y0 + ui_button_h;
    
    pause_btn2_x1 = btn_x;
    pause_btn2_y1 = btn_y0 + 1 * btn_step;
    pause_btn2_x2 = btn_x + ui_button_w;
    pause_btn2_y2 = pause_btn2_y1 + ui_button_h;
    
    pause_btn3_x1 = btn_x;
    pause_btn3_y1 = btn_y0 + 2 * btn_step;
    pause_btn3_x2 = btn_x + ui_button_w;
    pause_btn3_y2 = pause_btn3_y1 + ui_button_h;
}
else {
    // CONFIRM pages: 2 horizontal buttons (YES/NO)
    var yes_x = pause_menu_x + ui_menu_w * 0.5 - ui_button_w - 12;
    var no_x = pause_menu_x + ui_menu_w * 0.5 + 12;
    var btn_y = pause_menu_y + 220;
    
    pause_btn_x1 = yes_x;
    pause_btn_y1 = btn_y;
    pause_btn_x2 = yes_x + ui_button_w;
    pause_btn_y2 = btn_y + ui_button_h;
    
    pause_btn2_x1 = no_x;
    pause_btn2_y1 = btn_y;
    pause_btn2_x2 = no_x + ui_button_w;
    pause_btn2_y2 = btn_y + ui_button_h;
}

// Settings page control layout
if (pause_page == PausePage.SETTINGS) {
    var left_x = pause_menu_x + 40;
    var top_y = pause_menu_y + 140;
    var row_h = 56;
    var ctrl_x = left_x + 260;
    var bar_w = 260;
    var bar_h = sprite_get_height(sUI_Bar_Empty);
    
    // Sliders
    set_master_x1 = ctrl_x;
    set_master_y1 = top_y + 0 * row_h + 18;
    set_master_x2 = set_master_x1 + bar_w;
    set_master_y2 = set_master_y1 + bar_h;
    
    set_music_x1 = ctrl_x;
    set_music_y1 = top_y + 1 * row_h + 18;
    set_music_x2 = set_music_x1 + bar_w;
    set_music_y2 = set_music_y1 + bar_h;
    
    set_sfx_x1 = ctrl_x;
    set_sfx_y1 = top_y + 2 * row_h + 18;
    set_sfx_x2 = set_sfx_x1 + bar_w;
    set_sfx_y2 = set_sfx_y1 + bar_h;
    
    // Checkboxes
    var cb_w = sprite_get_width(sUI_Checkbox);
    var cb_h = sprite_get_height(sUI_Checkbox);
    
    set_full_x1 = ctrl_x;
    set_full_y1 = top_y + 3 * row_h + 14;
    set_full_x2 = set_full_x1 + cb_w;
    set_full_y2 = set_full_y1 + cb_h;
    
    set_fps_x1 = ctrl_x;
    set_fps_y1 = top_y + 4 * row_h + 14;
    set_fps_x2 = set_fps_x1 + cb_w;
    set_fps_y2 = set_fps_y1 + cb_h;
    
    // Textbox
    var tb_w = sprite_get_width(sUI_Textbox);
    var tb_h = sprite_get_height(sUI_Textbox);
    
    set_name_x1 = ctrl_x;
    set_name_y1 = top_y + 5 * row_h + 10;
    set_name_x2 = set_name_x1 + tb_w;
    set_name_y2 = set_name_y1 + tb_h;
    
    // Slider dragging logic
    if (settings_drag_id != -1) {
        if (mouse_check_button(mb_left)) {
            var pct = 0;
            if (settings_drag_id == 0) pct = (mx - set_master_x1) / (set_master_x2 - set_master_x1);
            if (settings_drag_id == 1) pct = (mx - set_music_x1) / (set_music_x2 - set_music_x1);
            if (settings_drag_id == 2) pct = (mx - set_sfx_x1) / (set_sfx_x2 - set_sfx_x1);
            pct = clamp(pct, 0, 1);
            
            if (settings_drag_id == 0) oGame.opt_master_vol = pct;
            if (settings_drag_id == 1) oGame.opt_music_vol = pct;
            if (settings_drag_id == 2) oGame.opt_sfx_vol = pct;
        } else {
            settings_drag_id = -1;
        }
    }
    
    // Textbox active - sync with keyboard
    if (settings_text_active) {
        oGame.opt_player_name = keyboard_string;
        
        // Length limit
        if (string_length(oGame.opt_player_name) > 20) {
            oGame.opt_player_name = string_copy(oGame.opt_player_name, 1, 20);
            keyboard_string = oGame.opt_player_name;
        }
        
        // Exit textbox on Enter/ESC
        if (keyboard_check_pressed(vk_enter) || keyboard_check_pressed(vk_escape)) {
            settings_text_active = false;
        }
    }
}

// Click handling
if (mouse_check_button_pressed(mb_left)) {
    var hit_exit = point_in_rectangle(mx, my, pause_exit_x1, pause_exit_y1, pause_exit_x2, pause_exit_y2);
    
    if (hit_exit) {
        // Close menu
        scr_set_pause(false);
        global.ui_menu_open = false;
        instance_destroy();
        exit;
    } else {
        var hit1 = point_in_rectangle(mx, my, pause_btn_x1, pause_btn_y1, pause_btn_x2, pause_btn_y2);
        var hit2 = point_in_rectangle(mx, my, pause_btn2_x1, pause_btn2_y1, pause_btn2_x2, pause_btn2_y2);
        var hit3 = point_in_rectangle(mx, my, pause_btn3_x1, pause_btn3_y1, pause_btn3_x2, pause_btn3_y2);
        var hit4 = point_in_rectangle(mx, my, pause_btn4_x1, pause_btn4_y1, pause_btn4_x2, pause_btn4_y2);
        
        // Settings page extra click handling
        if (pause_page == PausePage.SETTINGS) {
            // Click starts dragging sliders
            if (point_in_rectangle(mx, my, set_master_x1, set_master_y1, set_master_x2, set_master_y2)) {
                settings_drag_id = 0;
            }
            else if (point_in_rectangle(mx, my, set_music_x1, set_music_y1, set_music_x2, set_music_y2)) {
                settings_drag_id = 1;
            }
            else if (point_in_rectangle(mx, my, set_sfx_x1, set_sfx_y1, set_sfx_x2, set_sfx_y2)) {
                settings_drag_id = 2;
            }
            // Toggles
            else if (point_in_rectangle(mx, my, set_full_x1, set_full_y1, set_full_x2, set_full_y2)) {
                oGame.opt_fullscreen = !oGame.opt_fullscreen;
                window_set_fullscreen(oGame.opt_fullscreen);
            }
            else if (point_in_rectangle(mx, my, set_fps_x1, set_fps_y1, set_fps_x2, set_fps_y2)) {
                oGame.opt_show_fps = !oGame.opt_show_fps;
            }
            // Textbox focus
            else if (point_in_rectangle(mx, my, set_name_x1, set_name_y1, set_name_x2, set_name_y2)) {
                settings_text_active = true;
                keyboard_string = oGame.opt_player_name;
            }
            else {
                // Click outside removes focus
                settings_text_active = false;
            }
        }
        
        // Button actions per page
        switch (pause_page) {
            case PausePage.MAIN:
                if (hit1) {
                    // Continue
                    scr_set_pause(false);
                    global.ui_menu_open = false;
                    instance_destroy();
                }
                else if (hit2) {
                    // Settings
                    pause_page = PausePage.SETTINGS;
                }
                else if (hit3) {
                    // Restart
                    pause_page = PausePage.CONFIRM_RESTART;
                }
                else if (hit4) {
                    // Quit
                    pause_page = PausePage.QUIT;
                }
                break;
                
            case PausePage.SETTINGS:
                if (hit1) {
                    // Reset defaults
                    scr_settings_reset_default();
                }
                else if (hit2) {
                    // Back
                    pause_page = PausePage.MAIN;
                    settings_text_active = false;
                }
                break;
                
            case PausePage.QUIT:
                if (hit1) {
                    // Quit to menu
                    pause_page = PausePage.CONFIRM_MENU;
                }
                else if (hit2) {
                    // Quit to desktop
                    pause_page = PausePage.CONFIRM_DESKTOP;
                }
                else if (hit3) {
                    // Back
                    pause_page = PausePage.MAIN;
                }
                break;
                
            case PausePage.CONFIRM_RESTART:
                if (hit1) {
                    // YES - restart
                    scr_set_pause(false);
                    room_restart();
                }
                else if (hit2) {
                    // NO
                    pause_page = PausePage.MAIN;
                }
                break;
                
            case PausePage.CONFIRM_MENU:
                if (hit1) {
                    // YES - go to main menu
                    scr_set_pause(false);
                    room_goto(rm_mainMenu);
                }
                else if (hit2) {
                    // NO
                    pause_page = PausePage.QUIT;
                }
                break;
                
            case PausePage.CONFIRM_DESKTOP:
                if (hit1) {
                    // YES - quit game
                    game_end();
                }
                else if (hit2) {
                    // NO
                    pause_page = PausePage.QUIT;
                }
                break;
        }
    }
}