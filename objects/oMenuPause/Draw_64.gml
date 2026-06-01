// Renders the entire pause menu interface

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Draw snapshot background
if (surface_exists(pause_snap_surf)) {
    draw_surface_stretched(pause_snap_surf, 0, 0, gw, gh);
}

// Dim overlay
draw_set_alpha(0.8);
draw_set_colour(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

// Panel background
draw_set_alpha(0.92);
draw_set_colour(c_black);
draw_rectangle(pause_menu_x, pause_menu_y, pause_menu_x + ui_menu_w, pause_menu_y + ui_menu_h, false);

// Panel border
draw_set_alpha(1);
draw_set_colour(c_gray);
draw_rectangle(pause_menu_x, pause_menu_y, pause_menu_x + ui_menu_w, pause_menu_y + ui_menu_h, true);

// Exit button
draw_sprite(sUI_EXIT, 0, pause_exit_x1, pause_exit_y1);

// Title text
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);

var title_txt = "PAUSE";
if (pause_page == PausePage.SETTINGS) title_txt = "SETTINGS";
else if (pause_page == PausePage.QUIT) title_txt = "QUIT";
else if (pause_page == PausePage.CONFIRM_RESTART) title_txt = "RESTART ROUND";
else if (pause_page == PausePage.CONFIRM_MENU) title_txt = "QUIT TO MENU";
else if (pause_page == PausePage.CONFIRM_DESKTOP) title_txt = "QUIT TO DESKTOP";

draw_text(pause_menu_x + 24, pause_menu_y + 72, title_txt);

// Draw buttons based on current page
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

switch (pause_page) {
    case PausePage.MAIN:
        // 4 buttons: Continue, Settings, Restart, Quit
        draw_sprite(sUI_Button_BG, 0, pause_btn_x1, pause_btn_y1);
        draw_sprite(sUI_Button_BG, 0, pause_btn2_x1, pause_btn2_y1);
        draw_sprite(sUI_Button_BG, 0, pause_btn3_x1, pause_btn3_y1);
        draw_sprite(sUI_Button_BG, 0, pause_btn4_x1, pause_btn4_y1);
        
        draw_text((pause_btn_x1 + pause_btn_x2) * 0.5, (pause_btn_y1 + pause_btn_y2) * 0.5, "CONTINUE");
        draw_text((pause_btn2_x1 + pause_btn2_x2) * 0.5, (pause_btn2_y1 + pause_btn2_y2) * 0.5, "SETTINGS");
        draw_text((pause_btn3_x1 + pause_btn3_x2) * 0.5, (pause_btn3_y1 + pause_btn3_y2) * 0.5, "RESTART ROUND");
        draw_text((pause_btn4_x1 + pause_btn4_x2) * 0.5, (pause_btn4_y1 + pause_btn4_y2) * 0.5, "QUIT");
        break;
        
    case PausePage.SETTINGS:
        {
            // Layout anchors
            var left_x = pause_menu_x + 40;
            var top_y = pause_menu_y + 140;
            var row_h = 56;
            var ctrl_x = left_x + 260;
            
            // Labels
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text(left_x, top_y + 0 * row_h, "Master Volume");
            draw_text(left_x, top_y + 1 * row_h, "Music Volume");
            draw_text(left_x, top_y + 2 * row_h, "SFX Volume");
            draw_text(left_x, top_y + 3 * row_h, "Fullscreen");
            draw_text(left_x, top_y + 4 * row_h, "Show FPS");
            draw_text(left_x, top_y + 5 * row_h, "Player Name");
            
            // Sliders
            var bar_w = 260;
            var bar_h = sprite_get_bbox_bottom(sUI_Bar_Empty) - sprite_get_bbox_top(sUI_Bar_Empty);
            
            draw_sprite_stretched(sUI_Bar_Empty, 0, set_master_x1, set_master_y1, bar_w, bar_h);
            draw_sprite_stretched(sUI_Bar_Fill, 0, set_master_x1, set_master_y1, bar_w * oGame.opt_master_vol, bar_h);
            
            draw_sprite_stretched(sUI_Bar_Empty, 0, set_music_x1, set_music_y1, bar_w, bar_h);
            draw_sprite_stretched(sUI_Bar_Fill, 0, set_music_x1, set_music_y1, bar_w * oGame.opt_music_vol, bar_h);
            
            draw_sprite_stretched(sUI_Bar_Empty, 0, set_sfx_x1, set_sfx_y1, bar_w, bar_h);
            draw_sprite_stretched(sUI_Bar_Fill, 0, set_sfx_x1, set_sfx_y1, bar_w * oGame.opt_sfx_vol, bar_h);
            
            // Checkboxes
            draw_sprite(sUI_Checkbox, 0, set_full_x1, set_full_y1);
            if (oGame.opt_fullscreen) {
                var cb_w = sprite_get_width(sUI_Checkbox);
                var cb_h = sprite_get_height(sUI_Checkbox);
                var ck_w = sprite_get_width(sUI_Checkmark);
                var ck_h = sprite_get_height(sUI_Checkmark);
                draw_sprite(sUI_Checkmark, 0, 
                    set_full_x1 + (cb_w - ck_w) * 0.5, 
                    set_full_y1 + (cb_h - ck_h) * 0.5);
            }
            
            draw_sprite(sUI_Checkbox, 0, set_fps_x1, set_fps_y1);
            if (oGame.opt_show_fps) {
                var cb_w2 = sprite_get_width(sUI_Checkbox);
                var cb_h2 = sprite_get_height(sUI_Checkbox);
                var ck_w2 = sprite_get_width(sUI_Checkmark);
                var ck_h2 = sprite_get_height(sUI_Checkmark);
                draw_sprite(sUI_Checkmark, 0, 
                    set_fps_x1 + (cb_w2 - ck_w2) * 0.5, 
                    set_fps_y1 + (cb_h2 - ck_h2) * 0.5);
            }
            
            // Textbox
            draw_sprite(sUI_Textbox, 0, set_name_x1, set_name_y1);
            draw_text(set_name_x1 + 12, set_name_y1 + sprite_get_height(sUI_Textbox) * 0.5, oGame.opt_player_name);
            
            // Caret if active
            if (settings_text_active) {
                var tx = set_name_x1 + 12 + string_width(oGame.opt_player_name);
                var ty = set_name_y1 + 10;
                draw_line(tx, ty, tx, ty + sprite_get_height(sUI_Textbox) - 20);
            }
            
            // Description area
            var desc_w = sprite_get_width(sUI_Desc_Area);
            var desc_h = sprite_get_height(sUI_Desc_Area);
            var desc_x = pause_menu_x + ui_menu_w - desc_w - 32;
            var desc_y = top_y;
            
            draw_sprite(sUI_Desc_Area, 0, desc_x + 16, desc_y + 16);
            
            var desc_txt = "Hover an option to see details.";
            if (point_in_rectangle(mx, my, set_master_x1, set_master_y1, set_master_x2, set_master_y2))
                desc_txt = "Controls overall game audio volume.";
            else if (point_in_rectangle(mx, my, set_music_x1, set_music_y1, set_music_x2, set_music_y2))
                desc_txt = "Controls music volume.";
            else if (point_in_rectangle(mx, my, set_sfx_x1, set_sfx_y1, set_sfx_x2, set_sfx_y2))
                desc_txt = "Controls sound effects volume.";
            else if (point_in_rectangle(mx, my, set_full_x1, set_full_y1, set_full_x2, set_full_y2))
                desc_txt = "Toggle fullscreen mode.";
            else if (point_in_rectangle(mx, my, set_fps_x1, set_fps_y1, set_fps_x2, set_fps_y2))
                desc_txt = "Show FPS counter.";
            else if (point_in_rectangle(mx, my, set_name_x1, set_name_y1, set_name_x2, set_name_y2))
                desc_txt = "Edit player name.";
            
            draw_set_halign(fa_left);
            draw_set_valign(fa_top);
            draw_text_ext(desc_x + 16, desc_y + 16, desc_txt, -1, 22);
            
            // Bottom buttons: Reset / Back
            draw_set_halign(fa_center);
            draw_set_valign(fa_middle);
            draw_sprite(sUI_Button_BG, 0, pause_btn_x1, pause_btn_y1);
            draw_sprite(sUI_Button_BG, 0, pause_btn2_x1, pause_btn2_y1);
            
            draw_text((pause_btn_x1 + pause_btn_x2) * 0.5, (pause_btn_y1 + pause_btn_y2) * 0.5, "RESET DEFAULTS");
            draw_text((pause_btn2_x1 + pause_btn2_x2) * 0.5, (pause_btn2_y1 + pause_btn2_y2) * 0.5, "BACK");
        }
        break;
        
    case PausePage.QUIT:
        // 3 buttons: Quit to Menu, Quit to Desktop, Back
        draw_sprite(sUI_Button_BG, 0, pause_btn_x1, pause_btn_y1);
        draw_sprite(sUI_Button_BG, 0, pause_btn2_x1, pause_btn2_y1);
        draw_sprite(sUI_Button_BG, 0, pause_btn3_x1, pause_btn3_y1);
        
        draw_text((pause_btn_x1 + pause_btn_x2) * 0.5, (pause_btn_y1 + pause_btn_y2) * 0.5, "QUIT TO MENU");
        draw_text((pause_btn2_x1 + pause_btn2_x2) * 0.5, (pause_btn2_y1 + pause_btn2_y2) * 0.5, "QUIT TO DESKTOP");
        draw_text((pause_btn3_x1 + pause_btn3_x2) * 0.5, (pause_btn3_y1 + pause_btn3_y2) * 0.5, "BACK");
        break;
        
    case PausePage.CONFIRM_RESTART:
    case PausePage.CONFIRM_MENU:
    case PausePage.CONFIRM_DESKTOP:
        // 2 buttons: YES / NO
        draw_sprite(sUI_Button_BG, 0, pause_btn_x1, pause_btn_y1);
        draw_sprite(sUI_Button_BG, 0, pause_btn2_x1, pause_btn2_y1);
        
        draw_text((pause_btn_x1 + pause_btn_x2) * 0.5, (pause_btn_y1 + pause_btn_y2) * 0.5, "YES");
        draw_text((pause_btn2_x1 + pause_btn2_x2) * 0.5, (pause_btn2_y1 + pause_btn2_y2) * 0.5, "NO");
        break;
}

// Restore defaults
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(1);