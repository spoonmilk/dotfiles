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
    explorer = { enabled = true, replace_netrw = false },
    bigfile = { enabled = true },
    dim = { enabled = true },
    input = { enabled = true },
    picker = { enabled = false },
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
