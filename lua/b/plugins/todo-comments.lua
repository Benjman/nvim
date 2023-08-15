local present, tc = pcall(require, 'todo-comments')
if not present then return end

tc.setup({
  search = {
    command = 'rg',
    args = {
      "--glob=!lib/",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
    },
  },
})

local function opts(desc)
  return { desc = 'todo-comments: ' .. desc }
end

require('b.utils').apply_keymaps {
  { 'n', '<leader>tn', tc.jump_next,                   opts('Next') },
  { 'n', '<leader>tp', tc.jump_prev,                   opts('Previous') },
  { 'n', '<leader>tq', ':TodoQuickFix<cr>',            opts('Quickfix') },
  { 'n', '<leader>tt', ':TodoTelescope theme=ivy<cr>', opts('Telescope') },
}
