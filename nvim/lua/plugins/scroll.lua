return {
  "karb94/neoscroll.nvim",
  event = "VeryLazy",
  config = function()
    local neoscroll = require("neoscroll")

    neoscroll.setup({
      hide_cursor = false,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 0.8,
      easing = "linear",
      performance_mode = false,
      ignored_events = { "WinScrolled", "CursorMoved" },
    })

    local keymap = {
      ["<C-u>"] = function()
        neoscroll.ctrl_u({ duration = 300 })
      end,
      ["<C-d>"] = function()
        neoscroll.ctrl_d({ duration = 300 })
      end,
      ["<C-b>"] = function()
        neoscroll.ctrl_b({ duration = 450 })
      end,
      ["<C-f>"] = function()
        neoscroll.ctrl_f({ duration = 450 })
      end,
      ["<C-y>"] = function()
        neoscroll.scroll(-0.1, { move_cursor = false, duration = 100 })
      end,
      ["<C-e>"] = function()
        neoscroll.scroll(0.1, { move_cursor = false, duration = 100 })
      end,
    }

    local modes = { "n", "v", "x" }
    for key, func in pairs(keymap) do
      vim.keymap.set(modes, key, func, { silent = true })
    end
  end,
}
