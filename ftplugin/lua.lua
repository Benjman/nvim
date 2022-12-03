vim.api.nvim_create_autocmd('FileType', {
  pattern = 'lua',
  callback = function()
    local config = {
      name = 'sumneko_lua',
      cmd = { 'lua-language-server' },
      settings = {
        Lua = {
          runtime = {
            version = 'LuaJIT',
          },
          diagnostics = {
            globals = { 'vim' },
          },
          workspace = {
            library = vim.api.nvim_get_runtime_file('', true),
            checkThirdParty = false,
          },
          telemetry = { enable = false },
        },
      },
      root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
      on_attach = function(client, bufnr)
        require('b.lsp').on_attach(client, bufnr)
        require('b.lsp').format_on_save_enable(bufnr)
        client.server_capabilities.documentFormattingProvider = false
      end,
    }
    vim.lsp.start(vim.tbl_deep_extend('force', require('b.lsp').mk_config(), config))
  end,
})
