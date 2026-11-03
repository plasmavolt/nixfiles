return {
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  keys = {
    {
      '<leader>f',
      function()
        require('conform').format { async = true, lsp_format = 'fallback' }
      end,
      mode = '',
      desc = '[f]ormat buffer',
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      local name = vim.api.nvim_buf_get_name(bufnr)
      if name:match '%.mll$' or name:match '%.mly$' then
        return
      end
      return { timeout_ms = 500, lsp_format = 'fallback' }
    end,
    formatters_by_ft = {
      lua = { 'stylua' },
      nix = { 'nixfmt' },
      python = { 'ruff_format', 'ruff_organize_imports' },
      rust = { 'rustfmt' },
      c = { 'clang_format' },
      cpp = { 'clang_format' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      typescriptreact = { 'prettier' },
      javascriptreact = { 'prettier' },
      json = { 'prettier' },
      yaml = { 'prettier' },
      markdown = { 'prettier' },
      typst = { 'typstyle' },
    },
    formatters = {
      typstyle = { prepend_args = { '--line-width', '80' } },
    },
  },
}
