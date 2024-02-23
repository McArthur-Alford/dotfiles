{ desktop, lib, ... }:
{
  imports = lib.optional (builtins.pathExists (./. + "/${desktop}")) ./${desktop};
}
