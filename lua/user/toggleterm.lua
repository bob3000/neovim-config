local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
  return
end

toggleterm.setup {
  autochdir = true,
  size = 20,
  open_mapping = [[<c-\>]],
  hide_numbers = true,
  shade_terminals = true,
  shading_factor = 2,
  start_in_insert = true,
  insert_mappings = true,
  persist_size = true,
  direction = "float",
  close_on_exit = true,
  shell = vim.o.shell,
  float_opts = {
    border = "curved",
  },
  winbar = {
    enabled = false,
    name_formatter = function(term) --  term: Terminal
      return term.name
    end,
  },
}

function _G.set_terminal_keymaps()
  local opts = { noremap = true }
  -- vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-h>", [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-j>", [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-k>", [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, "t", "<C-l>", [[<C-\><C-n><C-W>l]], opts)
end

vim.cmd "autocmd! TermOpen term://* lua set_terminal_keymaps()"

local Terminal = require("toggleterm.terminal").Terminal

local lazygit = Terminal:new { cmd = "lazygit", hidden = true }
function _LAZYGIT_TOGGLE()
  lazygit:toggle()
end

local wiki = Terminal:new { dir = "~/Nextcloud/Synced/wiki", cmd = "nvim index.md", hidden = true }
function _WIKI_TOGGLE()
  wiki:toggle()
end

local config = Terminal:new { dir = "~/.config/nvim", cmd = "nvim init.lua", hidden = true }
function _CONFIG_TOGGLE()
  config:toggle()
end

local python = Terminal:new { cmd = "ipython", hidden = true }
function _PYTHON_TOGGLE()
  python:toggle()
end

local lua = Terminal:new { cmd = "lua", hidden = true }
function _LUA_TOGGLE()
  lua:toggle()
end
