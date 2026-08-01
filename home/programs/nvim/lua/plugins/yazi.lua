---@type LazySpec
return {
  'mikavilpas/yazi.nvim',
  version = '*',
  event = 'VeryLazy',
  dependencies = {
    { 'nvim-lua/plenary.nvim', lazy = true },
  },
  keys = {
    {
      '<leader>-',
      mode = { 'n', 'v' },
      '<cmd>Yazi<cr>',
      desc = 'open yazi at the current file',
    },
    {
      '<leader>cw',
      '<cmd>Yazi cwd<cr>',
      desc = "open the file manager in nvim's working directory",
    },
    {
      '<c-up>',
      '<cmd>Yazi toggle<cr>',
      desc = 'resume the last yazi session',
    },
  },
  ---@type YaziConfig | {}
  opts = {
    open_for_directories = false,
    keymaps = {
      show_help = '<f1>',
    },
  },
  init = function()
    -- don't load netrw
    vim.g.loaded_netrwPlugin = 1
  end,
}
