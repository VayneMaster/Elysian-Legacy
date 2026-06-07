gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

//pull stats from oGame obj
enemies_killed = 0;
units_deployed = 0;
units_lost = 0;
specials_used = 0;
mission_secs = 0;
skill_pts = 0;
victory = true; //set through ogame

if (instance_exists(oGame)) { 
	enemies_killed = oGame.stat_enemies_killed;
	units_deployed = oGame.stat_units_deployed;
	units_lost = oGame.stat_units_lost;
	specials_used = oGame.stat_specials_used;
	missions_secs = oGame.stat_mission_timer / TARGET_FPS;
}

if (instance_exists(oCampaignManager)) {
	var mid = oCampaignManager.current_mission;
    if (mid >= 0 && mid < MissionID.COUNT) {
        skill_pts = scr_get_mission_config(mid).skill_points_reward;
    }
}

// Layout
panel_w = 860;
panel_h = 560;
panel_x = (gui_w - panel_w) * 0.5;
panel_y = (gui_h - panel_h) * 0.5;

// Stats to display can add more entries here later without breaking layout
// Format: [label, player_value_string]
// Keep it even numbers for clean two-column layout
stat_labels = [
    "ENEMIES KILLED",
    "UNITS DEPLOYED",
    "SOLDIERS LOST",
    "SPECIALS USED"
];
stat_values = [
    string(enemies_killed),
    string(units_deployed),
    string(units_lost),
    string(specials_used)
];
stat_count = array_length(stat_labels);

// Continue button
cont_w = 280;
cont_h = 52;
cont_x = (gui_w - cont_w) * 0.5;
cont_y = panel_y + panel_h - cont_h - 24;

// Fade in
fade_alpha = 0;
fade_speed = 0.04;
ready      = false; // blocks input until fully faded in