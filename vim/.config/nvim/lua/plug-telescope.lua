local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
require("telescope").setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--hidden',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--glob=!.git',
      '--column',
      '--smart-case'
    },
    sorting_strategy = "ascending",
    layout_strategy = "horizontal",
    layout_config = {
      horizontal = {
        height = 0.6,
        preview_width = 0.5,
        prompt_position = "top",
        preview_cutoff = 60,
      },
      vertical = {
        mirror = false
      }
    },
    mappings = {
      i = {
        ["<esc>"] = actions.close,
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<tab>"] = actions.add_selection + actions.move_selection_next,
        ["<s-tab>"] = actions.remove_selection + actions.move_selection_previous
      }
    }
  },
  pickers = {
    buffers = {
      sort_lastused = true,
      mappings = {
        i = {
          ["<c-d>"] = require("telescope.actions").delete_buffer,
        },
      }
    }
  }
}

function ff()
  require('telescope.builtin').find_files {
    find_command = {'fd','--type','f','--hidden','--follow','--exclude','.git'}
  }
end
