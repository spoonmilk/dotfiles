return {
  'avuenja/shizukana.nvim',
  lazy = false,
  priority = 1000,
  config = function()
    require('shizukana').setup {
      -- your config here
    }
    vim.cmd.colorscheme 'shizukana'
  end,
}
