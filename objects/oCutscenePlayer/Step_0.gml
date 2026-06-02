if (completed) {
	instance_destroy();
	exit;
}

//get current scene
if (current_scene_index >= array_length(cutscene_config.scenes)) {
    completed = true;
    
    if (instance_exists(oCampaignManager)) {
        if (cutscene_id == CutsceneID.ZEUS_WARNING) {
            oCampaignManager.mission_state = CampaignState.CAMPAIGN_COMPLETE;
            room_goto(rm_mainMenu); // campaign done, back to main menu
        } else {
            oCampaignManager.mission_state = CampaignState.NOT_STARTED;
            room_goto(rm_missionSelect); // go to mission select after every other cutscene
        }
    }
    exit;
}

var scene = cutscene_config.scenes[current_scene_index];

//fade in
if (fade_in) {
	fade_alpha += fade_speed;
	if (fade_alpha >= 1) {
		fade_alpha = 1;
		fade_in = false;
		scene_timer = 0;
	}
}

//display scene
else if (!fade_in && scene_timer < scene.duration * TARGET_FPS) {
	scene_timer++;
	
	//skip with space/enter or Lclick
	if (skippable && (keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter) 
						|| mouse_check_button_pressed(mb_left))) {
		scene_timer = scene.duration * TARGET_FPS; //skip to end
						}
}

//fade out and next
else { 
	fade_alpha -= fade_speed;
	if (fade_alpha <= 0) {
		fade_alpha = 0;
		current_scene_index++;
		fade_in = true;
	}
}
