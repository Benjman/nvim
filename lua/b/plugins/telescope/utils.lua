local Path = require 'plenary.path'
local action_set = require 'telescope.actions.set'
local action_state = require 'telescope.actions.state'
local actions = require 'telescope.actions'
local conf = require('telescope.config').values
local finders = require 'telescope.finders'
local make_entry = require 'telescope.make_entry'
local os_sep = Path.path.sep
local pickers = require 'telescope.pickers'
local scan = require 'plenary.scandir'
local builtin = require 'telescope.builtin'
local themes = require 'telescope.themes'

local function search_config()
  builtin.find_files {
    prompt_title = '< VimConfig >',
    cwd = '$HOME/.config/nvim',
  }
end

local function help_tags() builtin.help_tags(themes.get_ivy()) end

local function live_grep_in_folder(opts)
  opts = opts or {}
  local data = {}
  scan.scan_dir(vim.loop.cwd(), {
    hidden = opts.hidden,
    only_dirs = true,
    respect_gitignore = opts.respect_gitignore,
    on_insert = function(entry) table.insert(data, entry .. os_sep) end,
  })
  table.insert(data, 1, '.' .. os_sep)

  pickers
    .new(opts, {
      prompt_title = 'Folders for Live Grep',
      finder = finders.new_table { results = data, entry_maker = make_entry.gen_from_file(opts) },
      previewer = conf.file_previewer(opts),
      sorter = conf.file_sorter(opts),
      attach_mappings = function(prompt_bufnr)
        action_set.select:replace(function()
          local current_picker = action_state.get_current_picker(prompt_bufnr)
          local dirs = {}
          local selections = current_picker:get_multi_selection()
          if vim.tbl_isempty(selections) then
            table.insert(dirs, action_state.get_selected_entry().value)
          else
            for _, selection in ipairs(selections) do
              table.insert(dirs, selection.value)
            end
          end
          actions.close(prompt_bufnr)
          builtin.live_grep { search_dirs = dirs }
        end)
        return true
      end,
    })
    :find()
end

---Sort and filter lsp results
local function sort_null_ls_as_last(lsp_results)
  local results = {}
  local null_results = {}

  for client_id, result in ipairs(lsp_results) do
    local client = vim.lsp.get_client_by_id(client_id)
    local is_null_ls = client.name == 'null-ls'
    print(client.name, is_null_ls)

    if is_null_ls then
      table.insert(null_results, result)
    else
      table.insert(results, result)
    end
  end

  -- Sort null-ls actions to the end
  return vim.list_extend(results, null_results)
end

local function lsp_code_actions(opts)
  -- Attach to vim.lsp.buf_request_sync
  local buf_request_sync = vim.lsp.buf_request_sync

  vim.lsp.buf_request_sync = function(...)
    local lsp_results, err = buf_request_sync(...)
    vim.lsp.buf_request_sync = buf_request_sync
    if err then return nil, err end

    return sort_null_ls_as_last(lsp_results), nil
  end

  builtin.lsp_code_actions(opts)
end

local function highlights()
  -- Extending default builtin to take selected value and put it into the buffer at the cursor position
  builtin.highlights {
    attach_mappings = function(prompt_bufnr, _)
      actions.select_default:replace(function()
        actions.close(prompt_bufnr)
        local pos = vim.api.nvim_win_get_cursor(0)
        local line = vim.api.nvim_get_current_line()
        local new_line = line:sub(0, pos[2])
          .. action_state.get_selected_entry().value
          .. line:sub(pos[2] + 1, string.len(line))
        vim.api.nvim_set_current_line(new_line)
        vim.api.nvim_win_set_cursor(0, { pos[1], string.len(new_line) })
      end)
      return true
    end,
  }
end

return {
  help_tags = help_tags,
  highlights = highlights,
  live_grep_in_folder = live_grep_in_folder,
  lsp_code_actions = lsp_code_actions,
  search_config = search_config,
  solsp_code_actionsrt_null_ls_as_last = sort_null_ls_as_last,
}