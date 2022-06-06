local fn = vim.fn

-- Automatically install packer
local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    "git",
    "clone",
    "--depth",
    "1",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  }
  print "Installing packer close and reopen Neovim..."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]


-- Use a protected call so we don"t error out on first use
local status_ok, packer = pcall(require, "packer")
if not status_ok then
  return
end

-- Have packer use a popup window
packer.init {
  display = {
    open_fn = function()
      return require("packer.util").float { border = "rounded" }
    end,
  },
}

return packer.startup(function(use)
  use "wbthomason/packer.nvim" -- packer can manage itself
  use "nvim-lua/plenary.nvim"
  use "windwp/nvim-autopairs"
  use "kevinhwang91/rnvimr" -- better file explorer
  use "moll/vim-bbye"
  use "akinsho/bufferline.nvim"
  use "lewis6991/impatient.nvim"
  -- use "folke/which-key.nvim" -- TODO implement
  use "andymass/vim-matchup"
  use "nacro90/numb.nvim" -- TODO implement
  use "windwp/nvim-spectre"
  use "folke/zen-mode.nvim"
  use "karb94/neoscroll.nvim"
  -- use "ThePrimeagen/harpoon" -- TODO implement
  use "tpope/vim-repeat"
  use "rcarriga/nvim-notify"
  use "ghillb/cybu.nvim"
  use "rmagatti/auto-session"

  -- commenting
  use "numToStr/Comment.nvim" -- motion based commenting
  use "folke/todo-comments.nvim" -- todo-like comment highlighting -- TODO implement
  -- use "danymat/neogen" -- code annotation comments -- TODO implement

  -- completion
  use "hrsh7th/nvim-cmp"
  use "hrsh7th/cmp-buffer" -- buffer completions
  use "hrsh7th/cmp-path" -- path completions
  use "hrsh7th/cmp-cmdline" -- cmdline completions
  use "saadparwaiz1/cmp_luasnip" -- snippet completions
  use "hrsh7th/cmp-nvim-lsp"
  use "hrsh7th/cmp-emoji"
  use "hrsh7th/cmp-nvim-lua"
  --use "rcarriga/cmp-dap"

  -- colorschemes
  use "folke/tokyonight.nvim"
  use "lunarvim/colorschemes"
  use "lunarvim/darkplus.nvim"
  use "rose-pine/neovim"

  -- snippets
  use "L3MON4D3/LuaSnip" --snippet engine -- TODO does this need configuration?
  use "rafamadriz/friendly-snippets" -- a bunch of snippets to use

  -- lsp
  use "neovim/nvim-lspconfig"
  use "williamboman/nvim-lsp-installer"
  use "ray-x/lsp_signature.nvim"

  -- telescope
  use "nvim-telescope/telescope.nvim"
  use "nvim-telescope/telescope-file-browser.nvim"
  use { "nvim-telescope/telescope-fzf-native.nvim", run = "make" }
  use "nvim-telescope/telescope-media-files.nvim"
  use "nvim-telescope/telescope-ui-select.nvim"
  use "tom-anders/telescope-vim-bookmarks.nvim"

  -- treesitter
  use {
    "nvim-treesitter/nvim-treesitter",
    run = ":TSUpdate",
  }
  use "JoosepAlviste/nvim-ts-context-commentstring"
  use "p00f/nvim-ts-rainbow"
  use "nvim-treesitter/playground"
  use "windwp/nvim-ts-autotag"
  use "romgrk/nvim-treesitter-context"
  use "mizlan/iswap.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if PACKER_BOOTSTRAP then
    require("packer").sync()
  end
end)
