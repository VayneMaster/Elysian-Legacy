global.camera_setup = CameraSetup.BATTLEFIELD;
if (instance_exists(oCamera)) {
    with (oCamera) { event_user(0); }
}