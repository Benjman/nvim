if vim.fn.executable('glslls') == 1 then
  vim.lsp.start({
    name = 'GLSL',
    cmd = { 'glslls', '--stdin' },
    root_dir = vim.fn.getcwd(),
  })
else
  vim.notify('\'glslls\' executable not found')
end
