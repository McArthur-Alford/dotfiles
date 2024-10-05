{
  pkgs,
  lib,
  config,
  ...
}:
with config.lib.stylix.colors;
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
      eva = rec {
        palette = {
          purple_primary = "#875FAF";
          purple_secondary = "#AB92FC";
          # orange_primary = "#D99145";
          orange_primary = "${orange}";
          light_purple = "#d1c3f4";
          green_light = "#adf182";
          gray_dark = "#9590bd";
          green_bright = "#87FF5F";
          red_primary = "#f7262b";
          background_dark = "#201430";
          purple_dark = "#483160";
          black = "#000000";
          brown_dark = "#660831"; # base02
          purple_muted = "#67478A";
          blue_gray = "#6D7BA6";
          black_lighter = "#212121";
          brown_primary = "#6E4C28";
        };

        attribute = palette.purple_primary;
        keyword = palette.purple_secondary;
        "keyword.directive" = palette.purple_primary;
        namespace = palette.purple_primary;
        punctuation = palette.purple_secondary;
        "punctuation.delimiter" = palette.purple_secondary;
        operator = palette.purple_primary;
        special = palette.orange_primary;
        "variable.other.member" = palette.light_purple;
        variable = palette.purple_secondary;
        "variable.parameter" = {
          fg = palette.purple_secondary;
        };
        "variable.builtin" = palette.green_light;
        type = palette.light_purple;
        "type.builtin" = palette.light_purple;
        constructor = palette.purple_primary;
        function = palette.light_purple;
        "function.macro" = palette.purple_primary;
        "function.builtin" = palette.light_purple;
        tag = palette.orange_primary;
        comment = palette.gray_dark;
        constant = palette.light_purple;
        "constant.builtin" = palette.light_purple;
        string = palette.green_light;
        "constant.numeric" = palette.orange_primary;
        "constant.character.escape" = palette.orange_primary;
        label = palette.orange_primary;

        "markup.heading" = palette.purple_primary;
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
          fg = palette.green_light;
          modifiers = [ "underlined" ];
        };
        "markup.link.text" = palette.orange_primary;
        "markup.raw" = palette.orange_primary;

        "diff.plus" = palette.green_bright;
        "diff.minus" = palette.red_primary;
        "diff.delta" = palette.purple_primary;

        "ui.background" = {
          bg = palette.background_dark;
        };
        "ui.background.separator" = {
          fg = palette.purple_dark;
        };
        "ui.linenr" = {
          fg = palette.purple_dark;
        };
        "ui.linenr.selected" = {
          fg = palette.purple_primary;
        };
        "ui.statusline" = {
          fg = palette.purple_primary;
          bg = palette.black;
        };
        "ui.statusline.inactive" = {
          fg = palette.purple_secondary;
          bg = palette.black;
        };
        "ui.popup" = {
          bg = palette.black;
        };
        "ui.window" = {
          fg = palette.brown_dark;
        };
        "ui.help" = {
          bg = palette.purple_muted;
          fg = palette.background_dark;
        };
        "ui.text" = {
          fg = palette.purple_secondary;
        };
        "ui.text.focus" = {
          fg = palette.light_purple;
        };
        "ui.text.inactive" = palette.gray_dark;
        "ui.virtual" = {
          fg = palette.purple_dark;
        };
        "ui.virtual.ruler" = {
          bg = palette.brown_dark;
        };
        "ui.virtual.jump-label" = {
          fg = palette.orange_primary;
          modifiers = [ "bold" ];
        };
        "ui.virtual.indent-guide" = {
          fg = palette.purple_dark;
        };

        "ui.selection" = {
          bg = palette.brown_dark;
        };
        "ui.selection.primary" = {
          bg = palette.brown_dark;
        };
        "ui.cursor.select" = {
          bg = palette.purple_secondary;
        };
        "ui.cursor.insert" = {
          bg = palette.light_purple;
        };
        "ui.cursor.primary.select" = {
          bg = palette.purple_secondary;
        };
        "ui.cursor.primary.insert" = {
          bg = palette.light_purple;
        };
        "ui.cursor.match" = {
          fg = palette.black_lighter;
          bg = palette.blue_gray;
        };
        "ui.cursor" = {
          modifiers = [ "reversed" ];
        };
        "ui.cursorline.primary" = {
          bg = palette.brown_dark;
        };
        "ui.highlight" = {
          bg = palette.brown_dark;
        };
        "ui.highlight.frameline" = {
          bg = palette.brown_primary;
        };
        "ui.debug" = {
          fg = palette.brown_primary;
        };
        "ui.debug.breakpoint" = {
          fg = palette.orange_primary;
        };
        "ui.menu" = {
          fg = palette.purple_secondary;
          bg = palette.black;
        };
        "ui.menu.selected" = {
          fg = palette.black;
          bg = palette.light_purple;
        };
        "ui.menu.scroll" = {
          fg = palette.purple_secondary;
          bg = palette.purple_dark;
        };

        "diagnostic.hint" = {
          underline = {
            color = palette.green_light;
            style = "curl";
          };
        };
        "diagnostic.info" = {
          underline = {
            color = palette.purple_secondary;
            style = "curl";
          };
        };
        "diagnostic.warning" = {
          underline = {
            color = palette.orange_primary;
            style = "curl";
          };
        };
        "diagnostic.error" = {
          underline = {
            color = palette.red_primary;
            style = "curl";
          };
        };
        "diagnostic.unnecessary" = {
          modifiers = [ "dim" ];
        };
        "diagnostic.deprecated" = {
          modifiers = [ "crossed_out" ];
        };

        warning = palette.orange_primary;
        error = palette.red_primary;
        info = palette.purple_secondary;
        hint = palette.green_light;
      };
    };
  };
}
