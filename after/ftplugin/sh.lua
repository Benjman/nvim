if vim.fn.executable('bash-language-server') == 1 then
  vim.lsp.start({
    name = 'Bash',
    cmd = { 'bash-language-server', 'start' },
    root_dir = vim.fn.getcwd(),
    on_attach = require('b.lsp').on_attach,
  })
end
