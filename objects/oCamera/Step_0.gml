// oCamera - Step Event

// Block camera movement while paused/menu open
if (global.game_paused || instance_exists(oMenuPause)) {
    exit;
}

// Mouse in GUI space
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Only scroll if mouse is inside the battlefield viewport area (top)
var in_battlefield = (my >= 0 && my < global.CAM_H);
var edge = 40;
var scroll_speed = 18;

if (in_battlefield) {
    if (mx <= edge) camera_target_x -= scroll_speed;
    if (mx >= global.CAM_W - edge) camera_target_x += scroll_speed;
    
    // Optional keyboard scrolling
    if (keyboard_check(vk_left) || keyboard_check(ord("A"))) camera_target_x -= scroll_speed;
    if (keyboard_check(vk_right) || keyboard_check(ord("D"))) camera_target_x += scroll_speed;
}

// Clamp target to room bounds
camera_target_x = clamp(camera_target_x, 0, room_width - global.CAM_W);

// Smooth + apply
camera_x = lerp(camera_x, camera_target_x, 0.15);
camera_set_view_pos(cam, camera_x, camera_y);