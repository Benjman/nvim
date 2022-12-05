local cmp_nvim_lsp_present, cmp_nvim_lsp = pcall('require', 'cmp_nvim_lsp')

local function add_signs()
  local signs = {
    { text = '', name = 'DiagnosticSignError' },
    { text = '', name = 'DiagnosticSignWarn' },
    { text = '', name = 'DiagnosticSignHint' },
    { text = '', name = 'DiagnosticSignInfo' },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = '' })
  end
  return signs
end

local function on_attach(_, bufnr)
  vim.lsp.handlers['textDocument/signatureHelp'] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'single' })
  require('b.keymaps').lsp(bufnr)
end

local function mk_config()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  if cmp_nvim_lsp_present then
    capabilities = vim.tbl_deep_extend('force', capabilities, cmp_nvim_lsp.default_capabilities())
  end
  return {
    capabilities = capabilities,
    flags = {
      debounce_text_changes = 80,
    },
    handlers = {},
    init_options = {},
    on_attach = on_attach,
    settings = {},
    signs = add_signs(),
  }
end

local formatting = { formatting_autocmds = {}, format_on_save_grp_ = vim.api.nvim_create_augroup('LspFormatting', {}) }

local function format_on_save_enable(bufnr)
  formatting.formatting_autocmds[bufnr] = vim.api.nvim_create_autocmd('BufWritePre', {
    buffer = bufnr,
    group = formatting.format_on_save_grp_,
    callback = vim.lsp.buf.formatting_sync,
  })
  vim.notify 'Enabled formatting on save'
end

local function format_on_save_disable(bufnr)
  vim.api.nvim_del_autocmd(formatting.formatting_autocmds[bufnr])
  formatting.formatting_autocmds[bufnr] = nil
  vim.notify 'Disabled formatting on save'
end

local function format_on_save_toggle(bufnr)
  if formatting.formatting_autocmds[bufnr] == nil then
    format_on_save_enable(bufnr)
  else
    format_on_save_disable(bufnr)
  end
end

return {
  add_signs = add_signs,
  format_on_save_disable = format_on_save_disable,
  format_on_save_enable = format_on_save_enable,
  format_on_save_toggle = format_on_save_toggle,
  mk_config = mk_config,
  on_attach = on_attach,
}
