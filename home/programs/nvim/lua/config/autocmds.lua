-- highlight on yank
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- typst: open the pdf tinymist exports (see lsp.lua) in zathura, which auto-reloads it
vim.api.nvim_create_autocmd('FileType', {
  desc = 'Typst pdf preview in zathura',
  group = vim.api.nvim_create_augroup('typst-preview', { clear = true }),
  pattern = 'typst',
  callback = function(event)
    vim.keymap.set('n', '<leader>p', function()
      local pdf = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(event.buf), ':r') .. '.pdf'
      if not vim.uv.fs_stat(pdf) then
        vim.notify('no pdf yet: ' .. pdf .. ' (fix errors / wait for tinymist)', vim.log.levels.WARN)
        return
      end
      vim.system({ 'zathura', pdf }, { detach = true })
    end, { buffer = event.buf, desc = 'typst [p]review pdf in zathura' })
  end,
})
