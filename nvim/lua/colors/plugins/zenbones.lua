return {
  {
    'zenbones-theme/zenbones.nvim',
    dependencies = 'rktjmp/lush.nvim',

    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.g.zenbones = { solid_line_nr = true, darken_comments = 45, lightness = 'dim', darkness = 'warm' }
      vim.cmd.colorscheme 'zenbones'
    end,
  },
}
