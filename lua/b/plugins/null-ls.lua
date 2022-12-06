local present, nls = pcall(require, 'null-ls')
if not present then return end

nls.setup {
  sources = {
    nls.builtins.code_actions.gitsigns,
    nls.builtins.diagnostics.clang_check,
    nls.builtins.diagnostics.cppcheck,
    nls.builtins.diagnostics.write_good.with { filetypes = { 'markdown', 'text' } },
    nls.builtins.formatting.clang_format,
    nls.builtins.formatting.prettier,
    nls.builtins.formatting.stylua,
  },
}
