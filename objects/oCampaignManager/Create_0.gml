persistent = true;
//current mission
current_mission = -1; //-1 = none
mission_state = CampaignState.NOT_STARTED;

//tracking
mission_completed = array_create(MissionID.COUNT, false);
mission_best_time = array_create(MissionID.COUNT, -1);

//campaign stats
total_skill_points_earned = SKILL_POINTS_START;
total_mission_completed = 0;
campaign_start_time = 0;
campaign_total_time = 0;

//mission timer
mission_timer = 0;
mission_duration_steps = 0;

//current mission config (cache)
mission_config = {};

//if exist load save
scr_load_campaign_progress();

show_debug_message("ocampaignmanager created - campaign rdy");