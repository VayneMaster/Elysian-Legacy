// oGame - Step Event (UI SEPARATED - Only Game Logic)

// PAUSE MENU
if (keyboard_check_pressed(vk_escape) && !instance_exists(oMenuPause)) {
    instance_create_depth(0, 0, -9999, oMenuPause);
}

if (keyboard_check_pressed(ord("P")) && !instance_exists(oMenuPause)) {
    var menu = instance_create_depth(0, 0, -9999, oMenuPause);
    menu.pause_page = PausePage.CONFIRM_RESTART;
}

// Block gameplay while paused
if (global.game_paused || instance_exists(oMenuPause)) {
    exit;
}

// --------------------------------- 
// Lane unattended tracking
for (var i = 0; i < lane_count; i++) {
    var player_on_lane = false;
    var enemy_on_lane = false;
    
    with (oUnit_player) {
        if (lane_index == i) player_on_lane = true;
    }
    with (oUnit_enemy) {
        if (lane_index == i) enemy_on_lane = true;
    }
    
    if (enemy_on_lane && !player_on_lane) {
        lane_unattended_time[i]++;
        if (lane_unattended_time[i] >= buff_threshold_2_steps)
            lane_buff_level[i] = 2;
        else if (lane_unattended_time[i] >= buff_threshold_1_steps)
            lane_buff_level[i] = 1;
        else
            lane_buff_level[i] = 0;
    } else {
        lane_unattended_time[i] = 0;
        lane_buff_level[i] = 0;
    }
}

// --------------------------------- 
// Passive gold
if (game_state == GameState.PLAYING) {
    gold += gold_per_step;
}

//------------
//mission timer (stat pnl)
if (game_state == GameState.PLAYING) {
	stat_mission_timer++;
}

// --------------------------------- 
// Special ability cooldown
if (special_cd_left > 0) {
    special_cd_left--;
    if (special_cd_left <= 0) {
        special_cd_left = 0;
        ui_special_ready = true;
    }
}

//count player units
player_unit_count = 0;
with (oParent_unit) {
    if (team == Team.PLAYER) {
        oGame.player_unit_count++;
    }
}

//enemy spec fire when "worthwile"
if (enemy_special_cd_left <= 0 && player_unit_count >= 3 && game_state == GameState.PLAYING) {
	var enemy_spc = scr_get_special_config(oCampaignManager.mission_config.cpu_special);
	var enemy_dmg = enemy_spc.damage;
	enemy_special_cd_left = enemy_spc.cooldown * TARGET_FPS;
	stat_enemy_specials_used++;
	with (oParent_unit) {
		if (team == Team.PLAYER) {
			last_hit_team = Team.ENEMY;
			hp -= enemy_dmg;
		}
	}
}
//enemy spec abil
if (enemy_special_cd_left > 0) {
	enemy_special_cd_left--;
}


// Trigger special (Space key)
if (keyboard_check_pressed(vk_space) && ui_special_ready && game_state == GameState.PLAYING) {
    var spc = scr_get_special_config(active_special);
	var dmg = spc.damage
	
	ui_special_ready = false;
	special_cd_left = spc.cooldown * TARGET_FPS;
	stat_specials_used++;
	
	with (oParent_unit) {
		if (team == Team.ENEMY) {
			last_hit_team = Team.PLAYER;
			hp -= dmg;
		}
	}
}

// --------------------------------- 
// Unit hotkeys (Q/W/E/R/T)
if (keyboard_check_pressed(ord("Q"))) selected_type = 0;
if (keyboard_check_pressed(ord("W"))) selected_type = 1;
if (keyboard_check_pressed(ord("E"))) selected_type = 2;
if (keyboard_check_pressed(ord("R"))) selected_type = 3;
if (keyboard_check_pressed(ord("T"))) selected_type = 4;

// --------------------------------- 
// Enemy spawn timer
if (game_state == GameState.PLAYING) {
    enemy_spawn_timer++;
    if (enemy_spawn_timer >= enemy_spawn_interval) {
        enemy_spawn_timer = 0;
        var lane = irandom(lane_count - 1);
        var lane_y_pos = lane_y[lane];
        var u = instance_create_layer(room_width - 200, lane_y_pos, "Instances", oUnit_enemy);
        u.lane_index = lane;
        u.y = lane_y_pos;
    }
}

// --------------------------------- 
// Victory/defeat checks
if (game_state == GameState.PLAYING) {
    if (instance_exists(player_base) && player_base.hp <= 0) {
        game_state = GameState.DEFEAT;
		var result = instance_create_depth(0,0, -15000, oMissionResult);
		result.victory = false;
		} else if (instance_exists(enemy_base) && enemy_base.hp <= 0) {
        game_state = GameState.VICTORY;
		var result = instance_create_depth(0,0, -15000, oMissionResult)
		result.victory = true;
	}
}

// --------------------------------- 
// CPU AI spawn
if (game_state == GameState.PLAYING) {
    cpu_spawn_time++;
    if (cpu_spawn_time >= cpu_spawn_interval) {
        cpu_spawn_time = 0;
        
        var best_lane = 0;
        for (var i = 1; i < lane_count; i++) {
            if (lane_buff_level[i] > lane_buff_level[best_lane])
                best_lane = i;
        }
        
        if (lane_buff_level[0] == lane_buff_level[1] && lane_buff_level[1] == lane_buff_level[2]) {
            best_lane = irandom(lane_count - 1);
        }
        
        var roll = irandom(99);
        var spawn_type;
        if (roll < 50) spawn_type = 0;
        else if (roll < 75) spawn_type = 1;
        else if (roll < 90) spawn_type = 2;
        else if (roll < 98) spawn_type = 3;
        else spawn_type = 4;
        
        scr_spawn_cpu_unit(best_lane, spawn_type);
    }
}

//----------------------------- DEV BUTTONS
if (keyboard_check_pressed(vk_f1)) {
    // Unlock all melee
    for (var i = SkillID.M1; i <= SkillID.M5; i++) {
        skill_unlocked[i] = true;
    }
}

if (keyboard_check_pressed(vk_f2)) {
    // Give 10 skill points
    scr_award_skill_points(10);
}

if (keyboard_check_pressed(vk_f3)) {
    // Show Basic unit stats
    var s = scr_get_unit_stats_with_masteries(0);
    show_debug_message("HP: " + string(s.hp) + " DMG: " + string(s.dmg));
}

if (keyboard_check_pressed(vk_f4) && !instance_exists(oMissionResult)) {
    game_state = GameState.VICTORY;
    var result = instance_create_depth(0, 0, -15000, oMissionResult);
    result.victory = true;
}
if (keyboard_check_pressed(vk_f5) && !instance_exists(oMissionResult)) {
    game_state = GameState.DEFEAT;
    var result = instance_create_depth(0, 0, -15000, oMissionResult);
    result.victory = false;
}

//--------------------- END OF DEV BUTTONS

// Track mastery changes for UI update
if (!variable_instance_exists(id, "last_mastery_state")) {
    last_mastery_state = array_create(SKILL_COUNT, false);
    array_copy(last_mastery_state, 0, skill_unlocked, 0, SKILL_COUNT);
}

// Check if any mastery changed
var mastery_changed = false;
for (var i = 0; i < SKILL_COUNT; i++) {
    if (skill_unlocked[i] != last_mastery_state[i]) {
        mastery_changed = true;
        last_mastery_state[i] = skill_unlocked[i];
    }
}

// Show notification when masteries change
if (mastery_changed) {
    show_debug_message("✓ Mastery unlocked - stats updated!");
}