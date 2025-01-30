{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    homebrew-nix.url = "github:homebrew/brew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs }:
  let
    configuration = { pkgs, ... }: {
      # List packages installed in system profile. To search by name, run:
      environment.systemPackages = with pkgs; [
        neovim
        tmux
        docker
        podman
        firefox
      ];

      # Homebrew Configuration
      homebrew = {
        enable = true;
        onActivation = {
          autoUpdate = true;
          cleanup = "zap";
        };
        taps = [
          "homebrew/cask"
          "homebrew/cask-versions"
        ];
        casks = [
          "google-chrome"
          "arc"
          "ghostty"
          "raycast"
          "rustdesk"
          "betterdisplay"
          "slack"
          "cursor"
          "input-source-pro"
          "apidog"
          "obsidian"
          "tailscale"
          "claude"
        ];
      };

      # Docker configuration
      virtualisation = {
        docker.enable = true;
        podman.enable = true;
      };

      # Enable Fish Shell
      programs.fish.enable = true;
      environment.shells = with pkgs; [ fish ];
      # Set Fish as default shell for your user
      environment.variables.SHELL = "${pkgs.fish}/bin/fish";

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 6;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."simple" = nix-darwin.lib.darwinSystem {
      modules = [ configuration ];
    };
  };
}
