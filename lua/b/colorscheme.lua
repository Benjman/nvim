local present, tokyonight = pcall(require, 'tokyonight')
if not present then return end

-- reload when file is saved
vim.api.nvim_create_autocmd('BufWritePost', {
  callback = function() vim.cmd [[ source <afile> ]] end,
  group = vim.api.nvim_create_augroup('colorscheme_reload', { clear = true }),
  pattern = { 'lua/b/colorscheme.lua' },
})

local function on_colors(_) end

local function on_highlights(hl, colors)
  hl.CursorLineNr = { bg = colors.bg_highlight, fg = colors.fg_dark, bold = true }
  hl.LineNr = { fg = colors.fg_gutter, bold = true }
  hl.NormalFloat = { fg = colors.fg_dark, bg = colors.bg_dark }
  hl.PMenu = { bg = colors.bg_dark }
  hl.SignColumn = { bg = colors.bg_dark }
  hl.StatusLine = { fg = colors.fg_float, bg = colors.bg_highlight }
  hl.WinSeparator = { fg = colors.dark3 }

  if pcall(require, 'telescope') then
    hl.TelescopeNormal = { bg = colors.bg_dark, fg = colors.dark3fg_dark }
    hl.TelescopeBorder = vim.tbl_extend('force', hl.TelescopeNormal or {}, { fg = colors.blue, bold = true })
    hl.TelescopeSelection = { bg = colors.blue7, fg = colors.blue5 }
  end

  if pcall(require, 'cmp') then
    hl.CmpItemAbbr = { fg = colors.fg_dark }
    hl.CmpItemAbbrMatch = { fg = colors.info }
    hl.CmpItemAbbrMatchFuzzy = { fg = colors.blue }
    hl.CmpItemAbbrDeprecated = { fg = colors.red, strikethrough = 1 }
    hl.CmpItemAbbrDeprecatedDefault = { fg = colors.red, strikethrough = 1 }
  end

  if pcall(require, 'nvim-tree') then
    hl.NvimTreeFolderName = { fg = colors.blue }
    hl.NvimTreeOpenedFolderName = vim.tbl_extend('force', hl.NvimTreeFolderName or {}, { bold = true })
    hl.NvimTreeOpenedFile = { bold = true, italic = true }
  end

end

tokyonight.setup {
  style = 'night',
  styles = {
    comments = { italic = true },
    keywords = { italic = false },
    functions = { italic = true },
    variables = { italic = true },
    -- sidebars = { 'qf', 'vista_kind', 'terminal', 'packer', 'NvimTree' },
    floats = 'light',
  },
  on_colors = on_colors,
  on_highlights = on_highlights,
}

vim.cmd [[ syntax on ]]
vim.cmd [[ colorscheme tokyonight ]]
