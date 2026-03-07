return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      winopts = {
        height = 0.85,
        width = 0.9,
        preview = {
          layout = "horizontal",
        },
      },

      fzf_colors = {
        bg = "-1",
        gutter = "-1",
      },

      actions = {
        files = {
          ["ctrl-q"] = { fn = fzf.actions.file_sel_to_qf, reload = true },
        },
      },
    })

    -- Keymaps
    vim.keymap.set("n", "<leader>ff", fzf.files, { desc = "Find files" })

    vim.keymap.set("n", "<leader>pf", function()
      local ok = pcall(fzf.git_files)
      if not ok then
        fzf.files()
      end
    end, { desc = "Find git files (fallback to files)" })

    vim.keymap.set("n", "<leader>fg", fzf.live_grep, { desc = "Live grep" })

    vim.keymap.set("n", "<leader>fG", function()
      fzf.live_grep({
        rg_opts = "--hidden --glob '!.git/*' --column --line-number --no-heading --color=always -e",
      })
    end, { desc = "Live grep (hidden)" })

    vim.keymap.set("n", "<leader>fb", fzf.buffers, { desc = "Buffers" })
    vim.keymap.set("n", "<leader>fh", fzf.help_tags, { desc = "Help tags" })

    vim.keymap.set("n", "<leader>fs", function()
      fzf.grep({ search = vim.fn.input("Grep For > ") })
    end, { desc = "Grep with input" })
  end,
}
