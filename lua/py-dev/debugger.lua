local M = {}
local config = require("py-dev").config

function M.setup_dap()
  local ok, dap = pcall(require, "dap")
  if not ok then
    vim.notify("nvim-dap is not installed.", vim.log.levels.ERROR)
    return false
  end
  
  dap.adapters.python = function(cb, config)
    if config.request == 'attach' then
      local port = (config.connect or config).port
      local host = (config.connect or config).host or '127.0.0.1'
      cb({
        type = 'server',
        port = assert(port, '`connect.port` is required for a python `attach` configuration'),
        host = host,
        options = {
          source_filetype = 'python',
        },
      })
    else
      cb({
        type = 'executable',
        command = os.getenv('VIRTUAL_ENV') and os.getenv('VIRTUAL_ENV') .. '/bin/python' or 'python3',
        args = { '-m', 'debugpy.adapter' },
        options = {
          source_filetype = 'python',
        },
      })
    end
  end
  
  dap.configurations.python = {
    {
      type = 'python',
      request = 'launch',
      name = "Launch file",
      program = "${file}",
      pythonPath = function()
        local cwd = vim.fn.getcwd()
        if vim.fn.executable(cwd .. '/.venv/bin/python') == 1 then
          return cwd .. '/.venv/bin/python'
        else
          return 'python3'
        end
      end,
    },
  }
  
  vim.notify("DAP for Python configured successfully.", vim.log.levels.INFO)
  return true
end

function M.start_debug()
  local ok, dap = pcall(require, "dap")
  if not ok then
    vim.notify("nvim-dap is not installed.", vim.log.levels.ERROR)
    return
  end
  if M.setup_dap() then
    dap.continue()
  end
end

return M
