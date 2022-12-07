-- highlight on yank text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function() vim.highlight.on_yank() end,
  group = vim.api.nvim_create_augroup('TextYankPost_hl_on_yank', { clear = true }),
})
