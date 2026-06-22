function scr_get_special_config(_special_id){
	
	var config = {};
	//numbers can be tweaked for balancing
	switch (_special_id) {
		case SpecialID.ROCKS:
			config.name = "ROCKS";
			config.damage = 100;
			config.cooldown = 20;
			break;
		
		case SpecialID.SPEARS:
		config.name = "SPEARS";
		config.damage = 150;
		config.cooldown = 26;
		break;
		
		case SpecialID.IRON:
		config.name = "IRON";
		config.damage = 200;
		config.cooldown = 30;
		break;
		
		case SpecialID.MODERN:
		config.name = "MODERN";
		config.damage = 250;
		config.cooldown = 35;
		break;
		
		case SpecialID.LASER:
		config.name = "LASER";
		config.damage = 300;
		config.cooldown = 40;
		break;
		
		case SpecialID.LIGHTNING:
		config.name = "LIGHTNING";
		config.damage = 375;
		config.cooldown = 43;
		break;
		
		default:
		config.name = "UNKOWN";
		config.damage = 0;
		config.cooldown = 30;
		break;
	}
	return config;

}