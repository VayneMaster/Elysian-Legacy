// Inherit the parent event
event_inherited();

team = Team.ENEMY;

max_hp =220;
hp = max_hp;
move_speed = 1;
damage = 22;
attack_range = 35;
attack_cooldown = floor(TARGET_FPS * 1.1);
uses_projectiles = false;
unit_cost = 250;
gold_reward = floor(unit_cost * (2/3));
