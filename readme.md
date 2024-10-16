# NixOS 安装示例


步骤:

1. kexec 进入临时的nixos系统

   ```
   # curl -L https://github.com/nix-community/nixos-images/releases/download/nixos-unstable/nixos-kexec-installer-noninteractive-x86_64-linux.tar.gz | tar -xzf- -C /root
   # /root/kexec/run
   ```

2. disko 磁盘分区

   ```
   # nix run github:nix-community/disko/latest -- --mode disko ./disko-config.nix
   ```

3. 执行安装

   ```
   # nixos-install --root /mnt --flake .#mynixiso
   ```

