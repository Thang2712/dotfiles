return {
  {
    "folke/tokyonight.nvim",
    name = "tokyonight",
    priority = 1000,
    opts = {
      style = "night",
      transparent = true,
      styles = {
        comments = { italic = true },
        keywords = { italic = true },
      },
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "mocha",
      transparent_background = true,
      integrations = {
        cmp = true,
        lsp_trouble = true,
        fzf = true,
      },
    },
  },
  {
    "rose-pine/neovim",
    name = "rose-pine",
    priority = 1000,
    opts = {
      styles = {
        transparency = true,
      },
    },
  },
  {
    "alligator/accent.vim",
    name = "accent",
    priority = 1000,
  },
  {
    -- Theme controller
    "nvim-lua/plenary.nvim",
    lazy = false,
    config = function()
      local themes = {
        "tokyonight",
        "accent",
        "catppuccin",
        "rose-pine",
      }

      local index = 1

      local function set_theme(name)
        local ok, _ = pcall(vim.cmd.colorscheme, name)
        if ok then
          vim.notify("Theme: " .. name, vim.log.levels.INFO)
        else
          vim.notify("Theme not found: " .. name, vim.log.levels.ERROR)
        end
      end

      set_theme(themes[index])

      vim.keymap.set("n", "<leader>nt", function()
        index = index % #themes + 1
        set_theme(themes[index])
      end, { desc = "Next colorscheme" })
    end,
  },
}
