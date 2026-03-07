return {
  "xiyaowong/transparent.nvim",
  lazy = false,
  config = function()
    require("transparent").setup({
      extra_groups = {
        "NormalFloat",
        "FloatBorder",
        "Pmenu",
        "PmenuSel",
        "TelescopeNormal",
        "TelescopeBorder",
        "FzfLuaNormal",
        "FzfLuaBorder",
        "FzfLuaPreviewNormal",
        "FzfLuaPreviewBorder",
        "FzfLuaTitle",
        "FzfLuaPreviewTitle",
      },
    })

    -- Clear UI plugins
    require("transparent").clear_prefix("lualine")
    require("transparent").clear_prefix("Telescope")
    require("transparent").clear_prefix("FzfLua")

    -- Core groups (để chắc chắn)
    vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
    vim.api.nvim_set_hl(0, "NormalNC", { bg = "none" })
    vim.api.nvim_set_hl(0, "CursorLine", { bg = "none" })
  end,
}
