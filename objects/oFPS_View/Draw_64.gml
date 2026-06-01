// oFPS.Draw_GUI
if (!opt_show_fps || global.ui_menu_open) exit;

draw_text(16, 16, string(fps_real));
