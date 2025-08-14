return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  keys = {
    {
      '<leader>bz',
      function()
        Snacks.zen()
      end,
      desc = 'Toggle Snacks Zen Mode',
    },
    {
      '\\',
      function()
        Snacks.explorer.open()
      end,
      desc = 'Open Snacks Explorer',
    },
  },
  opts = {
    indent = {
      indent = { enabled = true },
      animate = {
        enabled = false,
      },
    },
    explorer = { enabled = true, replace_netrw = false },
    bigfile = { enabled = true },
    dim = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = false },
    image = { enabled = true },
    zen = { enabled = true },
  },

  config = function(_, opts)
    require('snacks').setup(opts)
  end,
}
