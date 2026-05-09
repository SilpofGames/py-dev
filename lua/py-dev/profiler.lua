local M = {}
local config = require("py-dev").config

function M.run_profiler()
  local file = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  
  if ext ~= "py" then
    vim.notify("Not a Python file.", vim.log.levels.ERROR)
    return
  end
  
  local pstats_file = vim.fn.expand("%:p:r") .. ".prof"
  local cmd = string.format("%s -m cProfile -o %s %s", config.python_cmd, vim.fn.shellescape(pstats_file), vim.fn.shellescape(file))
  
  vim.notify("Running cProfile...", vim.log.levels.INFO)
  vim.fn.system(cmd)
  
  local script = string.format([[
import pstats
p = pstats.Stats('%s')
p.sort_stats('cumulative').print_stats(30)
  ]], pstats_file)
  
  local out = vim.fn.system({config.python_cmd, "-c", script})
  
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, vim.split(out, "\n"))
  
  vim.cmd("vnew")
  local win = vim.api.nvim_get_current_win()
  vim.api.nvim_win_set_buf(win, buf)
  vim.cmd("setlocal readonly")
end

return M
