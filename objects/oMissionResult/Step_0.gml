var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Fade in
if (fade_alpha < 1) {
    fade_alpha = min(1, fade_alpha + fade_speed);
    if (fade_alpha >= 1) ready = true;
    exit;
}

// Wait for input
if (!ready) exit;

var cont_hov = point_in_rectangle(mx, my, cont_x, cont_y, cont_x + cont_w, cont_y + cont_h);

if ((mouse_check_button_pressed(mb_left) && cont_hov)
    || keyboard_check_pressed(vk_enter)
    || keyboard_check_pressed(vk_space)) {

    if (victory) {
        scr_on_mission_complete();
    } else {
        // Defeat, go back to mission select without marking complete
        if (instance_exists(oCampaignManager)) {
            oCampaignManager.mission_state = CampaignState.NOT_STARTED;
        }
        room_goto(rm_missionSelect);
    }
    instance_destroy();
}