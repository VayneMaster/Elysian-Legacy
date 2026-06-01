// oTitleScreen - Draw GUI Event

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// No background drawing needed - using room background sprite
// Optional: Add a subtle dark overlay at bottom for button contrast
draw_set_alpha(0.3);
draw_set_colour(c_black);
draw_rectangle(0, gh * 0.4, gw, gh, false);
draw_set_alpha(1);

// No title text needed - it's in the background sprite!

//===============================================
// MENU BUTTONS
//===============================================
for (var i = 0; i < menu_count; i++) {
    var x1 = button_x1[i];
    var y1 = button_y1[i];
    var x2 = button_x2[i];
    var y2 = button_y2[i];
    
    var is_hovered = (i == menu_index);
    var is_disabled = (i == 1 && !has_save_file); // Disable continue if no save
    
    // Button background (matching the bronze/golden theme of background)
    if (is_disabled) {
        draw_set_alpha(0.3);
        draw_set_colour(make_colour_rgb(40, 40, 40));
    } else if (is_hovered) {
        draw_set_alpha(0.85);
        draw_set_colour(make_colour_rgb(120, 80, 40)); // Bronze/golden brown
    } else {
        draw_set_alpha(0.65);
        draw_set_colour(make_colour_rgb(60, 40, 30)); // Dark brown
    }
    
    draw_rectangle(x1, y1, x2, y2, false);
    
    // Button border (golden accent)
    draw_set_alpha(1);
    if (is_hovered && !is_disabled) {
        draw_set_colour(make_colour_rgb(255, 200, 100)); // Bright golden
        draw_rectangle(x1 - 3, y1 - 3, x2 + 3, y2 + 3, true);
        draw_rectangle(x1 - 2, y1 - 2, x2 + 2, y2 + 2, true);
    } else {
        draw_set_colour(make_colour_rgb(140, 100, 60)); // Dark bronze
        draw_rectangle(x1, y1, x2, y2, true);
    }
    
    // Button text (golden/bronze theme)
    if (is_disabled) {
        draw_set_colour(make_colour_rgb(80, 80, 80));
    } else if (is_hovered) {
        draw_set_colour(make_colour_rgb(255, 220, 150)); // Bright golden
    } else {
        draw_set_colour(make_colour_rgb(200, 160, 100)); // Muted bronze
    }
    
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    
    var text_scale = is_hovered && !is_disabled ? 1.2 : 1.0;
    draw_text_transformed((x1 + x2) * 0.5, (y1 + y2) * 0.5, menu_text[i], text_scale, text_scale, 0);
    
    // Disabled text overlay
    if (is_disabled) {
        draw_set_alpha(0.7);
        draw_set_colour(c_white);
        draw_text((x1 + x2) * 0.5, (y1 + y2) * 0.5 + 25, "(No Save File)");
    }
}

//===============================================
// VERSION INFO (BOTTOM RIGHT)
//===============================================
draw_set_alpha(0.6);
draw_set_colour(c_white);
draw_set_halign(fa_right);
draw_set_valign(fa_bottom);
draw_text(gw - 20, gh - 10, "v1.0.0 - Early Access");

//===============================================
// CONTROLS HINT (BOTTOM LEFT)
//===============================================
draw_set_halign(fa_left);
draw_text(20, gh - 10, "Arrow Keys/Mouse to Navigate | Enter/Click to Select | ESC to Quit");

// Reset
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);