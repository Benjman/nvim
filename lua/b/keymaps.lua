-- This script sets up keymaps for Neovim, LSP, and Telescope.

local set = vim.keymap.set
local opts = { noremap = true, silent = true }

local function apply_keymaps(keymaps)
  for _, keymap in ipairs(keymaps) do
    local mode, keys, action, options, description = unpack(keymap)
    set(mode, keys, action, options, description)
  end
end

local function lsp(bufnr)
  local lsp_opts = vim.tbl_extend('force', opts, { buffer = bufnr })

  local lsp_keymaps = {
    { 'n', 'gd', vim.lsp.buf.definition, lsp_opts, 'Go to definition' },
    { 'n', 'gr', vim.lsp.buf.references, lsp_opts, 'Find references' },
    { 'n', 'gi', vim.lsp.buf.implementation, lsp_opts, 'Go to implementation' },
    { 'n', 'gl', vim.diagnostic.open_float, lsp_opts, 'Show diagnostics' },
    { 'n', '<leader>pr', vim.lsp.buf.rename, lsp_opts, 'Rename' },
    {
      'n',
      '<leader>lf',
      function() require('b.lsp').format_on_save_toggle(bufnr) end,
      lsp_opts,
      'Toggle formatting on/off',
    },
    { 'n', '<leader>la', vim.lsp.buf.code_action, lsp_opts, 'Code action' },
    { 'n', 'gs', '<C-w>s<cmd>lua vim.lsp.buf.definition()<cr>', lsp_opts, 'Go to definition in split' },
    { 'n', 'gv', '<C-w>v<cmd>lua vim.lsp.buf.definition()<cr>', lsp_opts, 'Go to definition in vertical split' },
    { 'i', '<c-space>', vim.lsp.buf.signature_help, lsp_opts, 'Signature help' },
    { 'n', '<c-space>', vim.lsp.buf.signature_help, lsp_opts, 'Signature help' },
  }

  if pcall(require, 'null-ls') then
    table.insert(lsp_keymaps, { 'n', '<leader>li', require('null-ls.info').show_window, lsp_opts, 'LSP Info' })
  end

  apply_keymaps(lsp_keymaps)
end

local function telescope()
  local builtin = require 'telescope.builtin'

  local telescope_keymaps = {
    { 'n', '<leader>ps', builtin.live_grep, opts, 'Live grep' },
    { 'n', '<leader>pf', builtin.find_files, opts, 'Find files' },
    { 'n', '<leader>po', builtin.oldfiles, opts, 'Find files' },
    { 'n', '<leader>pg', builtin.git_files, opts, 'Find git files' },
    { 'n', '<leader>/a', builtin.autocommands, opts, 'Search autocommands' },
    { 'n', '<leader>/b', builtin.builtin, opts, 'Search Telescope builtins' },
    { 'n', '<leader>/C', builtin.command_history, opts, 'Search command history' },
    { 'n', '<leader>/c', builtin.commands, opts, 'Search commands' },
    { 'n', '<leader>/r', builtin.registers, opts, 'Search registers' },
    { 'n', '<leader>/m', builtin.marks, opts, 'Search marks' },
    { 'n', '<leader>/M', builtin.keymaps, opts, 'Search keymaps' },
    { 'n', '<leader>/t', builtin.treesitter, opts, 'Search treesitter' },
    { 'n', '<leader>bl', builtin.buffers, opts, 'Search buffers' },
    { 'n', '<leader>bc', builtin.git_bcommits, opts, 'Search buffer git commits' },
  }

  local functions = require 'b.plugins.telescope.utils'
  table.insert(telescope_keymaps, { 'n', '<leader>/h', functions.help_tags, opts, 'Search highlights' })
  table.insert(telescope_keymaps, { 'n', '<leader>cc', functions.search_config, opts, 'Search Neovim config' })
  table.insert(telescope_keymaps, { 'n', '<leader>pS', functions.live_grep_in_folder, opts, 'Live grep in folder' })
  table.insert(telescope_keymaps, { 'n', '<leader>/H', functions.highlights, opts, 'Search highlights' })

  apply_keymaps(telescope_keymaps)
end

local function init()
  local general_keymaps = {
    { 'v', '<', '<gv', opts, 'Indentation without leaving visual mode' },
    { 'v', '>', '>gv', opts, 'Indentation without leaving visual mode' },
    { 'v', 'p', '"_dP', opts, 'Replace selected with yanked' },
    { 'n', '<C-n>', '<cmd>cnext<cr>', opts, 'Jump to next item in quickfix list' },
    { 'n', '<C-p>', '<cmd>cprev<cr>', opts, 'Jump to previous item in quickfix list' },
    { 'n', '<C-q>', '<cmd>cclose<cr>', opts, 'Close quickfix list' },
    { 'n', 'Q', '<cmd>qa<cr>', opts, 'Quickly close Vim' },
  }

  apply_keymaps(general_keymaps)
end

return {
  init = init,
  lsp = lsp,
  telescope = telescope,
}
