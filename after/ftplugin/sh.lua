if vim.fn.executable('bash-language-server') == 1 then
  vim.lsp.start({
    name = 'Bash',
    cmd = { 'bash-language-server', 'start' },
    root_dir = vim.fn.getcwd(),
  })
end
