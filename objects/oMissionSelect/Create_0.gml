gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

//layout (4 pnl)

right_col_x = gui_w - 380;
right_col_w = 360;

map_x = 30;
map_y = 30;
map_w = right_col_x - 60;
map_h = gui_h - 220;

brief_x = 30;
brief_y = map_y + map_h + 20;
brief_w = map_w;
brief_h = gui_h - brief_y - 30;

upgrade_x = right_col_x;
upgrade_y = 30;
upgrade_w = right_col_w;
upgrade_h = 320;

command_x = right_col_x;
command_y = upgrade_y + upgrade_h + 20;
command_w = right_col_w;
command_h = gui_h - command_y - 30;

//Timeline nodes (missions) - 6 nodes
var usable_w = map_w -160;
var y_offsets = [-60, 20, -30, 50, -20, 10]; //change if not alligned properly

node_x = array_create(MissionID.COUNT, 0);
node_y = array_create(MissionID.COUNT, 0);
node_r = 28;

for (var i = 0; i < MissionID.COUNT; i++) {
	node_x[i] = map_x + 80 + (i / (MissionID.COUNT - 1)) * usable_w;
	node_y[i] = map_y + map_h * 0.5 + y_offsets[i];
}


//interaction
selected_mission = 0;
hovered_node = -1;
current_map_mission = 0;
//upgrade scroll
upgrade_scroll = 0;

//confirm dialo
confirm_open = false;
confirm_mission = -1;
confirm_w = 560;
confirm_h = 280;
confirm_x = (gui_w - confirm_w) * 0.5;
confirm_y = (gui_h - confirm_h) * 0.5;

//Amimation
pulse_t = 0;

//Development remove after (buttons/btm left)
dev_btn_w = 250;
dev_btn_h = 32;
dev_btn_x = 10;
dev_btn_y_start = gui_h - (MissionID.COUNT * (dev_btn_h + 4)) - 30;

if (!instance_exists(oCampaignManager)) {
	instance_create_depth(0, 0, 0, oCampaignManager);
}

//auto select first availabnle mission
for (var i = 0; i < MissionID.COUNT; i++) {
	if (scr_get_mission_status(i) == "AVAILABLE") {
		selected_mission = i;
		break;
	}
}

show_debug_message("oMissionSelect created");