{
  description = ''
    Everything You Need To Run Tablassert
    All in a Nix Flake - Using Nix Direnv
  '';
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs }:
        {
          devShells.default = pkgs.mkShell {
            env = {
              PLAYWRIGHT_BROWSERS_PATH = "${pkgs.playwright-driver.browsers}";
              PLAYWRIGHT_SKIP_VALIDATE_HOST_REQUIREMENTS = "true";
              PLAYWRIGHT_HOST_PLATFORM_OVERRIDE = "ubuntu-24.04";
              LC_ALL = "en_US.UTF-8";
              LANG = "en_US.UTF-8";
            };
            packages = with pkgs; [
              playwright-driver.browsers
              nodejs_24
              python314
              opencode
              awscli2
              bun
            ];
          };
        };
    };
}
