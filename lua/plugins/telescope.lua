local actions = require('telescope.actions')

require('telescope').setup {
  defaults = {
    sorting_strategy = "ascending",
    layout_strategy  = "horizontal",
    layout_config    = {
      horizontal = {
        prompt_position = "top",
        width = { padding = 0 },
        height = { padding = 0 },
        preview_width = 0.5,
      },
    },
    borders          = {},
    borderchars      = { "", "", "", "", "", "", "", "" },
    prompt_prefix    = "  ",
    selection_caret  = "  ",
    mappings         = {
      i = {
        ["<c-d>"] = actions.delete_buffer,
        ["dd"] = actions.delete_buffer,
      },
      n = {
        ["<c-d>"] = actions.delete_buffer,
        ["dd"] = actions.delete_buffer,
      },
    },
    path_display     = {
      filename_first = {
        reverse_directories = true,
      },
    },
  },
  pickers = {
    ignore_current_buffer = true,
  },
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {}
    }
  }
}

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")
