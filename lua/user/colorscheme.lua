local colorscheme = 'tokyonight'

vim.g.tokyonight_style = 'night'
vim.g.tokyonight_italic_comments = true
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_functions = true
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_transparent = false
vim.g.tokyonight_hide_inactive_statusline = false
vim.g.tokyonight_sidebars = { 'qf', 'vista_kind', 'terminal', 'packer' }
vim.g.tokyonight_dark_sidebar = true
vim.g.tokyonight_dark_float = true

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  vim.notify('colorscheme ' .. colorscheme .. ' not found!')
  return
end
