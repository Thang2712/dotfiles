return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
  config = function()
    local function short_filename()
      local root = vim.fn.getcwd()
      local filepath = vim.fn.expand("%:p")
      if filepath == "" then
        return ""
      end
      if not filepath:find(root, 1, true) then
        return vim.fn.expand("%:t")
      end

      local relpath = filepath:sub(#root + 2)
      local parts = vim.split(relpath, "/")
      local len = #parts
      if len > 2 then
        return table.concat({ parts[len - 2], parts[len - 1], parts[len] }, "/")
      else
        return relpath
      end
    end

    require("lualine").setup({
      options = {
        theme = "auto", -- 🔥 tự đổi theo colorscheme
        globalstatus = true, -- đẹp hơn với tmux
        section_separators = { left = "", right = "" },
        component_separators = { left = "", right = "" },
        disabled_filetypes = { "dashboard", "alpha" },
      },
      sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch" },
        lualine_c = {
          { short_filename },
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
          },
        },
        lualine_x = { "filetype" },
        lualine_y = {},
        lualine_z = { "location" },
      },
    })
  end,
}
