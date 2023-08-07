local executable = 'cmake-language-server'
if vim.fn.executable(executable) == 0 then return vim.notify('\'' .. executable .. '\' not found', vim.log.levels.WARN) end
vim.lsp.start({
  name = 'CMake',
  cmd = { 'cmake-language-server' },
  root_dir = vim.fs.dirname(vim.fs.find({ 'build/' }, { upward = true })[1]),
})
