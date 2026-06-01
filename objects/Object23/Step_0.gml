if (mouse_check_button_pressed(mb_left)) {
	global.camera_setup = CameraSetup.BATTLEFIELD;
	room_goto(rm_main);
}