local M = {}
local config = require("py-dev").config

function M.init_venv()
  local dir = vim.fn.getcwd()
  local venv_path = dir .. "/" .. config.venv_name
  
  if vim.fn.isdirectory(venv_path) == 1 then
    vim.notify("Venv already exists.", vim.log.levels.WARN)
    return
  end
  
  vim.notify("Creating virtual environment...", vim.log.levels.INFO)
  vim.fn.system(config.python_cmd .. " -m venv " .. config.venv_name)
  vim.notify("Virtual environment created!", vim.log.levels.INFO)
end

function M.init_project()
  local dir = vim.fn.getcwd()
  M.init_venv()
  
  vim.fn.mkdir(dir .. "/src", "p")
  vim.fn.mkdir(dir .. "/tests", "p")
  
  local pyproject = dir .. "/pyproject.toml"
  if vim.fn.filereadable(pyproject) == 0 then
    local content = {
      "[project]",
      "name = \"my_project\"",
      "version = \"0.1.0\"",
      "dependencies = []",
      "",
      "[build-system]",
      "requires = [\"hatchling\"]",
      "build-backend = \"hatchling.build\""
    }
    vim.fn.writefile(content, pyproject)
  end
  
  local main_py = dir .. "/src/main.py"
  if vim.fn.filereadable(main_py) == 0 then
    vim.fn.writefile({
      "def main():",
      "    print('Hello from Python!')",
      "",
      "if __name__ == '__main__':",
      "    main()"
    }, main_py)
  end
  
  vim.notify("Python project initialized!", vim.log.levels.INFO)
end

function M.run()
  local file = vim.fn.expand("%:p")
  local ext = vim.fn.expand("%:e")
  
  if ext ~= "py" then
    if vim.fn.filereadable(vim.fn.getcwd() .. "/src/main.py") == 1 then
      file = vim.fn.getcwd() .. "/src/main.py"
    else
      vim.notify("Not a Python file.", vim.log.levels.ERROR)
      return
    end
  end
  
  vim.cmd("split | terminal " .. config.python_cmd .. " " .. vim.fn.shellescape(file))
  vim.cmd("startinsert")
end

return M
