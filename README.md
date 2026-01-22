# autosave.nvim

Auto-save files on mode change and focus lost.

## Installation

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

## Configuration

| Option | Default | Description |
|--------|---------|-------------|
| `enabled` | `true` | Enable autosave |
| `events` | `{ "InsertLeave", "FocusLost" }` | Events that trigger autosave |
| `silent` | `true` | Silent save (no messages) |
| `debounce_delay` | `150` | Delay in ms before saving |

## Commands

- `:AutosaveEnable` - Enable autosave
- `:AutosaveDisable` - Disable autosave
- `:AutosaveToggle` - Toggle autosave

## License

MIT
