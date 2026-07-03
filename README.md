<div align="center">

# autosave.nvim

**Automatic file saving for Neovim on mode change and focus lost**

</div>

Zero-friction autosave plugin for Neovim. Saves modified buffers on `InsertLeave`, `FocusLost`, and `TextChanged` with debouncing, skipping special buffers, unnamed files, and read-only buffers automatically.

## ■ Features

- ❖ **Event-driven saves** — triggers on `InsertLeave`, `FocusLost`, and `TextChanged` by default
- ❖ **Debounced** — configurable delay (default 150 ms) prevents redundant writes on rapid edits
- ❖ **Smart skip** — ignores special buffers (`buftype != ""`), unnamed files, readonly and non-modifiable buffers
- ❖ **Silent mode** — saves without echoing the write message; errors surface via `vim.notify` when not silent
- ❖ **Toggle commands** — `:AutosaveEnable`, `:AutosaveDisable`, `:AutosaveToggle` at any time

## ■ Stack

<div align="center">

| Component | Technology |
|-----------|-----------|
| Plugin language | Lua |
| Host | Neovim |

</div>

## ■ How It Works

```
1. On startup, registers autocmd listeners for the configured events (InsertLeave, FocusLost, TextChanged by default)
2. When an event fires, a debounce timer starts (default 150 ms) to prevent redundant writes on rapid edits
3. After the delay, the plugin checks whether the current buffer is writable — named, modifiable, not a special buftype
4. If the buffer passes all checks, it is written silently; errors surface via vim.notify
```

## ■ Usage

### lazy.nvim

```lua
{
    "pluttan/autosave.nvim",
    config = function()
        require("autosave").setup({
            enabled = true,
            events = { "InsertLeave", "FocusLost" },
            silent = true,
            debounce_delay = 150,
        })
    end,
}
```

## ■ Configuration

All options with their defaults:

```lua
require("autosave").setup({
    enabled       = true,                                    -- enable on startup
    events        = { "InsertLeave", "FocusLost",           -- trigger events
                      "TextChanged" },
    silent        = true,                                    -- suppress write messages
    debounce_delay = 150,                                   -- ms to wait before saving
})
```

<div align="center">

| Option | Default | Description |
|--------|---------|-------------|
| `enabled` | `true` | Enable autosave on startup |
| `events` | `{ "InsertLeave", "FocusLost", "TextChanged" }` | Neovim autocmd events that trigger a save |
| `silent` | `true` | Use `silent! write` to suppress messages |
| `debounce_delay` | `150` | Milliseconds to debounce before writing |

</div>

### Commands

<div align="center">

| Command | Description |
|---------|-------------|
| `:AutosaveEnable` | Enable autosave |
| `:AutosaveDisable` | Disable autosave |
| `:AutosaveToggle` | Toggle autosave on/off |

</div>

## ■ License

MIT

---

Built by [pluttan](https://github.com/pluttan)
