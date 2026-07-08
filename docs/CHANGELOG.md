# Changelog

## [1.0.0] - 2026-07-08

### Added

- First public release
- Pane-tabs key table accessible via `prefix + t`
- Pane creation: `t t` (horizontal), `t v` (vertical), each auto-zoomed
- Pane switching by number: `t 0`-`t 9` using `select-pane -Z`
- Pane navigation: `t n` (next), `t p` (previous)
- Pane close: `t c` with confirmation prompt
- Pane rename: `t r` with interactive prompt
- Visual tab strip: second status bar line showing all panes as tabs
- Toggle display: `t f` to switch tab strip on/off
- Help popup: `t ?` showing key reference
- Configurable options: prefix key, status strip, border labels, markers, styles
