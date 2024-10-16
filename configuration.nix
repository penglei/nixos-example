{ pkgs, username, ... }:

{
  system.stateVersion = "23.05";

  time.timeZone = "Asia/Shanghai";

  users.users.${username} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIQG7W1vDUCVEklJQtUtr9Jtp5hnY2k/cMGzOwNcfexY"
    ];
  };

  security.sudo.extraRules = [{
    users = [ username ];
    commands = [{
      command = "ALL";
      options = [ "NOPASSWD" "SETENV" ];
    }];
  }];

  services.openssh.enable = true;

  environment.systemPackages = with pkgs; [ git vim curl pstree htop tree ];
}

