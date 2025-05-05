return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    dim = { enabled = true },
    zen = { enabled = true },
    animation = { enabled = true },
    scroll = { enabled = true },
    explorer = { enabled = true },
    dashboard = {
      sections = {
        { section = 'header' },
        { section = 'keys', gap = 1, padding = 1 },
        { section = 'startup' },
      },
      preset = {},
    },
    picker = {
      sources = {
        explorer = {
          focus = 'input',
          auto_close = true,
        },
      },
    },
  },
  config = function()
    vim.keymap.set('n', '\\', function()
      require('snacks').explorer()
    end, { desc = 'Open Snacks Explorer' })
  end,
}
