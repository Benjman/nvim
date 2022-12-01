vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.comp', '*.frag', '*.geom', '*.tesc', '*.tese', '*.vert', '*.fs', '*.vs' },
  callback = function() vim.bo.filetype = 'glsl' end,
})
