local set = vim.keymap.set
local opts = { noremap = true, silent = true }

local function init()
  set('v', '<', '<gv', opts) -- indentation without leaving visual mode
  set('v', '>', '>gv', opts) -- indentation without leaving visual mode
  set('v', 'p', '"_dP', opts) -- replace selected with yanked
  set('n', '<C-n>', '<cmd>cnext<cr>', opts) -- jump to next item in quickfix list
  set('n', '<C-p>', '<cmd>cprev<cr>', opts) -- jump to previous item in quickfix list
  set('n', '<C-q>', '<cmd>cclose<cr>', opts) -- close quickfix list
  set('n', 'Q', '<cmd>qa<cr>', opts) -- Quickly close vim
end

return {
  init = init,
}
