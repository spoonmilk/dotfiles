return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    indent = {
      indent = { enabled = true },
      animate = {
        enabled = false,
      },
    },
    explorer = { enabled = true, layout = {
      cycle = true,
    } },
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    dim = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    image = { enabled = true },
  },

  config = function()
    local snacks = require 'snacks'
    vim.keymap.set('n', '\\', snacks.explorer.open, { desc = 'Open Snacks Explorer' })
  end,
}
