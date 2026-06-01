// Inherit the parent event
event_inherited();

team = Team.ENEMY;

max_hp = 160;
hp = max_hp;
move_speed = 0.8;
damage = 17;
attack_range = 130;
attack_cooldown = floor(TARGET_FPS * 1.9);
uses_projectiles = true;
unit_cost = 220;
gold_reward = floor(unit_cost * (2/3));
