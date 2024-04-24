
{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = {self, nixpkgs}: {
    packages."aarch64-darwin".default = let
      pkgs = nixpkgs.legacyPackages."aarch64-darwin";
    in pkgs.buildEnv {
      name = "home-packages";
      paths = with pkgs; [
        pandoc
        tmux
        fish
        meson
        bash
        neovim
        fzf
        fd
        bat
        starship
        ripgrep
        llvm
        bear
        nixd
        delta
        ffmpeg
        ncurses
        ninja
        bear
        bison
        wget
        darwin.trash
        llvm
        git-crypt
        cmake
        pass
        fastfetch
        du-dust
        bottom
        htop
        zoxide
        lazygit
        eza
        git
        less
        fontforge
        tree
      ];
    };
  };
}
