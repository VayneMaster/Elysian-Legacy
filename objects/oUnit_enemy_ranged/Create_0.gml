// Inherit the parent event
event_inherited();

team = Team.ENEMY;

//stats
max_hp = 70;
hp = max_hp;
move_speed = 1.6;
damage = 12;
attack_range = 220;
attack_cooldown = floor(TARGET_FPS * 1.2); // 1.2 sec aprox

unit_cost = 120;
gold_reward = floor(unit_cost * (2/3));

uses_projectiles = true;