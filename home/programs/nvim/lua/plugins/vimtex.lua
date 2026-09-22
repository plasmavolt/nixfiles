return {
  'lervag/vimtex',
  lazy = false, -- VimTeX already loads its functionality by filetype
  init = function()
    vim.g.vimtex_view_method = 'zathura'
    vim.g.vimtex_compiler_method = 'latexmk'
    vim.g.vimtex_quickfix_mode = 0
  end,
}
