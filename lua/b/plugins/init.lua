local plugins = function(use)
  use { 'nvim-lua/plenary.nvim' } -- General Lua functions and utilities
  use { 'wbthomason/packer.nvim', opt = true } -- Plugin manager

end

local api = vim.api
local fn = vim.fn

vim.g.plugin_home = fn.stdpath('data') .. '/site/pack/packer'

local function packer_ensure_install()
  -- Where to install packer.nvim -- the package manager (we make it opt)
  local packer_dir = vim.g.plugin_home .. '/opt/packer.nvim'

  if fn.glob(packer_dir) ~= '' then
    return false
  end

  -- Auto-install packer in case it hasn't been installed.
  vim.api.nvim_echo({ { 'Installing packer.nvim', 'Type' } }, true, {})

  local packer_repo = 'https://github.com/wbthomason/packer.nvim'
  local install_cmd = string.format('!git clone --depth=1 %s %s', packer_repo, packer_dir)
  vim.cmd(install_cmd)

  return true
end

local fresh_install = packer_ensure_install()

api.nvim_create_autocmd('BufWritePost', {
  pattern = '*/nvim/lua/b/plugins/init.lua',
  group = api.nvim_create_augroup('packer_auto_compile', { clear = true }),
  callback = function(ctx)
    local cmd = 'source ' .. ctx.file
    vim.cmd(cmd)
    vim.cmd('PackerCompile')
    vim.notify('PackerCompile done!', vim.log.levels.INFO, { title = 'Nvim-config' })
  end,
})

-- Install packer if it hasn't been installed.
vim.cmd('packadd packer.nvim')

require('packer').startup({
  plugins,
  config = {
    max_jobs = 16,
    compile_path = require('packer.util').join_paths(fn.stdpath('data'), 'site', 'lua', 'packer_compiled.lua'),
  },
})

if fresh_install then
  require('packer').sync()
else
  local status, _ = pcall(require, 'packer_compiled')
  if not status then
    local msg = 'File packer_compiled.lua not found: run PackerSync to fix!'
    vim.notify(msg, vim.log.levels.ERROR, { title = 'nvim-config' })
  end
end

require('b.utils').apply_keymaps {
  { 'n', '<leader><leader>ps', ':PackerStatus<cr>',  'packer: Status' },
  { 'n', '<leader><leader>pS', ':PackerSync<cr>',    'packer: Sync' },
  { 'n', '<leader><leader>pc', ':PackerCompile<cr>', 'packer: Compile' },
}
