_: {
  nixpkgs.config.pulseaudio = true;

  security.rtkit.enable = true;
  # services.pulseaudio.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    wireplumber.enable = true;
  };
}
