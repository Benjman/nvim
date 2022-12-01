local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  print 'Cloning packer..'
  vim.fn.delete(install_path, 'rf')
  vim.fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print 'Installing packer close and reopen Neovim...'
end

vim.cmd [[packadd packer.nvim]]

vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function()
    vim.cmd [[ source <afile> ]]
    vim.cmd [[ PackerSync ]]
  end,
  group = vim.api.nvim_create_augroup('packer_reload', { clear = true }),
  pattern = { 'lua/b/plugins.lua' },
})

local status_ok, packer = pcall(require, 'packer')
if not status_ok then return end

packer.init {
  display = {
    open_fn = function() return require('packer.util').float { border = 'rounded' } end,
    prompt_border = 'single',
  },
  git = {
    clone_timeout = 600, -- Timeout, in seconds, for git clones
  },
  auto_clean = true,
  compile_on_sync = true,
  auto_reload_compiled = true,
}

return packer.startup {
  function(use)
    use { 'wbthomason/packer.nvim', event = 'VimEnter' }

    use {
      'kyazdani42/nvim-tree.lua',
      config = function() require 'b.plugins.nvim-tree' end,
    }

    use {
      'shatur/neovim-session-manager',
      config = function() require 'b.plugins.neovim-session-manager' end,
    }
  end,
}
