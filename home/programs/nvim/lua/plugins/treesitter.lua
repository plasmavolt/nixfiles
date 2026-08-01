return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  build = ':TSUpdate',
  main = 'nvim-treesitter.config',
  config = function(_, opts)
    require('nvim-treesitter.install').prefer_git = true
    require('nvim-treesitter.config').setup(opts)
  end,
  opts = {
    ensure_installed = {
      -- config/tooling
      'bash',
      'diff',
      'nix',
      'toml',
      'yaml',
      'json',
      'jsonc',
      -- docs
      'markdown',
      'markdown_inline',
      'html',
      'lua',
      'luadoc',
      'query',
      'vim',
      'vimdoc',
      -- my languages
      'python',
      'rust',
      'c',
      'cpp',
      'typescript',
      'tsx',
      'javascript',
      -- note: lean manages self
    },
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
  },
}
