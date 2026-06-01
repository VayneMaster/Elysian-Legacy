// Handle skill tree input

var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// ESC to close
if (keyboard_check_pressed(vk_escape)) {
    scr_set_pause(false);
    global.ui_menu_open = false;
    instance_destroy();
    exit;
}

// Exit button
if (mouse_check_button_pressed(mb_left)) {
    if (point_in_rectangle(mx, my, exit_x1, exit_y1, exit_x2, exit_y2)) {
        scr_set_pause(false);
        global.ui_menu_open = false;
        instance_destroy();
        exit;
    }
}

// Check hover on skills
hovered_skill = -1;

// Check MELEE skills (M1-M5)
for (var i = 0; i < 5; i++) {
    var sx = melee_x_arr[i];
    var sy = melee_y_arr[i];
    if (point_in_rectangle(mx, my, sx, sy, sx + node_size, sy + node_size)) {
        hovered_skill = SkillID.M1 + i;
        break;
    }
}

// Check RANGED skills (R1-R5)
if (hovered_skill == -1) {
    for (var i = 0; i < 5; i++) {
        var sx = ranged_x_arr[i];
        var sy = ranged_y_arr[i];
        if (point_in_rectangle(mx, my, sx, sy, sx + node_size, sy + node_size)) {
            hovered_skill = SkillID.R1 + i;
            break;
        }
    }
}

// Check ELITE skills (E1-E4)
if (hovered_skill == -1) {
    for (var i = 0; i < 4; i++) {
        var sx = elite_x_arr[i];
        var sy = elite_y_arr[i];
        if (point_in_rectangle(mx, my, sx, sy, sx + node_size, sy + node_size)) {
            hovered_skill = SkillID.E1 + i;
            break;
        }
    }
}

// Click to unlock skill
if (mouse_check_button_pressed(mb_left) && hovered_skill != -1) {
    // Check if can unlock
    var can_unlock = false;
    
    // Check if not already unlocked
    if (!oGame.skill_unlocked[hovered_skill]) {
        // Check if have points
        if (oGame.skill_points_available > 0) {
            // Check prerequisites
            var prereq_met = true;
            
            // MELEE skills (M1-M5)
            if (hovered_skill >= SkillID.M1 && hovered_skill <= SkillID.M5) {
                var index = hovered_skill - SkillID.M1;
                // M1 always available, others need previous
                if (index > 0) {
                    prereq_met = oGame.skill_unlocked[hovered_skill - 1];
                }
            }
            // RANGED skills (R1-R5)
            else if (hovered_skill >= SkillID.R1 && hovered_skill <= SkillID.R5) {
                var index = hovered_skill - SkillID.R1;
                // R1 always available, others need previous
                if (index > 0) {
                    prereq_met = oGame.skill_unlocked[hovered_skill - 1];
                }
            }
            // ELITE skills (E1-E4)
	else if (hovered_skill >= SkillID.E1 && hovered_skill <= SkillID.E4) {
	    var index = hovered_skill - SkillID.E1;

	    // E1: no prereqs
	    prereq_met = true;

	    // E2–E3: need previous elite
	    if (index > 0 && index < 3) {
	        prereq_met = oGame.skill_unlocked[hovered_skill - 1];
	    }

	    // E4: needs EVERYTHING
	    if (index == 3) {
	        var all_melee = true;
	        var all_ranged = true;
	        var all_elite  = true;

	        for (var i = SkillID.M1; i <= SkillID.M5; i++) {
	            if (!oGame.skill_unlocked[i]) all_melee = false;
	        }
	        for (var i = SkillID.R1; i <= SkillID.R5; i++) {
	            if (!oGame.skill_unlocked[i]) all_ranged = false;
	        }
	        for (var i = SkillID.E1; i <= SkillID.E3; i++) {
	            if (!oGame.skill_unlocked[i]) all_elite = false;
	        }

	        prereq_met = all_melee && all_ranged && all_elite;
	    }
	}

            
            if (prereq_met) {
                can_unlock = true;
            }
        }
    }
    
    // Unlock the skill
    if (can_unlock) {
        oGame.skill_unlocked[hovered_skill] = true;
        oGame.skill_points_available--;
        
        // Play sound (optional)
        // audio_play_sound(snd_skill_unlock, 1, false);
    }
}