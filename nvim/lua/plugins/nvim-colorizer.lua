return {
  'norcalli/nvim-colorizer.lua',
  config = function()
    local colorizer = require 'colorizer'
    colorizer.setup({
      '*', -- enable for all filetypes
    }, {
      RGB = true,      -- #RGB
      RRGGBB = true,   -- #RRGGBB
      RRGGBBAA = true, -- #RRGGBBAA
      names = true,    -- named colors like "Red"
      rgb_fn = true,   -- rgb() and rgba() functions
      hsl_fn = true,   -- hsl() and hsla() functions
      css = true,      -- all CSS color formats
      css_fn = true,   -- CSS functions
      mode = 'background',
    })

    -- Re-attach colorizer whenever the colorscheme changes so highlights
    -- stay correct across all themes (melange, menguless, alabaster,
    -- kanagawa-paper, vim-paper, and any built-ins).
    vim.api.nvim_create_autocmd('ColorScheme', {
      desc = 'Re-attach colorizer after colorscheme change',
      group = vim.api.nvim_create_augroup('colorizer-reattach', { clear = true }),
      callback = function()
        colorizer.attach_to_buffer(0)
      end,
    })
  end,
}
