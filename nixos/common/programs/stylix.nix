{ user, inputs, pkgs, ...}: {
  imports = [
    inputs.stylix.nixosModules.stylix
  ];

  stylix = {
    enable = true;
    autoEnable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/darcula.yaml";
    homeManagerIntegration.autoImport = true;
  };
}
