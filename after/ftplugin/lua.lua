local executable = 'lua-language-server'
if vim.fn.executable(executable) == 0 then return vim.notify('\'' .. executable .. '\' not found', vim.log.levels.WARN) end
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
  on_attach = function(_, _)
    require('b.lsp').fmt_is_enabled = false
  end,
})
