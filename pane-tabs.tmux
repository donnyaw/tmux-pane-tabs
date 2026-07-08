#!/usr/bin/env bash

CURRENT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$CURRENT_DIR/scripts/variables.sh"
source "$CURRENT_DIR/scripts/helpers.sh"

_set_bindings() {
  local prefix
  prefix=$(_get_tmux_option "$pane_tabs_prefix_option" "$pane_tabs_prefix_default")

  tmux unbind "$prefix" 2>/dev/null

  tmux bind "$prefix" switch-client -T pane-tabs

  tmux bind -T pane-tabs t run-shell "tmux split-window -h; tmux resize-pane -Z"
  tmux bind -T pane-tabs v run-shell "tmux split-window -v; tmux resize-pane -Z"
  tmux bind -T pane-tabs c confirm-before -p "kill-pane #P? (y/n)" kill-pane
  tmux bind -T pane-tabs r command-prompt -I "#{pane_title}" { select-pane -T "%%" }

  tmux bind -T pane-tabs n select-pane -Z -t :.+
  tmux bind -T pane-tabs p select-pane -Z -t :.-

  local i
  for i in $(seq 0 9); do
    tmux bind -T pane-tabs "$i" select-pane -Z -t :."$i"
  done

  tmux bind -T pane-tabs f run-shell "$CURRENT_DIR/scripts/toggle-display.sh"
  tmux bind -T pane-tabs '?' run-shell "$CURRENT_DIR/scripts/help.sh"
}

_set_display() {
  if _get_tmux_option "$pane_tabs_status_option" "$pane_tabs_status_default" == "on"; then
    local script_path="$CURRENT_DIR/scripts/render-tab-strip.sh"
    tmux set-option -g status-format[1] "#($script_path)" 2>/dev/null
    tmux set-option -g status 2 2>/dev/null
  fi

  if _get_tmux_option "$pane_tabs_border_option" "$pane_tabs_border_default" == "on"; then
    tmux set-option -gw pane-border-status top 2>/dev/null
    tmux set-option -gw pane-border-format "#{?pane_active,#[reverse],}#{pane_index}#[default] " 2>/dev/null
  fi
}

main() {
  _set_display
  _set_bindings
}
main
