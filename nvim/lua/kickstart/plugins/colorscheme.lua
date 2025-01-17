return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    -- 'neanias/everforest-nvim',
    -- 'vague2k/vague.nvim',
    --
    -- For zenbones: Enable these together
    -- 'zenbones-theme/zenbones.nvim',
    -- dependencies = 'rktjmp/lush.nvim',

    'catppuccin/nvim',
    lazy = false,
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      vim.cmd.colorscheme 'catppuccin'
      -- vim.cmd.colorscheme 'everforest'
      -- vim.cmd.colorscheme 'vague'
      -- vim.g.zenbones = { solid_line_nr = true, darken_comments = 45, lightness = 'dim', darkness = 'warm' }
      -- vim.cmd.colorscheme 'forestbones'
      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
