return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  config = function()
    vim.keymap.set('n', '<leader>fe', '<cmd>Neotree left<cr>', { desc = '[F]ile [E]xplore' })
    vim.keymap.set('n', '<leader>ff', '<cmd>Neotree float<cr>', { desc = '[F]ile explore [f]loat' })
  end,
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
    "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  opts = {
    filesystem = {
      follow_current_file = {
        enabled = true, -- This will find and focus the file in the active buffer every time
        --               -- the current file is changed while the tree is open.
      },
      group_empty_dirs = true, -- when true, empty folders will be grouped together
    },
  },
}
