{ hostname, ... }: {
  boot = {
    initrd.availableKernelModules = [ "nvme" "xhci_pci" ];
    loader = {
      timeout = 1;

      systemd-boot.enable = true;
      efi.efiSysMountPoint = "/boot";
      efi.canTouchEfiVariables = true;

      # grub.enable = true;
      # grub.device = "/dev/nvme0n1";
    };

  };

  fileSystems."/boot" = {
    device = "/dev/nvme0n1p1";
    fsType = "vfat";
    options = [ "fmask=0077" "dmask=0077" ];
  };
  fileSystems."/" = {
    device = "/dev/disk/by-label/nixos";
    fsType = "ext4";
  };

  # fileSystems."/boot" = {
  #   device = "/dev/disk/by-partlabel/disk-main-esp";
  #   fsType = "vfat";
  #   options = [ "fmask=0077" "dmask=0077" ];
  # };
  # fileSystems."/" = {
  #   device = "/dev/disk/by-partlabel/disk-main-root";
  #   fsType = "ext4";
  # };

  networking = {
    #我们使用 dhcpcd, resolvconf 管理网络配置，因此打开这两个配置。

    dhcpcd.enable = true;
    #自动配置 /etc/resolv.conf 的工具有: netconfig, NetworkManager, resolvconf, rdnssd，systemd-resolved。
    #如果不使用这些工具，则需要手动配置，比较麻烦。
    resolvconf.enable = true;

    useDHCP = true;
    hostName = hostname;
  };
}
