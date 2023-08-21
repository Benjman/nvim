local M = {
  fmt_is_enabled = true,
  fmt_augroups = {},
}
local cmp_nvim_lsp_present, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')

function M.init()
  vim.diagnostic.config {
    underline = true,
    virtual_text = true,
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

function M.set_lsp_keymaps(bufnr)
  local function opts(desc)
    return { desc = 'LSP: ' .. desc, buffer = bufnr, noremap = true, silent = true }
  end

  local lsp_keymaps = {
    { 'n', 'gd', vim.lsp.buf.definition, opts('Go to definition') },
    { 'n', 'gr', vim.lsp.buf.references, opts('Find references') },
    { 'n', 'gi', vim.lsp.buf.implementation, opts('Go to implementation') },
    { 'n', '<leader>pd', vim.diagnostic.open_float, opts('Show diagnostics') },
    { 'n', '<leader>pr', vim.lsp.buf.rename, opts('Rename') },
    { 'n', '<leader>la', vim.lsp.buf.code_action, opts('Code action') },
    { 'n', 'gs', '<C-w>s<cmd>lua vim.lsp.buf.definition()<cr>', opts('Go to definition in horizontal split') },
    { 'n', 'gv', '<C-w>v<cmd>lua vim.lsp.buf.definition()<cr>', opts('Go to definition in vertical split') },
    { { 'i', 'n' }, '<c-space>', vim.lsp.buf.signature_help, opts('Signature help') },
    { 'n', '<leader>bf', M.toggle_fmt, 'Toggle formatting on save' },
  }

  require('b.utils').apply_keymaps(lsp_keymaps)
end

function M.toggle_fmt()
  M.fmt_is_enabled = not M.fmt_is_enabled
  vim.notify('Formatting on save toggled ' .. (M.fmt_is_enabled and 'on' or 'off'))
end

function M.fmt_get_augroup(client)
  if not M.fmt_augroups[client.id] then
    local group_name = 'b-lsp-format' .. client.name
    local id = vim.api.nvim_create_augroup(group_name, { clear = true })
    M.fmt_augroups[client.id] = id
  end
  return M.fmt_augroups[client.id]
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

function M.get_client_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  local present_cmp, cmp = pcall(require, 'cmp_nvim_lsp')
  if present_cmp then
    capabilities = vim.tbl_extend('force', capabilities, cmp.default_capabilities())
  end
  return capabilities
end

return M
