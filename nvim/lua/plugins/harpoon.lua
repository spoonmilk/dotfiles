return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    local harpoon = require 'harpoon'
    harpoon:setup()

    local keymap = vim.keymap.set

    -- Add current file to harpoon list
    keymap('n', '<leader>ha', function()
      harpoon:list():add()
    end, { desc = 'Harpoon: [A]dd file' })

    -- Toggle the harpoon quick menu
    keymap('n', '<leader>he', function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end, { desc = 'Harpoon: Toggle menu' })

    -- Jump to marks 1–4
    keymap('n', '<leader>h1', function()
      harpoon:list():select(1)
    end, { desc = 'Harpoon: go to mark [1]' })

    keymap('n', '<leader>h2', function()
      harpoon:list():select(2)
    end, { desc = 'Harpoon: go to mark [2]' })

    keymap('n', '<leader>h3', function()
      harpoon:list():select(3)
    end, { desc = 'Harpoon: go to mark [3]' })

    keymap('n', '<leader>h4', function()
      harpoon:list():select(4)
    end, { desc = 'Harpoon: go to mark [4]' })

    -- Step through list forward/backward
    keymap('n', '<leader>h[', function()
      harpoon:list():prev()
    end, { desc = 'Harpoon: previous mark' })

    keymap('n', '<leader>h]', function()
      harpoon:list():next()
    end, { desc = 'Harpoon: next mark' })
  end,
}
