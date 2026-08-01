return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    winopts = {
      height = 0.85,
      width = 0.85,
    },
  },
  keys = {
    {
      '<leader>sf',
      function()
        require('fzf-lua').files()
      end,
      desc = '[s]earch [f]iles',
    },
    {
      '<leader>sg',
      function()
        require('fzf-lua').live_grep()
      end,
      desc = '[s]earch [g]rep',
    },
    {
      '<leader>sw',
      function()
        require('fzf-lua').grep_cword()
      end,
      desc = '[s]earch current [w]ord',
    },
    {
      '<leader>sb',
      function()
        require('fzf-lua').buffers()
      end,
      desc = '[s]earch [b]uffers',
    },
    {
      '<leader>sh',
      function()
        require('fzf-lua').helptags()
      end,
      desc = '[s]earch [h]elp',
    },
    {
      '<leader>sr',
      function()
        require('fzf-lua').oldfiles()
      end,
      desc = '[s]earch [r]ecent files',
    },
    {
      '<leader>sk',
      function()
        require('fzf-lua').keymaps()
      end,
      desc = '[s]earch [k]eymaps',
    },
    {
      '<leader>sd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = '[s]earch [d]iagnostics',
    },
    {
      '<leader>sc',
      function()
        require('fzf-lua').command_history()
      end,
      desc = '[s]earch [c]ommand history',
    },
    {
      '<leader>s/',
      function()
        require('fzf-lua').lgrep_curbuf()
      end,
      desc = '[s]earch [/] in current buffer',
    },
    {
      '<leader>sz',
      function()
        local fzf = require 'fzf-lua'
        local dirs = vim.fn.systemlist 'zoxide query -l'
        fzf.fzf_exec(dirs, {
          prompt = 'Zoxide> ',
          actions = {
            ['default'] = function(selected)
              local dir = selected[1]
              if dir then
                vim.cmd.cd(dir)
                fzf.files { cwd = dir }
              end
            end,
          },
        })
      end,
      desc = '[s]earch [z]oxide directories',
    },
  },
}
