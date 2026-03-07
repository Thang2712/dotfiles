-- Leader
vim.g.mapleader = " "

-- Tabs & indent
vim.opt.expandtab = true
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true

-- Line number colors
vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "white" })
vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#ead84e" })

-- Search
vim.opt.hlsearch = true
vim.opt.incsearch = true

-- Clipboard
vim.opt.clipboard = "unnamedplus"

-- Text width
vim.opt.colorcolumn = "94"

-- Wrap text
vim.opt.wrap = true
vim.opt.linebreak = true

-- Move selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Paste over selection without yanking
vim.keymap.set("x", "<leader>p", '"_dP')

-- Filter noisy LSP notify messages
local notify_original = vim.notify
vim.notify = function(msg, ...)
    if msg and (
        msg:match("position_encoding param is required")
        or msg:match("Defaulting to position encoding of the first client")
        or msg:match("multiple different client offset_encodings")
    ) then
        return
    end
    return notify_original(msg, ...)
end
