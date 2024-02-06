vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })
vim.keymap.set({ 'n', 'v' }, '<C-Q>', ':quit<cr>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>dm', vim.diagnostic.open_float, { desc = '[d]iagnostic message [f]loating window' })
vim.keymap.set('n', '<leader>do', vim.diagnostic.setloclist, { desc = '[O]pen [d]iagnostics' })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "[B]uffer: [N]ext buffer" })
vim.keymap.set("n", "<leader>bp", "<cmd>bnext<cr>", { desc = "[B]uffer: [P]rev buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "[B]uffer: Other [B]uffer" })
vim.keymap.set("n", "<leader>bD", "<cmd>bufdo bdelete<cr>", { desc = "[B]uffer: [D]elete all buffers" })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- windows
vim.keymap.set("n", "<leader>ww", "<C-W>p", { desc = "Other window", remap = true })
vim.keymap.set("n", "<leader>wd", "<C-W>c", { desc = "Delete window", remap = true })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })
vim.keymap.set("n", "<leader>w-", "<C-W>s", { desc = "Split window below", remap = true })
vim.keymap.set("n", "<leader>w|", "<C-W>v", { desc = "Split window right", remap = true })

-- start LSP server
vim.keymap.set('n', '<leader>lss', '<cmd>LspStart<cr>', { desc = '[L]SP [S]erver: [S]tart' })
vim.keymap.set('n', '<leader>lsi', '<cmd>LspInfo<cr>', { desc = '[L]SP [S]erver: [I]nfo' })

-- quickfix
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<cr>', { desc = '[Q]uickfix [n]ext' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<cr>', { desc = '[Q]uickfix [p]revious' })

-- File management
vim.keymap.set('n', '<leader>fn',
  function()
    local new_path = vim.fn.input({
      completion = 'dir',
      default = './' .. vim.fn.expand('%:h') .. '/',
      prompt = 'New File: ',
    })
    if new_path ~= '' and new_path ~= vim.fn.expand('%:h') .. '/' then
      vim.api.nvim_command('silent !touch ' .. new_path)
      vim.api.nvim_command('silent e ' .. new_path)
    end
  end,
  { desc = '[F]ile [N]ew' }
)

vim.keymap.set('n', '<leader>fd',
  function()
    local file_path = vim.fn.expand('%:p')
    local prompt = string.format("Are you sure you want to delete '%s'? [y/N]: ", file_path)
    local confirm = vim.fn.input(prompt)
    if confirm:lower() == 'y' then
      local bufnr = vim.fn.bufnr(0)
      vim.api.nvim_command('silent !rm ' .. vim.fn.shellescape(file_path))
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = true })
      end
    end
  end,
  { desc = '[F]ile [D]elete' }
)
