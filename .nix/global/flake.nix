
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
        
        # development productivity
        tmux
        neovim
        
        # shell stuff
        fish
        bash
        starship

        # build tools and programming languages
        meson
        llvm
        bear
        hugo
        llvm
        bison
        ninja
        cmake
        pkg-config
        ncurses
        
        nodejs_22
        go
        pipx
        dart-sass

        # git 
        git-crypt
        delta # page for git diffs
        git
        
        # cli productivity (most to least used)
        zoxide
        bat
        ripgrep
        fzf
        tree
        fd
        less
        htop
        fastfetch
        du-dust
        bottom
        eza

        # cli utilities
        ffmpeg
        wget
        darwin.trash
        pass
        gnupg
        pandoc
        lazygit
        jq
        
        # LSP
        nixd

        # other/should delete?
        #fontforge
        #poppler_utils
      ];
    };
  };
}
