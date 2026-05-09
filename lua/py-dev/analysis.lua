local M = {}
local config = require("py-dev").config

function M.run_tests()
  vim.notify("Running tests...", vim.log.levels.INFO)
  vim.cmd("split | terminal " .. config.test_cmd)
end

function M.run_type_check()
  local file = vim.fn.expand("%:p")
  vim.cmd("split | terminal " .. config.type_checker .. " " .. vim.fn.shellescape(file))
end

function M.run_linter()
  local file = vim.fn.expand("%:p")
  vim.cmd("split | terminal " .. config.linter .. " " .. vim.fn.shellescape(file))
end

function M.run_formatter()
  local file = vim.fn.expand("%:p")
  vim.fn.system(config.formatter .. " " .. vim.fn.shellescape(file))
  vim.cmd("edit!")
  vim.notify("Formatted " .. vim.fn.expand("%:t"), vim.log.levels.INFO)
end

return M
