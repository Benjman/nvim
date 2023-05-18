vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.asc', '*.gpg', '*.pgp' },
  callback = function()
    vim.bo.filetype = 'text'
    vim.bo.swapfile = false
    vim.opt.backup = false
  end,
})
