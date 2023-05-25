-- Don't forget to set Godot's external editor settings to:
--     Use external editor:   On
--     Exec path:             nvim
--     Exec flags:            --server /tmp/godot.pipe --remote-send "<esc>:n {file}<CR>:call cursor({line},{col})<CR>"

vim.lsp.start({
  name = 'Godot',
  cmd = vim.lsp.rpc.connect('127.0.0.1', os.getenv 'GDScript_Port' or '6005'),
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
  on_attach = function(client, bufnr)
    require('b.lsp').on_attach(client, bufnr)
    vim.api.nvim_command('echo serverstart("/tmp/godot.pipe")')
  end,
})

vim.opt_local.expandtab = false
vim.opt_local.commentstring = '# %s'
