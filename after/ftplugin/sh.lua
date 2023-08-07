local executable = 'bash-language-server'
if vim.fn.executable(executable) == 0 then return vim.notify('\'' .. executable .. '\' not found', vim.log.levels.WARN) end
vim.lsp.start({
  name = 'Bash',
  cmd = { 'bash-language-server', 'start' },
  root_dir = vim.fn.getcwd(),
})
