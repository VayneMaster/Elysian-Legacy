team = Team.PLAYER;
lane_index = 1; //def middle lane
is_base = false;
uses_projectiles = false;
last_hit_team = -1; //not hit yet

//stats
max_hp = 100;
hp = max_hp;
move_speed = 1.5;
damage = 10;
attack_range = 40;
attack_cooldown = TARGET_FPS;
attack_timer = 0;


//money stats
unit_cost = 30;
gold_reward = floor(unit_cost * (2/3)); //gp per kill

// states


state = UnitState.MOVING;
target = noone;

//pos on lane
y = oGame.lane_y[lane_index];

//zone modifiers, calced ea step
zone_dmg = 1;
zone_def = 1;
zone_spd = 1;