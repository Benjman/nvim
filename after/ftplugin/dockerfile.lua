if vim.fn.executable('docker-langserver') == 1 then
  vim.lsp.start({
    name = 'Docker',
    cmd = { 'docker-langserver', '--stdio' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'Dockerfile' }, { upward = true })[1]),
  })
end
