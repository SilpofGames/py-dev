# py-dev.nvim

A Neovim plugin for Python development. Manage venvs, run, test, lint, format, profile and debug Python projects.

## Install with silzy.nvim

```lua
use { "SilpofGames/py-dev.nvim",
  config = function()
    require("py-dev").setup({
      python_cmd = "python3",
      venv_name  = ".venv",
    })
  end,
}
use { "neovim/nvim-lspconfig",
  requires = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },
  config = function()
    require("lspconfig").pyright.setup({
      capabilities = require("cmp_nvim_lsp").default_capabilities(),
      settings = { python = { analysis = { typeCheckingMode = "strict" } } },
    })
  end,
}
```

## Commands

| Command | Description |
|---------|-------------|
| `:PyVenvInit` | Create a `.venv` virtual environment |
| `:PyInitProject` | Initialize a full Python project structure |
| `:PyRun` | Run the current file or `src/main.py` |
| `:PyTest` | Run tests with `pytest` |
| `:PyTypeCheck` | Type check with `mypy` |
| `:PyLint` | Lint with `ruff check` |
| `:PyFormat` | Format with `black` |
| `:PyDisasm` | Show Python bytecode with `dis` |
| `:PyProfile` | Profile with `cProfile` |
| `:PyDebug` | Start DAP debug session |

## Config options

```lua
require("py-dev").setup({
  python_cmd   = "python3",
  test_cmd     = "pytest",
  linter       = "ruff check",
  formatter    = "black",
  type_checker = "mypy",
  venv_name    = ".venv",
})
```
