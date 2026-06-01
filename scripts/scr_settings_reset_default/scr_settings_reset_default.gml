// ========================================
// SETTINGS HELPER FUNCTIONS
// ========================================

/// @description Reset all settings to default values
function scr_settings_reset_default() {
    if (!instance_exists(oGame)) return;
    
    // Audio settings
    oGame.opt_master_vol = 1.00;
    oGame.opt_music_vol = 1.00;
    oGame.opt_sfx_vol = 1.00;
    
    // Display settings
    oGame.opt_fullscreen = false;
    window_set_fullscreen(oGame.opt_fullscreen);
    
    // Game settings
    oGame.opt_show_fps = false;
    oGame.opt_player_name = "Player";
    
    // Apply audio changes
    scr_apply_audio_settings();
    
    show_debug_message("Settings reset to default");
}

/// @description Apply current audio settings to all audio
function scr_apply_audio_settings() {
    if (!instance_exists(oGame)) return;
    
    // Master volume affects everything
    audio_master_gain(oGame.opt_master_vol);
    
    // TODO: Apply music and SFX volumes to their respective audio groups
    // audio_group_set_gain(audiogroup_music, oGame.opt_music_vol, 0);
    // audio_group_set_gain(audiogroup_sfx, oGame.opt_sfx_vol, 0);
}

/// @description Save settings to file (basic implementation)
function scr_save_settings() {
    if (!instance_exists(oGame)) return false;
    
    var settings_map = ds_map_create();
    
    ds_map_add(settings_map, "master_vol", oGame.opt_master_vol);
    ds_map_add(settings_map, "music_vol", oGame.opt_music_vol);
    ds_map_add(settings_map, "sfx_vol", oGame.opt_sfx_vol);
    ds_map_add(settings_map, "fullscreen", oGame.opt_fullscreen);
    ds_map_add(settings_map, "show_fps", oGame.opt_show_fps);
    ds_map_add(settings_map, "player_name", oGame.opt_player_name);
    
    var json_string = json_encode(settings_map);
    var file = file_text_open_write(working_directory + "settings.sav");
    file_text_write_string(file, json_string);
    file_text_close(file);
    
    ds_map_destroy(settings_map);
    
    show_debug_message("Settings saved");
    return true;
}

/// @description Load settings from file
function scr_load_settings() {
    if (!instance_exists(oGame)) return false;
    
    var filepath = working_directory + "settings.sav";
    
    if (!file_exists(filepath)) {
        show_debug_message("No settings file found, using defaults");
        return false;
    }
    
    var file = file_text_open_read(filepath);
    var json_string = file_text_read_string(file);
    file_text_close(file);
    
    var settings_map = json_decode(json_string);
    
    if (ds_exists(settings_map, ds_type_map)) {
        // Load each setting
        if (ds_map_exists(settings_map, "master_vol"))
            oGame.opt_master_vol = ds_map_find_value(settings_map, "master_vol");
        if (ds_map_exists(settings_map, "music_vol"))
            oGame.opt_music_vol = ds_map_find_value(settings_map, "music_vol");
        if (ds_map_exists(settings_map, "sfx_vol"))
            oGame.opt_sfx_vol = ds_map_find_value(settings_map, "sfx_vol");
        if (ds_map_exists(settings_map, "fullscreen"))
            oGame.opt_fullscreen = ds_map_find_value(settings_map, "fullscreen");
        if (ds_map_exists(settings_map, "show_fps"))
            oGame.opt_show_fps = ds_map_find_value(settings_map, "show_fps");
        if (ds_map_exists(settings_map, "player_name"))
            oGame.opt_player_name = ds_map_find_value(settings_map, "player_name");
        
        ds_map_destroy(settings_map);
        
        // Apply loaded settings
        window_set_fullscreen(oGame.opt_fullscreen);
        scr_apply_audio_settings();
        
        show_debug_message("Settings loaded");
        return true;
    }
    
    return false;
}

/// @description Toggle fullscreen
function scr_toggle_fullscreen() {
    if (!instance_exists(oGame)) return;
    
    oGame.opt_fullscreen = !oGame.opt_fullscreen;
    window_set_fullscreen(oGame.opt_fullscreen);
    
    show_debug_message("Fullscreen: " + (oGame.opt_fullscreen ? "ON" : "OFF"));
}

/// @description Set volume for a specific channel
/// @param channel "master", "music", or "sfx"
/// @param volume 0.0 to 1.0
function scr_set_volume(_channel, _volume) {
    if (!instance_exists(oGame)) return;
    
    _volume = clamp(_volume, 0, 1);
    
    switch (_channel) {
        case "master":
            oGame.opt_master_vol = _volume;
            audio_master_gain(_volume);
            break;
        case "music":
            oGame.opt_music_vol = _volume;
            // TODO: Apply to music audio group
            break;
        case "sfx":
            oGame.opt_sfx_vol = _volume;
            // TODO: Apply to SFX audio group
            break;
    }
}