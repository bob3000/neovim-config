local status_ok, bufferline = pcall(require, "bufferline")
if not status_ok then
  return
end

bufferline.setup {
  options = {
    diagnostics = "nvim_lsp",
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    right_mouse_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    offsets = { { filetype = "NvimTree", text = "File Explorer", padding = 1 } },
    separator_style = "slant", -- | "thick" | "thin" | { 'any', 'any' },
  },
}
