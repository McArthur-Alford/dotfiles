{ ... }:
{
  programs = {
    zathura = {
      enable = true;
      extraConfig = ''
        set synctex true
        set synctex-editor-command "texlab inverse-search -i %{input} -l %{line}"
      '';
    };
  };
}
