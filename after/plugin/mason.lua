local mason = require("mason")
local mason_lspconfig = require("mason-lspconfig")
local mason_tool_installer = require("mason-tool-installer")

-- enable mason and configure icons
mason.setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
        },
    },
    ensure_installed = {
        "pyright",
        "debugpy",
    },
})

mason_lspconfig.setup({
    -- list of servers for mason to install
    ensure_installed = {
        "lua_ls",
        "rust_analyzer",
        "pyright",
        "ruff",
        "gopls",
    },
})

mason_tool_installer.setup({
    ensure_installed = {
        "prettier", -- prettier formatter
        "stylua",   -- lua formatter
        -- "isort", -- python formatter
        -- "black", -- python formatter
        "pylint", -- python linter
        "ruff",   -- python formatter
        "gopls",  -- go language server
    },
})
