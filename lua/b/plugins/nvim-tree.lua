local present_cmp, nvim_tree = pcall(require, 'nvim-tree')
if not present_cmp then return end

local api = require('nvim-tree.api')

local function nvim_tree_activate()
  if api.tree.is_visible() then
    api.tree.focus()
  else
    api.tree.toggle()
  end
end

require('b.utils').apply_keymaps {
  { 'n', '-', nvim_tree_activate, 'nvim-tree: Activate' }, -- Globally available key mapping
}

local function on_attach(bufnr)
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr }
  end

  require('b.utils').apply_keymaps {
    { 'n', '<C-]>',          api.tree.change_root_to_node,          opts('CD') },
    { 'n', '<C-e>',          api.node.open.replace_tree_buffer,     opts('Open: In Place') },
    { 'n', '<C-k>',          api.node.show_info_popup,              opts('Info') },
    { 'n', '<C-r>',          api.fs.rename_sub,                     opts('Rename: Omit Filename') },
    { 'n', '<C-t>',          api.node.open.tab,                     opts('Open: New Tab') },
    { 'n', '<C-v>',          api.node.open.vertical,                opts('Open: Vertical Split') },
    { 'n', '<C-x>',          api.node.open.horizontal,              opts('Open: Horizontal Split') },
    { 'n', 'h',              api.node.navigate.parent_close,        opts('Close Directory') },
    { 'n', '<CR>',           api.node.open.edit,                    opts('Open') },
    { 'n', '<Tab>',          api.node.open.preview,                 opts('Open Preview') },
    { 'n', '>',              api.node.navigate.sibling.next,        opts('Next Sibling') },
    { 'n', '<',              api.node.navigate.sibling.prev,        opts('Previous Sibling') },
    { 'n', '.',              api.node.run.cmd,                      opts('Run Command') },
    { 'n', '-',              function() end,                        opts('Up') },
    { 'n', 'a',              api.fs.create,                         opts('Create') },
    { 'n', 'bmv',            api.marks.bulk.move,                   opts('Move Bookmarked') },
    { 'n', 'B',              api.tree.toggle_no_buffer_filter,      opts('Toggle No Buffer') },
    { 'n', 'c',              api.fs.copy.node,                      opts('Copy') },
    { 'n', 'C',              api.tree.toggle_git_clean_filter,      opts('Toggle Git Clean') },
    { 'n', '[c',             api.node.navigate.git.prev,            opts('Prev Git') },
    { 'n', ']c',             api.node.navigate.git.next,            opts('Next Git') },
    { 'n', 'd',              api.fs.remove,                         opts('Delete') },
    { 'n', 'D',              api.fs.trash,                          opts('Trash') },
    { 'n', 'E',              api.tree.expand_all,                   opts('Expand All') },
    { 'n', 'e',              api.fs.rename_basename,                opts('Rename: Basename') },
    { 'n', ']e',             api.node.navigate.diagnostics.next,    opts('Next Diagnostic') },
    { 'n', '[e',             api.node.navigate.diagnostics.prev,    opts('Prev Diagnostic') },
    { 'n', 'F',              api.live_filter.clear,                 opts('Clean Filter') },
    { 'n', 'f',              api.live_filter.start,                 opts('Filter') },
    { 'n', 'g?',             api.tree.toggle_help,                  opts('Help') },
    { 'n', 'gy',             api.fs.copy.absolute_path,             opts('Copy Absolute Path') },
    { 'n', 'H',              api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles') },
    { 'n', 'I',              api.tree.toggle_gitignore_filter,      opts('Toggle Git Ignore') },
    { 'n', 'J',              api.node.navigate.sibling.last,        opts('Last Sibling') },
    { 'n', 'K',              api.node.navigate.sibling.first,       opts('First Sibling') },
    { 'n', 'm',              api.marks.toggle,                      opts('Toggle Bookmark') },
    { 'n', 'l',              api.node.open.edit,                    opts('Open') },
    { 'n', 'o',              api.node.open.edit,                    opts('Open') },
    { 'n', 'O',              api.node.open.no_window_picker,        opts('Open: No Window Picker') },
    { 'n', 'p',              api.fs.paste,                          opts('Paste') },
    { 'n', 'P',              api.node.navigate.parent,              opts('Parent Directory') },
    { 'n', 'q',              api.tree.close,                        opts('Close') },
    { 'n', 'r',              api.fs.rename,                         opts('Rename') },
    { 'n', 'R',              api.tree.reload,                       opts('Refresh') },
    { 'n', 's',              api.node.run.system,                   opts('Run System') },
    { 'n', 'S',              api.tree.search_node,                  opts('Search') },
    { 'n', 'U',              api.tree.toggle_custom_filter,         opts('Toggle Hidden') },
    { 'n', 'W',              api.tree.collapse_all,                 opts('Collapse') },
    { 'n', 'x',              api.fs.cut,                            opts('Cut') },
    { 'n', 'y',              api.fs.copy.filename,                  opts('Copy Name') },
    { 'n', 'Y',              api.fs.copy.relative_path,             opts('Copy Relative Path') },
    { 'n', '<2-LeftMouse>',  api.node.open.edit,                    opts('Open') },
    { 'n', '<2-RightMouse>', api.tree.change_root_to_node,          opts('CD') },
  }
end

nvim_tree.setup {
  auto_reload_on_write = true,
  disable_netrw = false,
  hijack_cursor = false,
  hijack_netrw = true,
  hijack_unnamed_buffer_when_opening = false,
  on_attach = on_attach,
  open_on_tab = false,
  sort_by = 'name',
  update_cwd = false,
  view = {
    width = 30,
    hide_root_folder = false,
    side = 'left',
    preserve_window_proportions = false,
    number = false,
    relativenumber = false,
    signcolumn = 'yes',
    mappings = {
      custom_only = false,
      list = {
      },
    },
  },
  renderer = {
    group_empty = true,
    indent_markers = {
      enable = false,
      icons = {
        corner = '└ ',
        edge = '│ ',
        none = '  ',
      },
    },
    icons = {
      webdev_colors = true,
    },
  },
  hijack_directories = {
    enable = true,
    auto_open = true,
  },
  update_focused_file = {
    enable = true,
    update_cwd = false,
    ignore_list = {},
  },
  system_open = {
    cmd = '',
    args = {},
  },
  diagnostics = {
    enable = false,
    show_on_dirs = false,
    icons = {
      hint = '',
      info = '',
      warning = '',
      error = '',
    },
  },
  filters = {
    dotfiles = false,
    custom = {},
    exclude = {},
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 400,
  },
  actions = {
    use_system_clipboard = true,
    change_dir = {
      enable = true,
      global = false,
      restrict_above_cwd = false,
    },
    open_file = {
      quit_on_open = false,
      resize_window = false,
      window_picker = {
        enable = true,
        chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890',
        exclude = {
          filetype = { 'notify', 'packer', 'qf', 'diff', 'fugitive', 'fugitiveblame' },
          buftype = { 'nofile', 'terminal', 'help' },
        },
      },
    },
  },
  trash = {
    cmd = 'trash',
    require_confirm = true,
  },
  log = {
    enable = false,
    truncate = false,
    types = {
      all = false,
      config = false,
      copy_paste = false,
      diagnostics = false,
      git = false,
      profile = false,
    },
  },
}
