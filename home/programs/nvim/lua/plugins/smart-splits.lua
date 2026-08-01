-- <C-hjkl> integration w/ zellij
return {
  'mrjones2014/smart-splits.nvim',
  lazy = false,
  opts = {},
  keys = {
    {
      '<C-h>',
      function()
        require('smart-splits').move_cursor_left()
      end,
      desc = 'move focus to the left window/pane',
    },
    {
      '<C-j>',
      function()
        require('smart-splits').move_cursor_down()
      end,
      desc = 'move focus to the lower window/pane',
    },
    {
      '<C-k>',
      function()
        require('smart-splits').move_cursor_up()
      end,
      desc = 'move focus to the upper window/pane',
    },
    {
      '<C-l>',
      function()
        require('smart-splits').move_cursor_right()
      end,
      desc = 'move focus to the right window/pane',
    },
    {
      '<A-h>',
      function()
        require('smart-splits').resize_left()
      end,
      desc = 'resize window/pane left',
    },
    {
      '<A-j>',
      function()
        require('smart-splits').resize_down()
      end,
      desc = 'resize window/pane down',
    },
    {
      '<A-k>',
      function()
        require('smart-splits').resize_up()
      end,
      desc = 'resize window/pane up',
    },
    {
      '<A-l>',
      function()
        require('smart-splits').resize_right()
      end,
      desc = 'resize window/pane right',
    },
  },
}
