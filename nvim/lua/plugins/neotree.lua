return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",

  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },

  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>v", function()
      require("neo-tree.command").execute({
        action = "focus",
        source = "filesystem",
        position = "left",
        reveal = true,
      })
    end, { desc = "NeoTree reveal right", silent = true })

    vim.keymap.set("n", "<leader>xx", function()
      require("neo-tree.command").execute({ action = "close" })
    end, { desc = "NeoTree close", silent = true })
  end,
}
