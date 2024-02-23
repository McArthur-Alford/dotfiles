{desktop, lib, pkgs, ...}:
{
  imports = [
    
  ]  ++ lib.optional (builtins.pathExists (./. + "/${desktop}")) ./${desktop};
}
