vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sh',
  callback = function()
    local config = {
      name = 'bash-language-server',
      cmd = { 'bash-language-server', 'start' },
    }
    vim.lsp.start(vim.tbl_deep_extend('force', require('b.lsp').mk_config(), config))
  end,
})
