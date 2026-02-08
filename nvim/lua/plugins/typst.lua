return {
  'chomosuke/typst-preview.nvim',
  ft = 'typst',
  build = function()
    require('typst-preview').update()
  end,
  opts = {},
  keys = {
    { '<leader>tp', '<cmd>TypstPreview<cr>', ft = 'typst', desc = '[T]ypst [P]review' },
    { '<leader>ts', '<cmd>TypstPreviewStop<cr>', ft = 'typst', desc = '[T]ypst preview [S]top' },
    { '<leader>tt', '<cmd>TypstPreviewToggle<cr>', ft = 'typst', desc = '[T]ypst preview [T]oggle' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
