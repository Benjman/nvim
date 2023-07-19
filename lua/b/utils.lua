local fn = vim.fn

local M = {
  config_augroup = vim.api.nvim_create_augroup('BGroup', { clear = true }),
}

function M.executable(name)
  if fn.executable(name) > 0 then
    return true
  end

  return false
end

--- check whether a feature exists in Nvim
--- @feat: string
---   the feature name, like `nvim-0.7` or `unix`.
--- return: bool
function M.has(feat)
  if fn.has(feat) == 1 then
    return true
  end

  return false
end

--- Create a dir if it does not exist
function M.may_create_dir(dir)
  local res = fn.isdirectory(dir)

  if res == 0 then fn.mkdir(dir, 'p')
  end
end

--- Generate random integers in the range [Low, High], inclusive,
--- adapted from https://stackoverflow.com/a/12739441/6064933
--- @low: the lower value for this range
--- @high: the upper value for this range
function M.rand_int(low, high)
  -- Use lua to generate random int, see also: https://stackoverflow.com/a/20157671/6064933
  math.randomseed(os.time())

  return math.random(low, high)
end

--- Select a random element from a sequence/list.
--- @seq: the sequence to choose an element
function M.rand_element(seq)
  local idx = M.rand_int(1, #seq)

  return seq[idx]
end

function M.add_pack(name)
  local status, _ = pcall(vim.cmd, 'packadd ' .. name)
  return status
end

-- Function to apply multiple keymaps
-- @param keymaps A list of keymaps, where each keymap is a table with the following structure:
--                {mode, keys, action, options}.
--                mode: The mode in which the keymap is valid (e.g., 'n' for normal mode).
--                keys: The keys to be mapped.
--                action: The action to be performed when the keys are pressed.
--                options: An optional table of options or a description string for the keymap. 
--                         If a table, it should contain key-value pairs representing options 
--                         (will be merged with default options). 
--                         If a string, it will be used as a description of the keymap and 
--                         added to the options table under the 'desc' key.
function M.apply_keymaps(keymaps)
  local default_opts = { noremap = true, silent = true }
  for _, keymap in ipairs(keymaps) do
    local mode, keys, action, options = unpack(keymap)
    if type(options) == 'table' then
      options = vim.tbl_deep_extend('keep', options, default_opts)
    else
      options = vim.tbl_deep_extend('keep', { desc = options }, default_opts)
    end
    vim.keymap.set(mode, keys, action, options)
  end
end

return M
