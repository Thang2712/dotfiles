return {
  {
    "nvim-telescope/telescope.nvim",
    tag = "0.1.8",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-ui-select.nvim",
    },

    opts = {
      defaults = {
        file_ignore_patterns = {
          "%.class",
          "node_modules",
          ".git/",
        },

        layout_config = {
          horizontal = {
            preview_width = 0.6,
            width = 0.85,
          },
          vertical = {
            preview_height = 0.6,
            height = 0.85,
          },
        },
      },
    },

    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      telescope.setup({
        extensions = {
          ["ui-select"] = require("telescope.themes").get_dropdown({}),
        },
      })

      telescope.load_extension("ui-select")

      local builtin = require("telescope.builtin")

      vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
      vim.keymap.set("n", "<leader>pf", builtin.git_files,  { desc = "Git files" })
      vim.keymap.set("n", "<leader>fg", builtin.live_grep,  { desc = "Live grep" })
      vim.keymap.set("n", "<leader>fb", builtin.buffers,    { desc = "Buffers" })
      vim.keymap.set("n", "<leader>fh", builtin.help_tags,  { desc = "Help tags" })
    end,
  },
}
