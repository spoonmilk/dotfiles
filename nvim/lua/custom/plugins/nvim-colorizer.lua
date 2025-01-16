return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = { -- set to setup table
  },
  init = function()
    require('colorizer').setup {
      '*', -- Highlight all files
      css = { rgb_fn = true }, -- Enable parsing rgb(...) functions in CSS
    }
  end,
}
