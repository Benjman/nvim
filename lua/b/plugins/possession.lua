return {
  "gennaro-tedesco/nvim-possession",
  config = function()
    local sessions_dir = vim.fn.stdpath("data") .. "/sessions"
    if not vim.loop.fs_stat(sessions_dir) then
      vim.fn.mkdir(sessions_dir)
    end
    require("nvim-possession").setup({
      autoload = true,
      autoswitch = {
        enable = true,
      },
    })
    vim.keymap.set("n", "<leader>Sl", require("nvim-possession").list, { silent = true, desc = "[S]ession: [L]ist" })
    vim.keymap.set("n", "<leader>Sn", require("nvim-possession").new, { silent = true, desc = "[S]ession: [N]ew" })
    vim.keymap.set(
      "n",
      "<leader>Su",
      require("nvim-possession").update,
      { silent = true, desc = "[S]ession: [U]pdate" }
    )
    vim.keymap.set(
      "n",
      "<leader>Sd",
      require("nvim-possession").delete,
      { silent = true, desc = "[S]ession: [D]elete" }
    )
  end,
  dependencies = {
    "ibhagwan/fzf-lua",
  },
}
