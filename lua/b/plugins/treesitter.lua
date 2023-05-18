local present, treesitter = pcall(require, 'nvim-treesitter.configs')
if not present then return end

treesitter.setup {
  ensure_installed = 'all',
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = { 'help' }, -- list of language that will be disabled
  },
}
