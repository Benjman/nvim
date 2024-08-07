-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

local function augroup(name)
  return vim.api.nvim_create_augroup("user_" .. name, { clear = true })
end

-- Disable autopairs when recording a macro
local minipairs_state
vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
  group = augroup("macro_no_pairs"),
  callback = function(ev)
    if ev.event == "RecordingEnter" then
      minipairs_state = vim.g.minipairs_disable or false
      vim.g.minipairs_disable = true
    else
      vim.g.minipairs_disable = minipairs_state
    end
  end,
})
