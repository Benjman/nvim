if vim.fn.executable('gopls') == 0 then return vim.notify('\'gopls\' not found', vim.log.levels.WARN) end
vim.lsp.start({
  name = 'Go',
  capabilities = require('b.lsp').get_client_capabilities(),
  cmd = { 'gopls', 'serve' },
  root_dir = vim.fn.getcwd(),
})
