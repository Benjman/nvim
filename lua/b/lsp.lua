local M = {}
local cmp_nvim_lsp_present, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

function M.init()
  vim.diagnostic.config {
    underline = false,
    virtual_text = false,
    signs = true,
    severity_sort = true,
  }
  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
  local signs = {
    { text = '', name = 'DiagnosticSignError' },
    { text = '', name = 'DiagnosticSignWarn' },
    { text = '', name = 'DiagnosticSignHint' },
    { text = '', name = 'DiagnosticSignInfo' },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text })
  end
end

function M.on_attach(_, bufnr)
  M.init()
  M.set_lsp_keymaps(bufnr)
end

function M.set_lsp_keymaps(bufnr)
  local toggle_formatting = function()
    M.format_on_save_toggle(bufnr)
  end

  local function opts(desc)
    return { desc = 'LSP: ' .. desc, buffer = bufnr, noremap = true, silent = true }
  end

  local lsp_keymaps = {
    { 'n', 'gd', vim.lsp.buf.definition, opts('Go to definition') },
    { 'n', 'gr', vim.lsp.buf.references, opts('Find references') },
    { 'n', 'gi', vim.lsp.buf.implementation, opts('Go to implementation') },
    { 'n', '<leader>pd', vim.diagnostic.open_float, opts('Show diagnostics') },
    { 'n', '<leader>pr', vim.lsp.buf.rename, opts('Rename') },
    { 'n', '<leader>lf', toggle_formatting, opts('Toggle formatting on/off') },
    { 'n', '<leader>la', vim.lsp.buf.code_action, opts('Code action') },
    { 'n', 'gs', '<C-w>s<cmd>lua vim.lsp.buf.definition()<cr>', opts('Go to definition in horizontal split') },
    { 'n', 'gv', '<C-w>v<cmd>lua vim.lsp.buf.definition()<cr>', opts('Go to definition in vertical split') },
    { { 'i', 'n' }, '<c-space>', vim.lsp.buf.signature_help, opts('Signature help') },
  }

  if pcall(require, 'null-ls') then
    table.insert(lsp_keymaps, { 'n', '<leader>li', require('null-ls.info').show_window, 'LSP Info', opts })
  end

  require('b.utils').apply_keymaps(lsp_keymaps)
end

local formatting = { formatting_autocmds = {}, format_on_save_grp_ = vim.api.nvim_create_augroup('LspFormatting', {}) }

function M.format_on_save_enable(bufnr)
  formatting.formatting_autocmds[bufnr] = vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    group = formatting.format_on_save_grp_,
    callback = vim.lsp.buf.formatting_sync,
  })
  vim.notify 'Enabled formatting on save'
end

function M.format_on_save_disable(bufnr)
  vim.api.nvim_del_autocmd(formatting.formatting_autocmds[bufnr])
  formatting.formatting_autocmds[bufnr] = nil
  vim.notify 'Disabled formatting on save'
end

function M.format_on_save_toggle(bufnr)
  if formatting.formatting_autocmds[bufnr] == nil then
    M.format_on_save_enable(bufnr)
  else
    M.format_on_save_disable(bufnr)
  end
end

function M.root_pattern(...) -- from neovim/nvim-lspconfig
  local patterns = vim.tbl_flatten { ... }
  local function matcher(path)
    for _, pattern in ipairs(patterns) do
      for _, p in ipairs(vim.fn.glob(M.path.join(M.path.escape_wildcards(path), pattern), true, true)) do
        if M.path.exists(p) then
          return path
        end
      end
    end
  end
  return function(startpath)
    startpath = M.strip_archive_subpath(startpath)
    return M.search_ancestors(startpath, matcher)
  end
end

return M
