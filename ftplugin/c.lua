vim.api.nvim_create_autocmd('FileType', {
  pattern = 'c',
  callback = function()
    local config = {
      cmd = { 'clangd' },
      name = 'clangd',
      root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
      on_attach = function(client, bufnr)
        local lsp = require 'b.lsp'
        lsp.on_attach(client, bufnr)
        if vim.fn.filereadable(vim.fn.getcwd() .. '/.clang-format') == 1 then
          lsp.format_on_save_enable(bufnr)
          client.server_capabilities.documentFormattingProvider = false
        end
      end,
    }
    vim.lsp.start(vim.tbl_deep_extend('force', require('b.lsp').mk_config(), config))
    vim.lsp.set_log_level(vim.log.levels.OFF) -- FIXME all clangd logs are sent as en error.
  end,
})
