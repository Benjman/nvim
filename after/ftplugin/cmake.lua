if vim.fn.executable('cmake-language-server') == 1 then
  vim.lsp.start({
    name = 'CMake',
    cmd = { 'cmake-language-server' },
    root_dir = vim.fs.dirname(vim.fs.find({ 'build/' }, { upward = true })[1]),
  })
end
