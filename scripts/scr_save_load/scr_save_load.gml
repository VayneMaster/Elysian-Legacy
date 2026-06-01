function scr_save_campaign_progress(){
	
	if (!instance_exists(oCampaignManager) || !instance_exists(oGame)) return false;
	if (!instance_exists(oGame)) return false;
	
	var save_data = ds_map_create();
	
	//version
	ds_map_add(save_data, "version", SAVE_VERSION);
	ds_map_add(save_data, "save_data", date_datetime_string(date_current_datetime()));
	
	//camp progress
	ds_map_add(save_data, "current_mission", oCampaignManager.current_mission);
	ds_map_add(save_data, "total_mission_completed", oCampaignManager.total_mission_completed);
	ds_map_add(save_data, "campaign_total_time", oCampaignManager.campaign_total_time);
	
	//mission completion
	var mission_completion_list = ds_list_create();
	
	for (var i = 0; i <  MissionID.COUNT; i++) {
		ds_list_add(mission_completion_list, oCampaignManager.mission_completed[i] ? 1 : 0);
	}
	ds_map_add_list(save_data, "mission_completed", mission_completion_list);
	
	//mission best times
	var mission_times_list = ds_list_create();
	for (var i = 0; i < MissionID.COUNT; i++) {
		ds_list_add(mission_times_list, oCampaignManager.mission_best_time[i]);
	}
	ds_map_add_list(save_data, "mission_best_time", mission_times_list);
	
	//skill tree progress
	ds_map_add(save_data, "skill_points_available", oGame.skill_points_available);
	ds_map_add(save_data, "skill_points_total", oGame.skill_points_total);
	
	var skills_unlocked_list = ds_list_create();
	for (var i = 0; i < SKILL_COUNT; i++) {
		ds_list_add(skills_unlocked_list, oGame.skill_unlocked[i] ? 1 : 0);
	}
	ds_map_add_list(save_data, "skills_unlocked", skills_unlocked_list);
	
	//settings
	ds_map_add(save_data, "opt_master_vol", oGame.opt_master_vol);
	ds_map_add(save_data, "opt_music_vol", oGame.opt_music_vol);
	ds_map_add(save_data, "opt_sfx_vol", oGame.opt_sfx_vol);
	ds_map_add(save_data, "opt_fullscreen", oGame.opt_fullscreen);
	ds_map_add(save_data, "opt_show_fps", oGame.opt_show_fps);
	ds_map_add(save_data, "opt_player_name", oGame.opt_player_name);
	
	//convert to json and save
	var json_string = json_encode(save_data);
	var file = file_text_open_write(working_directory + SAVE_FILE_NAME);
	file_text_write_string(file, json_string);
	file_text_close(file);
	
	//cleanup
	ds_map_destroy(save_data);
	
	show_debug_message("progress savd");
	return true;
}

function scr_load_campaign_progress(){
	var filepath = working_directory + SAVE_FILE_NAME;
	
	if (!file_exists(filepath)) {
		show_debug_message("No save");
		return false;
	}
	
	var file = file_text_open_read(filepath);
	var json_string = file_text_read_string(file);
	file_text_close(file);
	
	var save_data= json_decode(json_string);
	
	if (!ds_exists(save_data, ds_type_map)) {
		show_debug_message("invalid format");
		return false;
	}
	
	//cehck version
	var save_version = ds_map_find_value(save_data, "version");
	if (save_version != SAVE_VERSION) {
		show_debug_message("file version mismatch");
		ds_map_destroy(save_data);
		return false;
	}
	
	//load camp progress
	if (instance_exists(oCampaignManager)) {
		oCampaignManager.current_mission = ds_map_find_value(save_data, "current_mission");
		oCampaignManager.total_mission_completed = ds_map_find_value(save_data, "total_missions_completed");
		oCampaignManager.campaign_total_time = ds_map_find_value(save_data, "campaign_total_timer");
		
		//mission completion
		var mission_completion_list = ds_map_find_value(save_data, "mission_completed");
		for (var i = 0; i < min(ds_list_size(mission_completion_list), MissionID.COUNT); i++) {
			oCampaignManager.mission_completed[i] = (ds_list_find_value(mission_completion_list, i) == 1);
		}
		
		//mission times
		var mission_times_list = ds_map_find_value(save_data, "mission_best_time");
		for (var i = 0; i < min(ds_list_size(mission_times_list), MissionID.COUNT); i++) {
			oCampaignManager.mission_best_time[i] = ds_list_find_value(mission_times_list, i);
		}
	}
	
	//load skill tree
	if (instance_exists(oGame)) {
		oGame.skill_points_available = ds_map_find_value(save_data, "skill_points_available");
		oGame.skill_points_total = ds_map_find_value(save_data, "skill_points_total");
		
		var skills_unlocked_list = ds_map_find_value(save_data, "skills_unlocked");
		for (var i = 0; i < min(ds_list_size(skills_unlocked_list), SKILL_COUNT); i++) {
			oGame.skill_unlocked[i] = (ds_list_find_value(skills_unlocked_list, i) == 1);
		}
		
		//load settings
		oGame.opt_master_vol = ds_map_find_value(save_data, "opt_master_vol");
        oGame.opt_music_vol = ds_map_find_value(save_data, "opt_music_vol");
        oGame.opt_sfx_vol = ds_map_find_value(save_data, "opt_sfx_vol");
        oGame.opt_fullscreen = ds_map_find_value(save_data, "opt_fullscreen");
        oGame.opt_show_fps = ds_map_find_value(save_data, "opt_show_fps");
        oGame.opt_player_name = ds_map_find_value(save_data, "opt_player_name");
		
		//apply settings
		window_set_fullscreen(oGame.opt_fullscreen);
		audio_master_gain(oGame.opt_master_vol);
	}
	
	//cleanup
	ds_map_destroy(save_data);
	
	show_debug_message("camp loaded");
	return true;
}

function scr_delete_save_file() {
	var filepath = working_directory + SAVE_FILE_NAME;
	if (file_exists(filepath)) {
		file_delete(filepath);
		show_debug_message("file deleted");
		return true;
	}
	return false;
}

function scr_quick_save() {
	if (instance_exists(oCampaignManager) && instance_exists(oGame)) {
		//update time played
		if (oCampaignManager.mission_state == CampaignState.IN_PROGRESS) {
			oCampaignManager.campaign_total_time += delta_time / 1000000; //convert to seconds
		}
		return scr_save_campaign_progress();
	}
	return false;
}

function scr_autosave_after_mission() {
	return scr_save_campaign_progress();
}