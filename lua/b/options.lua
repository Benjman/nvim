local options = {

  backup = false,
  cmdheight = 1, -- Give more space for displaying messages.
  cursorcolumn = false,
  cursorline = true,
  errorbells = false,
  expandtab = true,
  hidden = true,
  ignorecase = true,
  inccommand = 'split', -- live preview of substitutions
  incsearch = true,
  hlsearch = false,
  number = true,
  relativenumber = true,
  scrolloff = 8,
  shiftwidth = 2,
  showmatch = true,
  smartcase = false,
  smartindent = true,
  smarttab = true,
  softtabstop = 2,
  spell = true,
  splitbelow = true,
  splitright = true,
  swapfile = false,
  tabstop = 2,
  termguicolors = true,
  timeoutlen = 500, -- time to wait for a mapped sequence to complete (in milliseconds)
  undodir = vim.fn.stdpath 'cache' .. '/undodir',
  undofile = true,
  updatetime = 50, -- Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable delays and poor user experience.
  wrap = false,

  -- Set completeopt to have a better completion experience
  -- :help completeopt
  -- menuone: popup even when there's only one match
  -- noinsert: Do not insert text until a selection is made
  -- noselect: Do not select, force user to select one from the menu
  completeopt = { 'menuone', 'noselect' }, -- mostly just for cmp

  -- column & git column
  signcolumn = 'yes:2',

  -- done by status bar
  showmode = false,

  -- show spaces
  list = true,
  listchars = 'tab:>·,trail:~,extends:>,precedes:<',

  -- global statusline
  laststatus = 2,
}

for k, v in pairs(options) do
  vim.opt[k] = v
end

-- disable netrw
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.opt.shortmess:append 'c'

vim.g.loaded_matchparen = 1

-- -- fold
-- vim.wo.foldcolumn = '0' -- defines 1 col at window left, to indicate folding
-- vim.o.foldlevelstart = 99 -- start file with all folds opened
--
-- -- using treesitter for folding
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'
