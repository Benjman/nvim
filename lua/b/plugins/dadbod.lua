return {
  'kristijanhusak/vim-dadbod-ui',
  dependencies = {
    { 'tpope/vim-dadbod',                     lazy = true },
    { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true },
  },
  cmd = {
    'DBUI',
    'DBUIToggle',
    'DBUIAddConnection',
    'DBUIFindBuffer',
  },
  init = function()
    vim.g.db_ui_use_nerd_fonts = 1
    require('which-key').register({
      d = { name = '[T]ools: [D]atabase', _ = 'which_key_ignore' },
    }, { prefix = '<leader>T' })
    vim.keymap.set('n', '<leader>Tdt', '<cmd>DBUIToggle<cr>', { desc = '[T]ools: [D]atabase [T]oggle' })
  end,
}
