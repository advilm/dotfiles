{ user, ... }:
{
  programs.virt-manager.enable = true;
  users.users.${user}.extraGroups = [
    "libvirtd"
    "kvm"
  ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;
  boot.kernelModules = [
    "kvm-amd"
    "kvm-intel"
  ];
}
