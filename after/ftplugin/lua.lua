if vim.fn.executable('lua-language-server') == 1 then
  vim.lsp.start({
    name = 'LuaLS',
    cmd = { 'lua-language-server' },
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', },
        diagnostics = { globals = { 'vim' }, },
        workspace = { checkThirdParty = false, },
        telemetry = { enable = false },
      },
    },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
  })
end
