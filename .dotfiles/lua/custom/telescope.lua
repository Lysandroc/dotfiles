  local actions = require('telescope.actions')
  require('telescope').setup{
    defaults = {
      file_sorter = require('telescope.sorters').get_fzy_sorter,
      prompt_prefix = '> ',
      prompt_position = "top",
      sorting_strategy = "ascending",
      set_env = { ['COLORTERM'] = 'truecolor' },
      file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
      grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
      qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-s>"] = actions.select_horizontal, 
          ["<C-v>"] = actions.select_vertical, 
          ["<C-q>"] = actions.send_to_qflist,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,
        },
      },
      extensions = {
          fzy_native = {
              override_generic_sorter = false,
              override_file_sorter = true,
          }
      }
    }
  }

  require('telescope').load_extension('fzy_native')

  local M = {}

  M.search_dotfiles = function() 
      require("telescope.builtin").find_files({
          prompt_title = "< dotfiles repository >",
          cwd = "$HOME/dotfiles",
          find_command = {
            "rg",
            "--smart-case",
            "--files",
            "--hidden",
            "--follow",
            "-g",
            "!.git/*"
          }
      })
  end

  return M
