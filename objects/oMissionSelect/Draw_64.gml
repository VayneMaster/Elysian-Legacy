var gw = display_get_gui_width();
var gh = display_get_gui_height();
var mx = device_mouse_x_to_gui(0);
var my = device_mouse_y_to_gui(0);

//colors
var c_bg = make_colour_rgb(14, 12 , 8);
var c_panel = make_colour_rgb(26,  21,  14);
var c_panel_dark = make_colour_rgb(18,  15,  10);
var c_rivet = make_colour_rgb(70,  60,  42);
var c_border = make_colour_rgb(100, 75,  40);
var c_gold = make_colour_rgb(255, 205, 90);
var c_gold_dim = make_colour_rgb(170, 120, 50);
var c_bronze = make_colour_rgb(130, 90,  40);
var c_muted = make_colour_rgb(155, 138, 108);
var c_locked = make_colour_rgb(60,  52,  38);
var c_complete = make_colour_rgb(70,  190, 90);
var c_red_dark = make_colour_rgb(110, 28,  22);
var c_red_bright = make_colour_rgb(190, 50,  40);


//background
draw_set_alpha(1);
draw_set_colour(c_bg);
draw_rectangle(0,0, gw, gh, false);

//scanline texture
draw_set_alpha(0.03);
draw_set_colour(c_gold_dim);
for (var _sy = 0; _sy < gh; _sy += 4) draw_line(0, _sy, gw, _sy);
draw_set_alpha(1);

var rv = 7; // rivet radius

// MAP PANEL
draw_set_colour(c_panel);
draw_rectangle(map_x, map_y, map_x + map_w, map_y + map_h, false);
draw_set_colour(c_border);
draw_rectangle(map_x, map_y, map_x + map_w, map_y + map_h, true);

// Rivets
draw_set_colour(c_rivet);
draw_circle(map_x + 14,           map_y + 14,           rv, false);
draw_circle(map_x + map_w - 14,   map_y + 14,           rv, false);
draw_circle(map_x + 14,           map_y + map_h - 14,   rv, false);
draw_circle(map_x + map_w - 14,   map_y + map_h - 14,   rv, false);
draw_set_colour(c_bg);
draw_circle(map_x + 14,           map_y + 14,           rv - 3, false);
draw_circle(map_x + map_w - 14,   map_y + 14,           rv - 3, false);
draw_circle(map_x + 14,           map_y + map_h - 14,   rv - 3, false);
draw_circle(map_x + map_w - 14,   map_y + map_h - 14,   rv - 3, false);

// Title bar
draw_set_colour(c_panel_dark);
draw_rectangle(map_x + 2, map_y + 2, map_x + map_w - 2, map_y + 36, false);
draw_set_colour(c_gold);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(map_x + map_w * 0.5, map_y + 19, "CAMPAIGN MAP", 1.3, 1.3, 0);

// Timeline path lines
for (var i = 0; i < MissionID.COUNT - 1; i++) {
    var _st = scr_get_mission_status(i);
    var lc  = c_locked;
    if (_st == "COMPLETE")  lc = c_complete;
    if (_st == "AVAILABLE") lc = c_gold_dim;
    draw_set_colour(lc);
    draw_set_alpha(0.6);
    draw_line(node_x[i],     node_y[i],     node_x[i+1], node_y[i+1]);
    draw_line(node_x[i]+1,   node_y[i]+1,   node_x[i+1]+1, node_y[i+1]+1);
    draw_line(node_x[i]-1,   node_y[i]-1,   node_x[i+1]-1, node_y[i+1]-1);
    draw_set_alpha(1);
}

// Timeline nodes
for (var i = 0; i < MissionID.COUNT; i++) {
    var nx  = node_x[i];
    var ny  = node_y[i];
    var st  = scr_get_mission_status(i);
    var sel = (selected_mission == i);
    var hov = (hovered_node == i);
    var cfg = scr_get_mission_config(i);

    // Selection glow
    if (sel) {
        draw_set_alpha((sin(pulse_t * 2) + 1) * 0.25 + 0.2);
        draw_set_colour(c_gold);
        draw_circle(nx, ny, node_r + 10, false);
        draw_set_alpha(1);
    }

    // Node fill
    var nfill = c_locked;
    if (st == "AVAILABLE") nfill = make_colour_rgb(55, 44, 22);
    if (st == "COMPLETE")  nfill = make_colour_rgb(20, 50, 25);
    draw_set_colour(nfill);
    draw_circle(nx, ny, node_r, false);

    // Node border
    var nbord = c_locked;
    if (st == "AVAILABLE") nbord = (hov || sel) ? c_gold : c_gold_dim;
    if (st == "COMPLETE")  nbord = c_complete;
    draw_set_colour(nbord);
    draw_circle(nx, ny, node_r, true);

    // Number
    draw_set_colour(st == "LOCKED" ? c_locked : (st == "COMPLETE" ? c_complete : c_gold));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(nx, ny, string(i + 1), 1.1, 1.1, 0);

    // Name label below
    draw_set_colour(st == "LOCKED" ? c_locked : c_muted);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text_ext(nx, ny + node_r + 6, cfg.name, -1, 130);

    // Complete star above
    if (st == "COMPLETE") {
        draw_set_colour(c_complete);
        draw_set_valign(fa_bottom);
        draw_text_transformed(nx, ny - node_r - 4, "★", 1.2, 1.2, 0);
    }
}

// BRIEFING PANEL
draw_set_colour(c_panel);
draw_rectangle(brief_x, brief_y, brief_x + brief_w, brief_y + brief_h, false);
draw_set_colour(c_border);
draw_rectangle(brief_x, brief_y, brief_x + brief_w, brief_y + brief_h, true);

draw_set_colour(c_rivet);
draw_circle(brief_x + 14,            brief_y + 14,            rv, false);
draw_circle(brief_x + brief_w - 14,  brief_y + 14,            rv, false);
draw_circle(brief_x + 14,            brief_y + brief_h - 14,  rv, false);
draw_circle(brief_x + brief_w - 14,  brief_y + brief_h - 14,  rv, false);
draw_set_colour(c_bg);
draw_circle(brief_x + 14,            brief_y + 14,            rv - 3, false);
draw_circle(brief_x + brief_w - 14,  brief_y + 14,            rv - 3, false);
draw_circle(brief_x + 14,            brief_y + brief_h - 14,  rv - 3, false);
draw_circle(brief_x + brief_w - 14,  brief_y + brief_h - 14,  rv - 3, false);

draw_set_colour(c_panel_dark);
draw_rectangle(brief_x + 2, brief_y + 2, brief_x + brief_w - 2, brief_y + 30, false);
draw_set_colour(c_gold);
draw_set_halign(fa_left);
draw_set_valign(fa_middle);
draw_text(brief_x + 16, brief_y + 16, "BRIEFING:");

if (selected_mission >= 0) {
    var bcfg = scr_get_mission_config(selected_mission);
    var bst  = scr_get_mission_status(selected_mission);

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);
    draw_set_colour(c_gold);
    draw_text_transformed(brief_x + 16, brief_y + 38,
        "Mission " + string(selected_mission + 1) + ": " + bcfg.name, 1.1, 1.1, 0);

    draw_set_colour(c_muted);
    draw_text_ext(brief_x + 16, brief_y + 62, bcfg.description, 18, brief_w - 32);

    // Footer stats
    var stat_y = brief_y + brief_h - 28;
    draw_set_colour(c_bronze);
    draw_line(brief_x + 16, stat_y - 8, brief_x + brief_w - 16, stat_y - 8);

    draw_set_colour(c_muted);
    draw_set_halign(fa_left);
    var tl_txt = (bcfg.time_limit == -1) ? "No time limit" : (string(bcfg.time_limit / 60) + " min");
    draw_text(brief_x + 16, stat_y, tl_txt);

    draw_set_halign(fa_right);
    draw_set_colour(bst == "COMPLETE" ? c_complete : c_gold_dim);
    draw_text(brief_x + brief_w - 16, stat_y,
        bst == "COMPLETE" ? "★ EARNED" : ("★ +" + string(bcfg.skill_points_reward) + " pts"));
}

// UPGRADE PANEL
draw_set_colour(c_panel);
draw_rectangle(upgrade_x, upgrade_y, upgrade_x + upgrade_w, upgrade_y + upgrade_h, false);
draw_set_colour(c_border);
draw_rectangle(upgrade_x, upgrade_y, upgrade_x + upgrade_w, upgrade_y + upgrade_h, true);

draw_set_colour(c_rivet);
draw_circle(upgrade_x + 14,              upgrade_y + 14,              rv, false);
draw_circle(upgrade_x + upgrade_w - 14,  upgrade_y + 14,              rv, false);
draw_circle(upgrade_x + 14,              upgrade_y + upgrade_h - 14,  rv, false);
draw_circle(upgrade_x + upgrade_w - 14,  upgrade_y + upgrade_h - 14,  rv, false);
draw_set_colour(c_bg);
draw_circle(upgrade_x + 14,              upgrade_y + 14,              rv - 3, false);
draw_circle(upgrade_x + upgrade_w - 14,  upgrade_y + 14,              rv - 3, false);
draw_circle(upgrade_x + 14,              upgrade_y + upgrade_h - 14,  rv - 3, false);
draw_circle(upgrade_x + upgrade_w - 14,  upgrade_y + upgrade_h - 14,  rv - 3, false);

draw_set_colour(c_panel_dark);
draw_rectangle(upgrade_x + 2, upgrade_y + 2, upgrade_x + upgrade_w - 2, upgrade_y + 36, false);
draw_set_colour(c_gold);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(upgrade_x + upgrade_w * 0.5, upgrade_y + 19, "UNIT UPGRADES", 1.3, 1.3, 0);

if (instance_exists(oGame)) {
    var sp = oGame.skill_points_available;

    // Points badge
    draw_set_colour(c_panel_dark);
    draw_rectangle(upgrade_x + upgrade_w * 0.5 - 34, upgrade_y + 42,
                   upgrade_x + upgrade_w * 0.5 + 34, upgrade_y + 84, false);
    draw_set_colour(c_gold_dim);
    draw_rectangle(upgrade_x + upgrade_w * 0.5 - 34, upgrade_y + 42,
                   upgrade_x + upgrade_w * 0.5 + 34, upgrade_y + 84, true);
    draw_set_colour(c_gold);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(upgrade_x + upgrade_w * 0.5, upgrade_y + 63, string(sp), 2.2, 2.2, 0);

    draw_set_colour(c_muted);
    draw_set_valign(fa_top);
    draw_text(upgrade_x + upgrade_w * 0.5, upgrade_y + 88, "UPGRADES AVAILABLE");

    // Skill slots
    var slot_x1  = upgrade_x + 12;
    var slot_x2  = upgrade_x + upgrade_w - 12;
    var slot_h   = 44;
    var slot_gap = 6;
    var list_top = upgrade_y + 118;
    var list_bot = upgrade_y + upgrade_h - 10;

    draw_set_halign(fa_left);
    draw_set_valign(fa_top);

    for (var i = 0; i < SKILL_COUNT; i++) {
        var sy1  = list_top + i * (slot_h + slot_gap) - upgrade_scroll;
        var sy2  = sy1 + slot_h;
        if (sy2 < list_top || sy1 > list_bot) continue;

        var unlocked = oGame.skill_unlocked[i];
        var can_buy  = scr_can_unlock_skill(i);
        var shov     = point_in_rectangle(mx, my, slot_x1, sy1, slot_x2, sy2)
                        && sy1 > list_top - 5 && sy2 < list_bot + 5;

if (unlocked) {
    draw_set_colour(make_colour_rgb(18, 42, 20));
} else if (can_buy) {
    if (shov) {
        draw_set_colour(make_colour_rgb(50, 38, 15));
    } else {
        draw_set_colour(make_colour_rgb(30, 24, 12));
    }
} else {
    draw_set_colour(make_colour_rgb(20, 16, 10));
}
        draw_rectangle(slot_x1, sy1, slot_x2, sy2, false);

if (unlocked) {
    draw_set_colour(c_complete);
} else if (can_buy) {
    draw_set_colour(c_gold_dim);
} else {
    draw_set_colour(c_locked);
}
        draw_rectangle(slot_x1, sy1, slot_x2, sy2, true);

if (unlocked) {
    draw_set_colour(c_complete);
} else if (can_buy) {
    draw_set_colour(c_gold);
} else {
    draw_set_colour(c_locked);
};
        draw_text(slot_x1 + 10, sy1 + 6, oGame.skill_name[i]);

        draw_set_colour(make_colour_rgb(100, 88, 65));
        draw_text(slot_x1 + 10, sy1 + 24, oGame.skill_desc[i]);

        draw_set_halign(fa_right);
        if (unlocked) {
            draw_set_colour(c_complete);
            draw_text(slot_x2 - 8, sy1 + 14, "✓");
        } else if (can_buy) {
            draw_set_colour(c_gold);
            draw_text(slot_x2 - 8, sy1 + 14, "1 pt ▶");
        } else {
            draw_set_colour(c_locked);
            draw_text(slot_x2 - 8, sy1 + 14, "LOCKED");
        }
        draw_set_halign(fa_left);
    }
}

// COMMAND PANEL
draw_set_colour(c_panel);
draw_rectangle(command_x, command_y, command_x + command_w, command_y + command_h, false);
draw_set_colour(c_border);
draw_rectangle(command_x, command_y, command_x + command_w, command_y + command_h, true);

draw_set_colour(c_rivet);
draw_circle(command_x + 14,               command_y + 14,               rv, false);
draw_circle(command_x + command_w - 14,   command_y + 14,               rv, false);
draw_circle(command_x + 14,               command_y + command_h - 14,   rv, false);
draw_circle(command_x + command_w - 14,   command_y + command_h - 14,   rv, false);
draw_set_colour(c_bg);
draw_circle(command_x + 14,               command_y + 14,               rv - 3, false);
draw_circle(command_x + command_w - 14,   command_y + 14,               rv - 3, false);
draw_circle(command_x + 14,               command_y + command_h - 14,   rv - 3, false);
draw_circle(command_x + command_w - 14,   command_y + command_h - 14,   rv - 3, false);

draw_set_colour(c_panel_dark);
draw_rectangle(command_x + 2, command_y + 2, command_x + command_w - 2, command_y + 36, false);
draw_set_colour(c_gold);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(command_x + command_w * 0.5, command_y + 19, "BATTLE COMMAND", 1.3, 1.3, 0);

// Selected mission name
if (selected_mission >= 0) {
    var mcfg = scr_get_mission_config(selected_mission);
    var mst  = scr_get_mission_status(selected_mission);
    draw_set_colour(mst == "LOCKED" ? c_locked : c_muted);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);
    draw_text(command_x + command_w * 0.5, command_y + 44,
        "Mission " + string(selected_mission + 1) + ": " + mcfg.name);
}

// LAUNCH BATTLE button
var launch_x1  = command_x + 20;
var launch_y1  = command_y + 75;
var launch_x2  = command_x + command_w - 20;
var launch_y2  = launch_y1 + 76;
var launch_hov = point_in_rectangle(mx, my, launch_x1, launch_y1, launch_x2, launch_y2);
var launch_ok  = (scr_get_mission_status(selected_mission) == "AVAILABLE"
               || scr_get_mission_status(selected_mission) == "COMPLETE");

draw_set_colour(launch_ok ? (launch_hov ? make_colour_rgb(150, 35, 28) : c_red_dark)
                          : make_colour_rgb(35, 28, 20));
draw_rectangle(launch_x1, launch_y1, launch_x2, launch_y2, false);
draw_set_colour(launch_ok ? (launch_hov ? c_gold : c_red_bright) : c_locked);
draw_rectangle(launch_x1, launch_y1, launch_x2, launch_y2, true);
draw_set_colour(launch_ok ? c_white : c_locked);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed((launch_x1 + launch_x2) * 0.5, (launch_y1 + launch_y2) * 0.5,
    "LAUNCH BATTLE", 1.5, 1.5, 0);

if (!launch_ok) {
    draw_set_colour(c_locked);
    draw_set_valign(fa_top);
    draw_text(command_x + command_w * 0.5, launch_y2 + 6, "Select an available mission");
}

// MAIN MENU button
var menu_x1  = command_x + 20;
var menu_y1  = command_y + command_h - 62;
var menu_x2  = command_x + command_w - 20;
var menu_y2  = menu_y1 + 44;
var menu_hov = point_in_rectangle(mx, my, menu_x1, menu_y1, menu_x2, menu_y2);

draw_set_colour(menu_hov ? make_colour_rgb(50, 40, 25) : make_colour_rgb(28, 22, 14));
draw_rectangle(menu_x1, menu_y1, menu_x2, menu_y2, false);
draw_set_colour(menu_hov ? c_gold : c_bronze);
draw_rectangle(menu_x1, menu_y1, menu_x2, menu_y2, true);
draw_set_colour(menu_hov ? c_gold : c_muted);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed((menu_x1 + menu_x2) * 0.5, (menu_y1 + menu_y2) * 0.5,
    "MAIN MENU", 1.1, 1.1, 0);

// DEV SKIP BUTTONS delete later
draw_set_halign(fa_left);
draw_set_valign(fa_top);
draw_set_alpha(0.75);
draw_set_colour(make_colour_rgb(180, 50, 50));
draw_text(dev_btn_x, dev_btn_y_start - 18, "[DEV] Complete & play cutscene:");
draw_set_alpha(1);

var dev_labels = ["M1 Stone vs Greek",  "M2 Iron Age",
                  "M3 Greek vs Modern", "M4 Modern vs Modern",
                  "M5 Portal Defense",  "M6 Zeus Final"];

for (var i = 0; i < MissionID.COUNT; i++) {
    var bx1  = dev_btn_x;
    var by1  = dev_btn_y_start + i * (dev_btn_h + 4);
    var bx2  = bx1 + dev_btn_w;
    var by2  = by1 + dev_btn_h;
    var bhov = point_in_rectangle(mx, my, bx1, by1, bx2, by2);

    draw_set_alpha(bhov ? 1.0 : 0.65);
    draw_set_colour(bhov ? make_colour_rgb(80, 26, 26) : make_colour_rgb(44, 18, 18));
    draw_rectangle(bx1, by1, bx2, by2, false);
    draw_set_colour(make_colour_rgb(160, 70, 70));
    draw_rectangle(bx1, by1, bx2, by2, true);
    draw_set_colour(make_colour_rgb(220, 140, 140));
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text((bx1 + bx2) * 0.5, (by1 + by2) * 0.5, dev_labels[i]);
    draw_set_alpha(1);
}

// CONFIRM DIALOG
if (confirm_open && confirm_mission >= 0) {
    var ccfg = scr_get_mission_config(confirm_mission);

    draw_set_alpha(0.72);
    draw_set_colour(c_bg);
    draw_rectangle(0, 0, gw, gh, false);
    draw_set_alpha(1);

    draw_set_colour(c_panel);
    draw_rectangle(confirm_x, confirm_y, confirm_x + confirm_w, confirm_y + confirm_h, false);
    draw_set_colour(c_border);
    draw_rectangle(confirm_x, confirm_y, confirm_x + confirm_w, confirm_y + confirm_h, true);
    draw_set_colour(c_gold);
    draw_line(confirm_x + 2, confirm_y, confirm_x + confirm_w - 2, confirm_y);

    draw_set_colour(c_panel_dark);
    draw_rectangle(confirm_x + 2, confirm_y + 2, confirm_x + confirm_w - 2, confirm_y + 36, false);
    draw_set_colour(c_gold);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed(confirm_x + confirm_w * 0.5, confirm_y + 19, "DEPLOY FORCES?", 1.4, 1.4, 0);

    draw_set_colour(c_gold);
    draw_set_valign(fa_top);
    draw_text_transformed(confirm_x + confirm_w * 0.5, confirm_y + 50, ccfg.name, 1.1, 1.1, 0);

    draw_set_colour(c_muted);
    var ctlim = (ccfg.time_limit == -1) ? "No time limit" : (string(ccfg.time_limit / 60) + " min");
    draw_text(confirm_x + confirm_w * 0.5, confirm_y + 82,
        ctlim + "   |   Reward: +" + string(ccfg.skill_points_reward) + " pts");
    draw_text_ext(confirm_x + confirm_w * 0.5, confirm_y + 112,
        ccfg.description, 18, confirm_w - 60);

    var btn_w  = 150;
    var btn_h  = 44;
    var yes_x1 = confirm_x + confirm_w * 0.5 - 18 - btn_w;
    var yes_y1 = confirm_y + confirm_h - btn_h - 22;
    var yes_x2 = yes_x1 + btn_w;
    var yes_y2 = yes_y1 + btn_h;
    var no_x1  = confirm_x + confirm_w * 0.5 + 18;
    var no_y1  = yes_y1;
    var no_x2  = no_x1 + btn_w;
    var no_y2  = yes_y2;
    var yhov   = point_in_rectangle(mx, my, yes_x1, yes_y1, yes_x2, yes_y2);
    var nhov   = point_in_rectangle(mx, my, no_x1,  no_y1,  no_x2,  no_y2);

    draw_set_colour(yhov ? make_colour_rgb(160, 40, 30) : c_red_dark);
    draw_rectangle(yes_x1, yes_y1, yes_x2, yes_y2, false);
    draw_set_colour(yhov ? c_gold : c_red_bright);
    draw_rectangle(yes_x1, yes_y1, yes_x2, yes_y2, true);
    draw_set_colour(c_white);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_text_transformed((yes_x1+yes_x2)*0.5, (yes_y1+yes_y2)*0.5, "DEPLOY", 1.1, 1.1, 0);

    draw_set_colour(nhov ? make_colour_rgb(48, 38, 20) : make_colour_rgb(30, 24, 14));
    draw_rectangle(no_x1, no_y1, no_x2, no_y2, false);
    draw_set_colour(nhov ? c_gold : c_bronze);
    draw_rectangle(no_x1, no_y1, no_x2, no_y2, true);
    draw_set_colour(nhov ? c_gold : c_muted);
    draw_text_transformed((no_x1+no_x2)*0.5, (no_y1+no_y2)*0.5, "CANCEL", 1.1, 1.1, 0);
}

// Reset draw state
draw_set_alpha(1);
draw_set_colour(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
