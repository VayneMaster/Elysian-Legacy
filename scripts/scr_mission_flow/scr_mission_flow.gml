//remove after testing!!!!!!!!!
//Skips mission to jump to cutscene!!!

function scr_dev_complete_mission(_mission_id){
	
	if (!instance_exists(oCampaignManager)) {
		show_debug_message("[dev] no ocampmanager");
		return;
	}
	for (var i = 0; i <= _mission_id; i++) {
		oCampaignManager.mission_completed[i] = true;
		if (oCampaignManager.mission_best_time[i] < 0) {
			oCampaignManager.mission_best_time[i] = 90 + irandom(60);
		}
	}
	
	oCampaignManager.total_skill_points_earned += scr_get_mission_config(_mission_id).skill_points_reward;
	oCampaignManager.current_mission = _mission_id;
	
	var cfg = scr_get_mission_config(_mission_id);
	var next_cs = cfg.next_cutscene;
	
	show_debug_message("Dev completed mission " + string(_mission_id) + " | next cutscene: " + string(next_cs));
	
	if (next_cs >= 0 && next_cs < CutsceneID.COUNT) {
		scr_play_cutscene(next_cs);
	} else {
		show_debug_message("dev No cutscene after mission");
	}
}

//calls when player
function scr_on_mission_complete() {
	if (!instance_exists(oCampaignManager)) return;
	
	var mid = oCampaignManage.current_mission;
	if (mid < 0 || mid >= MissionID.COUNT) return;
	
	var cfg = scr_get_mission_config(mid);
	
	oCampaignManager.mission_completed[mid] = true;
	oCampaignManager.mission_state = CampaignState.MISSION_COMPLETE;
	
	var elapsed = oCampaignManager.mission_timer / TARGET_FPS;
	if (oCampaignManager.mission_best_time[mid] < 0
	|| elapsed < oCampaignManager.mission_best_time[mid]) {
		oCampaignManager.mission_best_time[mid] = elapsed;
	}
	
	oCampaignManager.total_skill_points_earned += cfg.skill_points_reward;
	
	show_debug_message("Mission complete: " + cfg.name + " | nxt cutscene: " + string(cfg.next_cutscene));
	
	if (cfg.next_cutscene >= 0 && cfg.next_cutscene < CutsceneID.COUNT) {
		scr_play_cutscene(cfg.next_cutscene);
	} else {
		oCampaignManager.mission_state = CampaignState.NOT_STARTED;
		room_goto(rm_missionSelect);
	}
}
