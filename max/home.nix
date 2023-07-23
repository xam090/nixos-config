{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "max";
  home.homeDirectory = "/home/max";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = with pkgs; [
    firefox
    vscodium
    subversionClient
    meld
    gnumake
    gcc
    python311Full
    binutils
    opam
    rustup
    p7zip
    texlive.combined.scheme-full
    texstudio
    xclip
    libsForQt5.kwallet
    zotero
    (builtins.getFlake "github:xam090/kdesvn-flake/2c7b8b248126b97550e23019c7e495728dd311af").packages.x86_64-linux.default
    # (builtins.getFlake "/home/max/GitProjects/kdesvn-flake").packages.x86_64-linux.default
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    ".config/helix/config.toml".source = ./files/helix.toml;
    ".config/kdesvnpartrc".source = ./files/kdesvnpartrc;
  };

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/media-keys" = {
      custom-keybindings = [
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
        "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
      ];
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
      binding = "<Control><Alt>t";
      command = "kgx";
      name = "open-terminal";
    };

    "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
      binding = "<Control><Alt>c";
      command = "codium";
      name = "open-vscodium";
    };


    "org/gnome/desktop/inferface" = {
      color-scheme = "prefer-dark";
    };

    "org/gnome/mutter" = {
      edge-tiling = true;
    };
  };

  programs.zsh = {
    enable = true;
    enableAutosuggestions = true;
    shellAliases = {
      temp = "cd $(mktemp -d)";
      shx = "sudo hx --config /home/max/.config/helix/config.toml";
      rb = "sudo nixos-rebuild switch";
    };
    initExtra = ''
      disasm() {
        if [[ $# -eq 1 ]]
        then
          objdump -S -M intel --disassemble "$1"
        else
          objdump -S -M intel "$@" "--disassemble=$2" "$1"
        fi
      }
    '';
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "sudo" "copyfile" "history" ];
      theme = "duellj";
    };
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
