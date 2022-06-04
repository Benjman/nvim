local opts = { noremap = true, silent = true }
local keymap = vim.api.nvim_set_keymap

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

keymap('', '<Space>', '<Nop>', opts)

-- Window nav
keymap("n", "<C-h>",     "<C-w>h",                  opts) -- Window navigation
keymap("n", "<C-j>",     "<C-w>j",                  opts) -- Window navigation
keymap("n", "<C-k>",     "<C-w>k",                  opts) -- Window navigation
keymap("n", "<C-l>",     "<C-w>l",                  opts) -- Window navigation
keymap("n", "<C-Up>",    "<cmd>resize -2<cr>",          opts) -- Window resizing
keymap("n", "<C-Down>",  "<cmd>resize +2<cr>",          opts) -- Window resizing
keymap("n", "<C-Left>",  "<cmd>vertical resize -2<cr>", opts) -- Window resizing
keymap("n", "<C-Right>", "<cmd>vertical resize +2<cr>", opts) -- Window resizing

keymap("n", "gx", "<cmd>split | lua vim.lsp.buf.definition()<cr>",      opts) -- Goes to definition in a split
keymap("n", "gv", "<cmd>vert split | lua vim.lsp.buf.definition()<cr>", opts) -- Goes to definition in a vertical split

keymap("v", "p",     '"_dP',                opts) -- Replace selected with what is yanked
keymap("x", "J",     "<cmd>move '>+1<cr>gv-gv", opts) -- Move selected down
keymap("x", "K",     "<cmd>move '<-2<cr>gv-gv", opts) -- Move selected up
keymap("v", "<",     "<gv",                 opts) -- Indentation without leaving visual mode
keymap("v", ">",     ">gv",                 opts) -- Indentation without leaving visual mode

keymap("n", "<leader>e",  "<cmd>RnvimrToggle<cr>", opts)

-- lsp stuff
keymap("i", "<C-e>",      "<cmd>lua vim.lsp.buf.signature_help()<cr>",                 opts)
keymap("n", "<C-e>",      "<cmd>lua vim.lsp.buf.signature_help()<cr>",                 opts)
keymap("n", "<leader>f",  "<cmd>lua require'user.telescope.pickers'.find_files()<cr>", opts)
keymap("n", "<leader>F",  "<cmd>lua require'user.telescope.pickers'.live_grep()<cr>",  opts)
keymap("n", "<leader>tb", "<cmd>lua require'user.telescope.pickers'.buffers()<cr>",    opts)
keymap("n", "<leader>th", "<cmd>lua require'user.telescope.pickers'.help_tags()<cr>",  opts)

keymap("n", "<leader>lI", "<cmd>LspInstallInfo<cr>",                opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
keymap("n", "<leader>li", "<cmd>LspInfo<cr>",                       opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<cr>",      opts)

keymap("n", "<C-n>", "<cmd>cnext<cr>",  opts) -- jump to next item in quickfix list
keymap("n", "<C-p>", "<cmd>cprev<cr>",  opts) -- jump to previous item in quickfix list
keymap("n", "<C-q>", "<cmd>cclose<cr>", opts) -- close quickfix list

