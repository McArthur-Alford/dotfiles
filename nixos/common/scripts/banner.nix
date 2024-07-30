{ pkgs }:
pkgs.writeScriptBin "banner" ''
  #!${pkgs.stdenv.shell}

  # Function to convert hex to rgb
  hex_to_rgb() {
    echo $((16#''${1:0:2})) $((16#''${1:2:2})) $((16#''${1:4:2}))
  }

  # Function to calculate the intermediate color
  interpolate_color() {
    local start_color=($1)
    local end_color=($2)
    local ratio=$3

    local r=$(awk "BEGIN {printf \"%d\", (''${start_color[0]} + ($ratio * (''${end_color[0]} - ''${start_color[0]})))}")
    local g=$(awk "BEGIN {printf \"%d\", (''${start_color[1]} + ($ratio * (''${end_color[1]} - ''${start_color[1]})))}")
    local b=$(awk "BEGIN {printf \"%d\", (''${start_color[2]} + ($ratio * (''${end_color[2]} - ''${start_color[2]})))}")

    printf "%02x%02x%02x" $r $g $b
  }

  # Function to center text
  center_text() {
      # Get terminal width
      term_width=$(tput cols)

      while IFS= read -r line || [[ -n "$line" ]]; do
          line_length=''${#line}
          padding=''$(( (term_width - line_length) / 2 ))
          printf "%*s%s\n" "$padding" "" "$line"
      done
  }

  # Gradient function
  generate_gradient() {
    local start_hex=$1
    local end_hex=$2
    local input_string="$3"

    local start_rgb=($(hex_to_rgb ''${start_hex#"#"}))
    local end_rgb=($(hex_to_rgb ''${end_hex#"#"}))

    local IFS=$'\n'
    local lines=($input_string)
    local num_lines=''${#lines[@]}

    for i in "''${!lines[@]}"; do
      local ratio=$(awk "BEGIN {printf \"%.2f\", $i / ($num_lines - 1)}")
      local color=$(interpolate_color "''${start_rgb[*]}" "''${end_rgb[*]}" $ratio)
      local colored_line=$(echo -e "\e[38;2;$((16#''${color:0:2}));$((16#''${color:2:2}));$((16#''${color:4:2}))m''${lines[$i]}")
      echo -e "$colored_line"
    done
  }

  # Check for the correct number of arguments
  if [ "$#" -lt 3 ]; then
    echo "Usage: $0 <start_color> <end_color> <input_string>"
    exit 1
  fi

  # Usage
  start_color=$1
  end_color=$2
  input_string=$3

  generate_gradient $start_color $end_color "$input_string"
''
