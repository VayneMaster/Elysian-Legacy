if (last_hit_team == Team.PLAYER) {
	oGame.gold += gold_reward;
}
else if (last_hit_team == Team.ENEMY) {
	oGame.cpu_gold += gold_reward;
}