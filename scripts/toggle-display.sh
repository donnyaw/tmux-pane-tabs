#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/helpers.sh"

current_status=$(tmux show-option -gv status 2>/dev/null || echo "2")

if [ "$current_status" = "2" ]; then
  tmux set-option -g status 1
  tmux set-option -gw pane-border-status off 2>/dev/null
  tmux display-message "tmux-pane-tabs: display OFF"
else
  local script_path="$CURRENT_DIR/render-tab-strip.sh"
  tmux set-option -g status-format[1] "#($script_path)" 2>/dev/null
  tmux set-option -g status 2

  if _get_tmux_option "$pane_tabs_border_option" "$pane_tabs_border_default" == "on"; then
    tmux set-option -gw pane-border-status top 2>/dev/null
  fi

  tmux display-message "tmux-pane-tabs: display ON"
fi
