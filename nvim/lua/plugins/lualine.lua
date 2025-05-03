return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local git_blame = require 'gitblame'
    -- This disables showing of the blame text next to the cursor
    vim.g.gitblame_display_virtual_text = 0
    require('lualine').setup {
      options = {
        -- theme = "gruvbox",
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename' },
        lualine_x = { { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
        lualine_y = {},
        lualine_z = { 'location' },
      },
    }
  end,
}
