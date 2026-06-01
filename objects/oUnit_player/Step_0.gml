//Death
if (hp <= 0) {
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
