return {
  "folke/todo-comments.nvim",
  opts = {
    search = {
      command = "rg",
      args = {
        "--glob=!lib/",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
      },
    },
  },
}
