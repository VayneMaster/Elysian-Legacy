//Death
if (hp <= 0) {
    if (instance_exists(oGame)) {
        oGame.stat_units_lost++;
    }
    instance_destroy();
    exit;
}

switch (state) {
    case UnitState.MOVING:
        unit_step_moving();
        break;

    case UnitState.ATTACKING:
        unit_step_attacking();
        break;
}
