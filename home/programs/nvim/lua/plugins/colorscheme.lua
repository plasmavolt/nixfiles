return {
  'RRethy/base16-nvim',
  priority = 1000,
  config = function()
    local palette = vim.json.decode(table.concat(vim.fn.readfile(vim.fn.stdpath 'config' .. '/stylix.json'), '\n'))
    require('base16-colorscheme').setup(palette)

    local function clear_backgrounds()
      for _, group in ipairs {
        'Normal',
        'NormalNC',
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
      pattern = '*',
      group = vim.api.nvim_create_augroup('stylix-transparent-background', { clear = true }),
      callback = clear_backgrounds,
    })

    clear_backgrounds()
  end,
}
