# A Vultr VPS that I use to play/learn with NixOS
#
# Usage:
# - Create new Vultr instance from NixOS 18.09 ISO
# - Click `View Console`
#   $ curl https://eipi.xyz/vultr.sh | bash
# - Click Settings -> Custom ISO -> Remove ISO
# $ ssh root@<IP>  # password is "qqcTch4m"
#   $ nix-channel --add https://nixos.org/channels/nixos-19.09 nixos
#   $  nixos-rebuild switch --upgrade
#   $ vim /etc/nixos/configuration.nix  # add git to environment.systemPackages
#   $ nixos-rebuild switch
#   $ cd /etc/nixos
#     $ git init
#     $ git remote add origin https://github.com/zupo/nix.git
#     $ git pull
#     $ git checkout master
#     $ mv configuration.nix configuration.nix.bak
#     $ mv hardware-configuration.nix vultr/hardware-configuration.nix
#     $ ln -s vultr.nix configuration.nix
#     $ vim secrets/email && truncate -s -1 secrets/email && git update-index --assume-unchanged secrets/email
#     $ passwd  # set a new root password
#     $ nixos-rebuild switch
# $ ssh zupo@<IP>  # no password should be required, login with pubkey
#   $ sudo su -
#   $ reboot

{ config, pkgs, ... }:

{
  imports =
    [
      ./vultr/hardware-configuration.nix
      ./features/common.nix
    ];

  # Use the GRUB 2 boot loader.
  boot.loader.grub.enable = true;
  boot.loader.grub.version = 2;
  boot.loader.grub.device = "/dev/vda";
}
