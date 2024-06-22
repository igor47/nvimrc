local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local actions = require "telescope.actions"

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "truncate" },
    dynamic_preview_title = true,
    file_ignore_patterns = { ".git/", "node_modules" },

    mappings = {
      i = {
        ["<Down>"] = actions.cycle_history_next,
        ["<Up>"] = actions.cycle_history_prev,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
    },

    -- see:
    -- https://stackoverflow.com/a/75424071/153995
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case',
      '--hidden',
    },
  },
  pickers = {
    diagnostics = {
      theme = "dropdown",
    },
    buffers = {
      show_all_buffers = true,
      sort_lastused = true,
      theme = "dropdown",
      previewer = false,
      mappings = {
        i = {
          ["<c-d>"] = "delete_buffer",
        }
      },
    },
  },
}

require('telescope').load_extension('fzf')

local builtin = require("telescope.builtin")
local keymap = vim.keymap.set

keymap("n", "<C-p>", builtin.git_files, {})
keymap("n", "<leader>b", builtin.buffers, {})
keymap("n", "<leader>tj", builtin.current_buffer_fuzzy_find, {})
keymap("n", "<leader>tg", builtin.live_grep, {})
keymap("n", "<leader>tr", builtin.lsp_references, {})
keymap("n", "<leader>td", builtin.lsp_definitions, {})
keymap("n", "<leader>te", function () builtin.diagnostics({ bufnr = 0 }) end, {})
keymap("n", "<leader>ts", builtin.treesitter, {})

--[[ disable folds for telescope results. see:
  https://github.com/nvim-telescope/telescope.nvim/issues/991
]]
vim.api.nvim_create_autocmd("FileType", { pattern = "TelescopeResults", command = [[setlocal nofoldenable]] })
