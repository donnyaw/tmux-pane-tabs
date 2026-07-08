#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$CURRENT_DIR/variables.sh"
source "$CURRENT_DIR/helpers.sh"

active_style=$(_get_tmux_option "$pane_tabs_active_style_option" "$pane_tabs_active_style_default")
inactive_style=$(_get_tmux_option "$pane_tabs_inactive_style_option" "$pane_tabs_inactive_style_default")
active_marker=$(_get_tmux_option "$pane_tabs_active_marker_option" "$pane_tabs_active_marker_default")
inactive_marker=$(_get_tmux_option "$pane_tabs_inactive_marker_option" "$pane_tabs_inactive_marker_default")

tmux list-panes -F \
  '#{pane_index}|#{pane_active}|#{pane_title}|#{pane_current_command}' \
  2>/dev/null | sort -t'|' -k1 -n | while IFS='|' read -r idx active title cmd; do

  [ -z "$title" ] && title="$cmd"
  [ -z "$title" ] && title="pane-$idx"

  if [ "$active" = "1" ]; then
    printf "%s %s %s:%s %s" "$active_style" "$active_marker" "$idx" "$title" "#[default]"
  else
    printf "%s%s %s:%s%s" "$inactive_style" "$inactive_marker" "$idx" "$title" "#[default]"
  fi
  printf " "
done | tr -d '\n'
echo
