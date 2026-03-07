-- Open :help in a floating window
vim.api.nvim_create_autocmd("FileType", {
    pattern = "help",
    callback = function()
        local buf = vim.api.nvim_get_current_buf()

        -- Close the default help window
        vim.cmd("wincmd c")

        -- Open help in floating window
        vim.api.nvim_open_win(buf, true, {
            relative = "editor",
            width = math.floor(vim.o.columns * 0.8),
            height = math.floor(vim.o.lines * 0.8),
            col = math.floor(vim.o.columns * 0.1),
            row = math.floor(vim.o.lines * 0.1),
            border = "rounded",
        })
    end,
})
