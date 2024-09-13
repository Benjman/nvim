return {
  "nvim-telescope/telescope.nvim",
  opts = function(_, opts)
    opts.defaults.file_ignore_patterns = { "build", "lib" }
    opts.pickers.colorscheme = { ignore_builtins = true }
  end,
}
