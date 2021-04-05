local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
require("telescope").setup {
    defaults = {
        vimgrep_arguments = {
            "rg",
            "--hidden",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case"
        },
        prompt_position = "top",
        sorting_strategy = "ascending",
        layout_defaults = {
            horizontal = {
                mirror = false,
                preview_width = 0.5
            },
            vertical = {
                mirror = false
            }
        },
        winblend = 0,
        width = 0.75,
        preview_cutoff = 60,
        set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
        -- Developer configurations: Not meant for general override
        buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker,
        mappings = {
          i = {
            ["<esc>"] = actions.close,
            ["<c-j>"] = actions.move_selection_next,
            ["<c-k>"] = actions.move_selection_previous,
            ["<tab>"] = actions.add_selection + actions.move_selection_next,
            ["<s-tab>"] = actions.remove_selection + actions.move_selection_previous
          }
        }
    }
}

function my_find_files()
  require('telescope.builtin').find_files {
    find_command = {'fd','--type','f','--hidden','--follow','--exclude','.git'}
  }
end

function my_buffers(opts)
  opts = opts or {}
  opts.attach_mappings = function(prompt_bufnr, map)
    local delete_buf = function()
      local selection = action_state.get_selected_entry()
      actions.close(prompt_bufnr)
      vim.api.nvim_buf_delete(selection.bufnr, { force = true })
    end
    map('i', '<c-d>', delete_buf)
    return true
  end
  -- opts.previewer = false
  require('telescope.builtin').buffers(opts)
end
