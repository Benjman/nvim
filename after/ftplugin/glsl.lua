if vim.fn.executable('glslls') == 0 then return vim.notify('\'glslls\' not found', vim.log.levels.WARN) end
vim.lsp.start({
  name = 'GLSL',
  cmd = { 'glslls', '--stdin' },
  root_dir = vim.fn.getcwd(),
})
