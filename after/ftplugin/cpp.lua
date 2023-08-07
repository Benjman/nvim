-- change highlighting for tokens like `public`, `private`, and `const`
vim.api.nvim_set_hl(0, '@type.qualifier', { link = '@keyword' })
vim.api.nvim_set_hl(0, '@storageclass', { link = '@keyword' })

local executable = 'clangd'
if vim.fn.executable(executable) == 0 then return vim.notify('\'' .. executable .. '\' not found', vim.log.levels.WARN) end
vim.lsp.start({
  name = 'Clang',
  cmd = { 'clangd' },
  root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
})
