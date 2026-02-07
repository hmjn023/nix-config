{ config, pkgs, ... }:

{
  # Fix high CPU usage caused by ACPI interrupt storm (gpe6D)
  # Disable on boot
  systemd.services.disable-gpe6d = {
    description = "Disable GPE 6D to prevent high CPU usage";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "${pkgs.runtimeShell} -c 'echo disable > /sys/firmware/acpi/interrupts/gpe6D'";
      # Ignore errors if already disabled
      SuccessExitStatus = "0 1";
    };
  };

  # Disable on resume from suspend/hibernate
  powerManagement.resumeCommands = ''
    echo disable > /sys/firmware/acpi/interrupts/gpe6D
  '';

  # Trackpoint Scroll & Sensitivity
  services.udev.extraRules = ''
    ACTION=="add|change", KERNEL=="event*", ATTRS{name}=="TPPS/2 Synaptics TrackPoint", ENV{LIBINPUT_SCROLL_METHOD}="button", ENV{LIBINPUT_SCROLL_BUTTON}="274", ENV{LIBINPUT_CONFIG_ACCEL_SPEED}="-0.5", ENV{LIBINPUT_SCROLL_PIXEL_DISTANCE}="50"
  '';
}
