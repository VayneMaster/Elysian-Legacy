event_inherited();

max_hp = 1000;
hp = max_hp;

team = Team.PLAYER;

x = 200;
y = room_height * 0.5;

oGame.player_base = id;

turret_slot_count = 2;
turret_slots = array_create(turret_slot_count, -1);

turret_slot_dx = array_create(turret_slot_count, 0);
turret_slot_dy = array_create(turret_slot_count, 0);

turret_slot_dx[0] = 40;  turret_slot_dy[0] = -20;
turret_slot_dx[1] = 80;  turret_slot_dy[1] = -20;
