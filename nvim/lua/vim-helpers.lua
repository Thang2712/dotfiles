-- =========================
-- VIM HELPER FUNCTIONS
-- =========================

-- Copy diagnostic message under cursor
vim.keymap.set("n", "<leader>ce", function()
    local diagnostics = vim.diagnostic.get(0, {
        lnum = vim.fn.line(".") - 1,
    })
    if #diagnostics > 0 then
        local message = diagnostics[1].message
        vim.fn.setreg("+", message)
        print("Copied diagnostic: " .. message)
    else
        print("No diagnostic at cursor")
    end
end, { silent = true })

-- Diagnostic navigation
vim.keymap.set("n", "<leader>ne", vim.diagnostic.goto_next)
vim.keymap.set("n", "<leader>pe", vim.diagnostic.goto_prev)
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float)

-- Copy absolute file path
vim.keymap.set("n", "<leader>cp", function()
    local filepath = vim.fn.expand("%:p")
    vim.fn.setreg("+", filepath)
    print("Copied: " .. filepath)
end, { desc = "Copy absolute path" })

-- Open current file in browser
vim.keymap.set("n", "<leader>ob", function()
    local file_path = vim.fn.expand("%:p")
    if file_path == "" then
        print("No file to open")
        return
    end

    local cmd
    if vim.fn.has("mac") == 1 then
        cmd = "open " .. file_path
    else
        cmd = "xdg-open " .. file_path
    end

    os.execute(cmd .. " &")
end, { desc = "Open file in browser" })

-- =========================
-- INPUT METHOD SWITCH (macOS only)
-- =========================
-- Requires macism: https://github.com/laishulu/macism

local sysname = vim.loop.os_uname().sysname
local is_mac = sysname == "Darwin"

if is_mac then
    local english_layout = "com.apple.keylayout.ABC"
    local last_insert_layout = english_layout

    local function get_current_layout()
        local f = io.popen("macism")
        if not f then
            return english_layout
        end
        local layout = f:read("*all"):gsub("\n", "")
        f:close()
        return layout
    end

    vim.api.nvim_create_autocmd("InsertLeave", {
        callback = function()
            last_insert_layout = get_current_layout()
            os.execute("macism " .. english_layout)
        end,
    })

    vim.api.nvim_create_autocmd("InsertEnter", {
        callback = function()
            os.execute("macism " .. last_insert_layout)
        end,
    })

    vim.api.nvim_create_autocmd("FocusGained", {
        callback = function()
            if vim.fn.mode() == "i" then
                os.execute("macism " .. last_insert_layout)
            else
                os.execute("macism " .. english_layout)
            end
        end,
    })
end

-- =========================
-- FLOATING DIRECTORY TREE
-- =========================

vim.api.nvim_create_user_command("ShowTree", function()
    local buf = vim.api.nvim_create_buf(false, true)

    local width = math.floor(vim.o.columns * 0.6)
    local height = math.floor(vim.o.lines * 0.9)
    local row = math.floor((vim.o.lines - height) / 2)
    local col = math.floor((vim.o.columns - width) / 2)

    vim.api.nvim_open_win(buf, true, {
        relative = "editor",
        width = width,
        height = height,
        row = row,
        col = col,
        border = "rounded",
        style = "minimal",
    })

    vim.fn.jobstart("tree -L 4", {
        stdout_buffered = true,
        on_stdout = function(_, data)
            if not data then
                return
            end
            vim.api.nvim_buf_set_lines(buf, 0, -1, false, data)
        end,
    })
end, {})

vim.keymap.set(
    "n",
    "<leader>vt",
    "<cmd>ShowTree<CR>",
    { desc = "Show directory tree" }
)
