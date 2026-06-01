var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// ESC to close
if (keyboard_check_pressed(vk_escape)) {
    if (title_page == TitlePage.MAIN) {
        instance_destroy();
    } else {
        title_page = TitlePage.MAIN;
    }
    exit;
}

// Exit button
if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mx, my, exit_x1, exit_y1, exit_x2, exit_y2)) {
        title_page = TitlePage.MAIN;
        instance_destroy();
        exit;
    }
}

// OPTIONS PAGE
if (title_page == TitlePage.OPTIONS) {
    // Handle sliders
    for (var i = 0; i < slider_count; i++) {
        var sy = slider_y_start + i * slider_y_gap;
        var sx1 = slider_x;
        var sx2 = slider_x + slider_w;
        
        if (mouse_check_button_pressed(mb_left)) {
            if (point_in_rectangle(mx, my, sx1, sy, sx2, sy + slider_h)) {
                dragging_slider = i;
            }
        }
    }
    
    if (mouse_check_button_released(mb_left)) {
        dragging_slider = -1;
    }
    
    // Update slider being dragged
    if (dragging_slider != -1) {
        var i = dragging_slider;
        var sy = slider_y_start + i * slider_y_gap;
        var sx1 = slider_x;
        var sx2 = slider_x + slider_w;
        
        var new_val = clamp((mx - sx1) / slider_w, 0, 1);
        
        if (i == 3) { // Show FPS toggle
            new_val = (new_val > 0.5) ? 1 : 0;
        }
        
        // Apply setting
        switch (i) {
            case 0: 
                opt_master_vol = new_val;
                audio_master_gain(opt_master_vol);
                break;
            case 1: opt_music_vol = new_val; break;
            case 2: opt_sfx_vol = new_val; break;
            case 3: opt_show_fps = (new_val > 0.5); break;
        }
    }
    
    // Fullscreen toggle with F
    if (keyboard_check_pressed(ord("F"))) {
        opt_fullscreen = !opt_fullscreen;
        window_set_fullscreen(opt_fullscreen);
    }
}

// INFO PAGE
if (title_page == TitlePage.INFO) {
    // Scroll with mouse wheel
    if (mouse_wheel_up()) {
        scroll_y += scroll_speed;
    }
    if (mouse_wheel_down()) {
        scroll_y -= scroll_speed;
    }
    scroll_y = clamp(scroll_y, -400, 0);
}