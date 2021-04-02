local actions = require('telescope.actions')
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
                preview_width = 0.6
            },
            vertical = {
                mirror = false
            }
        },
        shorten_path = true,
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
            ["<c-k>"] = actions.move_selection_previous
          }
        }
    }
}
function jh_fd()
  require('telescope.builtin').find_files {
    find_command = {'fd','--type','f','--hidden','--follow','--exclude','.git'}
  }
end
