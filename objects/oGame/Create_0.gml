// oGame - Create Event (UI SEPARATED - Only Game Logic)

//------------------------------------- 
game_state = GameState.PLAYING;
player_base = noone;
enemy_base = noone;
lane_count = 3;

//-------------------------------------------------- 
// unattended lane logic
lane_unattended_time = array_create(lane_count, 0);
lane_buff_level = array_create(lane_count, 0);
buff_threshold_1 = 8;
buff_threshold_2 = 13;
buff_threshold_1_steps = buff_threshold_1 * TARGET_FPS;
buff_threshold_2_steps = buff_threshold_2 * TARGET_FPS;
alarm[0] = TARGET_FPS;

//-------------------------------------------------- 
// ECONOMY
gold = 500;
gold_per_second = 30;
gold_per_step = gold_per_second / TARGET_FPS;

cpu_gold = 500;
cpu_gold_multi = 1.1;
cpu_gold_per_step = (gold_per_second * cpu_gold_multi) / TARGET_FPS;

//-------------------------------------------------- 
// UNIT/TURRET DATA (accessed by UI)
// Unit selection
selected_type = 0;
unit_count = 5;

unit_type = array_create(unit_count, 0);
unit_cost = array_create(unit_count, 0);
unit_name = array_create(unit_count, "");
unit_hp = array_create(unit_count, 0);
unit_dmg = array_create(unit_count, 0);
unit_spd = array_create(unit_count, 0);
unit_rng = array_create(unit_count, 0);

unit_type[0] = 0; unit_cost[0] = 75; unit_name[0] = "Basic";
unit_type[1] = 1; unit_cost[1] = 120; unit_name[1] = "Ranged";
unit_type[2] = 2; unit_cost[2] = 250; unit_name[2] = "H. Melee";
unit_type[3] = 3; unit_cost[3] = 220; unit_name[3] = "H. Ranged";
unit_type[4] = 4; unit_cost[4] = 375; unit_name[4] = "Elite";

// temp stats
unit_hp[0] = 100; unit_dmg[0] = 10; unit_spd[0] = 15; unit_rng[0] = 40;
unit_hp[1] = 800; unit_dmg[1] = 8;  unit_spd[1] = 14; unit_rng[1] = 140;
unit_hp[2] = 170; unit_dmg[2] = 18; unit_spd[2] = 11; unit_rng[2] = 40;
unit_hp[3] = 130; unit_dmg[3] = 16; unit_spd[3] = 10; unit_rng[3] = 170;
unit_hp[4] = 260; unit_dmg[4] = 30; unit_spd[4] = 12; unit_rng[4] = 60;

// Turrets
turret_count = 4;
turret_type = array_create(turret_count, 0);
turret_cost = array_create(turret_count, 0);
turret_name = array_create(turret_count, "");
turret_unlocked = array_create(turret_count, false);

turret_type[0] = 0; turret_cost[0] = 150; turret_name[0] = "MG Turret";
turret_type[1] = 1; turret_cost[1] = 250; turret_name[1] = "Cannon";
turret_type[2] = 2; turret_cost[2] = 300; turret_name[2] = "Flak";
turret_type[3] = 3; turret_cost[3] = 400; turret_name[3] = "Laser";

// TEMP unlocks
turret_unlocked[0] = true;
turret_unlocked[1] = false;
turret_unlocked[2] = false;
turret_unlocked[3] = false;

selected_turret = turret_type[0];

// Build mode (accessed by UI)
build_tab = BuildTab.UNITS;

//-------------------------------------------------- 
player_unit_count = 0;
// SPECIAL ABILITY
ui_special_ready = true;
special_cd_steps = TARGET_FPS * 30; //30 sec
special_cd_left = 0;
active_special = SpecialID.ROCKS;
// SPECIAL ABILITY ENEMY
enemy_special_cd_steps = 0; 
enemy_special_cd_left = 0;
//-------------------------------------------------- 
// LANE POSITIONS (for UI lane preview)
var battlefield_h = room_height - 190; // ui_bar_h
lane_y = array_create(lane_count, 0);
var lane_top_margin = 120;
var lane_bottom_margin = 120;
var battlefield_top = lane_top_margin;
var battlefield_bottom = battlefield_h - lane_bottom_margin;

lane_y[0] = lerp(battlefield_top, battlefield_bottom, 0.18);
lane_y[1] = lerp(battlefield_top, battlefield_bottom, 0.50);
lane_y[2] = lerp(battlefield_top, battlefield_bottom, 0.82);

//-------------------------------------------------- 
// CPU spawn timers
cpu_spawn_time = 0;
cpu_spawn_interval = TARGET_FPS * 2;

enemy_spawn_timer = 0;
enemy_spawn_interval = TARGET_FPS * 2;

//--------------------------------- 
// Pause/Menu system
global.game_paused = false;
global.ui_menu_open = false;

//--------------------------------- 
// Settings (accessed by oMenuPause)
opt_fullscreen = window_get_fullscreen();
opt_master_vol = 1.00;
opt_music_vol = 1.00;
opt_sfx_vol = 1.00;
opt_show_fps = false;
opt_player_name = "Player";



// SKILL TREE SYSTEM
// Add this to oGame Create Event (at the end)

//-------------------------------------------------- 
// SKILL TREE DATA
skill_points_available = SKILL_POINTS_START; // Start with 1 free point
skill_points_total = SKILL_POINTS_START; // Track total earned

// Skill unlock status (true = unlocked)
skill_unlocked = array_create(SKILL_COUNT, false);

// Skill definitions (name, description, branch)
skill_name = array_create(SKILL_COUNT, "");
skill_desc = array_create(SKILL_COUNT, "");
skill_branch = array_create(SKILL_COUNT, 0);

// MELEE BRANCH (0-4)
skill_name[SkillID.M1] = "Melee Armor I";
skill_desc[SkillID.M1] = "+10% HP for melee units";
skill_branch[SkillID.M1] = SkillBranch.MELEE;

skill_name[SkillID.M2] = "Melee Armor II";
skill_desc[SkillID.M2] = "+20% HP for melee units";
skill_branch[SkillID.M2] = SkillBranch.MELEE;

skill_name[SkillID.M3] = "Melee Armor III";
skill_desc[SkillID.M3] = "+30% HP for melee units";
skill_branch[SkillID.M3] = SkillBranch.MELEE;

skill_name[SkillID.M4] = "Melee Damage I";
skill_desc[SkillID.M4] = "+15% damage for melee";
skill_branch[SkillID.M4] = SkillBranch.MELEE;

skill_name[SkillID.M5] = "Melee Damage II";
skill_desc[SkillID.M5] = "+30% damage for melee";
skill_branch[SkillID.M5] = SkillBranch.MELEE;

// RANGED BRANCH (5-9)
skill_name[SkillID.R1] = "Ranged Range I";
skill_desc[SkillID.R1] = "+15% range for ranged units";
skill_branch[SkillID.R1] = SkillBranch.RANGED;

skill_name[SkillID.R2] = "Ranged Range II";
skill_desc[SkillID.R2] = "+30% range for ranged units";
skill_branch[SkillID.R2] = SkillBranch.RANGED;

skill_name[SkillID.R3] = "Ranged Range III";
skill_desc[SkillID.R3] = "+45% range for ranged units";
skill_branch[SkillID.R3] = SkillBranch.RANGED;

skill_name[SkillID.R4] = "Ranged Speed I";
skill_desc[SkillID.R4] = "+10% move speed for ranged";
skill_branch[SkillID.R4] = SkillBranch.RANGED;

skill_name[SkillID.R5] = "Ranged Speed II";
skill_desc[SkillID.R5] = "+20% move speed for ranged";
skill_branch[SkillID.R5] = SkillBranch.RANGED;

// ELITE BRANCH (10-13) - Requires all melee + ranged complete
skill_name[SkillID.E1] = "Elite HP Boost";
skill_desc[SkillID.E1] = "+25% HP for elite units";
skill_branch[SkillID.E1] = SkillBranch.ELITE;

skill_name[SkillID.E2] = "Elite Damage Boost";
skill_desc[SkillID.E2] = "+25% damage for elite";
skill_branch[SkillID.E2] = SkillBranch.ELITE;

skill_name[SkillID.E3] = "Elite Speed Boost";
skill_desc[SkillID.E3] = "+15% speed for elite";
skill_branch[SkillID.E3] = SkillBranch.ELITE;

skill_name[SkillID.E4] = "Elite Master";
skill_desc[SkillID.E4] = "Elite units cost -25%";
skill_branch[SkillID.E4] = SkillBranch.ELITE;
//--------------------------------- 
// Window setup
window_set_size(1920, 1080);
surface_resize(application_surface, 1920, 1080);
display_set_gui_size(1920, 1080);

//-------------
//post mission stats
stat_enemies_killed = 0;
stat_units_deployed = 0;
stat_units_lost = 0;
stat_specials_used = 0;
stat_mission_timer = 0;


//post mission stats enemy
stat_e_unit_deployed = 0;