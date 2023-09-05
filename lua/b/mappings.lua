local function cmd(c) return '<cmd>' .. c .. '<cr>' end

local function reload_neovim_config()
  vim.cmd([[
  update $MYVIMRC
  source $MYVIMRC
  ]])
  vim.notify('Reloaded nvim config', vim.log.levels.INFO, { title = 'nvim-config' })
end

require('b.utils').apply_keymaps({
  { 'n', '<c-s>',    cmd 'update',      'Save buffer' },
  { 'n', '<c-q>',    cmd 'quit',        'Exit' },
  { 'x', '<',        '<gv',             'Indent without leaving visual mode' },
  { 'x', '>',        '>gv',             'Indent without leaving visual mode' },
  { 'v', 'p',        '"_dP',            'Replace selected with yanked' },
  { 'n', '/',        [[/\v]],           'Very magic mode for searching' },
  { 't', '<Esc>',    [[<c-\><c-n>]],    'Escape to quit terminal' },
  { 'i', '<c-o>',    [[<esc>O]],        'Insert line below while in insert mode' },
  { 'n', '<c-w>c',   cmd 'bdelete',     'Delete current buffer' },

  { 'n', '<leader><leader>e',    cmd 'tabnew $MYVIMRC <bar> tcd %:h',   'Edit Neovim config' },
  { 'n', '<leader><leader>n',    cmd 'Notifications',                   'View notifications' },

  { 'n', '<leader>q',    cmd 'copen',   'Quickfix' }, -- default behavior
  { 'n', '<leader>qn',   cmd 'cnext',   'Quickfix next' },
  { 'n', '<leader>qp',   cmd 'cprev',   'Quickfix prev' },
  { 'n', '<leader>qq',   cmd 'cclose',  'Quickfix close' },
  { 'n', '<leader>qo',   cmd 'copen',   'Quickfix open' },
})
