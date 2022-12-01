vim.api.nvim_create_autocmd('FileType', {
  pattern = 'zsh',
  callback = function() vim.bo.filetype = 'sh' end,
})
