local M = {}

local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

M.buffers = function ()
  builtin.buffers(themes.get_dropdown { previewer = false })
end

M.diagnostics = function ()
  builtin.diagnostics(themes.get_dropdown { previewer = false })
end

M.find_files = function ()
  builtin.find_files(themes.get_dropdown { previewer = false })
end

M.help_tags = function ()
  builtin.help_tags()
end

M.live_grep = function ()
  builtin.live_grep(themes.get_ivy())
end

M.lsp_references = function ()
  builtin.lsp_references()
end

return M
