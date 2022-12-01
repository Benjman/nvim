local present, nvim_tree = pcall(require, 'nvim-tree')
if not present then return end

local tree_cb = require('nvim-tree.config').nvim_tree_callback

-- default mappings
local mappings = {
  { key = { '<CR>', 'o', '<2-LeftMouse>', 'l' }, cb = tree_cb('edit') },
  { key = { '<2-RightMouse>', '<C-]>' }, cb = tree_cb('cd') },
  { key = '<C-v>', cb = tree_cb('vsplit') },
  { key = '<C-s>', cb = tree_cb('split') },
  { key = '<C-t>', cb = tree_cb('tabnew') },
  { key = '<', cb = tree_cb('prev_sibling') },
  { key = '>', cb = tree_cb('next_sibling') },
  { key = 'P', cb = tree_cb('parent_node') },
  { key = '<BS>', cb = tree_cb('close_node') },
  { key = { '<S-CR>', 'h' }, cb = tree_cb('close_node') },
  { key = '<Tab>', cb = tree_cb('preview') },
  { key = 'K', cb = tree_cb('first_sibling') },
  { key = 'J', cb = tree_cb('last_sibling') },
  { key = 'I', cb = tree_cb('toggle_ignored') },
  { key = 'H', cb = tree_cb('toggle_dotfiles') },
  { key = 'R', cb = tree_cb('refresh') },
  { key = 'a', cb = tree_cb('create') },
  { key = 'd', cb = tree_cb('remove') },
  { key = 'r', cb = tree_cb('rename') },
  { key = '<C-r>', cb = tree_cb('full_rename') },
  { key = 'x', cb = tree_cb('cut') },
  { key = 'c', cb = tree_cb('copy') },
  { key = 'p', cb = tree_cb('paste') },
  { key = '<C-o>', cb = tree_cb('copy_name') },
  { key = '<C-O>', cb = tree_cb('copy_path') },
  { key = 'gy', cb = tree_cb('copy_absolute_path') },
  { key = '[c', cb = tree_cb('prev_git_item') },
  { key = ']c', cb = tree_cb('next_git_item') },
  { key = 's', cb = tree_cb('system_open') },
  { key = '-', cb = tree_cb('close') },
  { key = 'q', cb = tree_cb('close') },
  { key = 'g?', cb = tree_cb('toggle_help') },
}

nvim_tree.setup {
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
  filters = {
    dotfiles = true,
  },
  git = {
    enable = false,
    show_on_open_dirs = false,
  },
  open_on_setup = false,
  open_on_tab = false,
  renderer = {
    group_empty = true,
    highlight_opened_files = 'icon',
    icons = {
      show = {
        folder = false,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
  },
  respect_buf_cwd = true,
  update_cwd = false,
  update_focused_file = { enable = true, update_cwd = false, ignore_list = {} },
  view = {
    adaptive_size = true,
    centralize_selection = true,
    preserve_window_proportions = true,
    float = {
      enable = true,
      open_win_config = {
        relative = 'win',
        border = 'rounded',
        width = 90,
        height = 60,
        row = 1,
        col = 1,
      }
    },
    mappings = {
      list = mappings,
    },
  },
}

vim.keymap.set('n', '-', '<cmd>NvimTreeToggle<cr>', { noremap = true, silent = true }, 'Toggle explorer')
