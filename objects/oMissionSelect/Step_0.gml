pulse_t += 0.04;

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//confirm dialog blaock all input undernertath
if (confirm_open) {
	var btn_w = 150;
	var btn_h = 44;
	var yes_x1 = confirm_x + confirm_w * 0.5 - 18 - btn_w;
	var yes_y1 = confirm_y + confirm_h - btn_h - 22;
	var yes_x2 = yes_x1 + btn_w;
	var yes_y2 = yes_y1 + btn_h;
	var no_x1 = confirm_x + confirm_w * 0.5 + 18;
	var no_y1 = yes_y1;
	var no_x2 = no_x1 + btn_w;
	var no_y2 = yes_y2;
	
	if (mouse_check_button_pressed(mb_left)) {
		if (point_in_rectangle(mx, my, yes_x1, yes_y1, yes_x2, yes_y2)) {
			if (instance_exists(oCampaignManager)) {
				
				var special_unlock = scr_get_mission_config(confirm_mission).player_unlock;
				if (special_unlock >= 0) {
					oCampaignManager.special_unlocked[special_unlock] = true;
				}
				oCampaignManager.current_mission = confirm_mission;
				oCampaignManager.mission_state = CampaignState.IN_PROGRESS;
				oCampaignManager.mission_config = scr_get_mission_config(confirm_mission);
				oCampaignManager.mission_timer = 0;
			}
			room_goto(rm_main);
			exit;
		}
		if (point_in_rectangle(mx, my, no_x1, no_y1, no_x2, no_y2)) {
			confirm_open = false;
			confirm_mission = -1;
		}
	}
	
	if (keyboard_check_pressed(vk_escape)) {
		confirm_open = false;
		confirm_mission = -1;
	}
	exit;
}
				
if (keyboard_check_pressed(vk_escape)) {
	room_goto(rm_mainMenu);
	exit;
}

//Dev skip buttons remove after
if (mouse_check_button_pressed(mb_left)) {
	for (var i = 0; i < MissionID.COUNT; i++) {
		var bx1 = dev_btn_x;
		var by1 = dev_btn_y_start + i * (dev_btn_h + 4);
		if (point_in_rectangle(mx, my, bx1, by1, bx1 + dev_btn_w, by1 + dev_btn_h)) {
			scr_dev_complete_mission(i);
			exit;
		}
	}
}


//mission lock
selected_mission = current_map_mission;

// Upgrade panel scroll
if (point_in_rectangle(mx, my, upgrade_x, upgrade_y, upgrade_x + upgrade_w, upgrade_y + upgrade_h)) {
    if (mouse_wheel_up())   upgrade_scroll = max(0, upgrade_scroll - 30);
    if (mouse_wheel_down()) upgrade_scroll = min(upgrade_scroll + 30, max(0, SKILL_COUNT * 50 - upgrade_h + 120));
}

// Upgrade slot clicks
if (instance_exists(oGame) && mouse_check_button_pressed(mb_left)) {
    var slot_x1  = upgrade_x + 12;
    var slot_h   = 44;
    var slot_gap = 6;
    var list_top = upgrade_y + 120;
    var list_bot = upgrade_y + upgrade_h - 10;

    for (var i = 0; i < SKILL_COUNT; i++) {
        var sy1 = list_top + i * (slot_h + slot_gap) - upgrade_scroll;
        var sy2 = sy1 + slot_h;
        if (sy1 < list_top - 5 || sy2 > list_bot + 5) continue;
        if (point_in_rectangle(mx, my, slot_x1, sy1, upgrade_x + upgrade_w - 12, sy2)) {
            if (scr_can_unlock_skill(i)) {
                scr_unlock_skill(i);
            }
        }
    }
}

// LAUNCH BATTLE button
var launch_x1 = command_x + 20;
var launch_y1 = command_y + 75;
var launch_x2 = command_x + command_w - 20;
var launch_y2 = launch_y1 + 76;

if (mouse_check_button_pressed(mb_left)
    && point_in_rectangle(mx, my, launch_x1, launch_y1, launch_x2, launch_y2)) {
    var st = scr_get_mission_status(selected_mission);
    if (st == "AVAILABLE" || st == "COMPLETE") {
        confirm_open    = true;
        confirm_mission = selected_mission;
    }
}

// MAIN MENU button
var menu_x1 = command_x + 20;
var menu_y1 = command_y + command_h - 62;
var menu_x2 = command_x + command_w - 20;
var menu_y2 = menu_y1 + 44;

if (mouse_check_button_pressed(mb_left)
    && point_in_rectangle(mx, my, menu_x1, menu_y1, menu_x2, menu_y2)) {
    room_goto(rm_mainMenu);
}

//determine 1st mssion
current_map_mission = 0;
for (var i = 0; i < MissionID.COUNT; i++) {
	if (instance_exists(oCampaignManager) && !oCampaignManager.mission_completed[i]) {
	current_map_mission = i;
	break;
	}
}
