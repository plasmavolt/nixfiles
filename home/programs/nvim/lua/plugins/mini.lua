return {
  'echasnovski/mini.nvim',
  config = function()
    -- better text objects
    require('mini.ai').setup { n_lines = 500 }

    -- add/delete/replace surrounds
    require('mini.surround').setup()

    -- minimal statusline
    local statusline = require 'mini.statusline'
    statusline.setup { use_icons = vim.g.have_nerd_font }
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v'
    end

    -- minimal file browser
    require('mini.files').setup {
      windows = {
        preview = true,
        width_focus = 30,
        width_preview = 30,
      },
    }

    local minifiles_toggle = function(...)
      if not MiniFiles.close() then
        MiniFiles.open(...)
      end
    end

    vim.keymap.set('n', '<leader>e', function()
      minifiles_toggle(vim.api.nvim_buf_get_name(0))
    end, { desc = 'open file browser (current file)' })

    vim.keymap.set('n', '<leader>E', function()
      minifiles_toggle(vim.uv.cwd())
    end, { desc = 'open file browser (cwd)' })
  end,
}
