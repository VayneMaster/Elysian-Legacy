function scr_turret_stats(_t){
	switch (_t.turret_type) {
		case 0: //cnn 1
		_t.damage = 10
		_t.range = 300;
		_t.rof_steps = 20;
		break;
		
		case 1: //cnn 2
		_t.damage = 15;
		_t.range = 230;
		_t.rof_steps = 22;
		break;
		
		case 2: //cnn 3
		_t.damage = 8;
		_t.range = 230;
		_t.rof_steps = 10;
		break;
		
		case 3: //cnnan 4
		_t.damage = 30;
		_t.range = 350;
		_t.rof_steps = 27;
		break;
	}
	_t.cooldown = irandom(_t.rof_steps);

}