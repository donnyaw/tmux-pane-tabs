# tmux-pane-tabs

Manage tmux panes like browser or yazi tabs.

- Switch between panes by number
- Selected pane zooms fullscreen, others are hidden
- Visual tab strip in the status bar
- Create, close, and rename panes

## Installation

### With tpm

Add to `~/.tmux.conf`:

```tmux
set -g @plugin 'donnyaw/tmux-pane-tabs'
```

Press `prefix + I` to install.

### Local development

```tmux
set -g @plugin '~/.tmux/plugins/tmux-pane-tabs'
```

Then source tmux:

```bash
tmux source-file ~/.tmux.conf
```

## Usage

Enter pane-tabs mode with `prefix + t`.

| Key | Action |
|-----|--------|
| `t` | Create new pane (horizontal split) |
| `v` | Create new pane (vertical split) |
| `c` | Close current pane (with confirmation) |
| `r` | Rename current pane |
| `n` | Next pane |
| `p` | Previous pane |
| `0`–`9` | Jump to pane by number |
| `f` | Toggle tab strip display on/off |
| `?` | Show help |

All pane jumps use `select-pane -Z` (zoom), so the active pane fills the window while others stay hidden. Use `prefix + M-z` to toggle zoom manually and see all panes.

## Visual tab strip

When enabled (`@pane-tabs-status on`), a second status bar line renders the current window's panes as a horizontal tab strip:

```
* 0:shell  - 1:yazi  - 2:opencode
```

Active pane is highlighted with `*` and reverse styling. Inactive panes show `-` in dimmed text.

Toggle on/off at runtime with `prefix + t f`.

### Customization

| Option | Default | Description |
|--------|---------|-------------|
| `@pane-tabs-prefix` | `t` | Prefix key after tmux prefix to enter pane-tabs mode |
| `@pane-tabs-status` | `on` | Show horizontal tab strip in status bar |
| `@pane-tabs-border` | `off` | Show numbered labels on pane borders |
| `@pane-tabs-active-style` | `#[reverse]` | SGR style for active tab in strip |
| `@pane-tabs-inactive-style` | `#[fg=brightblack]` | SGR style for inactive tabs |
| `@pane-tabs-active-marker` | `*` | Character before the active tab label |
| `@pane-tabs-inactive-marker` | `-` | Character before inactive tab labels |

Example customization:

```tmux
set -g @pane-tabs-prefix 'T'
set -g @pane-tabs-status 'off'
set -g @pane-tabs-border 'on'
set -g @pane-tabs-active-marker '>'
set -g @pane-tabs-inactive-marker '.'
```

## Key model

The plugin uses tmux key tables (same mechanism used by `opencode-rename` and `opencode-swap` in the author's config):

```
prefix + t      -> switch-client -T pane-tabs
pane-tabs: 1    -> select-pane -Z -t :.1
pane-tabs: c    -> confirm-before kill-pane
```

The `pane-tabs` key table is active only for the next keypress. After executing a binding, control returns to the normal prefix table.

## Limitations

- Tab numbers are tmux pane indexes. If `pane-base-index` is `0`, tabs start at `0`.
- The tab strip shows panes from the current window only.
- Extended pane mappings (10+) are not included. Use `display-panes` (`prefix + q`) for windows with many panes.
- If you use `status-format[1]` for other purposes, set `@pane-tabs-status off`.

## Requirements

- tmux 3.2+ (for `pane-border-status` and `status-format[1]`)
- tpm (recommended, not required)

## License

MIT
