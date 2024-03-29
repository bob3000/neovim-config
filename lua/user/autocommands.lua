vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "qf", "help", "man", "lspinfo", "spectre_panel" },
  callback = function()
    vim.cmd [[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]]
  end,
})

-- configure plaintext files
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- disable spelling for certain file types
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "Outline", "NvimTree" },
  callback = function()
    vim.opt_local.spell = false
  end,
})

vim.cmd "autocmd BufEnter * ++nested if winnr('$') == 1 && bufname() == 'NvimTree_' . tabpagenr() | quit | endif"

-- even windows when split
vim.api.nvim_create_autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd "tabdo wincmd ="
  end,
})

vim.api.nvim_create_autocmd({ "CmdWinEnter" }, {
  callback = function()
    vim.cmd "quit"
  end,
})

-- highlight on yank
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  callback = function()
    vim.highlight.on_yank { higroup = "Visual", timeout = 200 }
  end,
})

vim.api.nvim_create_autocmd({ "VimEnter" }, {
  callback = function()
    vim.cmd "hi link illuminatedWord LspReferenceText"
  end,
})

vim.api.nvim_create_autocmd({ "BufWinEnter" }, {
  callback = function()
    local line_count = vim.api.nvim_buf_line_count(0)
    if line_count >= 5000 then
      vim.cmd "IlluminatePauseBuf"
    end
  end,
})

-- switch to absolute line numbers in insert mode
vim.api.nvim_create_autocmd({ "InsertEnter" }, {
  callback = function()
    vim.opt.relativenumber = false
    vim.opt.cursorline = false
  end,
})

-- switch to relative line numbers in normal mode
vim.api.nvim_create_autocmd({ "InsertLeave" }, {
  callback = function()
    vim.opt.relativenumber = true
    vim.opt.cursorline = true
  end,
})

-- treat Jenkinsfile as groovy
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "Jenkinsfile", "Jenkinsfile.*" },
  callback = function()
    vim.bo.filetype = "groovy"
  end,
})

-- treat some file extension as hcl
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.nomad" },
  callback = function()
    vim.bo.filetype = "hcl"
  end,
})

-- treat some file extension as terraform
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tfvars" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

-- compile latex on write
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.latex" },
  callback = function()
    vim.cmd "TexlabBuild"
  end,
})

-- disable buffer line on dashboard
vim.api.nvim_create_autocmd("User", {
  pattern = "AlphaReady",
  desc = "disable tabline for alpha",
  callback = function()
    vim.opt.showtabline = 0
  end,
})

vim.api.nvim_create_autocmd("BufUnload", {
  buffer = 0,
  desc = "enable tabline after alpha",
  callback = function()
    vim.opt.showtabline = 2
  end,
})
