{ pkgs, lib, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = lib.mkForce "alucard";
      editor.undercurl = true;
      editor.true-color = true;
      editor.lsp.display-inlay-hints = true;
      editor.soft-wrap.enable = true;
      editor.bufferline = "multiple";
    };

    languages.language = [
      {
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixfmt-rfc-style}/bin/nixfmt";
        language-servers = [ "nil" ];
      }
    ];

    languages.language-servers = [
      {
        name = "nil";
        command = "${pkgs.nil}/bin/nil";
      }
    ];

    themes = {
      alucard = {
        inherits = "stylix";
        ui.background = "{}";
        ui.virtual.inlay-hint.fg = "cyan";
      };
    };
  };
}
