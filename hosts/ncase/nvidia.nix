{
  config,
  ...
}:

{
  # The monitor is plugged into the NVIDIA GPU; use the proprietary driver
  # instead of nouveau for substantially better performance.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
