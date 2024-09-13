{ pkgs, lib, ... }:
{
  programs.helix = {
    enable = true;
    settings = {
      theme = lib.mkForce "eva";
      editor.undercurl = true;
      editor.true-color = true;
      editor.lsp.display-inlay-hints = true;
      editor.soft-wrap.enable = true;
      editor.bufferline = "multiple";
      # lsp.display-messages = true;
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
      eva = {
        attribute = "#875FAF";
        keyword = "#AB92FC";
        "keyword.directive" = "#875FAF";
        namespace = "#875FAF";
        punctuation = "#AB92FC";
        "punctuation.delimiter" = "#AB92FC";
        operator = "#875FAF";
        special = "#D99145";
        "variable.other.member" = "#E1D6F8";
        variable = "#AB92FC";
        "variable.parameter" = {
          fg = "#AB92FC";
        };
        "variable.builtin" = "#9CDA7C";
        type = "#E1D6F8";
        "type.builtin" = "#E1D6F8";
        constructor = "#875FAF";
        function = "#E1D6F8";
        "function.macro" = "#875FAF";
        "function.builtin" = "#E1D6F8";
        tag = "#D99145";
        comment = "#666666";
        constant = "#E1D6F8";
        "constant.builtin" = "#E1D6F8";
        string = "#9CDA7C";
        "constant.numeric" = "#D99145";
        "constant.character.escape" = "#D99145";
        label = "#D99145";

        "markup.heading" = "#875FAF";
        "markup.bold" = {
          modifiers = [ "bold" ];
        };
        "markup.italic" = {
          modifiers = [ "italic" ];
        };
        "markup.strikethrough" = {
          modifiers = [ "crossed_out" ];
        };
        "markup.link.url" = {
          fg = "#9CDA7C";
          modifiers = [ "underlined" ];
        };
        "markup.link.text" = "#D99145";
        "markup.raw" = "#D99145";

        "diff.plus" = "#87FF5F";
        "diff.minus" = "#BF2D2D";
        "diff.delta" = "#875FAF";

        "ui.background" = {
          bg = "#201430";
        };
        "ui.background.separator" = {
          fg = "#483160";
        };
        "ui.linenr" = {
          fg = "#483160";
        };
        "ui.linenr.selected" = {
          fg = "#875FAF";
        };
        "ui.statusline" = {
          fg = "#875FAF";
          bg = "#000000";
        };
        "ui.statusline.inactive" = {
          fg = "#AB92FC";
          bg = "#000000";
        };
        "ui.popup" = {
          bg = "#000000";
        };
        "ui.window" = {
          fg = "#5B2B41";
        };
        "ui.help" = {
          bg = "#67478A";
          fg = "#201430";
        };
        "ui.text" = {
          fg = "#AB92FC";
        };
        "ui.text.focus" = {
          fg = "#E1D6F8";
        };
        "ui.text.inactive" = "#666666";
        "ui.virtual" = {
          fg = "#483160";
        };
        "ui.virtual.ruler" = {
          bg = "#5B2B41";
        };
        "ui.virtual.jump-label" = {
          fg = "#D99145";
          modifiers = [ "bold" ];
        };
        "ui.virtual.indent-guide" = {
          fg = "#483160";
        };

        "ui.selection" = {
          bg = "#5B2B41";
        };
        "ui.selection.primary" = {
          bg = "#5B2B41";
        };
        "ui.cursor.select" = {
          bg = "#AB92FC";
        };
        "ui.cursor.insert" = {
          bg = "#E1D6F8";
        };
        "ui.cursor.primary.select" = {
          bg = "#AB92FC";
        };
        "ui.cursor.primary.insert" = {
          bg = "#E1D6F8";
        };
        "ui.cursor.match" = {
          fg = "#212121";
          bg = "#6D7BA6";
        };
        "ui.cursor" = {
          modifiers = [ "reversed" ];
        };
        "ui.cursorline.primary" = {
          bg = "#5B2B41";
        };
        "ui.highlight" = {
          bg = "#5B2B41";
        };
        "ui.highlight.frameline" = {
          bg = "#6E4C28";
        };
        "ui.debug" = {
          fg = "#6E4C28";
        };
        "ui.debug.breakpoint" = {
          fg = "#D99145";
        };
        "ui.menu" = {
          fg = "#AB92FC";
          bg = "#000000";
        };
        "ui.menu.selected" = {
          fg = "#000000";
          bg = "#E1D6F8";
        };
        "ui.menu.scroll" = {
          fg = "#AB92FC";
          bg = "#483160";
        };

        "diagnostic.hint" = {
          underline = {
            color = "#9CDA7C";
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = "#AB92FC";
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = "#D99145";
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = "#BF2D2D";
            style = "curl";
          };
        };
        "diagnostic.unnecessary" = {
          modifiers = [ "dim" ];
        };
        "diagnostic.deprecated" = {
          modifiers = [ "crossed_out" ];
        };

        warning = "#D99145";
        error = "#BF2D2D";
        info = "#AB92FC";
        hint = "#9CDA7C";

        palette = {
          black = "#000000";
          magenta = "#483160";
          green = "#87FF5F";
          lost = "#666666";
          unit01 = "#67478A";
          selee = "#875FAF";
          mint = "#9CDA7C";
          hazard = "#D99145";
          purple = "#AB92FC";
          lcl = "#5B2B41";
          nerv = "#BF2D2D";
          rei = "#E1D6F8";
        };
      };

    };
  };
}
