local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  return
end

local lga_status_ok, lga_actions = pcall(require, "telescope-live-grep-args.actions")
if not lga_status_ok then
  return
end

telescope.setup {
  defaults = {

    prompt_prefix = " ",
    selection_caret = " ",
    path_display = { "smart" },
    file_ignore_patterns = { ".git/", "node_modules" },
  },
  extensions = {
    live_grep_args = {
      auto_quoting = true, -- enable/disable auto-quoting
      mappings = { -- extend mappings
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
        },
      },
      theme = "ivy",
    },
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
    },
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = "smart_case", -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

telescope.load_extension "live_grep_args"
telescope.load_extension "undo"
telescope.load_extension "refactoring"
telescope.load_extension "noice"
telescope.load_extension('fzf')
