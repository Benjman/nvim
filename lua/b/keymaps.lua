local set = vim.keymap.set
local opts = { noremap = true, silent = true }

local function telescope()
  local builtin = require 'telescope.builtin'
  set('n', '<leader>ps', builtin.live_grep, opts, 'Live grep')
  set('n', '<leader>pf', builtin.find_files, opts, 'Find files')
  set('n', '<leader>po', builtin.oldfiles, opts, 'Find files')
  set('n', '<leader>pg', builtin.git_files, opts, 'Find git files')
  set('n', '<leader>/a', builtin.autocommands, opts, 'Search autocommands')
  set('n', '<leader>/b', builtin.builtin, opts, 'Search Telescope builtins')
  set('n', '<leader>/C', builtin.command_history, opts, 'Search command history')
  set('n', '<leader>/c', builtin.commands, opts, 'Search commands')
  set('n', '<leader>/r', builtin.registers, opts, 'Search registers')
  set('n', '<leader>/m', builtin.marks, opts, 'Search marks')
  set('n', '<leader>/M', builtin.keymaps, opts, 'Search keymaps')
  set('n', '<leader>/t', builtin.treesitter, opts, 'Search treesitter')
  set('n', '<leader>bl', builtin.buffers, opts, 'Search buffers')
  set('n', '<leader>bc', builtin.git_bcommits, opts, 'Search buffer git commits')

  local functions = require 'b.plugins.telescope.utils'
  set('n', '<leader>/h', functions.help_tags, opts, 'Search highlights')
  set('n', '<leader>cc', functions.search_config, opts, 'Search neovim config')
  set('n', '<leader>pS', functions.live_grep_in_folder, opts, 'Live grep in folder')
  set('n', '<leader>/H', functions.highlights, opts, 'Search highlights')
end

local function init()
  set('v', '<', '<gv', opts) -- indentation without leaving visual mode
  set('v', '>', '>gv', opts) -- indentation without leaving visual mode
  set('v', 'p', '"_dP', opts) -- replace selected with yanked
  set('n', '<C-n>', '<cmd>cnext<cr>', opts) -- jump to next item in quickfix list
  set('n', '<C-p>', '<cmd>cprev<cr>', opts) -- jump to previous item in quickfix list
  set('n', '<C-q>', '<cmd>cclose<cr>', opts) -- close quickfix list
  set('n', 'Q', '<cmd>qa<cr>', opts) -- Quickly close vim
end

return {
  init = init,
  telescope = telescope,
}
