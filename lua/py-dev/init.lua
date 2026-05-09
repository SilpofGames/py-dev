local M = {}

M.config = {
  python_cmd = "python3",
  test_cmd = "pytest",
  linter = "ruff check",
  formatter = "black",
  type_checker = "mypy",
  venv_name = ".venv",
}

function M.setup(user_config)
  M.config = vim.tbl_deep_extend("force", M.config, user_config or {})
  
  local venv_path = vim.fn.getcwd() .. "/" .. M.config.venv_name
  if vim.fn.isdirectory(venv_path) == 1 then
    vim.env.VIRTUAL_ENV = venv_path
    vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
  end
end

return M
