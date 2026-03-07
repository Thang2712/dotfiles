return {
  "arnamak/stay-centered.nvim",

  config = function()
    require("stay-centered").setup({
      -- skip_filetypes = { "neo-tree", "help" },
    })

    vim.keymap.set("n", "<leader>us", function()
      require("stay-centered").toggle()
      vim.notify("Toggled stay-centered", vim.log.levels.INFO)
    end, { desc = "Toggle stay-centered.nvim", silent = true })
  end,
}
