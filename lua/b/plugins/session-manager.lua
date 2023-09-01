local present, possession = pcall(require, 'nvim-possession')
if not present then return end

possession.setup {
  autoload = true,
  autoswitch = {
    enable = true,
  },
}

local wk_present, wk = pcall(require, 'which-key')
if wk_present then
  wk.register {['<leader><leader>s'] = { name = 'Session', }};
end

require('b.utils').apply_keymaps {
  { 'n', '<leader><leader>sl', function() possession.list() end,   'List sessions' },
  { 'n', '<leader><leader>sn', function() possession.new() end,    'New session' },
  { 'n', '<leader><leader>su', function() possession.update() end, 'Update session' },
  { 'n', '<leader><leader>sd', function() possession.delete() end, 'Delete session' },
}
