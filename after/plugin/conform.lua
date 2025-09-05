-- Autoformat (Conform)
local conform = require("conform")
local util = require("conform.util")

conform.setup({
  notify_on_error = false,

  -- Use Conform on save. For Python, don't fall back to any LSP formatter.
  format_on_save = function(bufnr)
    local ft = vim.bo[bufnr].filetype
    if ft == "python" then
      return { lsp_fallback = false, timeout_ms = 1000 }
    end
    -- for other filetypes you can allow fallback if you want
    return { lsp_fallback = true, timeout_ms = 500 }
  end,

  -- Run Ruff fixes (incl. imports) first, then Ruff formatter
  formatters_by_ft = {
    python = { "ruff_fix", "ruff_format" },
    -- lua = { "stylua" },
    -- javascript = { "prettierd", "prettier" },
  },

  -- Formatter-specific config
  formatters = {
    -- run Ruff import fixes and code formatter from the project root
    ruff_fix = {
      command = "ruff",
      args = { "--fix", "--select", "I", "--stdin-filename", "$FILENAME", "-" },
      cwd = util.root_file({ "pyproject.toml", "ruff.toml", ".ruff.toml" }),
      stdin = true,
    },
    ruff_format = {
      command = "ruff",
      args = { "format", "--stdin-filename", "$FILENAME", "-" },
      cwd = util.root_file({ "pyproject.toml", "ruff.toml", ".ruff.toml" }),
      stdin = true,
    },
  },
})

-- Map <leader>f to Conform (define mappings OUTSIDE of conform.setup)
vim.keymap.set({ "n", "v" }, "<leader>f", function()
  require("conform").format({ async = false, lsp_fallback = false })
end, { desc = "[F]ormat buffer" })
