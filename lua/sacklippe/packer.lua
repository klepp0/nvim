-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    is_bootstrap = true
    vim.fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
    vim.cmd([[packadd packer.nvim]])
end

require("packer").startup(function(use)
    -- Packer can manage itself
    use("wbthomason/packer.nvim")

    --- Telescope ---
    -- Fuzzy Finder (files, lsp, etc)
    use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
    -- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
    use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

    --- LSP Zero ---
    use({
        "VonHeikemen/lsp-zero.nvim",
        branch = "v1.x",
        requires = {
            -- LSP Support
            { "neovim/nvim-lspconfig" }, -- Required
            { "williamboman/mason.nvim" }, -- Optional
            { "williamboman/mason-lspconfig.nvim" }, -- Optional

            -- Autocompletion
            { "hrsh7th/nvim-cmp" }, -- Required
            { "hrsh7th/cmp-nvim-lsp" }, -- Required
            { "hrsh7th/cmp-buffer" }, -- Optional
            { "hrsh7th/cmp-path" }, -- Optional
            { "saadparwaiz1/cmp_luasnip" }, -- Optional
            { "hrsh7th/cmp-nvim-lua" }, -- Optional

            -- Snippets
            { "L3MON4D3/LuaSnip" }, -- Required
            { "rafamadriz/friendly-snippets" }, -- Optional
        },
    })

    --- Null-LS ---
    use({ "jose-elias-alvarez/null-ls.nvim" })

    --- Harpoon ---
    use({ "theprimeagen/harpoon", requires = { "nvim-lua/plenary.nvim" } })

    --- Colorscheme ---
    use({
        "sainnhe/everforest",
        config = function()
            vim.cmd("colorscheme everforest")
            vim.g.everforest_better_performance = 1
            vim.g.everforest_background = 'hard'
        end,
    })

    --- Copilot ---
    use({ "github/copilot.vim", run = "cargo build --release" })

    --- Gitsigns ---
    use {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    }
end)
