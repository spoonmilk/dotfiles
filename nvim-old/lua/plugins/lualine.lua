return {
  'nvim-lualine/lualine.nvim',
  config = function()
    local git_blame = require 'gitblame'
    -- This disables showing of the blame text next to the cursor
    vim.g.gitblame_display_virtual_text = 0
    vim.g.gitblame_message_template = '<summary> • <date> • <author>'
    vim.g.gitblame_message_when_not_committed = 'Commit to the bit!'
    vim.g.gitblame_date_format = '%r %H'
    require('lualine').setup {
      options = {
        -- theme = "gruvbox",
        component_separators = '|',
        section_separators = '',
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { 'filename', { git_blame.get_current_blame_text, cond = git_blame.is_blame_text_available } },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    }
  end,
}
