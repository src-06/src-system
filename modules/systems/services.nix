{ ... }:

{
  services = {
    tuned.enable = true;
    upower.enable = true;

    xserver = {
      enable = true;
      videoDrivers = [ "amdgpu" ];
      # libinput.enable = true;

      xkb = {
        layout = "us";
        variant = "";
      };
    };

    printing.enable = true;

    pulseaudio.enable = false;

    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      # jack.enable = true;
      # media-session.enable = true;
    };

    # openssh = {
    #   enable = true;
    #   settings = {
    #     PermitRootLogin = "no";
    #     PasswordAuthentication = false;
    #   };
    # };
  };
}
