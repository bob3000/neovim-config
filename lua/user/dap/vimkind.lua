local M = {}

--- attach js-debug-adapter
---@param dap table nvim-dap object
M.setup = function(dap)
  dap.configurations.lua = {
    {
      type = "nlua",
      request = "attach",
      name = "Attach to running Neovim instance",
    },
  }

  dap.adapters.nlua = function(callback, config)
    callback { type = "server", host = config.host or "127.0.0.1", port = config.port or 8086 }
  end
end

return M
