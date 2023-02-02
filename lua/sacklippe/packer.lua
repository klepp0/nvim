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

	---- TELESCOPE
	--   -- ThePrimegean (https://github.com/ThePrimeagen/init.lua/blob/master/lua/theprimeagen/packer.lua)
	--   use {
	-- 	  'nvim-telescope/telescope.nvim', tag = '0.1.0',
	-- 	  -- or                            , branch = '0.1.x',
	-- 	  requires = { {'nvim-lua/plenary.nvim'} }
	--   }

	-- Fuzzy Finder (files, lsp, etc)
	use({ "nvim-telescope/telescope.nvim", branch = "0.1.x", requires = { "nvim-lua/plenary.nvim" } })
	-- Fuzzy Finder Algorithm which requires local dependencies to be built. Only load if `make` is available
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make", cond = vim.fn.executable("make") == 1 })

	---- NULL-LS
	use("jose-elias-alvarez/null-ls.nvim")
end)
