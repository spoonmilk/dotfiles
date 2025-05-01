return {
  'lervag/vimtex',
  lazy = false, -- we don't want to lazy load VimTeX
  init = function()
    -- Use the 'general' method to customize the viewer
    vim.g.vimtex_view_method = 'general'

    -- Specify Zathura as the general viewer and set options
    vim.g.vimtex_view_general_viewer = 'zathura'
    vim.g.vimtex_view_general_options = [[--synctex-forward @line:@col:@tex @pdf]]
  end,
}
