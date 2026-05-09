if vim.g.loaded_py_dev == 1 then
  return
end
vim.g.loaded_py_dev = 1

vim.api.nvim_create_user_command("PyVenvInit", function() require("py-dev.runner").init_venv() end, {})
vim.api.nvim_create_user_command("PyInitProject", function() require("py-dev.runner").init_project() end, {})
vim.api.nvim_create_user_command("PyRun", function() require("py-dev.runner").run() end, {})
vim.api.nvim_create_user_command("PyTest", function() require("py-dev.analysis").run_tests() end, {})
vim.api.nvim_create_user_command("PyTypeCheck", function() require("py-dev.analysis").run_type_check() end, {})
vim.api.nvim_create_user_command("PyLint", function() require("py-dev.analysis").run_linter() end, {})
vim.api.nvim_create_user_command("PyFormat", function() require("py-dev.analysis").run_formatter() end, {})
vim.api.nvim_create_user_command("PyDisasm", function() require("py-dev.bytecode").disasm() end, {})
vim.api.nvim_create_user_command("PyProfile", function() require("py-dev.profiler").run_profiler() end, {})
vim.api.nvim_create_user_command("PyDebug", function() require("py-dev.debugger").start_debug() end, {})
