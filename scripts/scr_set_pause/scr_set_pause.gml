// ========================================
// PAUSE SYSTEM
// ========================================

/// @description Pause or unpause the game
/// @param paused true to pause, false to unpause
function scr_set_pause(_paused) {
    // PAUSE
    if (_paused) {
        // Already paused, ignore
        if (global.game_paused) return;
        
        global.game_paused = true;
        
        // Deactivate all instances except persistent ones
        instance_deactivate_all(true);
        
        // Keep these objects active during pause
        instance_activate_object(oCamera);
        instance_activate_object(oGame);
        
        // Keep bases alive too (for rendering)
        if (instance_exists(oGame)) {
            if (instance_exists(oGame.player_base)) {
                instance_activate_object(oGame.player_base);
            }
            if (instance_exists(oGame.enemy_base)) {
                instance_activate_object(oGame.enemy_base);
            }
        }
        
        // Pause all audio
        audio_pause_all();
        
        show_debug_message("Game paused");
    }
    // UNPAUSE
    else {
        // Already unpaused, ignore
        if (!global.game_paused) return;
        
        global.game_paused = false;
        
        // Reactivate all instances
        instance_activate_all();
        
        // Resume all audio
        //audio_resume_all();
        
        show_debug_message("Game unpaused");
    }
}

/// @description Check if game is currently paused
function scr_is_paused() {
    return global.game_paused;
}

/// @description Toggle pause state
function scr_toggle_pause() {
    scr_set_pause(!global.game_paused);
}