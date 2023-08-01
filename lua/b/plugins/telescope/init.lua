local present, telescope = pcall(require, 'telescope')
if not present then return end

telescope.setup {
  defaults = {
    prompt_prefix = '  ',
    selection_caret = '  ',
    sorting_strategy = 'descending',
    layout_strategy = 'horizontal',
    file_ignore_patterns = { 'build', 'lib' },
    -- layout_config = { prompt_position = 'bottom' },
    mappings = {
      i = {
        ['<C-j>'] = require('telescope.actions').move_selection_next,
        ['<C-k>'] = require('telescope.actions').move_selection_previous,
        ['<C-s>'] = require('telescope.actions').file_split,
      },
    },
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      sort_mru = true,
      previewer = false,
      theme = 'dropdown',
      ignore_current_buffer = true,
    },
    find_files = { theme = 'dropdown', previewer = false },
    git_files = { theme = 'dropdown', previewer = false },
    registers = { theme = 'dropdown' },
    lsp_code_actions = {
      theme = 'cursor',
      layout_config = {
        height = 12,
      },
    },
    lsp_range_code_actions = { theme = 'cursor' },
    loclist = { previewer = false },
    live_grep = { theme = 'ivy' },
  },
  extensions = {
    -- fzf = {
    --   fuzzy = true,
    --   override_generic_sorter = false, -- override the generic sorter
    --   override_file_sorter = true, -- override the file sorter
    --   case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
    --   -- the default case_mode is 'smart_case'
    -- },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        -- even more opts
      },
    },
  },
}

telescope.load_extension 'ui-select'
-- telescope.load_extension 'fzf' -- FIXME causes an error

if pcall(require, 'nvim-mapper') then telescope.load_extension 'mapper' end
if pcall(require, 'project_nvim') then telescope.load_extension 'projects' end
if pcall(require, 'harpoon') then telescope.load_extension 'harpoon' end
if pcall(require, 'dap') then telescope.load_extension 'dap' end

local ts_builtins = require 'telescope.builtin'
local utils = require 'b.plugins.telescope.utils'

require('b.utils').apply_keymaps {
  { 'n', '<leader>/f',        ts_builtins.find_files,      'Find files' },
  { 'n', '<leader>/g',        ts_builtins.git_files,       'Find git files' },
  { 'n', '<leader>/S',        utils.live_grep_in_folder,   'Live grep in folder' },
  { 'n', '<leader>/s',        ts_builtins.live_grep,       'Live grep' },
  { 'n', '<leader><leader>/', utils.search_config,         'Search Neovim config' },
  { 'n', '<leader>/B',        ts_builtins.builtin,         'Search Telescope builtins' },
  { 'n', '<leader>/a',        ts_builtins.autocommands,    'Search autocommands' },
  { 'n', '<leader>/G',        ts_builtins.git_bcommits,    'Search buffer git commits' },
  { 'n', '<leader>/b',        ts_builtins.buffers,         'Search buffers' },
  { 'n', '<leader>/C',        ts_builtins.command_history, 'Search command history' },
  { 'n', '<leader>/c',        ts_builtins.commands,        'Search commands' },
  { 'n', '<leader>/H',        utils.highlights,            'Search highlights' },
  { 'n', '<leader>/h',        utils.help_tags,             'Search help tags' },
  { 'n', '<leader>/M',        ts_builtins.keymaps,         'Search keymaps' },
  { 'n', '<leader>/m',        ts_builtins.marks,           'Search marks' },
  { 'n', '<leader>/r',        ts_builtins.registers,       'Search registers' },
  { 'n', '<leader>/t',        ts_builtins.treesitter,      'Search treesitter' },
}
