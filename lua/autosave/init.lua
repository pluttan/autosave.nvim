-- autosave.nvim
-- Auto-save files on InsertLeave and FocusLost

local M = {}

M.config = {
    enabled = true,
    events = { "InsertLeave", "FocusLost" },
    silent = true,
    debounce_delay = 150,
}

local timer = nil

local function should_save()
    local buf = vim.api.nvim_get_current_buf()

    -- Skip if not modified
    if not vim.bo[buf].modified then
        return false
    end

    -- Skip special buffers
    local buftype = vim.bo[buf].buftype
    if buftype ~= "" then
        return false
    end

    -- Skip if no filename
    local filename = vim.api.nvim_buf_get_name(buf)
    if filename == "" then
        return false
    end

    -- Skip if readonly
    if vim.bo[buf].readonly then
        return false
    end

    -- Skip if not modifiable
    if not vim.bo[buf].modifiable then
        return false
    end

    return true
end

local function save()
    if not M.config.enabled then
        return
    end

    if not should_save() then
        return
    end

    local cmd = M.config.silent and "silent! write" or "write"
    local ok, err = pcall(vim.cmd, cmd)

    if not ok and not M.config.silent then
        vim.notify("Autosave failed: " .. tostring(err), vim.log.levels.WARN)
    end
end

local function debounced_save()
    if timer then
        timer:stop()
    end

    timer = vim.defer_fn(save, M.config.debounce_delay)
end

function M.enable()
    M.config.enabled = true
    vim.notify("Autosave enabled", vim.log.levels.INFO, { timeout = 1000 })
end

function M.disable()
    M.config.enabled = false
    vim.notify("Autosave disabled", vim.log.levels.INFO, { timeout = 1000 })
end

function M.toggle()
    if M.config.enabled then
        M.disable()
    else
        M.enable()
    end
end

function M.setup(opts)
    M.config = vim.tbl_deep_extend("force", M.config, opts or {})

    local group = vim.api.nvim_create_augroup("Autosave", { clear = true })

    for _, event in ipairs(M.config.events) do
        vim.api.nvim_create_autocmd(event, {
            group = group,
            callback = debounced_save,
        })
    end

    -- Commands
    vim.api.nvim_create_user_command("AutosaveEnable", M.enable, { desc = "Enable autosave" })
    vim.api.nvim_create_user_command("AutosaveDisable", M.disable, { desc = "Disable autosave" })
    vim.api.nvim_create_user_command("AutosaveToggle", M.toggle, { desc = "Toggle autosave" })
end

return M
