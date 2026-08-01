-- kanagawa dragon
return {
  'rebelot/kanagawa.nvim',
  priority = 1000,
  opts = {
    transparent = true,
    background = {
      dark = 'dragon',
      light = 'lotus',
    },
  },
  config = function(_, opts)
    require('kanagawa').setup(opts)

    local function clear_gutter_bg()
      for _, group in ipairs {
        'SignColumn',
        'LineNr',
        'LineNrAbove',
        'LineNrBelow',
        'CursorLineNr',
        'FoldColumn',
        'EndOfBuffer',
      } do
        local hl = vim.api.nvim_get_hl(0, { name = group, link = false }) --[[@as vim.api.keyset.highlight]]
        hl.bg = nil
        vim.api.nvim_set_hl(0, group, hl)
      end
    end

    vim.api.nvim_create_autocmd('ColorScheme', {
      pattern = 'kanagawa*',
      group = vim.api.nvim_create_augroup('kanagawa-transparent-gutter', { clear = true }),
      callback = clear_gutter_bg,
    })

    vim.cmd.colorscheme 'kanagawa-dragon'
    clear_gutter_bg()
  end,
}
