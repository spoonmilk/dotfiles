local function set_colorscheme()
  if vim.o.background == 'dark' then
    vim.cmd 'colorscheme zenbones'
  else
    vim.cmd 'colorscheme nightfox'
  end
end

-- Apply colorscheme on startup
set_colorscheme()

-- Optional: Automatically switch when background changes
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = set_colorscheme,
})
