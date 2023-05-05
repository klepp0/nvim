-- Learn the keybindings, see :help lsp-zero-keybindings
-- Learn to configure LSP servers, see :help lsp-zero-api-showcase
local lsp = require("lsp-zero")
lsp.preset("minimal")

lsp.ensure_installed({
    "tsserver",
    "eslint",
    "rust_analyzer",
})

-- Fix Undefined global 'vim'
lsp.nvim_workspace()

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }
local cmp_mappings = lsp.defaults.cmp_mappings({
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
})

lsp.set_preferences({
    suggest_lsp_servers = false,
    sign_icons = {
        error = 'E',
        warn = 'W',
        hint = 'H',
        info = 'I'
    }
})


--lsp.format_on_save({
--    servers = {
--        ['lua_ls'] = { 'lua' },
--        ['rust_analyzer'] = { 'rust' },
--        ['null-ls'] = { 'python' },
--    }
--})
--
--lsp.format_mapping("<leader>f",
--    servers = {
--        ['lua_ls'] = { 'lua' },
--        ['rust_analyzer'] = { 'rust' },
--        ['null-ls'] = { 'python' },
--    }
--)

lsp.on_attach(function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set("n", "gD", function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set("n", "gr", function() vim.lsp.buf.reference() end, opts)
    vim.keymap.set("n", "gi", function() vim.lsp.buf.implementation() end, opts)
    vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set("n", "<C-k>", function() vim.lsp.buf.signature_help() end, opts)
    vim.keymap.set("n", "<C-n>", function() vim.diagnostic.goto_next() end, opts)
    vim.keymap.set("n", "<C-p>", function() vim.diagnostic.goto_prew() end, opts)
end)


lsp.setup()

vim.diagnostic.config({
    virtual_text = true
})

local null_ls = require('null-ls')
local null_opts = lsp.build_options('null-ls', {})

null_ls.setup({
    on_attach = function(client, bufnr)
        null_opts.on_attach(client, bufnr)
        --- you can add more stuff here if you need it
    end,
    sources = {
        null_ls.builtins.formatting.black,
    }
})
