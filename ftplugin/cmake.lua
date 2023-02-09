if vim.fn.executable 'cmake-language-server' == 1 then
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'cmake',
    callback = function()
      local config = {
        name = 'cmake-language-server',
        cmd = { 'cmake-language-server' },
        root_dir = vim.fs.dirname(vim.fs.find({ 'build/' }, { upward = true })[1]),
      }
      vim.lsp.start(vim.tbl_deep_extend('force', require('b.lsp').mk_config(), config))
    end,
  })
end
