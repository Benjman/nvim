-- change highlighting for tokens like `public`, `private`, and `const`
vim.api.nvim_set_hl(0, '@type.qualifier', { link = '@keyword' })
vim.api.nvim_set_hl(0, '@storageclass', { link = '@keyword' })

if vim.fn.executable('clangd') == 1 then
  vim.lsp.start({
    name = 'Clang',
    cmd = { 'clangd' },
    root_dir = vim.fs.dirname(vim.fs.find({ '.git' }, { upward = true })[1]),
  })
end
