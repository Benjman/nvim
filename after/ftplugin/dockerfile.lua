local executable = 'docker-langserver'
if vim.fn.executable(executable) == 0 then return vim.notify('\'' .. executable .. '\' not found', vim.log.levels.WARN) end
vim.lsp.start({
  name = 'Docker',
  cmd = { 'docker-langserver', '--stdio' },
  root_dir = vim.fs.dirname(vim.fs.find({ '.git', 'Dockerfile' }, { upward = true })[1]),
})
