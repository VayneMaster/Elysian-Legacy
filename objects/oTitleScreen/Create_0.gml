// oTitleScreen - Create Event

// GUI dimensions
gui_w = display_get_gui_width();
gui_h = display_get_gui_height();

// Menu state
menu_index = 0;
menu_count = 5; // Start, Continue, Options, Info, Quit

// Menu items
menu_text = array_create(menu_count, "");
menu_text[0] = "START NEW GAME";
menu_text[1] = "CONTINUE CAMPAIGN";
menu_text[2] = "OPTIONS";
menu_text[3] = "INFO";
menu_text[4] = "QUIT TO DESKTOP";

// Menu button dimensions
button_w = 400;
button_h = 70;
button_gap = 20;

// Calculate menu position (centered vertically in lower half)
var total_height = (button_h * menu_count) + (button_gap * (menu_count - 1));
menu_start_x = (gui_w - button_w) * 0.5;
menu_start_y = gui_h * 0.52; // Adjusted to 52% to work with background image

// Calculate individual button positions
button_x1 = array_create(menu_count, 0);
button_y1 = array_create(menu_count, 0);
button_x2 = array_create(menu_count, 0);
button_y2 = array_create(menu_count, 0);

for (var i = 0; i < menu_count; i++) {
    button_x1[i] = menu_start_x;
    button_y1[i] = menu_start_y + i * (button_h + button_gap);
    button_x2[i] = button_x1[i] + button_w;
    button_y2[i] = button_y1[i] + button_h;
}

// Animation
pulse_timer = 0;

// Check for save file (for continue button)
has_save_file = false;
//create camp manager if doesnt exist
if (!instance_exists(oCampaignManager)) {
	instance_create_depth(0, 0, 0, oCampaignManager);
}