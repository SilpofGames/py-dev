local M = {}
local config = require("py-dev").config

function M.disasm()
  local file = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  
  if ext ~= "py" then
    vim.notify("Not a Python file.", vim.log.levels.ERROR)
    return
  end
  
  vim.notify("Disassembling python bytecode...", vim.log.levels.INFO)
  local cmd = string.format("%s -m dis %s", config.python_cmd, vim.fn.shellescape(file))
  local output = vim.fn.systemlist(cmd)
  
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, output)
  
  vim.cmd("vsplit")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.cmd("setlocal readonly")
end

return M
