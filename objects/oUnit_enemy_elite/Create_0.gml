// Inherit the parent event
event_inherited();

team = Team.ENEMY;

max_hp = 300;
hp = max_hp;
move_speed = 1.3;
damage = 40;
attack_range = 60;
attack_cooldown = floor(TARGET_FPS * 1.2);
uses_projectiles = false;
unit_cost = 375;
gold_reward = floor(unit_cost * (2/3));
