// oCamera - Create Event (FIXED)

// Initialize globals if not already set (prevents errors if oCamera runs before oGame)
if (!variable_global_exists("game_paused")) {
    global.game_paused = false;
}
if (!variable_global_exists("ui_menu_open")) {
    global.ui_menu_open = false;
}

global.UI_BAR_H = 190;

// Camera state
camera_x = 0;
camera_y = 0;
camera_target_x = 0;

switch (global.camera_setup) {
    case CameraSetup.TITLE:
        global.CAM_W = 1536;
        global.CAM_H = 1024;
        camera_x = (room_width - global.CAM_W) * 0.5;
        camera_y = (room_height - global.CAM_H) * 0.5;
        camera_target_x = camera_x;
        break;
    
    case CameraSetup.BATTLEFIELD:
    default:
        global.CAM_W = 1920;
        global.CAM_H = room_height - global.UI_BAR_H;
        camera_x = 0;
        camera_y = 0;
        camera_target_x = 0;
        break;
}



// Create camera and assign to view[0]
cam = camera_create_view(camera_x, camera_y, global.CAM_W, global.CAM_H, 0, noone, -1, -1, -1, -1);
view_enabled = true;
view_visible[0] = true;
view_camera[0] = cam;

show_debug_message("cam id = " + string(cam));
show_debug_message("view[0] camera = " + string(view_camera[0]));

// Viewport: draw the battlefield camera into the TOP part of the window
camera_set_view_size(cam, global.CAM_W, global.CAM_H);
camera_set_view_pos(cam, camera_x, camera_y);
view_set_wport(0, global.CAM_W);
view_set_hport(0, global.CAM_H);