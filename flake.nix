{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      nixpkgs,
      flake-utils,
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs { inherit system; };
      in
      {
        devShells.default = pkgs.mkShell {
          shellHook = ''
            export GEM_HOME=$PWD/.nix/ruby/$(${pkgs.ruby}/bin/ruby -e "puts RUBY_VERSION")
            mkdir -p $GEM_HOME
            export GEM_PATH=$GEM_HOME
            export PATH=$GEM_HOME/bin:$PATH
          '';

          buildInputs = with pkgs; [
            ruby
            bundler
          ];
        };
      }
    );
}
