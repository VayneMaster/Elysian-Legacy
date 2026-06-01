cutscene_id = -1;
cutscene_config = {};

current_scene_index = 0;
scene_timer = 0;

fade_alpha = 0;
fade_speed = 0.02;
fade_in = true;

skippable = true;
completed = false;

if (instance_exists(oCampaignManager)) {
	oCampaignManager.mission_state = CampaignState.CUTSCENE_PLAYING;
}

show_debug_message("Cutscene startedd: " + string(cutscene_id));