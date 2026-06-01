// oTitleScreen - Step Event

pulse_timer += 0.05;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Keyboard navigation
if (keyboard_check_pressed(vk_up)) {
    menu_index--;
    if (menu_index < 0) menu_index = menu_count - 1;
	//skip continue if no save
	if (menu_index == 1 && !has_save_file) menu_index = 2;
}

if (keyboard_check_pressed(vk_down)) {
    menu_index++;
    if (menu_index >= menu_count) menu_index = 0;
	//skip continie if no save
	if (menu_index == 1 && !has_save_file) menu_index = 2;
}

// Mouse hover detection
for (var i = 0; i < menu_count; i++) {
	
	//skip disbaled continue button
	if (i == 1 && !has_save_file) continue;
	
    if (point_in_rectangle(mx, my, button_x1[i], button_y1[i], button_x2[i], button_y2[i])) {
        menu_index = i;
        break;
    }
}

// Selection (Enter or Mouse Click)
var select_pressed = keyboard_check_pressed(vk_enter) || 
                     (mouse_check_button_pressed(mb_left) && 
                      point_in_rectangle(mx, my, button_x1[menu_index], button_y1[menu_index], 
                                         button_x2[menu_index], button_y2[menu_index]));

if (select_pressed) {
    switch (menu_index) {
        case 0: // START NEW GAME
            // Delete existing save and start fresh
            scr_delete_save_file();
            
            // Reset campaign manager
            if (instance_exists(oCampaignManager)) {
                for (var i = 0; i < MissionID.COUNT; i++) {
                    oCampaignManager.mission_completed[i] = false;
                    oCampaignManager.mission_best_time[i] = -1;
                }
                oCampaignManager.total_missions_completed = 0;
                oCampaignManager.current_mission = -1;
            }
            
            // Reset skill tree in oGame (if it exists)
            if (instance_exists(oGame)) {
                scr_reset_skill_tree();
            }
            
            // Play intro cutscene
            scr_play_cutscene(CutsceneID.INTRO);
            break;
            
        case 1: // CONTINUE CAMPAIGN
            if (has_save_file) {
                // Load is already done in oCampaignManager create
                // Just go to mission select
                room_goto(rm_main);
            }
            break;
            
        case 2: // OPTIONS
            if (!instance_exists(oTitleMenu)) {
                var menu = instance_create_depth(0, 0, -9999, oTitleMenu);
                menu.title_page = TitlePage.OPTIONS;
            }
            break;
            
        case 3: // INFO
            if (!instance_exists(oTitleMenu)) {
                var menu = instance_create_depth(0, 0, -9999, oTitleMenu);
                menu.title_page = TitlePage.INFO;
            }
            break;
            
        case 4: // QUIT TO DESKTOP
            game_end();
            break;
    }
}

// ESC to quit
if (keyboard_check_pressed(vk_escape)) {
    game_end();
}