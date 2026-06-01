title_page = TitlePage.MAIN;

// GUI dimensions
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

// Panel dimensions
panel_w = 800;
panel_h = 600;
panel_x = (gui_w - panel_w) * 0.5;
panel_y = (gui_h - panel_h) * 0.5;

// Exit button
exit_w = 32;
exit_h = 32;
exit_x1 = panel_x + panel_w - exit_w - 20;
exit_y1 = panel_y + 20;
exit_x2 = exit_x1 + exit_w;
exit_y2 = exit_y1 + exit_h;

// Settings (stored locally, will sync with oGame when game starts)
opt_master_vol = 1.0;
opt_music_vol = 1.0;
opt_sfx_vol = 1.0;
opt_fullscreen = window_get_fullscreen();
opt_show_fps = false;

// Try to load from file
if (file_exists(working_directory + "settings.sav")) {
    var file = file_text_open_read(working_directory + "settings.sav");
    var json_string = file_text_read_string(file);
    file_text_close(file);
    
    var settings_map = json_decode(json_string);
    if (ds_exists(settings_map, ds_type_map)) {
        if (ds_map_exists(settings_map, "master_vol"))
            opt_master_vol = ds_map_find_value(settings_map, "master_vol");
        if (ds_map_exists(settings_map, "music_vol"))
            opt_music_vol = ds_map_find_value(settings_map, "music_vol");
        if (ds_map_exists(settings_map, "sfx_vol"))
            opt_sfx_vol = ds_map_find_value(settings_map, "sfx_vol");
        if (ds_map_exists(settings_map, "fullscreen"))
            opt_fullscreen = ds_map_find_value(settings_map, "fullscreen");
        if (ds_map_exists(settings_map, "show_fps"))
            opt_show_fps = ds_map_find_value(settings_map, "show_fps");
        
        ds_map_destroy(settings_map);
    }
}

// Apply loaded settings
window_set_fullscreen(opt_fullscreen);
audio_master_gain(opt_master_vol);

// Option sliders
slider_count = 4;
slider_x = panel_x + 60;
slider_y_start = panel_y + 120;
slider_y_gap = 80;
slider_w = panel_w - 120;
slider_h = 30;

slider_labels = ["Master Volume", "Music Volume", "SFX Volume", "Show FPS"];
dragging_slider = -1;

// Info scroll
scroll_y = 0;
scroll_speed = 10;

// Snapshot for background blur
snap_surf = -1;
