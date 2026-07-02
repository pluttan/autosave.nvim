<div align="center">

# autosave.nvim

**Автосохранение файлов в Neovim при смене режима и потере фокуса**

[![License](https://img.shields.io/badge/license-MIT-2C2C2C?style=for-the-badge&labelColor=1E1E1E)](LICENSE)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=for-the-badge&logo=lua&labelColor=1E1E1E)](https://www.lua.org)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?style=for-the-badge&logo=neovim&labelColor=1E1E1E)](https://neovim.io)

</div>

Плагин для Neovim с нулевым трением при работе. Сохраняет изменённые буферы по событиям `InsertLeave`, `FocusLost` и `TextChanged` с дебаунсингом, автоматически пропуская специальные буферы, безымянные файлы и буферы только для чтения.

## ■ Возможности

- ❖ **Событийные сохранения** — срабатывает на `InsertLeave`, `FocusLost` и `TextChanged` по умолчанию
- ❖ **Дебаунсинг** — настраиваемая задержка (по умолчанию 150 мс) предотвращает лишние записи при быстром редактировании
- ❖ **Умный пропуск** — игнорирует специальные буферы (`buftype != ""`), безымянные файлы, буферы только для чтения и немодифицируемые буферы
- ❖ **Тихий режим** — сохраняет без вывода сообщений; ошибки появляются через `vim.notify` при отключённом silent
- ❖ **Команды переключения** — `:AutosaveEnable`, `:AutosaveDisable`, `:AutosaveToggle` в любой момент

## ■ Установка

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

## ■ Конфигурация

Все параметры со значениями по умолчанию:

```lua
require("autosave").setup({
    enabled        = true,                                   -- включить при старте
    events         = { "InsertLeave", "FocusLost",          -- события-триггеры
                       "TextChanged" },
    silent         = true,                                   -- подавить сообщения записи
    debounce_delay = 150,                                   -- задержка перед сохранением (мс)
})
```

| Параметр | По умолчанию | Описание |
|----------|-------------|----------|
| `enabled` | `true` | Включить автосохранение при запуске |
| `events` | `{ "InsertLeave", "FocusLost", "TextChanged" }` | События Neovim, вызывающие сохранение |
| `silent` | `true` | Использовать `silent! write` для подавления сообщений |
| `debounce_delay` | `150` | Задержка дебаунсинга перед записью в мс |

### Команды

| Команда | Описание |
|---------|----------|
| `:AutosaveEnable` | Включить автосохранение |
| `:AutosaveDisable` | Отключить автосохранение |
| `:AutosaveToggle` | Переключить автосохранение |

## ■ Лицензия

MIT

---

Built by [pluttan](https://github.com/pluttan)
