{
  pkgs,
  config,
  lib,
  channel,
  namespace,
  ...
}:
with lib;
with lib.${namespace}; {
  imports = [./hardware.nix];

  # Resolve an issue with Bismuth's wired connections failing sometimes due to weird
  # DHCP issues. I'm not quite sure why this is the case, but I have found that the
  # problem can be resolved by stopping dhcpcd, restarting Network Manager, and then
  # unplugging and replugging the ethernet cable. Perhaps there's some weird race
  # condition when the system is coming up that causes this.
  # networking.dhcpcd.enable = false;

nix.settings.trusted-substituters = ["https://ai.cachix.org"];
nix.settings.trusted-public-keys = ["ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="];
services.ntp.enable = true;

home-manager.backupFileExtension = "backup";

  boot.initrd.systemd.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];
  boot.plymouth.enable = true;
  boot.plymouth.theme = "breeze";
  environment.systemPackages = with pkgs; [
    plymouth
    breeze-plymouth
  ];
  hardware.nvidia-container-toolkit.enable = true;
#  boot.binfmt.emulatedSystems = ["aarch64-linux"];

  # NOTE: This _may_ be required for openvpn to work. However, I have
  # not confirmed that...
#  boot.kernelModules = ["tun"];


  snowfallorg.users.george.admin = false;
  Orchid = {

  };

  system.stateVersion = "21.11"; # Did you read the comment?
}
