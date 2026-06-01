// oUI_Masteries - Draw GUI Event (HORIZONTAL LAYOUT)

var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

// Background
if (surface_exists(snap_surf)) {
    draw_surface_stretched(snap_surf, 0, 0, gw, gh);
}

// Dim overlay
draw_set_alpha(0.85);
draw_set_colour(c_black);
draw_rectangle(0, 0, gw, gh, false);
draw_set_alpha(1);

//===============================================
// MAIN PANEL
//===============================================
// Outer border
draw_set_colour(make_colour_rgb(80, 80, 80));
draw_rectangle(panel_x - 4, panel_y - 4, panel_x + panel_w + 4, panel_y + panel_h + 4, false);

// Main background
draw_set_colour(make_colour_rgb(35, 35, 38));
draw_rectangle(panel_x, panel_y, panel_x + panel_w, panel_y + panel_h, false);

//===============================================
// MASTERIES TITLE (BIG at top)
//===============================================
draw_set_colour(make_colour_rgb(220, 200, 160));
draw_set_halign(fa_center);
draw_set_valign(fa_top);
draw_text_transformed(panel_x + panel_w * 0.5, panel_y + 20, "MASTERIES", 2, 2, 0);

// Exit button
var exit_bg_col = point_in_rectangle(mx, my, exit_x1, exit_y1, exit_x2, exit_y2) ? 
    make_colour_rgb(80, 40, 40) : make_colour_rgb(60, 30, 30);
draw_set_colour(exit_bg_col);
draw_rectangle(exit_x1 - 4, exit_y1 - 4, exit_x2 + 4, exit_y2 + 4, false);
draw_sprite(sUI_EXIT, 0, exit_x1, exit_y1);

//===============================================
// SECTION LABELS
//===============================================
var label_y = panel_y + 90;

// MELEE (left)
draw_set_colour(make_colour_rgb(180, 80, 80));
draw_set_halign(fa_center);
draw_text_transformed(melee_x_arr[1] + node_size * 0.5, label_y, "MELEE", 1.5, 1.5, 0);

// RANGED (right)
draw_set_colour(make_colour_rgb(80, 120, 180));
draw_text_transformed(ranged_x_arr[1] + node_size * 0.5, label_y, "RANGED", 1.5, 1.5, 0);

// ELITE (center, above elite nodes)
var elite_label_y = elite_y_arr[0] - 40;
draw_set_colour(make_colour_rgb(180, 150, 80));
draw_text_transformed(elite_x_arr[1] + node_size * 0.5, elite_label_y, "ELITE", 1.5, 1.5, 0);

//===============================================
// CONNECTION LINES
//===============================================
draw_set_alpha(0.5);

// MELEE connections (M1->M2->M3, then to M4 and M5)
// M1 to M2
var line_col = oGame.skill_unlocked[SkillID.M1] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(melee_x_arr[0] + node_size, melee_y_arr[0] + node_size * 0.5, 
                melee_x_arr[1], melee_y_arr[1] + node_size * 0.5, 4);

// M2 to M3
line_col = oGame.skill_unlocked[SkillID.M2] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(melee_x_arr[1] + node_size, melee_y_arr[1] + node_size * 0.5, 
                melee_x_arr[2], melee_y_arr[2] + node_size * 0.5, 4);

// M3 to M4 and M5 (branch down)
line_col = oGame.skill_unlocked[SkillID.M3] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(melee_x_arr[2] + node_size * 0.5, melee_y_arr[2] + node_size,
                melee_x_arr[3] + node_size * 0.5, melee_y_arr[3], 4);
draw_line_width(melee_x_arr[2] + node_size * 0.5, melee_y_arr[2] + node_size,
                melee_x_arr[4] + node_size * 0.5, melee_y_arr[4], 4);

// M4 to M5
line_col = oGame.skill_unlocked[SkillID.M4] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(melee_x_arr[3] + node_size, melee_y_arr[3] + node_size * 0.5,
                melee_x_arr[4], melee_y_arr[4] + node_size * 0.5, 4);

// RANGED connections (R1->R2->R3, then to R4 and R5)
// R1 to R2
line_col = oGame.skill_unlocked[SkillID.R1] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(ranged_x_arr[0] + node_size, ranged_y_arr[0] + node_size * 0.5,
                ranged_x_arr[1], ranged_y_arr[1] + node_size * 0.5, 4);

// R2 to R3
line_col = oGame.skill_unlocked[SkillID.R2] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(ranged_x_arr[1] + node_size, ranged_y_arr[1] + node_size * 0.5,
                ranged_x_arr[2], ranged_y_arr[2] + node_size * 0.5, 4);

// R3 to R4 and R5 (branch down)
line_col = oGame.skill_unlocked[SkillID.R3] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(ranged_x_arr[2] + node_size * 0.5, ranged_y_arr[2] + node_size,
                ranged_x_arr[3] + node_size * 0.5, ranged_y_arr[3], 4);
draw_line_width(ranged_x_arr[2] + node_size * 0.5, ranged_y_arr[2] + node_size,
                ranged_x_arr[4] + node_size * 0.5, ranged_y_arr[4], 4);

// R4 to R5
line_col = oGame.skill_unlocked[SkillID.R4] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(ranged_x_arr[3] + node_size, ranged_y_arr[3] + node_size * 0.5,
                ranged_x_arr[4], ranged_y_arr[4] + node_size * 0.5, 4);

// M5 and R5 to Elite (converge to E1)
var all_melee_done = true;
var all_ranged_done = true;
for (var i = SkillID.M1; i <= SkillID.M5; i++) {
    if (!oGame.skill_unlocked[i]) all_melee_done = false;
}
for (var i = SkillID.R1; i <= SkillID.R5; i++) {
    if (!oGame.skill_unlocked[i]) all_ranged_done = false;
}
line_col = (all_melee_done && all_ranged_done) ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);

// Melee to Elite
draw_line_width(melee_x_arr[4] + node_size * 0.5, melee_y_arr[4] + node_size,
                elite_x_arr[0] + node_size * 0.5, elite_y_arr[0], 4);

// Ranged to Elite  
draw_line_width(ranged_x_arr[4] + node_size * 0.5, ranged_y_arr[4] + node_size,
                elite_x_arr[2] + node_size * 0.5, elite_y_arr[2], 4);

// ELITE connections (E1->E2->E3, then to E4)
// E1 to E2
line_col = oGame.skill_unlocked[SkillID.E1] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(elite_x_arr[0] + node_size, elite_y_arr[0] + node_size * 0.5,
                elite_x_arr[1], elite_y_arr[1] + node_size * 0.5, 4);

// E2 to E3
line_col = oGame.skill_unlocked[SkillID.E2] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(elite_x_arr[1] + node_size, elite_y_arr[1] + node_size * 0.5,
                elite_x_arr[2], elite_y_arr[2] + node_size * 0.5, 4);

// E2 to E4 (center node down)
line_col = oGame.skill_unlocked[SkillID.E2] ? make_colour_rgb(100, 200, 100) : make_colour_rgb(60, 60, 60);
draw_set_colour(line_col);
draw_line_width(elite_x_arr[1] + node_size * 0.5, elite_y_arr[1] + node_size,
                elite_x_arr[3] + node_size * 0.5, elite_y_arr[3], 4);

draw_set_alpha(1);

//===============================================
// SKILL NODES (Professional styled)
//===============================================
function draw_professional_skill_node(skill_id, x_pos, y_pos, node_sz, is_hovered) {
    var is_unlocked = oGame.skill_unlocked[skill_id];
    var can_afford = oGame.skill_points_available > 0;
    
    // Check prerequisites (same logic as before)
    var prereq_met = false;
    
    if (skill_id >= SkillID.M1 && skill_id <= SkillID.M5) {
        var index = skill_id - SkillID.M1;
        prereq_met = (index == 0) ? true : oGame.skill_unlocked[skill_id - 1];
    }
    else if (skill_id >= SkillID.R1 && skill_id <= SkillID.R5) {
        var index = skill_id - SkillID.R1;
        prereq_met = (index == 0) ? true : oGame.skill_unlocked[skill_id - 1];
    }
	else if (skill_id >= SkillID.E1 && skill_id <= SkillID.E4) {
	    var index = skill_id - SkillID.E1;

	    // E1: no prereqs (but still needs points via can_afford)
	    prereq_met = true;

	    // E2–E3: need previous elite
	    if (index > 0 && index < 3) {
	        prereq_met = oGame.skill_unlocked[skill_id - 1];
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
  
    var can_unlock = !is_unlocked && can_afford && prereq_met;
    
    // OUTER FRAME
    var frame_expand = 3;
    if (is_hovered) {
        draw_set_colour(make_colour_rgb(200, 180, 120));
        draw_rectangle(x_pos - frame_expand - 2, y_pos - frame_expand - 2, 
                      x_pos + node_sz + frame_expand + 2, y_pos + node_sz + frame_expand + 2, false);
    }
    
    draw_set_colour(make_colour_rgb(70, 70, 70));
    draw_rectangle(x_pos - frame_expand, y_pos - frame_expand, 
                  x_pos + node_sz + frame_expand, y_pos + node_sz + frame_expand, false);
    
    // MAIN BACKGROUND
    var bg_col;
    if (is_unlocked) {
        bg_col = make_colour_rgb(40, 80, 40);
    } else if (can_unlock) {
        bg_col = make_colour_rgb(80, 70, 40);
    } else {
        bg_col = make_colour_rgb(40, 40, 42);
    }
    
    draw_set_colour(bg_col);
    draw_rectangle(x_pos, y_pos, x_pos + node_sz, y_pos + node_sz, false);
    
    // INNER BORDER
    draw_set_colour(make_colour_rgb(25, 25, 28));
    draw_rectangle(x_pos + 2, y_pos + 2, x_pos + node_sz - 2, y_pos + node_sz - 2, true);
    
    // STATUS OVERLAY
    if (!is_unlocked && !can_unlock) {
        draw_set_alpha(0.7);
        draw_set_colour(c_black);
        draw_rectangle(x_pos + 2, y_pos + 2, x_pos + node_sz - 2, y_pos + node_sz - 2, false);
        draw_set_alpha(1);
    }
    
    // SKILL LABEL
    var node_num = "";
    var label_col = c_white;
    
    if (skill_id >= SkillID.M1 && skill_id <= SkillID.M5) {
        node_num = "M" + string(skill_id - SkillID.M1 + 1);
        label_col = make_colour_rgb(255, 150, 150);
    }
    else if (skill_id >= SkillID.R1 && skill_id <= SkillID.R5) {
        node_num = "R" + string(skill_id - SkillID.R1 + 1);
        label_col = make_colour_rgb(150, 180, 255);
    }
    else if (skill_id >= SkillID.E1 && skill_id <= SkillID.E4) {
        node_num = "E" + string(skill_id - SkillID.E1 + 1);
        label_col = make_colour_rgb(255, 200, 100);
    }
    
    draw_set_colour(label_col);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(x_pos + node_sz * 0.5, y_pos + node_sz * 0.5, node_num, 1.3, 1.3, 0);
    
    // LOCK ICON
    if (!is_unlocked && !can_unlock) {
        draw_set_alpha(0.9);
        draw_set_colour(make_colour_rgb(180, 180, 180));
        draw_text(x_pos + node_sz * 0.5, y_pos + node_sz - 15, "🔒");
        draw_set_alpha(1);
    }
    
    // CHECKMARK
    if (is_unlocked) {
        draw_set_colour(make_colour_rgb(100, 255, 100));
        draw_circle(x_pos + node_sz - 12, y_pos + 12, 8, false);
        draw_set_colour(make_colour_rgb(20, 80, 20));
        draw_text_transformed(x_pos + node_sz - 12, y_pos + 12, "✓", 0.8, 0.8, 0);
    }
}

// Draw MELEE nodes
for (var i = 0; i < 5; i++) {
    var skill_id = SkillID.M1 + i;
    var is_hovered = (hovered_skill == skill_id);
    draw_professional_skill_node(skill_id, melee_x_arr[i], melee_y_arr[i], node_size, is_hovered);
}

// Draw RANGED nodes
for (var i = 0; i < 5; i++) {
    var skill_id = SkillID.R1 + i;
    var is_hovered = (hovered_skill == skill_id);
    draw_professional_skill_node(skill_id, ranged_x_arr[i], ranged_y_arr[i], node_size, is_hovered);
}

// Draw ELITE nodes
for (var i = 0; i < 4; i++) {
    var skill_id = SkillID.E1 + i;
    var is_hovered = (hovered_skill == skill_id);
    draw_professional_skill_node(skill_id, elite_x_arr[i], elite_y_arr[i], node_size, is_hovered);
}

//===============================================
// POINTS DISPLAY (BIG at bottom)
//===============================================
var points_w = 200;
var points_h = 50;
var points_x = panel_x + (panel_w - points_w) * 0.5;
var points_y = panel_y + panel_h - points_h - 20;

draw_set_colour(make_colour_rgb(25, 25, 28));
draw_rectangle(points_x, points_y, points_x + points_w, points_y + points_h, false);
draw_set_colour(make_colour_rgb(80, 80, 80));
draw_rectangle(points_x, points_y, points_x + points_w, points_y + points_h, true);

draw_set_colour(make_colour_rgb(255, 200, 80));
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(points_x + points_w * 0.5, points_y + points_h * 0.5, 
    "POINTS: " + string(oGame.skill_points_available), 1.5, 1.5, 0);

//===============================================
// TOOLTIP
//===============================================
if (hovered_skill != -1) {
    var tooltip_w = 320;
    var tooltip_h = 110;
    var tooltip_x = mx + 25;
    var tooltip_y = my + 25;
    
    if (tooltip_x + tooltip_w > gw) tooltip_x = mx - tooltip_w - 25;
    if (tooltip_y + tooltip_h > gh) tooltip_y = my - tooltip_h - 25;
    
    // Outer border
    draw_set_colour(make_colour_rgb(100, 90, 70));
    draw_rectangle(tooltip_x - 3, tooltip_y - 3, tooltip_x + tooltip_w + 3, tooltip_y + tooltip_h + 3, false);
    
    // Main background
    draw_set_alpha(0.98);
    draw_set_colour(make_colour_rgb(30, 30, 32));
    draw_rectangle(tooltip_x, tooltip_y, tooltip_x + tooltip_w, tooltip_y + tooltip_h, false);
    draw_set_alpha(1);
    
    // Inner border
    draw_set_colour(make_colour_rgb(60, 60, 62));
    draw_rectangle(tooltip_x, tooltip_y, tooltip_x + tooltip_w, tooltip_y + tooltip_h, true);
    
    // Header bar
    draw_set_colour(make_colour_rgb(50, 45, 40));
    draw_rectangle(tooltip_x, tooltip_y, tooltip_x + tooltip_w, tooltip_y + 28, false);
    
    // Content
    var skill_name = oGame.skill_name[hovered_skill];
    var skill_desc = oGame.skill_desc[hovered_skill];
    var is_unlocked = oGame.skill_unlocked[hovered_skill];
    
    // Title
    draw_set_colour(make_colour_rgb(220, 200, 160));
    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_text(tooltip_x + 12, tooltip_y + 8, skill_name);
    
    // Description
    draw_set_colour(make_colour_rgb(200, 200, 200));
    draw_set_alpha(0.9);
    draw_text_ext(tooltip_x + 12, tooltip_y + 38, skill_desc, 17, tooltip_w - 24);
    draw_set_alpha(1);
    
    // Status bar
    var status_y = tooltip_y + tooltip_h - 24;
    draw_set_colour(make_colour_rgb(45, 45, 47));
    draw_rectangle(tooltip_x, status_y, tooltip_x + tooltip_w, tooltip_y + tooltip_h, false);
    
    if (is_unlocked) {
        draw_set_colour(make_colour_rgb(100, 200, 100));
        draw_text(tooltip_x + 12, status_y + 5, "✓ UNLOCKED");
    } else {
        draw_set_colour(make_colour_rgb(255, 200, 80));
        draw_text(tooltip_x + 12, status_y + 5, "Click to unlock (Cost: 1 point)");
    }
}

// Reset
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_colour(c_white);
draw_set_alpha(1);