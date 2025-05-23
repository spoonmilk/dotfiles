--[[
--

This config started based on kickstart.nvim. Since then, it's changed a lot, but I encourage you
to check them out if you're getting into things!

]]
--

-- Set <space> as the leader key
-- See `:help mapleader`
--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ','

-- Set to true if you have a Nerd Font installed and selected in the terminal
vim.g.have_nerd_font = true

-- Vimtex settings
vim.g.vimtex_view_method = 'zathura'
vim.g.vimtex_compiler_method = 'latexmk'
vim.g.vimtex_view_zathura_options = '-reuse-instance'

vim.fn.has 'nvim-0.8'

vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.bo.softtabstop = 4

-- [[ Setting options ]]
require 'options'

-- [[ Basic Keymaps ]]
require 'keymaps'

-- [[ Install `lazy.nvim` plugin manager ]]
require 'lazy-bootstrap'

-- [[ Configure and install plugins ]]
require 'lazy-plugins'

-- Auto-switch colorscheme based on background mode
local function set_colorscheme()
  if vim.o.background == 'dark' then
    vim.cmd 'colorscheme kanagawa-paper-ink'
  else
    vim.cmd 'colorscheme dayfox'
  end
end

-- Apply colorscheme on startup
set_colorscheme()

-- React to background changes dynamically
vim.api.nvim_create_autocmd('OptionSet', {
  pattern = 'background',
  callback = set_colorscheme,
})

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
