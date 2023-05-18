local plugins = function(use)
  use { 'nvim-lua/plenary.nvim' } -- General Lua functions and utilities
  use { 'wbthomason/packer.nvim', opt = true } -- Plugin manager

  use { 'nvim-treesitter/nvim-treesitter', event = 'BufEnter', run = ':TSUpdate', config = [[require('b.plugins.treesitter')]] } -- Syntax highlighting and parsing using Treesitter
  use { 'folke/tokyonight.nvim' } -- Tokyonight color scheme
  use { 'nvim-tree/nvim-tree.lua', requires = { 'nvim-tree/nvim-web-devicons' }, config = [[require('b.plugins.nvim-tree')]] } -- Provides a file explorer tree for easy navigation and management
  use { 'nvim-tree/nvim-web-devicons' } -- File icon support for NvimTree
  use { 'nvim-lualine/lualine.nvim', event = 'VimEnter', config = [[require('b.plugins.statusline')]] } -- Statusline plugin
  use { 'akinsho/bufferline.nvim', event = 'VimEnter', config = [[require('b.plugins.bufferline')]] } -- Buffer line plugin
  use { 'lukas-reineke/indent-blankline.nvim', event = 'VimEnter', config = [[require('b.plugins.indent-blankline')]] } -- Indentation guide lines plugin
  use { 'rcarriga/nvim-notify', event = 'BufEnter', config = function() vim.defer_fn(function() require('b.plugins.nvim-notify') end, 2000) end } -- Notification plugin
  use { 'tpope/vim-commentary', event = 'VimEnter' } -- Commenting plugin
  use { 'stevearc/dressing.nvim' } -- Utility UI library
  use { 'lewis6991/gitsigns.nvim', config = [[require('b.plugins.gitsigns')]] } -- Git integration plugin
  use { 'kevinhwang91/nvim-bqf', ft = 'qf', config = [[require('b.plugins.bqf')]] } -- Better quickfix window plugin
  use { 'andymass/vim-matchup', event = 'VimEnter' } -- Enhanced % matching plugin

  use { 'nvim-telescope/telescope.nvim', config = [[require('b.plugins.telescope')]] } -- A highly extensible fuzzy finder
  use { 'nvim-telescope/telescope-symbols.nvim', after = 'telescope.nvim' } -- Enables symbol search functionality
  use { 'nvim-telescope/telescope-ui-select.nvim' } -- Provides UI customization options
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make', after = 'telescope.nvim' } -- Enables FZF-native sorting functionality

  use { 'SirVer/ultisnips', event = 'InsertEnter' } -- Snippet engine
  use { 'honza/vim-snippets', after = 'ultisnips' } -- Snippet collection for UltiSnips

  use { 'onsails/lspkind-nvim', event = 'VimEnter' } -- Adds symbol icons for LSP items
  use { 'hrsh7th/nvim-cmp', after = 'lspkind-nvim', config = [[require('b.plugins.nvim-cmp')]] } -- Autocompletion plugin framework
  use { 'hrsh7th/cmp-buffer', after = 'nvim-cmp' } -- Completion source for buffer words
  use { 'hrsh7th/cmp-emoji', after = 'nvim-cmp' } -- Provides emoji completion
  use { 'hrsh7th/cmp-nvim-lsp', after = 'nvim-cmp' } -- Adds LSP completion source
  use { 'quangnguyen30192/cmp-nvim-ultisnips', after = { 'nvim-cmp', 'ultisnips' } } -- Enables UltiSnips as a source
  use { 'hrsh7th/cmp-omni', after = 'nvim-cmp' } -- Adds Omni completion source
  use { 'hrsh7th/cmp-path', after = 'nvim-cmp' } -- Provides file path completion source
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
