// Free surface when menu is destroyed

if (surface_exists(pause_snap_surf)) {
    surface_free(pause_snap_surf);
    pause_snap_surf = -1;
}