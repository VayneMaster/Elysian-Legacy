// oMenuPause - Create Event
// This object now handles ALL pause menu functionality

// Immediately freeze the game
scr_set_pause(true);
global.ui_menu_open = true;

// Get GUI dimensions
var gw = display_get_gui_width();
var gh = display_get_gui_height();

// Menu panel dimensions
ui_menu_w = min(760, gw * 0.45);
ui_menu_h = 620;

// Button dimensions (from oGame's UI setup)
ui_button_w = sprite_get_width(sUI_Button_BG);
ui_button_h = sprite_get_height(sUI_Button_BG);

// Current page
pause_page = PausePage.MAIN;

// Panel position (centered)
pause_menu_x = (gw - ui_menu_w) * 0.5;
pause_menu_y = (gh - ui_menu_h) * 0.5;

// Button bounds (will be recalculated in Step)
pause_exit_x1 = 0;
pause_exit_y1 = 0;
pause_exit_x2 = 0;
pause_exit_y2 = 0;

pause_btn_x1 = 0;
pause_btn_y1 = 0;
pause_btn_x2 = 0;
pause_btn_y2 = 0;

pause_btn2_x1 = 0;
pause_btn2_y1 = 0;
pause_btn2_x2 = 0;
pause_btn2_y2 = 0;

pause_btn3_x1 = 0;
pause_btn3_y1 = 0;
pause_btn3_x2 = 0;
pause_btn3_y2 = 0;

pause_btn4_x1 = 0;
pause_btn4_y1 = 0;
pause_btn4_x2 = 0;
pause_btn4_y2 = 0;

// Settings control bounds
set_master_x1 = 0;
set_master_y1 = 0;
set_master_x2 = 0;
set_master_y2 = 0;

set_music_x1 = 0;
set_music_y1 = 0;
set_music_x2 = 0;
set_music_y2 = 0;

set_sfx_x1 = 0;
set_sfx_y1 = 0;
set_sfx_x2 = 0;
set_sfx_y2 = 0;

set_full_x1 = 0;
set_full_y1 = 0;
set_full_x2 = 0;
set_full_y2 = 0;

set_fps_x1 = 0;
set_fps_y1 = 0;
set_fps_x2 = 0;
set_fps_y2 = 0;

set_name_x1 = 0;
set_name_y1 = 0;
set_name_x2 = 0;
set_name_y2 = 0;

// Settings UI state
settings_drag_id = -1; // -1 = none, 0 = master, 1 = music, 2 = sfx
settings_text_active = false;

// Snapshot surface for background
pause_snap_surf = -1;

// Take snapshot of current game state
if (!surface_exists(pause_snap_surf) || 
    surface_get_width(pause_snap_surf) != gw || 
    surface_get_height(pause_snap_surf) != gh) {
    
    if (surface_exists(pause_snap_surf)) {
        surface_free(pause_snap_surf);
    }
    pause_snap_surf = surface_create(gw, gh);
}

// Copy current frame to snapshot
if (surface_exists(pause_snap_surf) && surface_exists(application_surface)) {
    surface_set_target(pause_snap_surf);
    draw_clear_alpha(c_black, 1);
    draw_set_alpha(1);
    draw_set_colour(c_white);
    draw_surface_stretched(application_surface, 0, 0, gw, gh);
    surface_reset_target();
}