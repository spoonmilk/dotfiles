return {
  'nvim-lualine/lualine.nvim',
  event = 'VeryLazy',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/noice.nvim',
  },
  config = function()
    local icons = {
      diagnostics = {
        Error = ' ',
        Warning = ' ',
        Information = ' ',
        Hint_alt = ' ',
      },
      git = {
        Add = ' ',
        Mod = ' ',
        Mod_alt = ' ',
        Remove = ' ',
        Branch = '',
      },
      ui = {
        Tab = '󰌒 ',
        FolderWithHeart = '󰉋 ',
      },
      misc = {
        LspAvailable = ' ',
        NoActiveLsp = ' ',
        PyEnv = ' ',
      },
      git_nosep = {
        Branch = '',
      },
    }

    local conditionals = {
      has_enough_room = function()
        return vim.o.columns > 100
      end,
      has_comp_before = function()
        return vim.bo.filetype ~= ''
      end,
      has_git = function()
        local gitdir = vim.fs.find('.git', {
          limit = 1,
          upward = true,
          type = 'directory',
          path = vim.fn.expand '%:p:h',
        })
        return #gitdir > 0
      end,
    }

    local utils = {
      force_centering = function()
        return '%='
      end,
      abbreviate_path = function(path)
        local home = vim.env.HOME
        if path:find(home, 1, true) == 1 then
          path = '~' .. path:sub(#home + 1)
        end
        return path
      end,
    }

    local function diff_source()
      local gitsigns = vim.b.gitsigns_status_dict
      if gitsigns then
        return {
          added = gitsigns.added,
          modified = gitsigns.changed,
          removed = gitsigns.removed,
        }
      end
    end

    local components = {
      file_status = {
        function()
          local symbols = {}
          if vim.bo.modified then
            table.insert(symbols, '[+]')
          end
          if not vim.bo.modifiable then
            table.insert(symbols, '[-]')
          end
          if vim.bo.readonly then
            table.insert(symbols, '[RO]')
          end
          if vim.fn.filereadable(vim.fn.expand '%') == 0 then
            table.insert(symbols, '[New]')
          end
          return #symbols > 0 and table.concat(symbols, '') or ''
        end,
        padding = { left = -1, right = 1 },
        cond = conditionals.has_comp_before,
      },
      lsp = {
        function()
          local clients = vim.lsp.get_clients { bufnr = vim.api.nvim_get_current_buf() }
          if not clients or #clients == 0 then
            return icons.misc.NoActiveLsp
          end
          local names = {}
          for _, client in ipairs(clients) do
            if not vim.tbl_contains(names, client.name) then
              table.insert(names, client.name)
            end
          end
          return string.format('%s[%s]', icons.misc.LspAvailable, table.concat(names, ', '))
        end,
        cond = conditionals.has_enough_room,
      },
      python_venv = {
        function()
          if vim.bo.filetype ~= 'python' then
            return ''
          end
          local venv = os.getenv 'CONDA_DEFAULT_ENV' or os.getenv 'VIRTUAL_ENV'
          if venv then
            return icons.misc.PyEnv .. venv:match '([^/]+)$'
          end
          return ''
        end,
        cond = conditionals.has_enough_room,
      },
      tabwidth = {
        function()
          return icons.ui.Tab .. vim.bo.tabstop
        end,
        padding = 1,
      },
      cwd = {
        function()
          return icons.ui.FolderWithHeart .. utils.abbreviate_path(vim.fs.normalize(vim.fn.getcwd()))
        end,
      },
      file_location = {
        function()
          local line = vim.fn.line '.'
          local col = vim.fn.virtcol '.'
          local total = vim.fn.line '$'
          local pct = math.floor(line / total * 100)
          local pos = (line == 1 and 'Top') or (line == total and 'Bot') or string.format('%2d%%%%', pct)
          return string.format('%s · %3d:%-2d', pos, line, col)
        end,
      },
    }

    require('lualine').setup {
      options = {
        icons_enabled = true,
        theme = 'auto',
        disabled_filetypes = { statusline = { 'alpha' } },
        component_separators = '',
        section_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = {
          { require('noice').api.status.mode.get, cond = require('noice').api.status.mode.has },
        },
        lualine_b = {
          {
            'filetype',
            icon_only = false,
            icon = { align = 'left' },
          },
          components.file_status,
        },
        lualine_c = {
          {
            'branch',
            icon = icons.git_nosep.Branch,
            cond = conditionals.has_git,
          },
          {
            'diff',
            symbols = {
              added = icons.git.Add,
              modified = icons.git.Mod_alt,
              removed = icons.git.Remove,
            },
            source = diff_source,
            cond = conditionals.has_git,
          },
          { utils.force_centering },
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            sections = { 'error', 'warn', 'info', 'hint' },
            symbols = {
              error = icons.diagnostics.Error,
              warn = icons.diagnostics.Warning,
              info = icons.diagnostics.Information,
              hint = icons.diagnostics.Hint_alt,
            },
          },
          components.lsp,
        },
        lualine_x = {
          {
            'encoding',
            show_bomb = true,
            fmt = string.upper,
            cond = conditionals.has_enough_room,
          },
          {
            'fileformat',
            symbols = { unix = 'LF', dos = 'CRLF', mac = 'CR' },
          },
          components.tabwidth,
        },
        lualine_y = {
          components.python_venv,
          components.cwd,
        },
        lualine_z = {
          components.file_location,
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {},
      },
      extensions = {},
    }
  end,
}
