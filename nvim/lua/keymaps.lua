-- [[ All Keymaps ]]
-- This module sets global keymaps on require and exports
-- callback functions for buffer-local keymaps (LSP, gitsigns).
--  See `:help vim.keymap.set()`

local keymap = vim.keymap.set
if not keymap then
  vim.notify('vim.keymap.set is not available', vim.log.levels.ERROR)
  return
end

local M = {}

-- ============================================================================
-- Global Keymaps
-- ============================================================================

-- Clear highlights on search when pressing <Esc> in normal mode
--  See `:help hlsearch`
keymap('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
keymap('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })
keymap('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror message' })
keymap('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
keymap('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })

-- Exit terminal mode
keymap('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
keymap('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
keymap('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
keymap('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
keymap('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- ============================================================================
-- Oil keymaps
-- ============================================================================

keymap('n', '<leader>pv', '<cmd>Oil<CR>', { desc = 'Toggle [P]roject [V]iew' })
keymap({ 'n', 'v' }, '<leader>pf', '<cmd>Oil<CR>', { desc = 'Open oil at the current directory' })

-- ============================================================================
-- Snacks keymaps
-- ============================================================================

keymap('n', '<leader>bz', function()
  Snacks.zen()
end, { desc = 'Toggle Snacks Zen Mode' })

keymap('n', '\\', function()
  Snacks.explorer.open()
end, { desc = 'Open Snacks Explorer' })

-- ============================================================================
-- Conform keymaps
-- ============================================================================

keymap('', '<leader>f', function()
  require('conform').format { async = true, lsp_format = 'fallback' }
end, { desc = '[F]ormat buffer' })

-- ============================================================================
-- Telescope keymaps
-- ============================================================================

keymap('n', '<leader>sh', function()
  require('telescope.builtin').help_tags()
end, { desc = '[S]earch [H]elp' })

keymap('n', '<leader>sk', function()
  require('telescope.builtin').keymaps()
end, { desc = '[S]earch [K]eymaps' })

keymap('n', '<leader>sf', function()
  require('telescope.builtin').find_files()
end, { desc = '[S]earch [F]iles' })

keymap('n', '<leader>ss', function()
  require('telescope.builtin').builtin()
end, { desc = '[S]earch [S]elect Telescope' })

keymap('n', '<leader>sw', function()
  require('telescope.builtin').grep_string()
end, { desc = '[S]earch current [W]ord' })

keymap('n', '<leader>sg', function()
  require('telescope.builtin').live_grep()
end, { desc = '[S]earch by [G]rep' })

keymap('n', '<leader>sd', function()
  require('telescope.builtin').diagnostics()
end, { desc = '[S]earch [D]iagnostics' })

keymap('n', '<leader>sr', function()
  require('telescope.builtin').resume()
end, { desc = '[S]earch [R]esume' })

keymap('n', '<leader>s.', function()
  require('telescope.builtin').oldfiles()
end, { desc = '[S]earch Recent Files ("." for repeat)' })

keymap('n', '<leader><leader>', function()
  require('telescope.builtin').buffers()
end, { desc = '[ ] Find existing buffers' })

keymap('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

keymap('n', '<leader>s/', function()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end, { desc = '[S]earch [/] in Open Files' })

keymap('n', '<leader>sn', function()
  require('telescope.builtin').find_files { cwd = vim.fn.stdpath 'config' }
end, { desc = '[S]earch [N]eovim files' })

-- ============================================================================
-- LSP buffer-local keymaps (called from LspAttach autocmd)
-- ============================================================================

function M.lsp_on_attach(event)
  local map = function(keys, func, desc, mode)
    mode = mode or 'n'
    keymap(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
  end

  map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
  map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
  map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')
  map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')
  map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
  map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')
  map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')
  map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

  ---@param client vim.lsp.Client
  ---@param method vim.lsp.protocol.Method
  ---@param bufnr? integer some lsp support methods only in specific files
  ---@return boolean
  local function client_supports_method(client, method, bufnr)
    if vim.fn.has 'nvim-0.11' == 1 then
      return client:supports_method(method, bufnr)
    else
      return client.supports_method(method, { bufnr = bufnr })
    end
  end

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
    map('<leader>th', function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
    end, '[T]oggle Inlay [H]ints')
  end
end

-- ============================================================================
-- Gitsigns buffer-local keymaps (called from gitsigns on_attach)
-- ============================================================================

function M.gitsigns_on_attach(bufnr)
  local gitsigns = require 'gitsigns'

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    keymap(mode, l, r, opts)
  end

  -- Navigation
  map('n', ']c', function()
    if vim.wo.diff then
      vim.cmd.normal { ']c', bang = true }
    else
      gitsigns.nav_hunk 'next'
    end
  end, { desc = 'Jump to next git [c]hange' })

  map('n', '[c', function()
    if vim.wo.diff then
      vim.cmd.normal { '[c', bang = true }
    else
      gitsigns.nav_hunk 'prev'
    end
  end, { desc = 'Jump to previous git [c]hange' })

  map('n', '<leader>hb', gitsigns.blame_line, { desc = 'git [b]lame line' })
  map('n', '<leader>hd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
  map('n', '<leader>hD', function()
    gitsigns.diffthis '@'
  end, { desc = 'git [D]iff against last commit' })

  -- Toggles
  map('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
  map('n', '<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
end

-- ============================================================================
-- Autocommands (not keymaps, but co-located from original file)
-- ============================================================================

-- Highlight when yanking (copying) text
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

return M
-- vim: ts=2 sts=2 sw=2 et
