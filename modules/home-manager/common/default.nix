{
  outputs,
  userConfig,
  pkgs,
  isCorporate,
  ...
}:
{
  imports = [
     ../programs/ghostty
  ];

  # Nixpkgs configuration
  nixpkgs = {
    # overlays = [
    #   outputs.overlays.stable-packages
    # ];

    config = {
      allowUnfree = true;
    };
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # Home-Manager configuration for the user's home environment
  home = {
    username = "${userConfig.name}";
    homeDirectory =
      if pkgs.stdenv.isDarwin then "/Users/${userConfig.name}" else "/home/${userConfig.name}";
  };

  # Ensure common packages are installed
  home.packages =
    with pkgs;
    [
      ghostty-bin # install Ghostty prebuilt binary to ~/Application/Home\ Manager\ Apps/
      # yq
    ]
    ++ lib.optionals isCorporate [
      raycast
    ]
    ++ lib.optionals (!isCorporate) [
    ];


}
