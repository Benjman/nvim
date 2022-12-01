local present, telescope = pcall(require, 'telescope')
if not present then return end

require('b.keymaps').telescope()

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
    fzf = {
      fuzzy = true,
      override_generic_sorter = false, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or 'ignore_case' or 'respect_case'
      -- the default case_mode is 'smart_case'
    },
    ['ui-select'] = {
      require('telescope.themes').get_dropdown {
        -- even more opts
      },
    },
  },
}

telescope.load_extension 'ui-select'
telescope.load_extension 'fzf'

if pcall(require, 'nvim-mapper') then telescope.load_extension 'mapper' end
if pcall(require, 'project_nvim') then telescope.load_extension 'projects' end
if pcall(require, 'harpoon') then telescope.load_extension 'harpoon' end
if pcall(require, 'dap') then telescope.load_extension 'dap' end
