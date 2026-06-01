var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Draw snapshot background (if exists)
if (surface_exists(snap_surf)) {
    draw_surface_stretched(snap_surf, 0, 0, gw, gh);
}

// Dim overlay
draw_set_alpha(0.85);
draw_set_colour(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

// Panel background
draw_set_colour(make_colour_rgb(35, 35, 38));
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, false);
draw_set_colour(make_colour_rgb(80, 80, 80));
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, true);

// Title
var title_text = "OPTIONS";
if (title_page == TitlePage.INFO) title_text = "INFORMATION";

draw_set_colour(make_colour_rgb(220, 200, 160));
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text_transformed(panel_x + panel_w * 0.5, panel_y + 30, title_text, 2, 2, 0);

// Exit button
var exit_hovered = point_in_rectangle(mx, my, exit_x1, exit_y1, exit_x2, exit_y2);
draw_set_colour(exit_hovered ? make_colour_rgb(200, 100, 100) : make_colour_rgb(150, 150, 150));
draw_circle(exit_x1 + exit_w * 0.5, exit_y1 + exit_h * 0.5, 16, false);
draw_set_colour(c_white);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text(exit_x1 + exit_w * 0.5, exit_y1 + exit_h * 0.5, "X");

// Draw content based on page
if (title_page == TitlePage.OPTIONS) {
    // Draw sliders
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    
    var slider_values = [opt_master_vol, opt_music_vol, opt_sfx_vol, opt_show_fps ? 1 : 0];
    
    for (var i = 0; i < slider_count; i++) {
        var sy = slider_y_start + i * slider_y_gap;
        var sx1 = slider_x;
        var sx2 = slider_x + slider_w;
        
        // Label
        draw_set_colour(c_white);
        draw_text(sx1, sy - 30, slider_labels[i]);
        
        // Slider track
        draw_set_colour(make_colour_rgb(60, 60, 60));
        draw_rectangle(sx1, sy, sx2, sy + slider_h, false);
        
        // Slider fill
        var fill_w = slider_w * slider_values[i];
        draw_set_colour(make_colour_rgb(100, 150, 200));
        draw_rectangle(sx1, sy, sx1 + fill_w, sy + slider_h, false);
        
        // Slider handle
        var handle_x = sx1 + fill_w;
        draw_set_colour(make_colour_rgb(220, 220, 220));
        draw_circle(handle_x, sy + slider_h * 0.5, 15, false);
        
        // Value text
        if (i == 3) {
            draw_set_colour(c_white);
            draw_text(sx2 + 20, sy + 5, slider_values[i] > 0.5 ? "ON" : "OFF");
        } else {
            draw_text(sx2 + 20, sy + 5, string(floor(slider_values[i] * 100)) + "%");
        }
    }
    
    // Fullscreen hint
    draw_set_alpha(0.8);
    draw_set_colour(c_white);
    draw_set_halign(fa_center);
    draw_text(panel_x + panel_w * 0.5, panel_y + panel_h - 50, 
              "Press F to toggle fullscreen (Current: " + (opt_fullscreen ? "ON" : "OFF") + ")");
    draw_set_alpha(1);
}
else if (title_page == TitlePage.INFO) {
    // Info content with scrolling
    var content_x = panel_x + 40;
    var content_y = panel_y + 100 + scroll_y;
    var content_w = panel_w - 80;
    
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_colour(c_white);
    
    // Your game info here
    draw_set_colour(make_colour_rgb(220, 200, 160));
    draw_text_transformed(content_x, content_y, "LEGACY OF ELYSIAN WARFARE", 1.5, 1.5, 0);
    content_y += 50;
    
    draw_set_colour(make_colour_rgb(180, 180, 180));
    draw_text(content_x, content_y, "Developer: [Your Name]");
    content_y += 25;
    draw_text(content_x, content_y, "Engine: GameMaker Studio 2");
    content_y += 25;
    draw_text(content_x, content_y, "Genre: Real-Time Strategy");
    content_y += 40;
    
    draw_set_colour(make_colour_rgb(200, 200, 200));
    var desc = @"A fast-paced lane-based strategy game where you must defend 
your base while attacking the enemy. Deploy units, build turrets, 
and unlock powerful masteries to dominate the battlefield!";
    draw_text_ext(content_x, content_y, desc, 20, content_w);
    
    // Scroll hint
    draw_set_alpha(0.7);
    draw_set_colour(c_white);
    draw_set_halign(fa_center);
    draw_text(panel_x + panel_w * 0.5, panel_y + panel_h - 30, "Scroll with Mouse Wheel");
    draw_set_alpha(1);
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(1);