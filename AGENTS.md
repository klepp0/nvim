# AGENTS.md

Guidance for AI coding agents operating in this repository.

## Project Overview

Personal Neovim configuration (dotfiles) written entirely in **Lua**. Uses
**lazy.nvim** (stable branch) as the plugin manager. Originally bootstrapped
from kickstart.nvim and heavily customized. Author namespace: `klepp0`.

Repository: https://github.com/klepp0/nvim

## Directory Structure

```
init.lua                       -- Entry point: require("klepp0")
lua/klepp0/
  init.lua                     -- Loads set -> remap -> lazy (order matters)
  set.lua                      -- Vim options and autocommands
  remap.lua                    -- Global keymaps
  lazy.lua                     -- Bootstraps lazy.nvim, loads plugin specs
  plugins/
    init.lua                   -- Aggregates all plugin specs into one table
    colorscheme.lua            -- rose-pine theme
    completion.lua             -- nvim-cmp + LuaSnip
    conform.lua                -- Format-on-save (ruff for Python)
    copilot.lua                -- GitHub Copilot
    dap.lua                    -- Debug Adapter Protocol (Python)
    editor.lua                 -- vim-sleuth, Comment.nvim, todo-comments, etc.
    git.lua                    -- gitsigns + git-worktree
    harpoon.lua                -- Quick file navigation
    lsp.lua                    -- LSP Zero + Mason + null-ls
    mini.lua                   -- mini.ai, mini.surround, mini.statusline
    refactoring.lua            -- refactoring.nvim
    telescope.lua              -- Fuzzy finder
    treesitter.lua             -- Syntax highlighting
Makefile                       -- install / uninstall / help
.pre-commit-config.yaml        -- Pre-commit hooks
```

## Build / Install / Validate Commands

This is a Neovim config, not a compiled project. There is **no test suite**.

| Command | Purpose |
|---|---|
| `make install` | Updates submodules, symlinks repo to `~/.config/nvim` |
| `make uninstall` | Removes symlink, restores backup |
| `pre-commit run --all-files` | Runs all linting/formatting checks |
| `nvim --headless "+checkhealth" "+qa"` | Verify config loads without errors |

### Pre-commit Hooks (run on every commit and in CI)

1. `trailing-whitespace` -- removes trailing whitespace
2. `end-of-file-fixer` -- ensures files end with a newline
3. `check-yaml` -- validates YAML syntax
4. `check-added-large-files` -- prevents large file commits
5. `stylua` (v0.20.0) -- Lua formatter

### CI Workflows (`.github/workflows/`)

- **pre-commit.yml** -- Runs pre-commit hooks on push to `main` and all PRs
- **release.yml** -- Auto-generates changelog from conventional commits
- **dispatch.yml** -- Notifies `klepp0/dotfiles` repo to update nvim submodule

## Code Style Guidelines

### Formatter: StyLua (v0.20.0, default config)

No `stylua.toml` exists -- StyLua runs with defaults:
- **Indentation:** Tabs
- **Column width:** 120
- **Quote style:** Double quotes

Always run `stylua` before committing or rely on the pre-commit hook.

### Lua Conventions

- **All variables must be `local`** -- no globals anywhere
- **Double quotes** for all strings: `"string"`, never `'string'`
- **Tab indentation** in Lua source files
- **Trailing commas** on all multi-line table entries
- **One entry per line** in multi-line tables
- **Line length:** 120 characters (colorcolumn is set to 120 in `set.lua`)
- **Comments:** single-line `--` style; use descriptive section headers

### Module / Import Patterns

- Top-level entry: `init.lua` calls `require("klepp0")`
- Load order in `lua/klepp0/init.lua`: `set` -> `remap` -> `lazy` (order matters)
- Plugin specs: each file in `plugins/` returns a single lazy.nvim spec table
- `plugins/init.lua` aggregates all specs: `return { require("klepp0.plugins.X"), ... }`
- External modules are `require()`-d inside `config = function() ... end` blocks
- Always assign requires to local variables: `local cmp = require("cmp")`

### Naming Conventions

- **Directories/modules:** lowercase (`klepp0`, `plugins`)
- **Plugin files:** lowercase, single-word descriptive names (`lsp.lua`, `git.lua`)
- **Variables:** `snake_case` (`mason_lspconfig`, `lsp_zero`, `null_opts`)
- **Functions:** `snake_case` (`detect_python_path`, `create_worktree`)
- **Keymap descriptions:** bracket-letter convention for which-key: `"[S]earch [F]iles"`, `"[G]it [W]orktrees"`

### Leader Key Prefix Conventions

| Prefix | Domain |
|---|---|
| `<leader>s` | Search (Telescope) |
| `<leader>d` | Debug (DAP) |
| `<leader>g` | Git |
| `<leader>r` | Refactoring |
| `<leader>f` | Format |
| `<leader>p` | Paste / Project |
| `<leader>1-0` | Harpoon file marks |

### Keymap Style

Always use `vim.keymap.set()` (never the older `vim.api.nvim_set_keymap()`).
Include a `desc` field in the options table for which-key discoverability:

```lua
vim.keymap.set("n", "<leader>sf", builtin.find_files, { desc = "[S]earch [F]iles" })
```

### Vim API Style

- Options: use `vim.opt.*` (never `vim.o.*` or `vim.cmd("set ...")`)
- Autocommands: use `vim.api.nvim_create_autocmd()` with table config
- Augroups: use `vim.api.nvim_create_augroup()` with `{ clear = true }`

### Error Handling

- **`pcall()`** for optional extensions that may not be installed:
  ```lua
  pcall(telescope.load_extension, "fzf")
  ```
- **`vim.notify()`** for user-facing errors:
  ```lua
  vim.notify("No branch selected", vim.log.levels.ERROR)
  ```
- **Conditional guards** for platform/tool availability:
  ```lua
  if vim.fn.executable("make") == 0 then return end
  ```
- **Fallback chains** for environment detection (see `dap.lua` Python path pattern)
- **`---@diagnostic disable-next-line:`** for known LSP false positives (use sparingly)

### Adding a New Plugin

1. Create `lua/klepp0/plugins/<name>.lua` returning a lazy.nvim spec table
2. Add `require("klepp0.plugins.<name>")` to `lua/klepp0/plugins/init.lua`
3. Put all plugin setup logic inside `config = function() ... end`
4. Follow the keymap description convention: `"[X]action [Y]target"`

### Commit Message Convention

This project uses **Conventional Commits** (enforced by CI release workflow):

```
feat: add git-worktree plugin
fix: update ruff_fix args for newer ruff versions
chore(release): 2.11.1
```

Use `feat:` for new features, `fix:` for bug fixes, `chore:` for maintenance.
Scoped commits are fine: `fix(diagnostics): ...`, `feat(lsp): ...`.
